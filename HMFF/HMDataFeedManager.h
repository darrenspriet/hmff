//
//  HMDataFeedManager.h
//  HMFF
//
//  Created by Darren Spriet on 2013-05-17.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "STTwitterAPIWrapper.h"
#define PARSE_APP_ID @"klHQu3ms3Mb6gzVHglLvFwfjdYoyuY0UIKDijxZC"
#define PARSE_CLIENT_KEY @"tioUMseVIJyFgr85vRqCWAiVBF36SMNE65WbqSD7"
#define FLICKR_API_KEY @"628288db7c4e7d09c884009576b5eed9"
#define FLICKER_USER_ID @"95406796"
#define FLICKER_SET_NUMBER @"72157633844444754"
#define TWITTER_CONSUMER_KEY @"FDj5uDk7unth9kkgL21PA"
#define TWITTER_CONSUMER_SECRET @"CHlhsqOzU3wZKDiKyIf25w6uxM0sKEpFylAZUa4Gt6U"
#define NEWS_URL @"http://www.hmff.com/?json=get_recent_posts&count=1000"
#define FLICKER_URL @"http://api.flickr.com/services/rest/?&method=flickr.photosets.getPhotos&photoset_id=%@&api_key=%@&user_id=%@&per_page=20&format=json&nojsoncallback=1"
#define SMALL_FLICKER_PHOTO @"http://farm%@.static.flickr.com/%@/%@_%@_t.jpg"
#define LARGE_FLICKER_PHOTO @"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg"

typedef void (^HMDataFeedManagerCompletionBlock)(BOOL success);

@interface HMDataFeedManager : NSObject

//As singleton Object that is called at the beginning of the Application
+ (HMDataFeedManager*) sharedDataFeedManager;


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

@property(nonatomic, copy)HMDataFeedManagerCompletionBlock completionBlock;

@property(strong, nonatomic)NSString *HTMLString;

@property(strong, nonatomic)NSMutableArray *linksArray;

@property(strong, nonatomic)NSMutableArray *youTubeArray;




@end
