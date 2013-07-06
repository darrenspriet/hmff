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


@interface HMThirdTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *band;
@property (nonatomic, strong) NSMutableArray *venue;
@property (nonatomic, strong) NSMutableArray *lineUp;

@end
