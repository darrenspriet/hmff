//
//  HMDataFeedManager.h
//  HMFF
//
//  Created by Darren Spriet on 2013-05-17.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#define APP_ID @"BKjoCRi6vlE1bMuIY100LN8zsIrlWprOUUZyuaAg"
#define CLIENT_KEY @"xxSG9DGIVpodQBawjcSWKhgqkH3tdL1kaWM6e7bW"
#define FLICKR_API_KEY @"628288db7c4e7d09c884009576b5eed9"

@interface HMDataFeedManager : NSObject

//As singleton Object that is called at the beginning of the Application
+ (HMDataFeedManager*) sharedDataFeedManager;

//Gets Parse Objects
-(void)getParseObjects;

//Fetches Flicker Feed
-(void)fetchFlickerFeed;

//Fetches News Feed from website
- (void)fetchNewsFeed;

//Fetches there Tweets
- (void)fetchTweets;

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
