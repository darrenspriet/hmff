//
//  HMBuyTicketsViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-24.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMBuyTicketsViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIWebView* webView;
@property (nonatomic, retain) IBOutlet UIToolbar* toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* back;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* forward;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* refresh;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* stop;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSString *passedURL;
-(IBAction)shareButtonPressed:(UIBarButtonItem*)sender;
- (void)updateButtons;


@end
