//
//  HMNewsFeedCell.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-09.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMNewsFeedCell : UITableViewCell

//Used to set the title of the News Feed Cell
@property (weak, nonatomic) IBOutlet UILabel *title;

//Used to set the Date of the News Feed Cell
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
