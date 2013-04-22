//
//  HMTwitterTableViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-03-28.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "HMTwitterDetailViewController.h"
#import "HMTweetCell.h"
#import "HMAppDelegate.h"



@interface HMTwitterTableViewController : UITableViewController

@property (nonatomic, strong)NSArray *tweets;

//- (void)fetchTweets;

//This is used for a Search if needed
//@property (nonatomic, strong)NSDictionary *tweets;

@end



