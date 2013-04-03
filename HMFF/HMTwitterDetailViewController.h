//
//  HMTwitterDetailViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-02.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMTwitterDetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *profileImage;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak)  IBOutlet UILabel *tweetLabel;
@property (nonatomic)NSDictionary *detailItem;

@end
