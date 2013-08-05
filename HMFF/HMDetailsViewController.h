//
//  HMDetailsViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-07-16.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMDetailsViewController : UIViewController
//the view that I change the alpha to .3
@property (weak, nonatomic) IBOutlet UIView *blackView;
//the detail textview for the detail view
@property (weak, nonatomic) IBOutlet UITextView *detailsLabel;
//Labelf or the the address
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
//String for the detail so it can be passed from the previous controller
@property(strong, nonatomic) NSString *detailString;
//String for the address so it can be passed from the previous controller
@property(strong, nonatomic) NSString *addressString;

@end
