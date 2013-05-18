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
    //Fetches all of the News Feeds
    [self fetchNewsFeed];
    
    //This is the Client key and app ID for the parse online
    [Parse setApplicationId:APP_ID clientKey:CLIENT_KEY];
    [self getParseObjects];
    
    //Fetches all of the Tweets for HMFFEST from twitter
    [self fetchTweets];
    
    //Fetches the FlickerFeed
    [self fetchFlickerFeed];
    
    return self;
}
//Fetches all of the FlickerFeeds
-(void)fetchFlickerFeed{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString:[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?&method=flickr.people.getPublicPhotos&api_key=%@&user_id=95406796@N08&per_page=100&format=json&nojsoncallback=1", FLICKR_API_KEY]]];
        NSError* error;
        self.photos = [NSJSONSerialization JSONObjectWithData:data
                                                      options:kNilOptions
                                                        error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Flicker Feed Dispatch Finished");
            [self loadPhotoArrays];
        });
    });
    
}
-(void)loadPhotoArrays{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Build an array from the dictionary for easy access to each entry
        NSArray *photos = [[self.photos objectForKey:@"photos"] objectForKey:@"photo"];
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
            
            
            // The performance (scrolling) of the table will be much better if we
            // build an array of the image data here, and then add this data as
            // the cell.image value (see cellForRowAtIndexPath:)
            [self.smallPhotos addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
            //            NSLog(@"small photos %@", self.smallPhotos);
            
            
            // Build and save the URL to the large image so we can zoom
            // in on the image if requested
            photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
            [self.largePhotos addObject:[NSURL URLWithString:photoURLString]];
            //            NSLog(@"large photos %@", self.largePhotos);
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Finished loading the Arrays");
            
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString: @"https://api.twitter.com/1/statuses/user_timeline.json?screen_name=HMFFEST&include_rts=1&count=100"]];
        
        NSError* error;
        
        self.tweets = [NSJSONSerialization JSONObjectWithData:data
                                                      options:kNilOptions
                                                        error:&error];
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
    NSMutableArray *arrayVenue = [[NSMutableArray alloc]init];
    
    self.date = [[NSMutableArray alloc]init];
    self.band= [[NSMutableArray alloc]init];
    
    
    //Initial query
    PFQuery *query = [PFQuery queryWithClassName:@"HMFFDates"];
    //Puts all of the querys into an object
    allObjects= [query findObjects];
    
    //Pulls out all of the dates from the objects
    for (NSDictionary *diction in allObjects){
        [tempArray addObject:[diction objectForKey:@"date"]];
    }
    //Used to find the Unique Dates
    NSSet *uniqueDates = [NSSet setWithArray:tempArray];
    
    ////Put the Set back into the array so I can use it
    self.date= [NSMutableArray arrayWithArray:[uniqueDates allObjects]];
    
    //Sorts the dates
    [self.date sortUsingSelector:@selector(compare:)];
    
    NSLog(@"dates %@", self.date);
    NSMutableArray *tempArray1 = [[NSMutableArray alloc]init];
    
    for (NSDictionary *diction in allObjects){
        [tempArray1 addObject:[diction objectForKey:@"venue"]];
    }
    //Used to find the Unique Dates
    NSSet *uniqueVenues = [NSSet setWithArray:tempArray1];
    
    ////Put the Set back into the array so I can use it
    venue= [NSMutableArray arrayWithArray:[uniqueVenues allObjects]];
    
    //Finds venue for unique dates
    for (int i= 0; i <[self.date count]; i++) {
        for (NSDictionary *diction in allObjects){
            if ([[diction objectForKey:@"date"] isEqualToString:[self.date objectAtIndex:i]]) {
                [arrayVenue addObject:[diction objectForKey:@"venue"]];
            }
        }
        
    }
    //Sorts the Venues, and into unique Venues
    uniqueVenues = [NSSet setWithArray:arrayVenue];
    NSLog(@"unique venues %@", uniqueVenues);
    
    venue = [NSMutableArray arrayWithArray:[uniqueVenues allObjects]];
    NSLog(@"venues %@", venue);
    
    //Finds band for unique dates and venue
    for (int i= 0; i <[self.date count]; i++) {
        NSMutableArray *arrayBand = [[NSMutableArray alloc]init];
        for (NSDictionary *diction in allObjects){
            if ([[diction objectForKey:@"date"] isEqualToString:[self.date objectAtIndex:i]]) {
                if ([[diction objectForKey:@"venue"] isEqualToString:[venue objectAtIndex:i]]) {
                    //Adds the dictionary to the array
                    [arrayBand addObject:diction];
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
