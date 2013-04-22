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

@implementation HMAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [Parse setApplicationId:APP_ID clientKey:CLIENT_KEY];
    [self getParseObjects];
    [self fetchTweets];
    
    return YES;
}

- (void)fetchTweets
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        
                        //This is used for a Search if needed
                        //     [NSURL URLWithString:@"https://search.twitter.com/search.json?q=%23hmffest"]];
                        
                        [NSURL URLWithString: @"https://api.twitter.com/1/statuses/user_timeline.json?screen_name=HMFFEST&include_rts=1&count=100"]];
        
        NSError* error;
        
        self.tweets = [NSJSONSerialization JSONObjectWithData:data
                                                      options:kNilOptions
                                                        error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    });
}

-(void)getParseObjects{
    
    //Try to keep the Parse calls to a minimum...there are 3 right now.
    
    self.allObjects = [[NSMutableArray alloc]init];
    self.date = [[NSMutableArray alloc]init];
    self.venue= [[NSMutableArray alloc]init];
    self.band= [[NSMutableArray alloc]init];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    //Initial query
    PFQuery *query = [PFQuery queryWithClassName:@"HMFFDates"];
    //Puts all of the querys into an object
    self.allObjects= [query findObjects];

    //Pulls out all of the dates from the objects
    for (NSDictionary *diction in self.allObjects){
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
    
    for (NSDictionary *diction in self.allObjects){
        [tempArray1 addObject:[diction objectForKey:@"venue"]];
    }
    //Used to find the Unique Dates
    NSSet *uniqueVenues = [NSSet setWithArray:tempArray1];
    
    ////Put the Set back into the array so I can use it
    self.venue= [NSMutableArray arrayWithArray:[uniqueVenues allObjects]];
    
    NSMutableArray *arrayVenue = [[NSMutableArray alloc]init];
    //Finds venue for unique dates
    for (int i= 0; i <[self.date count]; i++) {
        for (NSDictionary *diction in self.allObjects){
            if ([[diction objectForKey:@"date"] isEqualToString:[self.date objectAtIndex:i]]) {
                [arrayVenue addObject:[diction objectForKey:@"venue"]];
            }
        }
        
    }
    //Sorts the Venues, and into unique Venues
    uniqueVenues = [NSSet setWithArray:arrayVenue];
    NSLog(@"unique venues %@", uniqueVenues);
    
    self.venue = [NSMutableArray arrayWithArray:[uniqueVenues allObjects]];
    NSLog(@"venues %@", self.venue);
    
    //Finds band for unique dates and venue
    for (int i= 0; i <[self.date count]; i++) {
        NSMutableArray *arrayBand = [[NSMutableArray alloc]init];
        for (NSDictionary *diction in self.allObjects){
            if ([[diction objectForKey:@"date"] isEqualToString:[self.date objectAtIndex:i]]) {
                if ([[diction objectForKey:@"venue"] isEqualToString:[self.venue objectAtIndex:i]]) {
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
