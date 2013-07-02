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

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            HMMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];
            [cell.title setText:@"Submit a Band"];
            return cell;
            break;
        }
        case 1:{
            HMMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];
            [cell.title setText:@"Submit a Video"];
            return cell;
            break;
        }
        case 2:{
            HMMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];
            [cell.title setText:@"Go to the Website"];
            return cell;
            break;
        }
        case 3:{
            HMPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoCell"];

            [cell.title setText:@"Photos"];
            return cell;
            break;
        }
        default:{
            HMMoreVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreVideoCell"];

            [cell.title setText:@"Videos"];
            return cell;
            break;
        }
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}

#pragma Prepare for Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];

    HMMoreWebBrowserViewController *webBrowser = segue.destinationViewController;
    //Calls the submit a band segue
    if ([segue.identifier isEqualToString:@"moreSegue"]){
        if(indexPath.row==0){
     webBrowser.passedURL=@"http://www.hmff.com/?page_id=403";
        }
        else if(indexPath.row==1){
            webBrowser.passedURL=@"http://www.hmff.com/?page_id=407";
        }
        else{
            webBrowser.passedURL=@"http://www.hmff.com";
        }
    }
    else if([segue.identifier isEqualToString:@"photoSegue"]){
        HMPhotoCollectionViewController *photoController = segue.destinationViewController;
        [photoController setTitle:@"HMFF Flickr Photos"];
    }
    else if([segue.identifier isEqualToString:@"moreVideoSegue"]){
        HMVideosTableViewController *videoController = segue.destinationViewController;
        [videoController setTitle:@"HMFF YouTube Videos"];
    }
    
}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    switch (indexPath.row) {
//        case 0:{
//            [cell.title setText:@"Submit a Band"];
//            return cell;
//            break;
//        }
//        case 1:{
//            [cell.title setText:@"Submit a Video"];
//            return cell;
//            break;
//        }
//        case 2:{
//            [cell.title setText:@"Go to the Website"];
//            return cell;
//            break;
//        }
//        case 3:{
//            [cell.title setText:@"Photos"];
//            return cell;
//            break;
//        }
//        default:{
//            [cell.title setText:@"Videos"];
//            return cell;
//            break;
//        }
//
//}


@end
