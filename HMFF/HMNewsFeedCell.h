//
//  HMNewsFeedCell.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-09.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMNewsFeedCell : UITableViewCell

//sets up a label for the title
@property (weak, nonatomic) IBOutlet UILabel *title;
//sets up a label for the date
@property (weak, nonatomic) IBOutlet UILabel *date;
//sets up a view for the Cell
@property (weak, nonatomic) IBOutlet UIView *cellView;
//sets up a UIImage for the chevron
@property (weak, nonatomic) IBOutlet UIImageView *chevron;

@end
