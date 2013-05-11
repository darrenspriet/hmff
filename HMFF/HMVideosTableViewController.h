//
//  HMVideosTableViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-05-10.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMVideoCell.h"


@interface HMVideosTableViewController : UITableViewController


//An array of dictionaries which stores the content(title and url) of the youtube videos
@property (strong, nonatomic) NSArray *Videos;
@property (strong, nonatomic) NSDictionary *VideoContent;
@end
