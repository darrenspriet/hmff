//
//  HMDataFeedManager.m
//  HMFF
//
//  Created by Darren Spriet on 2013-05-17.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMDataFeedManager.h"

@implementation HMDataFeedManager

//Singleton Object of this class and is accessed again and again
+ (HMDataFeedManager*) sharedDataFeedManager {
    
    static HMDataFeedManager *sharedDataFeedManager;
    
    @synchronized(self){
        
        if (!sharedDataFeedManager){
            sharedDataFeedManager = [[HMDataFeedManager alloc] init];
        }
        return sharedDataFeedManager;
    }
}
//The init Method
-(id)init{
    //Fetches all of the Tweets for HMFFEST from twitter
   // [self fetchTweets];
    //Fetches all of the News Feeds
    [self fetchNewsFeed];
    
    //This is the Client key and app ID for the parse online
    [Parse setApplicationId:PARSE_APP_ID clientKey:PARSE_CLIENT_KEY];
    [self getParseObjects];
    

    
    //Fetches the FlickerFeed
    [self fetchFlickerFeed];
    return self;
}
//Fetches all of the FlickerFeeds
-(void)fetchFlickerFeed{
    dispatch_async(dispatch_get_main_queue(), ^{
//This could be used just for the main stream
//        NSData* data = [NSData dataWithContentsOfURL:
//                        [NSURL URLWithString:[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?&method=flickr.people.getPublicPhotos&api_key=%@&user_id=%@@N08&per_page=20&format=json&nojsoncallback=1", FLICKR_API_KEY, USER_ID]]];
        
//This is for  a specific Set with a ID number
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString:[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?&method=flickr.photosets.getPhotos&photoset_id=%@&api_key=%@&user_id=%@&per_page=20&format=json&nojsoncallback=1",FLICKER_SET_NUMBER ,FLICKR_API_KEY, FLICKER_USER_ID ]]];
       
        NSError* error;
        self.photos = [NSJSONSerialization JSONObjectWithData:data
                                                      options:kNilOptions
                                                        error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"photos is: %@", self.photos);
            NSLog(@"Flicker Feed Dispatch Finished");
            [self loadPhotoArrays];
        });
    });
    
}
-(void)loadPhotoArrays{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Build an array from the dictionary for easy access to each entry
        //If trying to get the Stream the first object is "photo", other wise if it is a set
        //its a "photoset"
        NSArray *photos = [[self.photos objectForKey:@"photoset"] objectForKey:@"photo"];
        NSMutableArray  *photoTitles =[[NSMutableArray alloc]init];
        self.smallPhotos =[[NSMutableArray alloc]init];
        self.largePhotos =[[NSMutableArray alloc]init];
        
        // Loop through each entry in the dictionary...
        for (NSDictionary *photo in photos)
        {
            // Get title of the image
            NSString *title = [photo objectForKey:@"title"];
            
            // Save the title to the photo titles array
            [photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
            
            // Build the URL to where the image is stored (see the Flickr API)
            // In the format http://farmX.static.flickr.com/server/id/secret
            // Notice the "_s" which requests a "small" image 75 x 75 pixels
            NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_t.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
            
            NSLog(@"Finished Smalls");
            // The performance (scrolling) of the table will be much better if we
            // build an array of the image data here, and then add this data as
            // the cell.image value (see cellForRowAtIndexPath:)
            [self.smallPhotos addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
            //            NSLog(@"small photos %@", self.smallPhotos);
            
            
            // Build and save the URL to the large image so we can zoom
            // in on the image if requested
            photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
            [self.largePhotos addObject:[NSURL URLWithString:photoURLString]];
            NSLog(@"Finished Large");
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Finished loading the Arrays");
            if (self.completionBlock!=nil) {
                self.completionBlock(YES);
            }
            
            
        });
    });
    
    
}

//Goes through the news feed and grabs the data from a JSON object on the MAIN thread
//This needs to be looked at because if there is NO internet it may crash
- (void)fetchNewsFeed{
    //Must change this Cause it is on the mainQue
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString: @"http://www.hmff.com/?json=get_recent_posts&count=1000"]];
        
        NSError* error;
        
        self.news = [NSJSONSerialization JSONObjectWithData:data
                                                    options:kNilOptions
                                                      error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"News Feed Dispatch Finished");
            
        });
    });
}


