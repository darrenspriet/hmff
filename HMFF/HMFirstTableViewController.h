//
//  HMFirstTableViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMFirstTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableOne;

@property (nonatomic, strong) NSArray *tableOneArray;

@end
