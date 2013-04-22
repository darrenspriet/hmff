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


- (void)viewDidLoad
{
    
    [super viewDidLoad];
        self.tweets = [(HMAppDelegate *)[[UIApplication sharedApplication] delegate]tweets];
}

#pragma mark - Table view data source

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
    
    NSArray *array = [date componentsSeparatedByString:@" "];
    NSString *newsting = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",[array objectAtIndex:0], @" ", [array objectAtIndex:1],@" ", [array objectAtIndex:2],@" ", [array objectAtIndex:5]];

    NSString *name;
    NSString *imageUrl;
    
    if ([tweet objectForKey:@"retweeted_status"]) {
        name = [[[tweet objectForKey:@"retweeted_status"] objectForKey:@"user"] objectForKey:@"name"];
        imageUrl= [[[tweet objectForKey:@"retweeted_status"] objectForKey:@"user"] objectForKey:@"profile_image_url"];
    }
    else{
        name = [[tweet objectForKey:@"user"] objectForKey:@"name"];
        imageUrl= [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
        
    }

    [cell.tweet setText:text];
    [cell.userName setText:[NSString stringWithFormat:@"by %@", name]];
    [cell.date setText:newsting];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.image setImage:[UIImage imageWithData:data]];
        });
    });

    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


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
