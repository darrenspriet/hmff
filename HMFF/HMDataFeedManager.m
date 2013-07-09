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
    
    //Fetches all of the links parse objects
    [self fetchLinksParseObjects];
    
    //Fetches all of the News Feeds
    [self fetchNewsFeed];
    
    //Fetches all of the Tweets for HMFFEST from twitter
    [self fetchTweets];
    
    //Fetches the FlickerFeed
    [self fetchFlickerFeed];
   
    //Fetches all of the schedule parse objects
    [self fetchScheduleParseObjects];
    
    //Fetches all of the youtube parse objects
    [self fetchYouTubeParseObjects];

    return self;
}
//Fetches all of the FlickerFeeds
-(void)fetchFlickerFeed{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //This is for  a specific Set with a ID number
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString:[NSString stringWithFormat:FLICKER_URL,FLICKER_SET_NUMBER ,FLICKR_API_KEY, FLICKER_USER_ID ]]];
        
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
        NSLog(@"photos array dispach started");

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
            NSString *photoURLString = [NSString stringWithFormat:SMALL_FLICKER_PHOTO, [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
            
           // NSLog(@"Finished Smalls");
            // The performance (scrolling) of the table will be much better if we
            // build an array of the image data here, and then add this data as
            // the cell.image value (see cellForRowAtIndexPath:)
            [self.smallPhotos addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
            //            NSLog(@"small photos %@", self.smallPhotos);
            
            
            // Build and save the URL to the large image so we can zoom
            // in on the image if requested
            photoURLString = [NSString stringWithFormat:LARGE_FLICKER_PHOTO, [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
            [self.largePhotos addObject:[NSURL URLWithString:photoURLString]];
          //  NSLog(@"Finished Large");
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"photos array dispach finished");
            
            
        });
    });
    
    
}

//Goes through the news feed and grabs the data from a JSON object on the MAIN thread
//This needs to be looked at because if there is NO internet it may crash
- (void)fetchNewsFeed{
    //Must change this Cause it is on the mainQue
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"News Feed dispach started");

        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString: NEWS_URL]];
        
        NSError* error;
        
        self.news = [NSJSONSerialization JSONObjectWithData:data
                                                    options:kNilOptions
                                                      error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"News Feed dispatch finished");
            
        });
    });
}


//Goes through the twitter feed and grabs the data from a JSON object on a Global thread
//This needs to be looked at because if there is NO internet it may crash
- (void)fetchTweets{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"twitter dispach started");
        STTwitterAPIWrapper *twitter = [STTwitterAPIWrapper  twitterAPIApplicationOnlyWithConsumerKey:TWITTER_CONSUMER_KEY
                                                                                      consumerSecret:TWITTER_CONSUMER_SECRET];
        
        [twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
            
            NSLog(@"Access granted with %@", bearerToken);
            [twitter getUserTimelineWithScreenName:@"HMFFEST" count:100 successBlock:^(NSArray *statuses) {
                    NSLog(@"-- statuses: %@", statuses);
            
                self.tweets=statuses;
                NSLog(@"Tweets are loaded");
                if (self.completionBlock!=nil) {
                    self.completionBlock(YES);
                    
                }
                
                
            } errorBlock:^(NSError *error) {
                // NSLog(@"-- error: %@", error);
            }];
            
        } errorBlock:^(NSError *error) {
            NSLog(@"-- error %@", error);
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"twitter dispach finished");
            
        });
    });
    
}

#pragma mark Parse Fetchers


-(void)fetchScheduleParseObjects{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"schedule dispach started");
        
        
        NSArray *scheduleObjects = [[NSMutableArray alloc]init];
        PFQuery *scheduleQuery = [PFQuery queryWithClassName:@"schedule"];
        //Puts all of the querys into an object
        scheduleObjects= [scheduleQuery findObjects];
        NSLog(@"Schedule done");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"schedule dispatch finished");
            [self parseSchedule:scheduleObjects];
            ;
            
        });
    });
    
}

