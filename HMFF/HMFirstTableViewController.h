//
//  HMFirstTableViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMAppDelegate.h"

@interface HMFirstTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableOne;

@property (nonatomic, strong) NSArray *tableOneArray;
@property (nonatomic, strong)NSMutableArray *parse;
@property (nonatomic, strong) PFObject *parseObjects;

//https://www.parse.com/docs/ios_guide#objects-retrieving/iOS

@end
