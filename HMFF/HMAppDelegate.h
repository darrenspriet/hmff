//
//  HMAppDelegate.h
//  HMFF
//
//  Created by Darren Spriet on 13-03-21.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "HMFirstTableViewController.h"


@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//Holds the Dates that will be sent to Schedule View Controller(Parse)
@property (nonatomic, strong) NSMutableArray *date;

//Holds the Bands that will be sent to Schedule View Controller(Parse)
@property (nonatomic, strong) NSMutableArray *band;

//Holds the Tweets that will be sent to Twitter View Controller(Twitter)
@property (nonatomic, strong) NSArray *tweets;

//Holds the News Feeds that will be sent to News View Controller(News)
@property (nonatomic, strong)NSDictionary *news;

//Holds the Photos that will be sent to More View Controller(More)
@property (nonatomic, strong) NSDictionary *photos;

//Holds the Small Photos that will be sent to More View Controller(More)
@property (nonatomic, strong) NSMutableArray *smallPhotos;

//Holds the Large Photos that will be sent to More View Controller(More)
@property (nonatomic, strong) NSMutableArray *largePhotos;



@end
