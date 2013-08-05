//
//  HMScheduleScrollViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//
//Sets up a delegate for the ScrollView Controller
@protocol HMScheduleScrollViewControllerDelegate <NSObject>
- (void)changeDate:(NSString*)date;
-(void)imagesForButton:(NSString*)backImage andFrontImage:(NSString*)frontImage;
@end
#import <UIKit/UIKit.h>
#import "HMScheduleViewController.h"

@class HMScheduleViewController;
@interface HMScheduleScrollViewController : UIViewController <HMScheduleViewControllerDelegate>
//set up the scrollview outlet
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//attaches the scrollviewcontroller as a delegate
@property (nonatomic, strong)id<HMScheduleScrollViewControllerDelegate>delegate;
//holds the date array for the bands
@property (nonatomic, strong) NSMutableArray *date;




@end
