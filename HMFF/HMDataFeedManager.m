//
//  HMDataFeedManager.m
//  HMFF
//
//  Created by Darren Spriet on 2013-05-17.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMDataFeedManager.h"

@interface HMDataFeedManager()
@property (nonatomic, strong) STTwitterAPIWrapper *twitter;

@end

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
-(void)checkPhotoLoadingStatus{
    if (!self.isFinishedPhotos) {
        [self setMustNotDownloadPhotos:YES];
    }
}
-(void)cancelActions{
    if (!self.isFinishedPhotos) {
        [self setMustNotDownloadPhotos:YES];
    }
}

//The init Method
-(id)init{
    //Initialize Bools for tracking photo
    [self setIsFinishedPhotos:NO];
    [self setMustNotDownloadPhotos:NO];
    
    //Fetches all of the Tweets for HMFFEST from twitter
    [self fetchTweets];
    
    //Fetches the FlickerFeed
    [self fetchFlickerFeed];
    
    //Fetches all of the News Feeds
    [self fetchNewsFeed];
    
    //Fetches all of the schedule parse objects
    [self fetchSchedule];
    
    //Removing for faster launch
    
    //    //Fetches all of the links parse objects
    //    [self fetchLinks];
    //
    //    //Fetches all of the youtube parse objects
    //    [self fetchYouTube];
    
    //Fetches all of the submit page parse objects
    [self fetchSubmit];
    
    return self;
}


#pragma mark Flicker Fetchers
//Fetches all of the FlickerFeeds
-(void)fetchFlickerFeed{
    dispatch_queue_t myQueue = dispatch_queue_create("FLICKER FETCH QUE",NULL);
    dispatch_async(myQueue, ^{
        
        [self setPhotos:[[NSDictionary alloc]init] ];
        
        
        
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString:[NSString stringWithFormat:FLICKER_URL,FLICKER_SET_NUMBER ,FLICKR_API_KEY, FLICKER_USER_ID ]]];
        
        if (data!=nil) {
            NSError* error;
            [self setPhotos: [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error]];
        }
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //            NSDate *endTime= [NSDate date];
            //            CGFloat difference= [endTime timeIntervalSinceDate:startTime];
            //            NSLog(@"Flicker Finished Time:%f", difference);
            if (data!=nil) {
                [self loadPhotoArrays];
            }
        });
    });
    
}

//loads the flickerPhotos in the arrays
-(void)loadPhotoArrays{
    dispatch_queue_t myQueue = dispatch_queue_create("LOAD PHOTOS ARRAY",NULL);
    dispatch_async(myQueue, ^{
        //        NSDate *startTime= [NSDate date];
        //        NSLog(@"Photos Thread:%@ ",[NSThread currentThread]);
        
        // Build an array from the dictionary for easy access to each entry
        //If trying to get the Stream the first object is "photo", other wise if it is a set
        //its a "photoset"
        NSArray *photos = [[self.photos objectForKey:@"photoset"] objectForKey:@"photo"];
        self.smallPhotos =[[NSMutableArray alloc]init];
        self.largePhotosData =[[NSMutableArray alloc]init];
        
        // Loop through each entry in the dictionary...
        for (NSDictionary *photo in photos)
        {
            // Get title of the image
            // Build the URL to where the image is stored (see the Flickr API)
            // In the format http://farmX.static.flickr.com/server/id/secret
            // Notice the "_s" which requests a "small" image 75 x 75 pixels
            NSString *photoURLString = nil;
            if (!self.mustNotDownloadPhotos)
            {
                photoURLString = [NSString stringWithFormat:SMALL_FLICKER_PHOTO, [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
            }
            if (!self.mustNotDownloadPhotos)
            {
                //Add all of the small photos with NSdata and a urlstring
                
                NSError *error=nil;
                NSData *theData =[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString] options:NSDataReadingMappedAlways error:&error];
                if (error) {
                    //NSLog(@"error is%@", error);
                }
                else{
                    [self.smallPhotos addObject:theData];
                }
            }
            
            // Build and save the URL to the large image so we can zoom
            // in on the image if requested
            if (!self.mustNotDownloadPhotos)
            {
                photoURLString = [NSString stringWithFormat:LARGE_FLICKER_PHOTO, [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
            }
            if (!self.mustNotDownloadPhotos)
            {
                NSError *error=nil;
                NSData *theData =[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString] options:NSDataReadingMappedAlways error:&error];
                if (error) {
                    //NSLog(@"error is%@", error);
                }
                else{
                    [self.largePhotosData addObject:theData];
                }
            }
        }
        //If photos didn't finish then we need to run the process again
        if (self.mustNotDownloadPhotos) {
            [self setMustNotDownloadPhotos:NO];
            [self loadPhotoArrays];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setIsFinishedPhotos:YES];
            
            //            NSDate *endTime= [NSDate date];
            //            CGFloat difference= [endTime timeIntervalSinceDate:startTime];
            //            NSLog(@"Photos Finished Time:%f", difference);
            
        });
    });
    
}

