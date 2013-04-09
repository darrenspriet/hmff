//
//  HMNewsFeedTableViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-06.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMNewsFeedDetailViewController.h"
#import "HMNewsFeedCell.h"


@interface HMNewsFeedTableViewController : UITableViewController<NSURLConnectionDelegate>

@property(nonatomic, strong) NSMutableData *newsFeedData;
@property(nonatomic, strong) NSURLConnection *connection;
@property(nonatomic, strong) NSMutableArray *titleArray;
@property(nonatomic, strong) NSMutableArray *contentArray;
@property(nonatomic, strong) NSMutableArray *dateArray;

@property (nonatomic, strong)NSArray *news;

//Add the date and also add a detail page when selected bringing up the details of all of the next feeds.

//Work on the cells making it custom and something more interesting.
@end
