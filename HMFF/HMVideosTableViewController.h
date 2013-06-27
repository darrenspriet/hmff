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


//An array of dictionaries which stores the content(title and url) of the youtube videos
@property (strong, nonatomic) NSDictionary *VideoContent;
@property(strong, nonatomic)NSMutableArray *youTubeArray;

@end
