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
    [self fetchLinks];
    
    //Fetches all of the News Feeds
    [self fetchNewsFeed];
    
    //Fetches all of the Tweets for HMFFEST from twitter
    [self fetchTweets];
    
    //Fetches the FlickerFeed
    [self fetchFlickerFeed];
    
    //Fetches all of the schedule parse objects
    [self fetchSchedule];
    
    //Fetches all of the youtube parse objects
    [self fetchYouTube];
    
    //Fetches all of the submit page parse objects
    [self fetchSubmit];
    
    return self;
}
#pragma mark Flicker Fetchers
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
//loads the flickerPhotos in the arrays
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
            
            
            //Add all of the small photos with NSdata and a urlstring
            [self.smallPhotos addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
            
            
            // Build and save the URL to the large image so we can zoom
            // in on the image if requested
            photoURLString = [NSString stringWithFormat:LARGE_FLICKER_PHOTO, [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]];
            UIImage *largeImage= [UIImage imageWithData:imageData];
            
            //sets the large photos to the large image from above
            [self.largePhotos addObject:largeImage];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"photos array dispach finished");
            
        });
    });
    
    
}

#pragma mark News Fetcher
//Goes through the news feed and grabs the data from a JSON object on the MAIN thread
- (void)fetchNewsFeed{
    //Must change this Cause it is on the mainQue
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"News Feed dispach started");
        
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString: NEWS_URL]];
        
        NSError* error;
        
        [self setNews: [NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions
                                                         error:&error]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"News Feed dispatch finished");
            
        });
    });
}

#pragma mark Twitter Fetcher
//Goes through the twitter feed and grabs the data from a JSON object on the main queue, utilizes the STTwitter library found at: https://github.com/nst/STTwitter
- (void)fetchTweets{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"twitter dispach started");
        //sets up the credentials the consumer key and the consumber secret
        STTwitterAPIWrapper *twitter = [STTwitterAPIWrapper  twitterAPIApplicationOnlyWithConsumerKey:TWITTER_CONSUMER_KEY
                                                                                       consumerSecret:TWITTER_CONSUMER_SECRET];
        
        [twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
            
            //sets the username and count of twitter feeds
            [twitter getUserTimelineWithScreenName:@"HMFFEST" count:100 successBlock:^(NSArray *statuses) {
                
                //sets the tweets to the statuses
                [self setTweets:statuses];
                NSLog(@"Tweets are loaded");
                
                //if this executes then the splash screeen will load the schedule page
                if (self.completionBlock!=nil) {
                    self.completionBlock(YES);
                }
            } errorBlock:^(NSError *error) {
                // NSLog(@"-- error: %@", error);
            }];
            
        } errorBlock:^(NSError *error) {
            //            NSLog(@"-- error %@", error);
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"twitter dispach finished");
        });
    });
}

#pragma mark Schedule Fetchers
//starts the schedule parse
-(void)fetchSchedule{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"schedule dispach started");
        NSArray *scheduleObjects = [[NSMutableArray alloc]init];
        //creates a pfquery for the schedule
        PFQuery *scheduleQuery = [PFQuery queryWithClassName:@"schedule"];
        //Puts all of the querys into an object
        scheduleObjects= [scheduleQuery findObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"schedule dispatch finished");
            //parse's the schedule objects
            [self parseSchedule:scheduleObjects];
            ;
            
        });
    });
    
}
//used to parse through the schedule objects
-(void)parseSchedule:(NSArray*)array{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"parseSchedule dispach started");
        
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
        NSMutableArray *tempDates = [[NSMutableArray alloc]init];
        tempDates= [NSMutableArray arrayWithArray:[tempDateUniqueDates allObjects]];
        
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
        NSMutableArray *venue= [[NSMutableArray alloc]init];
        venue = [NSMutableArray arrayWithArray:[uniqueVenues allObjects]];
        
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
            NSLog(@"parseSchedule dispach finished");
            
        });
    });
    
}

#pragma mark Youtube fetcher
//fetches the youtubes from parse.com
-(void)fetchYouTube{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"youTube dispach started");
        
        NSArray *youTubeObject = [[NSMutableArray alloc]init];
        //creates a query to the youtube table
        PFQuery *youTubeQuery = [PFQuery queryWithClassName:@"youtube"];
        
        //Puts all of the querys into an object
        youTubeObject= [youTubeQuery findObjects];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"youTube dispatch finished");
            
            //parses through all of the youtube objects
            [self parseYouTubeLinks:youTubeObject];
            ;
            
        });
    });
    
}
//parses the youtube links
-(void)parseYouTubeLinks:(NSArray*)array{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"parse youtube dispach started");
        
        [self setYouTubeArray:[[NSMutableArray alloc]init]];
        
        //iterates through the youtube objects
        for (NSDictionary *diction in array){
            [self.youTubeArray addObject:diction];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"parse youtube dispach finished");
            ;
        });
    });
}


