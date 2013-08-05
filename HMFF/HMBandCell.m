//
//  HMBandCell.m
//  HMFF
//
//  Created by Darren Spriet on 2013-06-08.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMBandCell.h"

@implementation HMBandCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    //initializes the cell with background color, text, and text color and an image
    [self.cellView setAlpha:0.3f];
    [self.cellView setBackgroundColor:[UIColor blackColor]];
    [self.bandName setTextColor:[UIColor whiteColor]];
    [self.time setTextColor:[UIColor whiteColor]];
    [self.chevron setImage:[UIImage imageNamed:@"chevron.png"]];
    
    if (selected){
        //changes the cell background color, text, and text color and an image when selected
        [self.cellView setAlpha:0.5f];
        [self.cellView setBackgroundColor:[UIColor whiteColor]];
        [self.bandName setTextColor:[UIColor blackColor]];
        [self.time setTextColor:[UIColor blackColor]];
        [self.chevron setImage:[UIImage imageNamed:@"chevronblack.png"]];
    }
}

@end
