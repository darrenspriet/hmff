//
//  HMLineUpViewController.m
//  HMFF
//
//  Created by Darren Spriet on 13-03-21.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMLineUpViewController.h"

@interface HMLineUpViewController ()

@end

@implementation HMLineUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.scrollView setContentSize:CGSizeMake(640, self.scrollView.frame.size.height)];
}


- (void)dataForTables {
    
    self.tableOneArray = [[NSArray alloc] initWithObjects:@"BAND1", @"BAND2", @"BAND3", @"BAND4", @"BAND5", @"BAND6", @"BAND7",@"BAND8",@"BAND9",@"BAND10",nil];
    self.tableTwoArray = [[NSArray alloc] initWithObjects:@"VIDEO 1", @"VIDEO 2", @"VIDEO 3", @"VIDEO 4",@"VIDEO 5",@"VIDEO 6",@"VIDEO 7",@"VIDEO 8", nil];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self dataForTables];
    
    self.tableViewOne.rowHeight = 44;
    self.tableViewTwo.rowHeight = 60;
    
    
    UIImage *image = [UIImage imageNamed:@"HMFFlogo.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:nil];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag == 100) {
        return self.tableOneArray.count;
    }
    if (tableView.tag == 101) {
        return self.tableTwoArray.count;
    }
    return 0;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    if (tableView.tag == 100) {
//        return [NSString stringWithFormat:@"%@ %d", @"Plain", section];
//    }
//    if (tableView.tag == 101) {
//        return [NSString stringWithFormat:@"%@ %d", @"Group", section];
//    }
//    return nil;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 100) {
        static NSString *cellIdentifier1 = @"cellIdentifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
        cell.textLabel.text = [self.tableOneArray objectAtIndex:indexPath.row];

        return cell;
    }
    
    if (tableView.tag == 101) {
        static NSString *cellIdentifier2 = @"cellIdentifier2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = [self.tableTwoArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.tableOneArray objectAtIndex:indexPath.row];
        return cell;
    }
    
    return nil;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSUInteger section = indexPath.section;
//    NSUInteger row = indexPath.row;
//    
//    if (tableView.tag == 100) {
//        PlainViewController *viewController = [[PlainViewController alloc]
//                                               initWithNibName:@"PlainViewController" bundle:nil];
//        NSString *title = [NSString stringWithFormat:@"Section %d %@", section, [array1 objectAtIndex:row]];
//        viewController.title = title;
//        [self.navigationController pushViewController:viewController animated:YES];
//        [viewController release];
//    }
//    if (tableView.tag == 101) {
//        GroupViewController *viewController = [[GroupViewController alloc]
//                                               initWithNibName:@"GroupViewController" bundle:nil];
//        NSString *title = [NSString stringWithFormat:@"Section %d %@", section, [array2 objectAtIndex:row]];
//        viewController.title = title;
//        [self.navigationController pushViewController:viewController animated:YES];
//        [viewController release];
//    }
//}
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
//    
//    NSString *msg = [NSString stringWithFormat:@"Section %d %@", indexPath.section,
//                     [array1 objectAtIndex:indexPath.row]];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
//                                                    message:msg
//                                                   delegate:nil
//                                          cancelButtonTitle:@"Cancle"
//                                          otherButtonTitles:nil];
//    [alert show];
//    [alert release];
//}
#pragma mark UITableViewDelegate End -



#pragma mark UIScrollViewDelegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    float x = scrollView.contentOffset.x;
//    NSLog(@"what is x %f", x);
//    
//    if (x > 320/2 && x < 640/2) {
////        [self.tableViewTwo setContentOffset:CGPointMake(self.tableViewTwo.contentOffset.x, self.tableViewTwo.contentOffset.y)];
////       [scrollView setContentOffset: CGPointMake(scrollView.contentOffset.x, 0)];
//    }
//    
//    if (x > 0 && x < 320/2) {
////  [scrollView setContentOffset: CGPointMake(scrollView.contentOffset.x, 0)];
//    }
//}


#pragma mark UIScrollViewDelegate End -


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