#pragma mark Submit fetcher
//fetches all of the information for the Submission pages
-(void)fetchSubmit{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"submit dispach started");
        
        NSArray *submitObject = [[NSMutableArray alloc]init];
        
        //Creates a query from parse and the submit class
        PFQuery *submitQuery = [PFQuery queryWithClassName:@"submit"];
        
        //Puts all of the querys into an object
        submitObject= [submitQuery findObjects];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"submitParseDone dispatch finished");
            //parse through the submit details
            [self parseSubmitDetails:submitObject];
            ;
            
        });
    });
    
}
//parses through all of the Submit details
-(void)parseSubmitDetails:(NSArray*)array{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"parse submit dispach started");
        
        [self setSubmitArray: [[NSMutableArray alloc]init]];
        
        //iterates through the objects in the submit table
        for (NSDictionary *diction in array){
            NSString * string=[diction objectForKey:@"name"];
            //if the name is entry form
            if ([string isEqualToString:@"entryformlink"]) {
                //load the Pdf Data for further use
                [self loadPdfData: [diction objectForKey:@"details"]];
                
            }
            //then add them all to the submit array
            [self.submitArray addObject:diction];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"submitDetails dispach finished");
            ;
        });
    });
}
//takes the string from the url and loads it into nsdata so it can be opened in a document
-(void)loadPdfData:(NSString*)string{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"parse loadPDF started dispach started");
        
        //loads the pdf data into the nsdata property
        [self setPdfData:  [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:string]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"loadPDF dispach finished");
            ;
        });
    });
}

#pragma mark links fetcher
//fetch all of the links from parse
-(void)fetchLinks{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"links dispach started");
        
        NSArray *linkObjects = [[NSMutableArray alloc]init];
        
        //create a query that grabs the objects from the class called links
        PFQuery *linkQuery = [PFQuery queryWithClassName:@"links"];
        linkObjects= [linkQuery findObjects];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"links dispach finished");
            
            //parses the TicketLink into a HTMLString
            [self parseTicketLink:linkObjects];
            
            //parses through the Social links to save to an array
            [self parseSocialLinks:linkObjects];
        });
    });
}

//parses through the social links
-(void)parseSocialLinks:(NSArray*)array{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"parseLinks dispach started");
        
        //allocating arrays
        NSString *finalLink = [[NSString alloc]init];
        [self setLinksArray: [[NSMutableArray alloc]init]];
        
        //iterates through the array and puts it into the linksArray
        for (NSDictionary *diction in array){
            NSString * string=[diction objectForKey:@"name"];
            
            //if the name is equal to hmff
            if ([string isEqualToString:@"hmff"]) {
                
                //adds it to the links Array
                [self.linksArray addObject:diction];
                
                //Then builds a HTMLString of the Website
                finalLink= [self buildLinkData:[diction objectForKey:@"link"]];
                
                //builds a temporary NSDictionary with the final Link
                NSDictionary *tempDict=[[NSDictionary alloc]initWithObjectsAndKeys:@"htmlLink", @"name",finalLink,@"link", nil];
                
                //adds the dictionary to the linksArray
                [self.linksArray addObject:tempDict];
            }
            else{
                //adds the dictionary to the links array
                [self.linksArray addObject:diction];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"parseLinks dispach finished");
            ;
            
        });
    });
}

//parses through to get the ticket link
-(void)parseTicketLink:(NSArray*)array{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"single link");
        
        //initializes the strings
        [self setHTMLString: [[NSString alloc]init]];
        
        //iterates through the array to find the ticket
        for (NSDictionary *diction in array){
            NSString * string=[diction objectForKey:@"name"];
            if ([string isEqualToString:@"ticket"]) {
                
                //calls the build link data and sets it to the HTMLString
                [self setHTMLString: [self buildLinkData:[diction objectForKey:@"link"]]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"single link finished");
            ;
        });
    });
}

//builds Link Data sending in a string and returning a string
-(NSString*)buildLinkData:(NSString*)string{
    //intialize a NSData
    NSData *urlData;
    //sets up a request with the string passed in
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:string] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval: 10.0];
    //initializes an NSError, and NSURLResponse
    NSError *error = nil;
    NSURLResponse* response = nil;
    //sets the url data with the request and response and error
    urlData  = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //sets up the string with the url data from above
    NSString *returnString= [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    //returnts the return string from above
    return returnString;
}


@end
