//
//  HMLineUpViewController.h
//  HMFF
//
//  Created by Darren Spriet on 13-03-21.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMLineUpViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableViewOne;
@property (weak, nonatomic) IBOutlet UITableView *tableViewTwo;
@property(strong, nonatomic)NSString *passed;


@property (nonatomic, strong) NSArray *tableOneArray;
@property (nonatomic, strong) NSArray *tableTwoArray;
@end
