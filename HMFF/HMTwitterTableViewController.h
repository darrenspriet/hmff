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

@interface HMTwitterTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *dataSource;
//@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;
- (void)requestTimeline;
//- (IBAction)requestMentions:(id)sender;
@end



