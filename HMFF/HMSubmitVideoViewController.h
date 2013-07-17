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

@property (weak, nonatomic) IBOutlet UIView *blackView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *submissionLabel;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *submissionDeadlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *option1Label;
@property (weak, nonatomic) IBOutlet UILabel *option2Label;

@property(strong, nonatomic)NSMutableArray *submit;

@property(strong, nonatomic)NSString *submissionFee;

@property(strong, nonatomic)NSString *submissionDeadline;

@property(strong, nonatomic)NSString *entryFormLink;

@property(strong, nonatomic)NSString *address;

@property(strong, nonatomic)NSString *payPalLink;

@property(strong, nonatomic)NSString *videoDetail;

@property(strong, nonatomic)NSString *videoLength;

@property(strong, nonatomic)NSString *videoOption1;

@property(strong, nonatomic)NSString *videoOption2;

@property (nonatomic, strong) NSData *pdfData;

@property (weak, nonatomic) IBOutlet UIImageView *noteIcon;


@end