#pragma mark News Fetcher
//Goes through the news feed and grabs the data from a JSON object on the MAIN thread
- (void)fetchNewsFeed{
    dispatch_queue_t myQueue = dispatch_queue_create("NEWS FEED QUE",NULL);
    dispatch_async(myQueue, ^{
        //        NSDate *startTime= [NSDate date];
        //        NSLog(@"News Feed Thread:%@",[NSThread currentThread]);
        
        
        
        
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString: NEWS_URL]];
        
        if (data!=nil) {
            NSError* error;
            [self setNews: [NSJSONSerialization JSONObjectWithData:data
                                                           options:kNilOptions
                                                             error:&error]];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //            NSDate *endTime= [NSDate date];
            //            CGFloat difference= [endTime timeIntervalSinceDate:startTime];
            //            NSLog(@"News Feed Finished:%f", difference);
            
        });
    });
}

#pragma mark Twitter Fetcher
//Goes through the twitter feed and grabs the data from a JSON object on the main queue, utilizes the STTwitter library found at: https://github.com/nst/STTwitter
- (void)fetchTweets{
    dispatch_async(dispatch_get_main_queue(), ^{
        //        NSDate *startTime= [NSDate date];
        //        NSLog(@"Twitter Feed Thread:%@",[NSThread currentThread]);
        
        
        //sets up the credentials the consumer key and the consumber secret
        self.twitter = [STTwitterAPIWrapper  twitterAPIApplicationOnlyWithConsumerKey:TWITTER_CONSUMER_KEY
                                                                       consumerSecret:TWITTER_CONSUMER_SECRET];
        
        __weak typeof(self) weakSelf = self;
        
        self.scheduleCompletionBlock = ^(BOOL success){
            if (success)
            {
                [weakSelf.twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
                    
                    //sets the username and count of twitter feeds
                    [weakSelf.twitter getUserTimelineWithScreenName:@"HMFFEST" count:100 successBlock:^(NSArray *statuses) {
                        
                        //sets the tweets to the statuses
                        [weakSelf setTweets:statuses];
                        //                NSLog(@"Tweets are loaded");
                        //if this executes then the splash screeen will load the schedule page
                        
                        
                        if (weakSelf.completionBlock!=nil) {
                            weakSelf.completionBlock(YES);
                        }
                        
                        //                        NSDate *endTime= [NSDate date];
                        //                        CGFloat difference= [endTime timeIntervalSinceDate:startTime];
                        //                        NSLog(@"Completion Block Tweet Thread:%@ and Time:%f",[NSThread currentThread], difference);
                    } errorBlock:^(NSError *error) {
                        // NSLog(@"-- error: %@", error);
                    }];
                    
                    
                } errorBlock:^(NSError *error) {
                    //            NSLog(@"-- error %@", error);
                }];
            }
            else{
                //            NSLog(@"app did not load successfully");
            }
        };
        dispatch_async(dispatch_get_main_queue(), ^{
            //            NSDate *endTime= [NSDate date];
            //            CGFloat difference= [endTime timeIntervalSinceDate:startTime];
            //            NSLog(@"Twitter Finished: %f", difference);
        });
    });
}

