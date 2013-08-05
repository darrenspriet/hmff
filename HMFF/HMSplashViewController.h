//
//  HMSplashViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-05-17.
//  Copyright (c) 2013 HMFF. All rights reserved.
//
@class Reachability;
#import <UIKit/UIKit.h>


@interface HMSplashViewController : UIViewController

//splash image
@property (weak, nonatomic) IBOutlet UIImageView *splashImage;
//Date label
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
//city label
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
//large activity indicator
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *largeActivitiyIndicator;
//hmff logo
@property (weak, nonatomic) IBOutlet UIImageView *hmffImage;
//internetReachable property
@property (strong, nonatomic) Reachability* internetReachable;
//hostReachable property
@property (strong, nonatomic) Reachability* hostReachable;
//for checking for the status of the network
-(void) checkNetworkStatus:(NSNotification *)notice;

@end
