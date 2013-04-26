//
//  HMSocialWebBrowserViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-10.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HMSocialWebBrowserViewController : UIViewController

//All properties for web browser
@property (nonatomic, retain) IBOutlet UIWebView* webView;
@property (nonatomic, retain) IBOutlet UIToolbar* toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* back;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* forward;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* refresh;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* stop;



//Property used to pass the URL to the the web page
@property (nonatomic, strong) NSString *passedURL;

//Share button
-(IBAction)shareButtonPressed:(UIBarButtonItem*)sender;


@end
