//
//  HMVideoCell.h
//  HMFF
//
//  Created by Darren Spriet on 2013-05-10.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMVideoCell : UITableViewCell
//access to the videoTitle
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
//access to the videoWebView
@property (weak, nonatomic) IBOutlet UIWebView *videoWebView;
//access to the large activity indicator
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *largeActivityIndicator;


@end