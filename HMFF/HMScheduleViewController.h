//
//  HMScheduleViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMScheduleScrollViewController.h"
#import "HMAppDelegate.h"


@interface HMScheduleViewController : UIViewController<HMScheduleScrollViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *dateForEvent;

@property (nonatomic, strong) NSArray *allObjects;
@property (nonatomic, strong) NSDictionary *Dictionary;
@property (nonatomic, strong) NSMutableArray *date;



@end
