//
//  HMTwitterTableViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-03-28.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMTwitterTableViewController.h"

@interface HMTwitterTableViewController ()

@end

@implementation HMTwitterTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)fetchTweets
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        
//This is used for a Search if needed                 
//     [NSURL URLWithString:@"https://search.twitter.com/search.json?q=%23hmffest"]];
                        
        [NSURL URLWithString: @"https://api.twitter.com/1/statuses/user_timeline.json?screen_name=HMFFEST&include_rts=1&count=100"]];

        NSError* error;
        
        self.tweets = [NSJSONSerialization JSONObjectWithData:data
                                                 options:kNilOptions
                                                   error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchTweets];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Tweet Cell";
    
    HMTweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HMTweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tweet = [self.tweets objectAtIndex:indexPath.row];
    NSString *text = [tweet objectForKey:@"text"];
    NSString *date =  [tweet objectForKey:@"created_at"];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//
//    [dateFormatter setDateFormat:@"EEE, MMM d, yyyy"];
//
//    NSDate *date1 = [dateFormatter dateFromString:preDate];
//    [dateFormatter setDateFormat:@"EEE, MMM d, yyyy"];
//   NSString *date = [dateFormatter stringFromDate:date1];
//    NSLog(@"date %@", preDate);
//    NSLog(@"newdate %@", date);


    NSString *name;
    
    if ([tweet objectForKey:@"retweeted_status"]) {
        name = [[[tweet objectForKey:@"retweeted_status"] objectForKey:@"user"] objectForKey:@"name"];
    }
    else{
        name = [[tweet objectForKey:@"user"] objectForKey:@"name"];
   
    }
    [cell.tweet setText:text];
    [cell.userName setText:[NSString stringWithFormat:@"by %@", name]];
    [cell.date setText:date];
    
    return cell;
    
    //This is used for a Search if needed
//    NSArray *tweet = [tweets objectForKey:@"results"];
//    //    NSString *text = [tweet objectForKey:@"text"];
//    NSDictionary *othertweet =[tweet objectAtIndex:indexPath.row];
//    NSString *text = [othertweet objectForKey:@"text" ];
//    NSString *name = [othertweet objectForKey: @"from_user_name"];
//    cell.textLabel.text = text;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"by %@", name];
//    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



#pragma mark - Prepare for Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showTweet"]) {
        
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *tweet = [self.tweets objectAtIndex:row];
        
        HMTwitterDetailViewController *twitterDetailViewController = segue.destinationViewController;
        twitterDetailViewController.detailItem = tweet;
    }
}

@end
