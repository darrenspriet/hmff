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

//The property that holds the news feed that is sent from App Delegate
@property (nonatomic, strong)NSDictionary *news;

@end
