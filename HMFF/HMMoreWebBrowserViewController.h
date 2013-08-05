//
//  HMMoreWebBrowserViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-05.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HMMoreWebBrowserViewController : UIViewController <UIActionSheetDelegate, UIDocumentInteractionControllerDelegate>

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
//lets the controller know if the page was called with a pdf URL
@property (nonatomic, assign) BOOL isPDF;
//used to hold the pdfNSData
@property (nonatomic, strong) NSData *pdfData;
//the at the bottom of the page
-(IBAction)shareButtonPressed:(UIBarButtonItem*)sender;
//document controller
@property (nonatomic, retain) UIDocumentInteractionController *docController;
@end
