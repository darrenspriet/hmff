//
//  HMDetailsViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-07-16.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *blackView;

@property (weak, nonatomic) IBOutlet UITextView *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property(strong, nonatomic) NSString *detailString;
@property(strong, nonatomic) NSString *addressString;

@end
