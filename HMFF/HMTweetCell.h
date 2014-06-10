//
//  HMTweetCell.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-03.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMTweetCell : UITableViewCell

//sets up the label for the tweet title
@property (weak, nonatomic) IBOutlet UITextView *tweet;
//sets up the label for the userName
@property (weak, nonatomic) IBOutlet UILabel *userName;
//sets up the label for the date
@property (weak, nonatomic) IBOutlet UILabel *date;
//sets up the image for the tweet
@property (weak, nonatomic) IBOutlet UIImageView *image;
//sets up the UIView for the cell
@property (weak, nonatomic) IBOutlet UIView *cellView;
//sets up the UIImageView for the chevron
@property (weak, nonatomic) IBOutlet UIImageView *chevron;

@end
