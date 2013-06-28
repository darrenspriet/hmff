//
//  HMSplashViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-05-17.
//  Copyright (c) 2013 HMFF. All rights reserved.
//
@class Reachability;
#import <UIKit/UIKit.h>


@interface HMSplashViewController : UIViewController{
    Reachability* internetReachable;
    Reachability* hostReachable;
}

@property (weak, nonatomic) IBOutlet UIImageView *splashImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

-(void) checkNetworkStatus:(NSNotification *)notice;

@end
