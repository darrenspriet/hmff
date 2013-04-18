//
//  HMFirstTableViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMFirstTableViewController.h"

@interface HMFirstTableViewController ()

@end

@implementation HMFirstTableViewController

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
    self.Dictionary = [[NSDictionary alloc]init];
    self.allObjects = [[NSMutableArray alloc]init];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"HMFFDates"];
    //    [query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
    
    self.allObjects= [query findObjects];
    self.date = [[NSMutableArray alloc]init];
    
    for (NSDictionary *diction in self.allObjects){
        [self.date addObject:[diction objectForKey:@"date"]];
    }
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
    
    return [self.allObjects count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    self.Dictionary=self.allObjects[indexPath.row];
    
    
    static NSString *cellIdentifier1 = @"cellIdentifier1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier1];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    [cell.textLabel setText:[self.date objectAtIndex:indexPath.row]];
    
    
    return cell;
    
    
}
@end