-(void)parseSchedule:(NSArray*)array{
    //Try to keep the Parse calls to a minimum...there are 3 right now.
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"parseSchedule dispach started");
        
        NSMutableArray *venue= [[NSMutableArray alloc]init];
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        NSMutableArray *tempArray2 = [[NSMutableArray alloc]init];
        NSMutableArray *tempArray4 = [[NSMutableArray alloc]init];
        NSMutableArray *arrayVenue = [[NSMutableArray alloc]init];
        
        
        self.date = [[NSMutableArray alloc]init];
        self.band= [[NSMutableArray alloc]init];
        NSMutableArray *allObjectsSorted = [NSMutableArray arrayWithArray:array];
        [allObjectsSorted sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES], nil]];
        
        // NSLog(@"allobjectssorted 3%@", allObjectsSorted);
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
        
        // NSLog(@"temparray ordered?%@", tempArray4);
        
        
        //Used to find the Unique Dates
        NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:tempArray4];
        //Used to find the Unique Dates
        NSSet *uniqueDates = [orderedSet set];
        
        
        ////Put the Set back into the array so I can use it
        tempArray2= [NSMutableArray arrayWithArray:[uniqueDates allObjects]];
        // NSLog(@"temparray 3%@", tempArray2);
        
        
        self.date= [NSMutableArray arrayWithArray:tempArray2];
        
        //   NSLog(@"dates %@", self.date);
        NSMutableArray *tempArray1 = [[NSMutableArray alloc]init];
        
        for (NSDictionary *diction in allObjectsSorted){
            [tempArray1 addObject:[diction objectForKey:@"venue"]];
        }
        //Used to find the Unique Dates
        NSSet *uniqueVenues = [NSSet setWithArray:tempArray1];
        
        ////Put the Set back into the array so I can use it
        venue = [NSMutableArray arrayWithArray:[uniqueVenues allObjects]];
        //Finds venue for unique dates
        for (int i= 0; i <[self.date count]; i++) {
            for (NSDictionary *diction in allObjectsSorted){
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
        //  NSLog(@"venues %@", venue);
        
        //Finds band for unique dates and venue
        for (int i= 0; i <[self.date count]; i++) {
            NSMutableArray *arrayBand = [[NSMutableArray alloc]init];
            for (NSDictionary *diction in allObjectsSorted){
                NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                [dateFormatter1 setDateFormat:@"MMM dd YYYY"];
                NSString *compareString =[dateFormatter1 stringFromDate:[diction objectForKey:@"date"]];
                //   NSLog(@"compare date %@", compareString);
                //  NSLog(@"otherdate at i %@", [self.date objectAtIndex:i]);
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
            //  NSLog(@"band %@", self.band);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"parseSchedule dispach finished");
            
        });
    });
    
}

#pragma mark PARSE YOUTUBE OBJECTS

-(void)fetchYouTubeParseObjects{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"schedule dispach started");
        
        
        NSArray *youTubeObject = [[NSMutableArray alloc]init];
        PFQuery *youTubeQuery = [PFQuery queryWithClassName:@"youtube"];
        //Puts all of the querys into an object
        youTubeObject= [youTubeQuery findObjects];
        NSLog(@"Schedule done");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"schedule dispatch finished");
            [self parseYouTubeLinks:youTubeObject];
            ;
            
        });
    });
    
}

-(void)parseYouTubeLinks:(NSArray*)array{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"parse youtube dispach started");

        self.youTubeArray = [[NSMutableArray alloc]init];
        for (NSDictionary *diction in array){
                [self.youTubeArray addObject:diction];
                
            }
         NSLog(@"the youtube are %@", self.youTubeArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"parseyoutube dispach finished");
            ;
            
        });
    });
}


#pragma mark PARSE LINK OBJECSTS

-(void)fetchLinksParseObjects{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"links dispach started");
        
        NSArray *linkObjects = [[NSMutableArray alloc]init];
        PFQuery *linkQuery = [PFQuery queryWithClassName:@"links"];
        linkObjects= [linkQuery findObjects];
        NSLog(@"links done");
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"links dispach finished");
            [self parseTicketLink:linkObjects];
            [self parseSocialLinks:linkObjects];
            
        });
    });
    
}

-(void)parseSocialLinks:(NSArray*)array{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"parseLinks dispach started");
        
        
        NSString *links = [[NSString alloc]init];
        NSString *finalLink = [[NSString alloc]init];
        self.linksArray = [[NSMutableArray alloc]init];
        
        for (NSDictionary *diction in array){
            NSString * string=[diction objectForKey:@"name"];
            if ([string isEqualToString:@"ticket"]) {
                //Do nothing
            }
            else if ([string isEqualToString:@"hmff"]) {
                links =[diction objectForKey:@"link"];
                finalLink= [self buildLinkData:links];
                
                NSDictionary *tempDict=[[NSDictionary alloc]initWithObjectsAndKeys:[diction objectForKey:@"name"], @"name",finalLink,@"link", nil];
                [self.linksArray addObject:tempDict];
            }
            else{
                [self.linksArray addObject:diction];
                
            }
        }
        // NSLog(@"the links are %@", self.linksArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"parseLinks dispach finished");
            ;
            
        });
    });
}

-(void)parseTicketLink:(NSArray*)array{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"single link");
        NSString *links = [[NSString alloc]init];
        self.HTMLString= [[NSString alloc]init];
        
        for (NSDictionary *diction in array){
            NSString * string=[diction objectForKey:@"name"];
            if ([string isEqualToString:@"ticket"]) {
                links =[diction objectForKey:@"link"];
                self.HTMLString= [self buildLinkData:links];
                NSLog(@"we have the ticket page: %@", self.HTMLString);
            }
        }
        //  NSLog(@"the links are %@", self.linksArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"single link finished");
            ;
            
        });
    });
}

-(NSString*)buildLinkData:(NSString*)stringURL{
    NSData *urlData;    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:stringURL] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval: 10.0];
    NSError *error = nil;
    NSURLResponse* response = nil;
    urlData  = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *returnString= [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    return returnString;
}


@end
