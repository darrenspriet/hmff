//
//  HMBandCell.h
//  HMFF
//
//  Created by Darren Spriet on 2013-06-08.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMBandCell : UITableViewCell
//sets up a label for the band Name
@property (weak, nonatomic) IBOutlet UILabel *bandName;
//sets up a label for the time 
@property (weak, nonatomic) IBOutlet UILabel *time;
//sets up a view for the Cell
@property (weak, nonatomic) IBOutlet UIView *cellView;
//sets up a UIImage for the chevron 
@property (weak, nonatomic) IBOutlet UIImageView *chevron;


@end
