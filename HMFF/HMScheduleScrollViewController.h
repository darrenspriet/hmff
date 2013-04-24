//
//  HMScheduleScrollViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

@protocol HMScheduleScrollViewControllerDelegate <NSObject>
- (void)changeDate:(NSString*)date;
-(void)imagesForButton:(NSString*)backImage andFrontImage:(NSString*)frontImage;
@end


#import <UIKit/UIKit.h>
#import "HMScheduleViewController.h"
@class HMScheduleViewController;


@interface HMScheduleScrollViewController : UIViewController <HMScheduleViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong)id<HMScheduleScrollViewControllerDelegate>delegate;

@property (nonatomic, strong) NSMutableArray *date;




@end
