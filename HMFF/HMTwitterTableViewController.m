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
    [self requestTimeline];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataSource) {
        return 1;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource) {
        return self.dataSource.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell Identifier";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tweet = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [tweet objectForKey:@"text"];
    cell.imageView.image = [UIImage imageNamed:@"placeholder"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.HMFF.HMFF", NULL);
    dispatch_queue_t main = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        NSURL *imageURL = [NSURL URLWithString:[[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        dispatch_async(main, ^{
            cell.imageView.image = [UIImage imageWithData:imageData];
        });
    });
    
//    dispatch_release(queue);
    
    return cell;
}

#pragma mark -
#pragma mark Actions

- (void)requestTimeline{
	// Create a request, which in this example, grabs the public timeline.
	// This example uses version 1 of the Twitter API.
	// This may need to be changed to whichever version is currently appropriate.
	TWRequest *postRequest = [[TWRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.twitter.com/1/statuses/darrenspriet_timeline.json"] parameters:nil requestMethod:TWRequestMethodGET];
	
	// Perform the request created above and create a handler block to handle the response.
	[postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
		NSString *output;
		
		if ([urlResponse statusCode] == 200) {
			// Parse the responseData, which we asked to be in JSON format for this request, into an NSDictionary using NSJSONSerialization.
			NSError *jsonParsingError = nil;
			NSDictionary *publicTimeline = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonParsingError];
			output = [NSString stringWithFormat:@"HTTP response status: %i\nPublic timeline:\n%@", [urlResponse statusCode], publicTimeline];
		}
		else {
			output = [NSString stringWithFormat:@"HTTP response status: %i\n", [urlResponse statusCode]];
		}
		
		[self performSelectorOnMainThread:@selector(displayText:) withObject:output waitUntilDone:NO];
	}];
}


//- (void)requestTimeline{
//    [self.tableView setHidden:YES];
////    [self.activityIndicatorView startAnimating];
//    
//    NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/user_timeline.json"];
//    
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//    [parameters setObject:@"envatomobile" forKey:@"screen_name"];
//    [parameters setObject:@"50" forKey:@"count"];
//    [parameters setObject:@"1" forKey:@"include_entities"];
//    
//    TWRequest *request = [[TWRequest alloc] initWithURL:url parameters:parameters requestMethod:TWRequestMethodGET];
//    
//    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//        if (responseData != nil) {
//            NSError *error = nil;
//            self.dataSource = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
//            
//            if (self.dataSource != nil) {
//                [self.tableView reloadData];
//                [self.tableView setHidden:NO];
////                [self.activityIndicatorView stopAnimating];
//                
//            } else {
//                NSLog(@"Error serializing response data %@ with user info %@.", error, error.userInfo);
//            }
//        } else {
//            NSLog(@"Error requesting timeline %@ with user info %@.", error, error.userInfo);
//        }
//    }];
//}

//- (IBAction)requestMentions:(id)sender {
//    [self.tableView setHidden:YES];
//    [self.activityIndicatorView startAnimating];
//    
//    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
//    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
//    
//    [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
//        if (granted) {
//            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
//            
//            if (accounts.count) {
//                ACAccount *twitterAccount = [accounts objectAtIndex:0];
//                
//                NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/mentions.json"];
//                
//                NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//                [parameters setObject:@"20" forKey:@"count"];
//                [parameters setObject:@"1" forKey:@"include_entities"];
//                
//                TWRequest *request = [[TWRequest alloc] initWithURL:url parameters:parameters requestMethod:TWRequestMethodGET];
//                [request setAccount:twitterAccount];
//                
//                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//                    if (responseData) {
//                        NSError *error = nil;
//                        self.dataSource = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
//                        
//                        if (self.dataSource) {
//                            [self.tableView reloadData];
//                            [self.tableView setHidden:NO];
//                            [self.activityIndicatorView stopAnimating];
//                            
//                        } else {
//                            NSLog(@"Error %@ with user info %@.", error, error.userInfo);
//                        }
//                    }
//                }];
//            }
//            
//        } else {
//            NSLog(@"The user does not grant us permission to access its Twitter account(s).");
//        }
//    }];
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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

@end
