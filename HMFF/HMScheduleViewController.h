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

//ScheduleScrollView Delegate property
@property (nonatomic, weak) id <HMScheduleViewControllerDelegate> delegate;
//Used to show the date of the Schedule on the top
@property (weak, nonatomic) IBOutlet UILabel *dateForEvent;
//holds the date array for the bands
@property (nonatomic, strong) NSMutableArray *date;
//button moves pages forward
- (IBAction)forwardButton:(UIButton *)sender;
//forward button image
@property (weak, nonatomic) IBOutlet UIButton *forwardButtonImage;
//button moves pages back
- (IBAction)backButton:(UIButton *)sender;
//back button image
@property (weak, nonatomic) IBOutlet UIButton *backButtonImage;
//Holds the HTMLString of the Tickets Page
@property(strong, nonatomic)NSString*HTMLString;
//Holds the linkObjects
@property (nonatomic, strong) NSArray *linkObject;
//Holds the Links Array 
@property(strong, nonatomic)NSMutableArray *linksArray;


@end
