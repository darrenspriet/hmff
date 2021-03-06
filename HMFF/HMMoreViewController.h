//
//  HMMoreViewController.h
//  HMFF
//
//  Created by Darren Spriet on 13-03-21.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface HMMoreViewController : UIViewController <MFMailComposeViewControllerDelegate>

//holds the HTMLString for the URL's
@property(strong, nonatomic)NSString*HTMLString;
//Button to send an email
- (IBAction)SendAnEmail:(UIButton *)sender;

@end
