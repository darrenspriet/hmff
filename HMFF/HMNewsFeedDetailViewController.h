//
//  HMNewsFeedDetailViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-08.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMNewsFeedDetailViewController : UIViewController

@property (nonatomic)NSDictionary *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UITextView *content;


//Left off at the Feed Detail view controller and must do all the the schedule controllers
//and the app delegates as well as anything else below

@end
