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
    [self setBands: [tempArray objectAtIndex:1]];
    
    [self setVenue:[(HMAppDelegate *) [[UIApplication sharedApplication]delegate]venue]];

    	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    return [self.bands count]+ 1;
    
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
    
    
    if (indexPath.row==0) {
        HMVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:VENUE_CELL];
        [cell.venueLabel setText:[self.venue objectAtIndex:indexPath.row]];
        return cell;
        
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BAND_CELL];
        [cell.textLabel setText:[self.bands objectAtIndex:indexPath.row-1]];
        return  cell;
        
    }  
}


@end
