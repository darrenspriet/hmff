//
//  HMFirstTableViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMAppDelegate.h"
#import "HMVenueCell.h"


@interface HMFirstTableViewController : UIViewController
//@property (weak, nonatomic) IBOutlet UITableView *tableOne;

//@property (nonatomic, strong) PFObject *parseObjects;
//@property (nonatomic, strong) NSArray *allObjects;
//@property (nonatomic, strong) NSDictionary *Dictionary;
@property (nonatomic, strong) NSMutableArray *bands;
@property (nonatomic, strong) NSMutableArray *venue;


//https://www.parse.com/docs/ios_guide#objects-retrieving/iOS

@end
