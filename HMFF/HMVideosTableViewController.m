//
//  HMVideosTableViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-05-10.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMVideosTableViewController.h"

@interface HMVideosTableViewController ()
//Activitiy indicatior used in the Navigaition bar
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation HMVideosTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //this checks whether the internet is accessible and if it isn't, it will display a message
    HMCheckInternetAccess *internetAccess = [[HMCheckInternetAccess alloc]init];
    if ([internetAccess isInternetReachable]) {
        NSLog(@"Internet is Working!");
    }
    else{
        NSLog(@"Something wrong with the internet");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Internet is not Working" message:@"This page requires access to the internet. Please try again later." delegate:self cancelButtonTitle:nil otherButtonTitles: @"Dismiss", nil];
        [alert show];
    }
    
}
//Returns that this controller should always rotate
-(BOOL)shouldAutorotate{
    return YES;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self setYouTubeArray:[[HMDataFeedManager sharedDataFeedManager] youTubeArray]];

}
-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    UILabel *titleLabel = (UILabel *)self.navigationItem.titleView;
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:19.0f]];
        [titleLabel setTextColor:[UIColor blackColor]];
        [self.navigationItem setTitleView:titleLabel];
    }
    [titleLabel setText:title];
    [titleLabel sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.youTubeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //sets the dictionary which contains the content for youtube video to the array object at indexpath
    [self setVideoContent:[self.youTubeArray objectAtIndex:[indexPath row]]];
    
    //The youtubeVideosContent dictionary contains two keys: title and url which are defined in .h file.
    
    //creates a custom cell and calls the embedYoutube method which loads the video
    HMVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell"];
    [cell.videoWebView setBackgroundColor:[UIColor clearColor]];
    [cell.videoWebView setOpaque:NO];
    [cell.largeActivityIndicator startAnimating];
    

    [self embedYouTube:[self.VideoContent objectForKey:@"link"] webView:cell.videoWebView view:cell.videoWebView];
    
        [cell.videoWebView.scrollView setScrollEnabled:NO];
    [cell.videoTitle setText:[self.VideoContent objectForKey:@"title"]];
    return cell;

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





#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    NSInteger width = applicationFrame.size.width;
    NSInteger height = applicationFrame.size.height;

    
    //for iphone's portrait view
    if (width == 320) {
        return 205;
    }
    
    //for iphone5's landscape view
    else if (height == 568) {
        return 345;
    }
    
    
    //for iphone4S's landscape view
    else if (height == 480) {
        return 281;
    }
    
    //for ipad's portrait view
    else if (width == 768){
        return 421;
    }
    
    //for ipad's landscape view
    else if (height == 1024) {
        return 573;
    }
    
    //for ipad's landscape view
    else {
        return 535;
    }
    
    
}


-(void) embedYouTube: (NSString *)url webView:(UIWebView *)webView view:(UIView *)view{
    
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    NSInteger width = applicationFrame.size.width;
    NSInteger height = applicationFrame.size.height;
    //for iphone's portrait view
    if (width == 320) {
        NSString *embeddedHTML = [[NSString alloc]initWithFormat: @"<html><head><title>.</title><style>body,html,iframe{margin:0; margin-top:-10;padding:0;}</style></head><body><iframe width=\"321\" height=\"194\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe></body></html>" /*, width, height */, url];
        [webView loadHTMLString:embeddedHTML baseURL:nil];
    }
    
    //for iphone5's landscape view
    else if (height == 568) {
        NSString *embeddedHTML = [[NSString alloc]initWithFormat: @"<html><head><title>.</title><style>body,html,iframe{margin:0; margin-top:-13;padding:0;}</style></head><body><iframe width=\"569\" height=\"345\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe></body></html>" /*, width, height */, url];
        [webView loadHTMLString:embeddedHTML baseURL:nil];
    }
    
    
    //for iphone4S's landscape view
    else if (height == 480) {
        NSString *embeddedHTML = [[NSString alloc]initWithFormat: @"<html><head><title>.</title><style>body,html,iframeiframe{margin:0; margin-top:-13;padding:0;}</style></head><body><iframe width=\"481\" height=\"270\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe></body></html>" /*, width, height */, url];
        [webView loadHTMLString:embeddedHTML baseURL:nil];
    }
    
}


@end