//Goes through the twitter feed and grabs the data from a JSON object on a Global thread
//This needs to be looked at because if there is NO internet it may crash
- (void)fetchTweets{
    dispatch_async(dispatch_get_main_queue(), ^{
        STTwitterAPIWrapper *twitter = [STTwitterAPIWrapper twitterAPIApplicationOnlyWithConsumerKey:TWITTER_CONSUMER_KEY
                                      consumerSecret:TWITTER_CONSUMER_SECRET];
        
        [twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
            
            NSLog(@"Access granted with %@", bearerToken);
            [twitter getUserTimelineWithScreenName:@"HMFFEST" count:20 successBlock:^(NSArray *statuses) {
                NSLog(@"-- statuses: %@", statuses);
                
                self.tweets=statuses;
                NSLog(@"-- self.tweets: %@", self.tweets);

            } errorBlock:^(NSError *error) {
                NSLog(@"-- error: %@", error);
            }];
            
        } errorBlock:^(NSError *error) {
            NSLog(@"-- error %@", error);
        }];

//        NSData* data = [NSData dataWithContentsOfURL:
//                        [NSURL URLWithString: @"https://api.twitter.com/1/statuses/user_timeline.json?screen_name=HMFFEST&include_rts=1&count=100"]];
//        
//        NSError* error;
//        
//        self.tweets = [NSJSONSerialization JSONObjectWithData:data
//                                                      options:kNilOptions
//                                                        error:&error];
       dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"finished twitter dispatch");
            
        });
    });
}
-(void)getParseObjects{
    //Try to keep the Parse calls to a minimum...there are 3 right now.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSArray *allObjects = [[NSMutableArray alloc]init];
        NSMutableArray *venue= [[NSMutableArray alloc]init];
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        NSMutableArray *tempArray2 = [[NSMutableArray alloc]init];
        NSMutableArray *tempArray4 = [[NSMutableArray alloc]init];



        NSMutableArray *arrayVenue = [[NSMutableArray alloc]init];
        
        self.date = [[NSMutableArray alloc]init];
        self.band= [[NSMutableArray alloc]init];
        
        
        //Initial query
        PFQuery *query = [PFQuery queryWithClassName:@"HMFFDates"];
        //Puts all of the querys into an object
        allObjects= [query findObjects];
        NSMutableArray *allObjectsSorted = [NSMutableArray arrayWithArray:allObjects];
            [allObjectsSorted sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES], nil]];
        
         NSLog(@"allobjectssorted 3%@", allObjectsSorted);
        //Pulls out all of the dates from the objects
        for (NSDictionary *diction in allObjectsSorted){
            
            [tempArray addObject:[diction objectForKey:@"date"]];
        }
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"MMM dd YYYY"];
        for (NSDate *date in tempArray)
        {
            NSString *newDate =[dateFormatter1 stringFromDate:date];
            [tempArray4 addObject:newDate];
        }
       
        NSLog(@"temparray ordered?%@", tempArray4);

        
        //Used to find the Unique Dates
        NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:tempArray4];
        //Used to find the Unique Dates
        NSSet *uniqueDates = [orderedSet set];

        
        ////Put the Set back into the array so I can use it
        tempArray2= [NSMutableArray arrayWithArray:[uniqueDates allObjects]];
        NSLog(@"temparray 3%@", tempArray2);

        
        self.date= [NSMutableArray arrayWithArray:tempArray2];
        
        NSLog(@"dates %@", self.date);
        NSMutableArray *tempArray1 = [[NSMutableArray alloc]init];
        
        for (NSDictionary *diction in allObjects){
            [tempArray1 addObject:[diction objectForKey:@"venue"]];
        }
        //Used to find the Unique Dates
        NSSet *uniqueVenues = [NSSet setWithArray:tempArray1];
        
        ////Put the Set back into the array so I can use it
        venue = [NSMutableArray arrayWithArray:[uniqueVenues allObjects]];
        //Finds venue for unique dates
        for (int i= 0; i <[self.date count]; i++) {
            for (NSDictionary *diction in allObjects){
                NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                [dateFormatter1 setDateFormat:@"MMM dd YYYY"];
                NSString *compareString =[dateFormatter1 stringFromDate:[diction objectForKey:@"date"]];
                if ([compareString isEqualToString:[self.date objectAtIndex:i]]) {
                    [arrayVenue addObject:[diction objectForKey:@"venue"]];
                    
                }
            }
            
        }
        //Sorts the Venues, and into unique Venues
        uniqueVenues = [NSSet setWithArray:arrayVenue];
        //NSLog(@"unique venues %@", uniqueVenues);
        
        venue = [NSMutableArray arrayWithArray:[uniqueVenues allObjects]];
        NSLog(@"venues %@", venue);
        
        //Finds band for unique dates and venue
        for (int i= 0; i <[self.date count]; i++) {
            NSMutableArray *arrayBand = [[NSMutableArray alloc]init];
            for (NSDictionary *diction in allObjects){
                NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                [dateFormatter1 setDateFormat:@"MMM dd YYYY"];
                NSString *compareString =[dateFormatter1 stringFromDate:[diction objectForKey:@"date"]];
                NSLog(@"compare date %@", compareString);
                NSLog(@"otherdate at i %@", [self.date objectAtIndex:i]);
                if ([compareString isEqualToString:[self.date objectAtIndex:i]]) {
                    for (int j=0; j<[venue count]; j++) {
                        if ([[diction objectForKey:@"venue"] isEqualToString:[venue objectAtIndex:j]]) {
                            //Adds the dictionary to the array
                            [arrayBand addObject:diction];
                            //NSLog(@"venues %@", diction);
                            
                        }
                    }
                }
            }
            //Adds the Array with dictionarys in it to the array
            [self.band addObject:arrayBand];
            NSLog(@"band %@", self.band);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Parse object done");
            
        });
    });
}


@end
