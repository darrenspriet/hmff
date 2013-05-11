//
//  HMVideoCell.h
//  HMFF
//
//  Created by Darren Spriet on 2013-05-10.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMVideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UIWebView *videoWebView;

@end
