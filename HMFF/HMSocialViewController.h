//
//  HMSocialViewController.h
//  HMFF
//
//  Created by Darren Spriet on 13-03-21.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSocialWebBrowserViewController.h"

@interface HMSocialViewController : UIViewController

@property(strong, nonatomic)NSString *HTMLString;

@property(strong, nonatomic)NSMutableArray *links;

@property(strong, nonatomic)NSString *facebook;

@property(strong, nonatomic)NSString *twitter;

@property(strong, nonatomic)NSString *youtube;

@property(strong, nonatomic)NSString *hmffWebsite;

@property(strong, nonatomic)NSString *vimeo;








@end
