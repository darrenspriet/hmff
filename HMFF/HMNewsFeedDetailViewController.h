//
//  HMNewsFeedDetailViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-08.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMNewsFeedDetailViewController : UIViewController

@property (nonatomic)NSDictionary *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *content;


@end
