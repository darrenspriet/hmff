//
//  HMTwitterTableViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-03-28.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMTwitterTableViewController : UITableViewController

-(void)fetchTweets;
@property (nonatomic)NSArray *tweets;

@end



