//
//  HMMoreTableViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-04.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMMoreCell.h"
#define SUBMIT_BAND_CELL @"submitBandCell"
#define SUBMIT_VIDEO_CELL @"submitVideoCell"
#define PHOTO_CELL @"photoCell"
#define YOUTUBE_CELL @"moreVideoCell"
#define ABOUT_US_CELL @"moreCell"

@interface HMMoreTableViewController : UITableViewController

//Holds the pdfdata from the Entry Form pdf in the More View Controller(More)
@property (nonatomic, strong) NSData *pdfData;

//Holds the submitObjects that will be sent to More View Controller(More)
@property (nonatomic, strong) NSArray *submitObject;

@end
