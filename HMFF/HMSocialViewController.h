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
//Holds the HTMLString of the Tickets Page
@property(strong, nonatomic)NSString*HTMLString;
//used to set the links array
@property(strong, nonatomic)NSMutableArray *links;
//used to set the facebook NSString
@property(strong, nonatomic)NSString *facebook;
//used to set the twitter NSString
@property(strong, nonatomic)NSString *twitter;
//used to set the youtube NSString
@property(strong, nonatomic)NSString *youtube;
//used to set the hmffWebSite NSString
@property(strong, nonatomic)NSString *hmffWebsite;
//used to set the vimeo NSString
@property(strong, nonatomic)NSString *vimeo;
//the view that we can change the alpha with it
@property (weak, nonatomic) IBOutlet UIView *controllerView;









@end
