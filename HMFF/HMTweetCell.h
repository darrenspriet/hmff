//
//  HMTweetCell.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-03.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMTweetCell : UITableViewCell

//The Properties for the Tweet Cell
@property (weak, nonatomic) IBOutlet UILabel *tweet;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
