//
//  HMThirdTableViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-07-03.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMVenueCell.h"
#import "HMBandCell.h"
#import "HMBandWebBrowserViewController.h"
#define VENUE_CELL @"VenueCell"
#define BAND_CELL @"BandCell"

@interface HMThirdTableViewController : UITableViewController 
//holds the band array
@property (nonatomic, strong) NSMutableArray *band;
//holds the venue array
@property (nonatomic, strong) NSMutableArray *venue;
//holds the lineUp array
@property (nonatomic, strong) NSMutableArray *lineUp;
@end