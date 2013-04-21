//
//  HMSecondTableViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMSecondTableViewController.h"
#define VENUE_CELL @"VenueCell"
#define BAND_CELL @"BandCell"

@interface HMSecondTableViewController ()

@end

@implementation HMSecondTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *tempArray = [(HMAppDelegate *)[[UIApplication sharedApplication] delegate] band];
    [self setBand: [tempArray objectAtIndex:1]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    return [self.band count]+ 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row==0) {
        return 30.0f;
    }
    else{
        return 55.0f;
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * diction = [[NSDictionary alloc]init];
    if (indexPath.row==0) {
        diction = [self.band objectAtIndex:indexPath.row];
        HMVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:VENUE_CELL];
        [cell.venueLabel setText:[diction objectForKey:@"venue"]];
        return cell;
        
    }
    else{
        diction = [self.band objectAtIndex:indexPath.row-1];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BAND_CELL];
        [cell.textLabel setText:[diction objectForKey:@"band"]];
        return  cell;
        
    }
}

#pragma mark - Prepare for Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"DetailView"]) {
        
        NSInteger row = [[self tableView].indexPathForSelectedRow row]-1;
        NSDictionary * passedURL = [[NSDictionary alloc]init];
        passedURL = [self.band objectAtIndex:row];
        NSLog(@"url is: %@", [passedURL objectForKey:@"link"]);
        HMBandWebBrowserViewController *webBrowser = segue.destinationViewController;
        webBrowser.passedURL=[passedURL objectForKey:@"link"];
        
    }
    
    
}

@end
