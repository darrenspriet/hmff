//
//  HMEightTableViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-07-03.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMEightTableViewController.h"

@interface HMEightTableViewController ()

@end

@implementation HMEightTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    //    [[HMDataFeedManager sharedDataFeedManager] getParseObjects];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lineUp = [[NSMutableArray alloc]init];
    
    NSMutableArray *tempArray = [[HMDataFeedManager sharedDataFeedManager] band];
    
    [self setBand: [tempArray objectAtIndex:7]];
    [self.band sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"venue_order" ascending:YES], nil]];
    NSMutableArray *tempArray1 = [[NSMutableArray alloc]init];
    //NSLog(@"self.band is1: %@", self.band);
    
    
    for (NSDictionary *diction in self.band){
        [tempArray1 addObject:[diction objectForKey:@"venue"]];
    }
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:tempArray1];
    //Used to find the Unique Dates
    NSSet *uniqueVenues = [orderedSet set];
    
    ////Put the Set back into the array so I can use it
    [self setVenue :[NSMutableArray arrayWithArray:[uniqueVenues allObjects]]];
    //  NSLog(@"what is venuse:%@", self.venue);
    //Finds band for unique dates and venue
    for (int i= 0; i <[self.venue count]; i++) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (NSDictionary *diction in self.band){
            if ([[diction objectForKey:@"venue"] isEqualToString:[self.venue objectAtIndex:i]]) {
                //Adds the dictionary to the array
                [array addObject:diction];
                //   NSLog(@"venues %@", diction);
            }
        }
        //Adds the Array with dictionarys in it to the array
        [array sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"band_order" ascending:YES], nil]];
        [self.lineUp addObject:array];
        //  NSLog(@"lineup %@", self.lineUp);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.venue count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 1:{
            return [[self.lineUp objectAtIndex:1]count]+1;
            break;
        }
        case 2:{
            return [[self.lineUp objectAtIndex:2]count]+1;
            break;
        }
        case 3:{
            return [[self.lineUp objectAtIndex:3]count]+1;
            break;
        }
        case 4:{
            return [[self.lineUp objectAtIndex:4]count]+1;
            break;
        }
        case 5:{
            return [[self.lineUp objectAtIndex:5]count]+1;
            break;
        }
            
        default:{
            return [[self.lineUp objectAtIndex:0]count]+1;
            break;
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0){
        return 30.0f;
    }
    else{
        return 55.0f;
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * diction = [[NSDictionary alloc]init];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    switch (indexPath.section) {
        case 1:{
            array=[self.lineUp objectAtIndex:1];
            if (indexPath.row==0) {
                diction =[array objectAtIndex:indexPath.row];
                //      NSLog(@"what is diction %@", diction);
                HMVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:VENUE_CELL];
                [cell.venueLabel setText:[diction objectForKey:@"venue"]];
                // NSLog(@"what is venue %@", [diction objectForKey:@"venue"]);
                return cell;
            }
            else{
                diction = [array objectAtIndex:indexPath.row-1];
                HMBandCell *cell = [tableView dequeueReusableCellWithIdentifier:BAND_CELL];
                [cell.bandName setText:[diction objectForKey:@"band"]];
                [cell.time setText:[diction objectForKey:@"time"]];
                return  cell;
            }
            break;
        }
        case 2:{
            array=[self.lineUp objectAtIndex:2];
            if (indexPath.row==0) {
                diction =[array objectAtIndex:indexPath.row];
                //   NSLog(@"what is diction %@", diction);
                HMVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:VENUE_CELL];
                [cell.venueLabel setText:[diction objectForKey:@"venue"]];
                // NSLog(@"what is venue %@", [diction objectForKey:@"venue"]);
                return cell;
            }
            else{
                diction = [array objectAtIndex:indexPath.row-1];
                HMBandCell *cell = [tableView dequeueReusableCellWithIdentifier:BAND_CELL];
                [cell.bandName setText:[diction objectForKey:@"band"]];
                [cell.time setText:[diction objectForKey:@"time"]];
                return  cell;
            }
            
            break;
        }
        case 3:{
            array=[self.lineUp objectAtIndex:3];
            if (indexPath.row==0) {
                diction =[array objectAtIndex:indexPath.row];
                //    NSLog(@"what is diction %@", diction);
                HMVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:VENUE_CELL];
                [cell.venueLabel setText:[diction objectForKey:@"venue"]];
                // NSLog(@"what is venue %@", [diction objectForKey:@"venue"]);
                return cell;
            }
            else{
                diction = [array objectAtIndex:indexPath.row-1];
                HMBandCell *cell = [tableView dequeueReusableCellWithIdentifier:BAND_CELL];
                [cell.bandName setText:[diction objectForKey:@"band"]];
                [cell.time setText:[diction objectForKey:@"time"]];
                return  cell;
            }
            break;
        }
        case 4:{
            array=[self.lineUp objectAtIndex:4];
            if (indexPath.row==0) {
                diction =[array objectAtIndex:indexPath.row];
                //    NSLog(@"what is diction %@", diction);
                HMVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:VENUE_CELL];
                [cell.venueLabel setText:[diction objectForKey:@"venue"]];
                // NSLog(@"what is venue %@", [diction objectForKey:@"venue"]);
                return cell;
            }
            else{
                diction = [array objectAtIndex:indexPath.row-1];
                HMBandCell *cell = [tableView dequeueReusableCellWithIdentifier:BAND_CELL];
                [cell.bandName setText:[diction objectForKey:@"band"]];
                [cell.time setText:[diction objectForKey:@"time"]];
                return  cell;
            }
            
            break;
        }
        case 5:{
            array=[self.lineUp objectAtIndex:5];
            if (indexPath.row==0) {
                diction =[array objectAtIndex:indexPath.row];
                //     NSLog(@"what is diction %@", diction);
                HMVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:VENUE_CELL];
                [cell.venueLabel setText:[diction objectForKey:@"venue"]];
                // NSLog(@"what is venue %@", [diction objectForKey:@"venue"]);
                return cell;
            }
            else{
                diction = [array objectAtIndex:indexPath.row-1];
                HMBandCell *cell = [tableView dequeueReusableCellWithIdentifier:BAND_CELL];
                [cell.bandName setText:[diction objectForKey:@"band"]];
                [cell.time setText:[diction objectForKey:@"time"]];
                return  cell;
            }
            
            break;
        }
            
        default:{
            array=[self.lineUp objectAtIndex:0];
            
            if (indexPath.row==0) {
                diction =[array objectAtIndex:indexPath.row];
                //    NSLog(@"what is diction %@", diction);
                HMVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:VENUE_CELL];
                [cell.venueLabel setText:[diction objectForKey:@"venue"]];
                // NSLog(@"what is venue %@", [diction objectForKey:@"venue"]);
                return cell;
                
            }
            else{
                diction = [array objectAtIndex:indexPath.row-1];
                HMBandCell *cell = [tableView dequeueReusableCellWithIdentifier:BAND_CELL];
                [cell.bandName setText:[diction objectForKey:@"band"]];
                [cell.time setText:[diction objectForKey:@"time"]];
                
                return  cell;
            }
            break;
        }
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
