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


@interface HMTwitterTableViewController : UITableViewController{
NSArray *tweets;
}

- (void)fetchTweets;
@end



