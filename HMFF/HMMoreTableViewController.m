//
//  HMMoreTableViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-04.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMMoreTableViewController.h"

@interface HMMoreTableViewController ()

@end

@implementation HMMoreTableViewController

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        //Changes the size if it is the iPhone 5
        if (screenSize.height > 480.0f) {
            //returns 60f if it is iPhone 5
            return 60.0f;
        }
        else {
            //else returns 47f 
            return 47.0f;
        }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Sets the text to the cells and uses the More Cell for each of the cells
    switch (indexPath.row) {
        case 0:{
            static NSString *CellIdentifier = SUBMIT_BAND_CELL;
            HMMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[HMMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell.title setText:@"Band Submission"];
            return cell;
            break;
        }
        case 1:{
            static NSString *CellIdentifier = SUBMIT_VIDEO_CELL;
            HMMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[HMMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell.title setText:@"Video Submission"];
            return cell;
            break;
        }

        case 2:{
            static NSString *CellIdentifier = PHOTO_CELL;
            HMMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[HMMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell.title setText:@"Photos"];
            return cell;
            break;
        }
        case 3:{
            static NSString *CellIdentifier = YOUTUBE_CELL;
            HMMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[HMMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell.title setText:@"Videos"];
            return cell;
            break;
        }
        default :{
            static NSString *CellIdentifier = ABOUT_US_CELL;
            HMMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[HMMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell.title setText:@"About Us"];
            return cell;
            break;
        }
    }
    
}
//This returns the view and causes the table to not go on after the final cell
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    return view;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
