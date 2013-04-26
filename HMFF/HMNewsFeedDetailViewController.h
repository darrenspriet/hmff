//
//  HMNewsFeedDetailViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-08.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMNewsFeedDetailViewController : UIViewController

//This is to hold the details item from the previous screen
@property (nonatomic)NSDictionary *detailItem;
//Holds the News title 
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
//Holds the News Label
@property (weak, nonatomic) IBOutlet UITextView *content;


@end
