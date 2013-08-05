//
//  HMVideosTableViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-05-10.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMVideoCell.h"


@interface HMVideosTableViewController : UITableViewController <UIActionSheetDelegate>

//used for the video content from data feed manager
@property (strong, nonatomic) NSDictionary *VideoContent;
//used for the youtube array
@property(strong, nonatomic)NSMutableArray *youTubeArray;



@end