#pragma mark Schedule Fetchers
//starts the schedule parse
-(void)fetchSchedule{
    
    dispatch_queue_t myQueue = dispatch_queue_create("SCHEDULE QUE",NULL);
    dispatch_async(myQueue, ^{
        //        NSDate *startTime= [NSDate date];
        //        NSLog(@"Schedule Feed Thread:%@",[NSThread currentThread]);
        
        
        //        NSLog(@"schedule dispach started");
        
        //creates a pfquery for the schedule
        PFQuery *scheduleQuery = [PFQuery queryWithClassName:@"schedule"];
        //Puts all of the querys into an object
        NSArray *scheduleObjects = nil;
        if (scheduleQuery!=nil) {
            scheduleObjects= [scheduleQuery findObjects];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //            NSDate *endTime= [NSDate date];
            //            CGFloat difference= [endTime timeIntervalSinceDate:startTime];
            //            NSLog(@"Schedule Finished: %f", difference);
            
            //parse's the schedule objects
            if (scheduleQuery!=nil) {
                [self parseSchedule:scheduleObjects];
            }
            else{
                if (self.scheduleCompletionBlock!=nil) {
                    self.scheduleCompletionBlock(YES);
                }
            }
            
        });
    });
    
}
//used to parse through the schedule objects
-(void)parseSchedule:(NSArray*)array{
    dispatch_queue_t myQueue = dispatch_queue_create("PARSE QUE",NULL);
    dispatch_async(myQueue, ^{
        //        NSLog(@"parseSchedule dispach started");
        
        //Allocating all of the Arrays
        [self setDate: [[NSMutableArray alloc]init]];
        [self setBand: [[NSMutableArray alloc]init]];
        
        //puts the recieved array into another array called allObjectsSorted
        NSMutableArray *allObjectsSorted = [NSMutableArray arrayWithArray:array];
        //sorts by date
        [allObjectsSorted sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES], nil]];
        
        //Creating a date only used for the Scroll View not with 99
        NSMutableArray *tempDatesArray = [[NSMutableArray alloc]init];
        for (NSDictionary *diction in allObjectsSorted){
            if (![[diction objectForKey:@"band_order"] isEqualToNumber:[NSNumber numberWithInt:99]]) {
                [tempDatesArray addObject:[diction objectForKey:@"date"]];
            }
        }
        
        //Date formatters
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd YYYY"];
        
        NSMutableArray *tempDatesWithFormat = [[NSMutableArray alloc]init];
        //iterates throught he dates anf formats them into a new array
        for (NSDate *date in tempDatesArray){
            [tempDatesWithFormat addObject:[dateFormatter stringFromDate:date]];
        }
        
        //creates a order set from the dates with the format
        NSOrderedSet *tempDateOrderedSet = [NSOrderedSet orderedSetWithArray:tempDatesWithFormat];
        //Used to find the Unique Dates
        NSSet *tempDateUniqueDates = [tempDateOrderedSet set];
        
        //sets the tempDates the the tempDates unique dates all objects
        NSMutableArray *tempDates= [NSMutableArray arrayWithArray:[tempDateUniqueDates allObjects]];
        
        //Pulls out all of the real dates from the objects
        NSMutableArray *realDates = [[NSMutableArray alloc]init];
        for (NSDictionary *diction in allObjectsSorted){
            [realDates addObject:[diction objectForKey:@"date"]];
        }
        //formats all of the dates and adds them to formatted dates array
        NSMutableArray *dateWithFormat = [[NSMutableArray alloc]init];
        for (NSDate *date in realDates){
            [dateWithFormat addObject:[dateFormatter stringFromDate:date]];
        }
        
        //Used to find the Unique Dates
        NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:dateWithFormat];
        //Used to find the Unique Dates
        NSSet *uniqueDates = [orderedSet set];
        //set the date with the set and unique dates
        [self setDate: [NSMutableArray arrayWithArray:[uniqueDates allObjects]]];
        
        //grabs all of the venue objects and puts them into temp venue array
        NSMutableArray *tempArray1 = [[NSMutableArray alloc]init];
        for (NSDictionary *diction in allObjectsSorted){
            [tempArray1 addObject:[diction objectForKey:@"venue"]];
        }
        
        //Finds venue for unique dates
        NSMutableArray *arrayVenue = [[NSMutableArray alloc]init];
        for (int i= 0; i <[self.date count]; i++) {
            //iterates through all of the objects
            for (NSDictionary *diction in allObjectsSorted){
                //sets the string to compare to the the date
                NSString *compareString =[dateFormatter stringFromDate:[diction objectForKey:@"date"]];
                //checks to see what the date for the venue is
                if ([compareString isEqualToString:[self.date objectAtIndex:i]]) {
                    //adds that to the array venue
                    [arrayVenue addObject:[diction objectForKey:@"venue"]];
                }
            }
        }
        
        //Sorts the Venues, and into unique Venues
        NSSet *uniqueVenues = [NSSet setWithArray:arrayVenue];
        //sets the venue array with the unique venues
        NSMutableArray *venue = [NSMutableArray arrayWithArray:[uniqueVenues allObjects]];
        
        //Finds band for unique dates and venue
        for (int i= 0; i <[self.date count]; i++) {
            NSMutableArray *tempBand = [[NSMutableArray alloc]init];
            for (NSDictionary *diction in allObjectsSorted){
                
                //sets the string to compare to the the date
                NSString *compareString =[dateFormatter stringFromDate:[diction objectForKey:@"date"]];
                
                //checks to see what the date for the venue is
                if ([compareString isEqualToString:[self.date objectAtIndex:i]]) {
                    
                    //iterates through the venues
                    for (int j=0; j<[venue count]; j++) {
                        //if this object is equal to the venue object inside
                        if ([[diction objectForKey:@"venue"] isEqualToString:[venue objectAtIndex:j]]) {
                            //Adds the band dictionary to the temband
                            [tempBand addObject:diction];
                        }
                    }
                }
            }
            //Adds the Array with dictionarys in it to the array
            [self.band addObject:tempBand];
        }
        //sets the dates to the temp Dates as this is what we need for the app
        [self setDate:tempDates];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.scheduleCompletionBlock!=nil) {
                self.scheduleCompletionBlock(YES);
            }
            //            NSLog(@"parseSchedule dispach finished");
            
        });
    });
    
}

