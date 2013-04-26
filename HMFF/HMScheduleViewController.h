//
//  HMScheduleViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

//This is a Delegate method so we can access the scroll method from the buttons created at the top
@protocol HMScheduleViewControllerDelegate <NSObject>
-(void)scrollBack;
-(void)scrollForward;
@end

#import <UIKit/UIKit.h>
#import "HMScheduleScrollViewController.h"



@class HMScheduleScrollViewController;

@interface HMScheduleViewController : UIViewController<HMScheduleScrollViewControllerDelegate>

@property (nonatomic, weak) id <HMScheduleViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *dateForEvent;

@property (nonatomic, strong) NSMutableArray *date;

- (IBAction)forwardButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *forwardButtonImage;
- (IBAction)backButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *backButtonImage;


@end
