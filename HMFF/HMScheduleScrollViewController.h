//
//  HMScheduleScrollViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMAppDelegate.h"
@protocol HMScheduleScrollViewControllerDelegate <NSObject>

- (void)changeDate:(NSString*)date;
@end


@interface HMScheduleScrollViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong)id<HMScheduleScrollViewControllerDelegate>delegate;

@property (nonatomic, strong) NSMutableArray *date;




@end
