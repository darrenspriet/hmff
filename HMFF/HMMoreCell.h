//
//  HMMoreCell.h
//  HMFF
//
//  Created by Darren Spriet on 2013-07-01.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMMoreCell : UITableViewCell
//access to the title label
@property (weak, nonatomic) IBOutlet UILabel *title;
//access to the chevron uiImageView
@property (weak, nonatomic) IBOutlet UIImageView *chevron;
//access to the cellView
@property (weak, nonatomic) IBOutlet UIView *cellView;

@end
