//
//  HMSeventhTableViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-07-03.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMSeventhTableViewController.h"

@interface HMSeventhTableViewController ()

@end

@implementation HMSeventhTableViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadData];
    
}
-(void)loadData{
    //initalize the lineup array
    self.lineUp = [[NSMutableArray alloc]init];
    //store the band from hmdatafeedmanager
    NSMutableArray *tempArray = [[HMDataFeedManager sharedDataFeedManager] band];
    //set the band from the temp array to the one for the proper page
    [self setBand: [tempArray objectAtIndex:6]];
    //sorts the band array by venue_order
    [self.band sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"venue_order" ascending:YES], nil]];
    //initialize the tempArray1
    NSMutableArray *tempArray1 = [[NSMutableArray alloc]init];
    //goes through the band array and sets the temparray1 to each venue
    for (NSDictionary *diction in self.band){
        [tempArray1 addObject:[diction objectForKey:@"venue"]];
    }
    //creates an orderedset with the temparray1
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:tempArray1];
    //Used to find the Unique venues
    NSSet *uniqueVenues = [orderedSet set];
    //now puts the unique venues into the venues
    [self setVenue :[NSMutableArray arrayWithArray:[uniqueVenues allObjects]]];
    //Finds band for unique dates and venue
    for (int i= 0; i <[self.venue count]; i++) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (NSDictionary *diction in self.band){
            if ([[diction objectForKey:@"venue"] isEqualToString:[self.venue objectAtIndex:i]]) {
                //Adds the dictionary to the array
                [array addObject:diction];
            }
        }
        //sorts the array by band_order
        [array sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"band_order" ascending:YES], nil]];
        //Adds the Array with dictionarys in it to the array
        [self.lineUp addObject:array];
        //  NSLog(@"lineup %@", self.lineUp);
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.venue count];
}
//returns the number of rows in each section based on the lineUp array
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
        //returns the height of the venue cell
        return 30.0f;
    }
    else{
        //returns the height of the band cell
        return 55.0f;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //initalizes the dictionary and array that holds the line up
    NSDictionary * diction = [[NSDictionary alloc]init];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    switch (indexPath.section) {
        case 1:{
            //Grabs the object at index 1
            array=[self.lineUp objectAtIndex:1];
            //Checks to see if the indexrow.row=0
            if (indexPath.row==0) {
                //sets the diction to the correct one at the index
                diction =[array objectAtIndex:indexPath.row];
                //loads up the cell with all of the information and text
                static NSString *CellIdentifier = VENUE_CELL;
                HMVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[HMVenueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.venueLabel setText:[diction objectForKey:@"venue"]];
                return cell;
            }
            else{
                //sets the diction to the indexPath.row-1
                diction = [array objectAtIndex:indexPath.row-1];
                //loads up the cell with all of the information and text
                static NSString *CellIdentifier = BAND_CELL;
                HMBandCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[HMBandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.bandName setText:[diction objectForKey:@"band"]];
                [cell.time setText:[diction objectForKey:@"time"]];
                return  cell;
            }
            break;
        }
        case 2:{
            //Grabs the object at index 2
            array=[self.lineUp objectAtIndex:2];
            //Checks to see if the indexrow.row=0
            if (indexPath.row==0) {
                //sets the diction to the correct one at the index
                diction =[array objectAtIndex:indexPath.row];
                static NSString *CellIdentifier = VENUE_CELL;
                HMVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[HMVenueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.venueLabel setText:[diction objectForKey:@"venue"]];
                return cell;
            }
            else{
                //sets the diction to the indexPath.row-1
                diction = [array objectAtIndex:indexPath.row-1];
                static NSString *CellIdentifier = BAND_CELL;
                HMBandCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[HMBandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.bandName setText:[diction objectForKey:@"band"]];
                [cell.time setText:[diction objectForKey:@"time"]];
                return  cell;
            }
            break;
        }
        case 3:{
            //Grabs the object at index 3
            array=[self.lineUp objectAtIndex:3];
            //Checks to see if the indexrow.row=0
            if (indexPath.row==0) {
                //sets the diction to the correct one at the index
                diction =[array objectAtIndex:indexPath.row];
                static NSString *CellIdentifier = VENUE_CELL;
                HMVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[HMVenueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.venueLabel setText:[diction objectForKey:@"venue"]];
                return cell;
            }
            else{
                //sets the diction to the indexPath.row-1
                diction = [array objectAtIndex:indexPath.row-1];
                static NSString *CellIdentifier = BAND_CELL;
                HMBandCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[HMBandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.bandName setText:[diction objectForKey:@"band"]];
                [cell.time setText:[diction objectForKey:@"time"]];
                return  cell;
            }
            break;
        }
        case 4:{
            //Grabs the object at index 4
            array=[self.lineUp objectAtIndex:4];
            //Checks to see if the indexrow.row=0
            if (indexPath.row==0) {
                //sets the diction to the correct one at the index
                diction =[array objectAtIndex:indexPath.row];
                static NSString *CellIdentifier = VENUE_CELL;
                HMVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[HMVenueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.venueLabel setText:[diction objectForKey:@"venue"]];
                return cell;
            }
            else{
                //sets the diction to the indexPath.row-1
                diction = [array objectAtIndex:indexPath.row-1];
                static NSString *CellIdentifier = BAND_CELL;
                HMBandCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[HMBandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.bandName setText:[diction objectForKey:@"band"]];
                [cell.time setText:[diction objectForKey:@"time"]];
                return  cell;
            }
            break;
        }
        case 5:{
            //Grabs the object at index 5
            array=[self.lineUp objectAtIndex:5];
            //Checks to see if the indexrow.row=0
            if (indexPath.row==0) {
                //sets the diction to the correct one at the index
                diction =[array objectAtIndex:indexPath.row];
                static NSString *CellIdentifier = VENUE_CELL;
                HMVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[HMVenueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.venueLabel setText:[diction objectForKey:@"venue"]];
                return cell;
            }
            else{
                //sets the diction to the indexPath.row-1
                diction = [array objectAtIndex:indexPath.row-1];
                static NSString *CellIdentifier = BAND_CELL;
                HMBandCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[HMBandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.bandName setText:[diction objectForKey:@"band"]];
                [cell.time setText:[diction objectForKey:@"time"]];
                return  cell;
            }
            break;
        }
            
        default:{
            //Grabs the object at index 0
            array=[self.lineUp objectAtIndex:0];
            //Checks to see if the indexrow.row=0
            if (indexPath.row==0) {
                //sets the diction to the correct one at the index
                diction =[array objectAtIndex:indexPath.row];
                static NSString *CellIdentifier = VENUE_CELL;
                HMVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[HMVenueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.venueLabel setText:[diction objectForKey:@"venue"]];
                return cell;
            }
            else{
                //sets the diction to the indexPath.row-1
                diction = [array objectAtIndex:indexPath.row-1];
                static NSString *CellIdentifier = BAND_CELL;
                HMBandCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[HMBandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
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
        //Sets the URL for the band and there detail view
        NSInteger row = [[self tableView].indexPathForSelectedRow row]-1;
        NSDictionary * passedURL = [[NSDictionary alloc]init];
        passedURL = [self.band objectAtIndex:row];
        //        NSLog(@"url is: %@", [passedURL objectForKey:@"link"]);
        HMBandWebBrowserViewController *webBrowser = segue.destinationViewController;
        webBrowser.passedURL=[passedURL objectForKey:@"link"];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
