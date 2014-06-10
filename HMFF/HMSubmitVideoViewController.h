//
//  HMSubmitVideoViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-07-10.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMMoreWebBrowserViewController.h"
#import "HMDetailsViewController.h"

@interface HMSubmitVideoViewController : UIViewController
//sets the property for the view over the uiimage
@property (weak, nonatomic) IBOutlet UIView *blackView;
//the webview for the pay pal button
//@property (weak, nonatomic) IBOutlet UIWebView *webView;
////the indicator that starts when the pay pal button is loading
//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
////used to set overtop of the uiwebview for the pay pal button
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//access to the submission label
@property (weak, nonatomic) IBOutlet UILabel *submissionLabel;
//access to the length label
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;
//access to the submission deadline label
@property (weak, nonatomic) IBOutlet UILabel *submissionDeadlineLabel;
//access to the option1 label
@property (weak, nonatomic) IBOutlet UILabel *option1Label;
//access to the option2 label
@property (weak, nonatomic) IBOutlet UILabel *option2Label;
//used to set the submit array
@property(strong, nonatomic)NSMutableArray *submit;
//string form the entryform link to be passed
@property(strong, nonatomic)NSString *entryFormLink;
//used to pass the address to the next controller
@property(strong, nonatomic)NSString *address;
//used to set the pay pal link
@property(strong, nonatomic)NSString *payPalLink;
//used to send the videodetail information to the detial page
@property(strong, nonatomic)NSString *videoDetail;
//used to set the data for the pdf
@property (nonatomic, strong) NSData *pdfData;
//UIImageview for the background
@property (weak, nonatomic) IBOutlet UIImageView *submitImage;

@end
