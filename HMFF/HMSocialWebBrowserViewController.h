//
//  HMSocialWebBrowserViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-10.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HMSocialWebBrowserViewController : UIViewController<UIActionSheetDelegate>
//HTMLString passed to the URL
@property (nonatomic, strong) NSString *HTMLString;
//the webview on the storyboard
@property (nonatomic, retain) IBOutlet UIWebView* webView;
//the toolbar on the storyboard
@property (nonatomic, retain) IBOutlet UIToolbar* toolbar;
//the back button on the storyboard
@property (nonatomic, retain) IBOutlet UIBarButtonItem* back;
//the forward button on the storyboard
@property (nonatomic, retain) IBOutlet UIBarButtonItem* forward;
//the refresh button on the storyboard
@property (nonatomic, retain) IBOutlet UIBarButtonItem* refresh;
//the stop button on the storyboard
@property (nonatomic, retain) IBOutlet UIBarButtonItem* stop;
//the large Indicator on the storyboard
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *largeActivityIndicator;
//the url passed from the Table
@property (nonatomic, strong) NSString *passedURL;
//the at the bottom of the page
-(IBAction)shareButtonPressed:(UIBarButtonItem*)sender;

@end
