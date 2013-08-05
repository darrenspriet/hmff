//
//  HMBuyTicketsViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-24.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMBuyTicketsViewController : UIViewController<UIActionSheetDelegate>

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
//holds the links that are passed from Data Feed Manager
@property(strong, nonatomic)NSMutableArray *links;
//the property of which page pushed to this page
@property (nonatomic, strong) NSString *pagePushed;
//the outlet for the bar button item
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
//the at the bottom of the page
-(IBAction)shareButtonPressed:(UIBarButtonItem*)sender;
//Done button for the flip page
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender;

@end
