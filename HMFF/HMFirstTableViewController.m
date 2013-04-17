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
    self.parse = [[NSMutableArray alloc]init];
  
    PFQuery *query = [PFQuery queryWithClassName:@"Player"];
//    [query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
//    NSArray* scoreArray = [query findObjects];
      self.parseObjects = [query getFirstObject];
//    [self.parse addObject:objects];
//    NSLog(@"%@", self.parse);
    [self dataForTables];
	// Do any additional setup after loading the view.
}

- (void)dataForTables {
    
    self.tableOneArray = [[NSArray alloc] initWithObjects:@"BAND1", @"BAND2", @"BAND3", @"BAND4", @"BAND5", @"BAND6", @"BAND7",@"BAND8",@"BAND9",@"BAND10",nil];

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
    
        return 2;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        return 44.0f;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    

    
        static NSString *cellIdentifier1 = @"cellIdentifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
    NSLog(@"%@", [self.tableOneArray objectAtIndex:indexPath.row]);
    [cell.textLabel setText:[self.parseObjects objectForKey:@"Name"]];
        return cell;
       
    
}

@end