#pragma mark Youtube fetcher
//fetches the youtubes from parse.com
-(void)fetchYouTube{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //        NSLog(@"youTube dispach started");
        
        //creates a query to the youtube table
        PFQuery *youTubeQuery = [PFQuery queryWithClassName:@"youtube"];
        
        //Puts all of the querys into an object
        NSArray *youTubeObject= [youTubeQuery findObjects];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            NSLog(@"youTube dispatch finished");
            
            //parses through all of the youtube objects
            [self parseYouTubeLinks:youTubeObject];
            ;
            
        });
    });
    
}
//parses the youtube links
-(void)parseYouTubeLinks:(NSArray*)array{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //        NSLog(@"parse youtube dispach started");
        
        [self setYouTubeArray:[[NSMutableArray alloc]init]];
        
        //iterates through the youtube objects
        for (NSDictionary *diction in array){
            [self.youTubeArray addObject:diction];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //            NSLog(@"parse youtube dispach finished");
            ;
        });
    });
}


#pragma mark Submit fetcher
//fetches all of the information for the Submission pages
-(void)fetchSubmit{
    dispatch_queue_t myQueue = dispatch_queue_create("SUBMIT QUE",NULL);
    dispatch_async(myQueue, ^{
        //        NSDate *startTime= [NSDate date];
        //        NSLog(@"Submit Feed Thread:%@",[NSThread currentThread]);
        
        self.submitObject = [[NSMutableArray alloc]init];
        
        //Creates a query from parse and the submit class
        PFQuery *submitQuery = [PFQuery queryWithClassName:@"submit"];
        
        if (submitQuery!=nil) {
            //Puts all of the querys into an object
            self.submitObject= [submitQuery findObjects];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            NSDate *endTime= [NSDate date];
            //            CGFloat difference= [endTime timeIntervalSinceDate:startTime];
            //            NSLog(@"Submit Finished: %f", difference);
            //parse through the submit details
            if (submitQuery!=nil) {
                [self parseSubmitDetails:self.submitObject];
                
            }
            
        });
    });
    
}
//parses through all of the Submit details
-(void)parseSubmitDetails:(NSArray*)array{
    
    dispatch_queue_t myQueue = dispatch_queue_create("SUBMIT QUE",NULL);
    dispatch_async(myQueue, ^{
        //        NSLog(@"parse submit dispach started");
        
        //allocates the memory for the to properties
        [self setPdfData:[[NSData alloc]init]];
        [self setBandPdfData:[[NSData alloc]init]];
        [self setSubmitArray: [[NSMutableArray alloc]init]];
        [self setHTMLString: [[NSString alloc]init]];
        //iterates through the objects in the submit table
        for (NSDictionary *diction in array){
            //then add them all to the submit array
            [self.submitArray addObject:diction];
            if ([[diction objectForKey:@"name"] isEqualToString:@"ticketLink"]) {
                [self setHTMLString:[diction objectForKey:@"details" ]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //            NSLog(@"submitDetails dispach finished");
            ;
        });
    });
}


#pragma mark links fetcher
//fetch all of the links from parse
-(void)fetchLinks{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //        NSLog(@"links dispach started");
        
        //initializes the Arrays
        [self setLinkObject :[[NSMutableArray alloc]init]];
        [self setLinksArray :[[NSMutableArray alloc]init]];
        
        //initializes the strings
        [self setHTMLString: [[NSString alloc]init]];
        
        //create a query that grabs the objects from the class called links
        PFQuery *linkQuery = [PFQuery queryWithClassName:@"links"];
        [self setLinkObject: [linkQuery findObjects]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            NSLog(@"links dispach finished");
            
        });
    });
}


@end
