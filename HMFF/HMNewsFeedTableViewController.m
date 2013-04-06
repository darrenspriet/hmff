//
//  HMNewsFeedTableViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-06.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMNewsFeedTableViewController.h"

@interface HMNewsFeedTableViewController (){
    NSMutableData *newsFeedData;
    NSURLConnection *connection;
    NSMutableArray *titleArray;
    NSMutableArray *contentArray;
    
}

@end

@implementation HMNewsFeedTableViewController

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
    UIImage *image = [UIImage imageNamed:@"HMFFlogo.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    titleArray = [[NSMutableArray alloc]init];
    contentArray = [[NSMutableArray alloc]init];
    
    
    //This was in the Action in the Previous project
    NSURL *url =[NSURL URLWithString:@"http://www.hmff.com/?json=get_recent_posts&count=100"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if(connection){
        newsFeedData = [[NSMutableData alloc]init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return [titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text =[titleArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - NSURL Connections

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [newsFeedData setLength:0];
    NSLog(@"Did Recieve a Response");
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [newsFeedData appendData:data];
    NSLog(@"Did Recieve Data");
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Failed with error %@", error);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *dataDictionary= [NSJSONSerialization JSONObjectWithData:newsFeedData options:0 error:nil];
    NSArray *title = [dataDictionary objectForKey:@"posts"];
    NSArray *content =[dataDictionary objectForKey:@"posts"];
    
    for(NSDictionary *diction in title){
        NSString  *title =[diction objectForKey:@"title"];
        NSLog(@"this is the title %@", title);
        [titleArray addObject:title];
    }
    for(NSDictionary *diction in content){
        NSString  *content =[diction objectForKey:@"excerpt"];
        NSLog(@"this is the content %@", content);
        [contentArray addObject:content];
    }
    
    [[self tableView] reloadData];
}
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
