//
//  HMSubmitBandViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-07-10.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMMoreWebBrowserViewController.h"
#import "HMDetailsViewController.h"


@interface HMSubmitBandViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *blackView;

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

@property(strong, nonatomic)NSString *sonicBidsLink;

@property(strong, nonatomic)NSString *bandDetail;

@property(strong, nonatomic)NSString *bandLength;

@property(strong, nonatomic)NSString *bandOption1;

@property(strong, nonatomic)NSString *bandOption2;

@property (nonatomic, strong) NSData *pdfData;

@property (weak, nonatomic) IBOutlet UIImageView *noteIcon;


@end
