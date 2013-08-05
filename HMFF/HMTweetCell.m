//
//  HMTweetCell.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-03.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMTweetCell.h"

@implementation HMTweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    //initializes the cell with background color, text, and text color and an image
    [self.cellView setAlpha:0.4f];
    [self.cellView setBackgroundColor:[UIColor blackColor]];
    [self.tweet setTextColor:[UIColor whiteColor]];
    [self.userName setTextColor:[UIColor whiteColor]];
    [self.date setTextColor:[UIColor whiteColor]];
    [self.chevron setImage:[UIImage imageNamed:@"chevron.png"]];
    
    if (selected){
        //changes the cell background color, text, and text color and an image when selected
        [self.cellView setAlpha:0.6f];
        [self.cellView setBackgroundColor:[UIColor whiteColor]];
        [self.tweet setTextColor:[UIColor blackColor]];
        [self.userName setTextColor:[UIColor blackColor]];
        [self.date setTextColor:[UIColor blackColor]];
        [self.chevron setImage:[UIImage imageNamed:@"chevronblack.png"]];
        
    }
}

@end
