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
    // Configure the cell...
    switch (indexPath.row) {
        case 0:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"submitABand"];
            return cell;
            break;
        }
        case 1:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"submitAVideo"];
            return cell;
            break;
        }
        case 2:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goToTheWebsite"];
            return cell;
            break;
        }
        case 3:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goToPhotos"];
            return cell;
            break;
        }
            
        default:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goToVideos"];
            return cell;
            break;
            
        }
    }
    
}

#pragma Prepare for Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    HMMoreWebBrowserViewController *webBrowser = segue.destinationViewController;
    //Calls the submit a band segue
    if ([segue.identifier isEqualToString:@"submitABand"]){
        webBrowser.passedURL=@"http://www.hmff.com/?page_id=403";
    }
    //Calls the submit a video segue
    else if([segue.identifier isEqualToString:@"submitAVideo"]){
        webBrowser.passedURL=@"http://www.hmff.com/?page_id=407";
    }
    //Calls the website
    else if([segue.identifier isEqualToString:@"goToTheWebsite"]){
        webBrowser.passedURL=@"http://www.hmff.com";
    }
    else if([segue.identifier isEqualToString:@"videos"]){
        HMVideosTableViewController *videoController = segue.destinationViewController;
        [videoController setTitle:@"HMFF YouTube Videos"];
    }
    else if([segue.identifier isEqualToString:@"photosCollection"]){
        HMPhotoCollectionViewController *photoController = segue.destinationViewController;
        [photoController setTitle:@"HMFF Flickr Photos"];
    }
    
}


@end
