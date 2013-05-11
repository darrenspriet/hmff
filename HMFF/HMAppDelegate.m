//
//  HMAppDelegate.m
//  HMFF
//
//  Created by Darren Spriet on 13-03-21.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMAppDelegate.h"
#define APP_ID @"BKjoCRi6vlE1bMuIY100LN8zsIrlWprOUUZyuaAg"
#define CLIENT_KEY @"xxSG9DGIVpodQBawjcSWKhgqkH3tdL1kaWM6e7bW"
#define FLICKR_API_KEY @"628288db7c4e7d09c884009576b5eed9"


@implementation HMAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    //Fetches all of the News Feeds From HMFF
    [self fetchNewsFeed];
    
    //Sets all of the Bar Button Items in the entire app to black
    [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
    
    //Set the status bar style to blackopaque
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    //This is the Client key and app ID for the parse online
    [Parse setApplicationId:APP_ID clientKey:CLIENT_KEY];
    [self getParseObjects];
    
    //Fetches all of the Tweets for HMFFEST from twitter
    [self fetchTweets];
    
    
    [self fetchFlickerFeed];
    
    
    
    return YES;
}
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
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HMFF" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HMFF.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
