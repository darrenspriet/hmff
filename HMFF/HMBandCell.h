//
//  HMBandCell.h
//  HMFF
//
//  Created by Darren Spriet on 2013-06-08.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMBandCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bandName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UIImageView *chevron;


@end
