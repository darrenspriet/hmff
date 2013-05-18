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


- (void)viewDidLoad{
    [super viewDidLoad];
    //Sets the Tweet array from the App Delegate
        self.tweets = [[HMDataFeedManager sharedDataFeedManager] tweets];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Uses the Tweet Cell
    static NSString *CellIdentifier = @"Tweet Cell";
    
    HMTweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HMTweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //Grabs the Dictionary for the Row
    NSDictionary *tweet = [self.tweets objectAtIndex:indexPath.row];
    
    //Gets the tweet title for the tweet
    NSString *title = [tweet objectForKey:@"text"];
    //Gets the Date for the tweet
    NSString *date =  [tweet objectForKey:@"created_at"];
    //Formats the Date Correctly in an array
    NSArray *dateArray = [date componentsSeparatedByString:@" "];
    //Takes that array and keeps what we want in the view
    NSString *newDateString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",[dateArray objectAtIndex:0], @" ", [dateArray objectAtIndex:1],@" ", [dateArray objectAtIndex:2],@" ", [dateArray objectAtIndex:5]];

    NSString *name;
    NSString *imageUrl;
    //Checks to see if this is a retweeted status, if so gets the original user
    if ([tweet objectForKey:@"retweeted_status"]) {
        name = [[[tweet objectForKey:@"retweeted_status"] objectForKey:@"user"] objectForKey:@"name"];
        imageUrl= [[[tweet objectForKey:@"retweeted_status"] objectForKey:@"user"] objectForKey:@"profile_image_url"];
    }
    //else just grabs the name and imageurl of initial user
    else{
        name = [[tweet objectForKey:@"user"] objectForKey:@"name"];
        imageUrl= [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
        
    }
    //Sets all the properties of the cell
    [cell.tweet setText:title];
    [cell.userName setText:[NSString stringWithFormat:@"by %@", name]];
    [cell.date setText:newDateString];
    
    //Starts a dispatch to get the image and then sets it to the cell
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.image setImage:[UIImage imageWithData:data]];
        });
    });

    
    return cell;
}

//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}


#pragma mark - Prepare for Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //Goes the the show Tweet detail page sending the detail of the tweet
    if ([segue.identifier isEqualToString:@"showTweet"]) {
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *tweet = [self.tweets objectAtIndex:row];
        HMTwitterDetailViewController *twitterDetailViewController = segue.destinationViewController;
        twitterDetailViewController.detailItem = tweet;
    }
}

@end
