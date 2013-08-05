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

@interface HMNewsFeedTableViewController : UITableViewController
//holds the news dictionary from the Data Feed Manger
@property (nonatomic, strong)NSDictionary *news;

@end
