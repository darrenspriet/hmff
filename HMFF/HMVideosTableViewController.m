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
//        NSLog(@"Internet is Working!");
    }
    else{
//        NSLog(@"Something wrong with the internet");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Internet is not Working" message:@"This page requires access to the internet. Please try again later." delegate:self cancelButtonTitle:nil otherButtonTitles: @"Dismiss", nil];
        [alert show];
    }
    
}
//checks the rotation and returns accurate position
-(BOOL)shouldAutorotate{
    return YES;
}
//if the page rotates it reloads the video cells so that they resize properly
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.tableView reloadData];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //Sets the title to Videos
    [self.navigationItem setTitle:@"Videos"];
    //sets the youTube Array to the One in HMData Feed Manager
    [self setYouTubeArray:[[HMDataFeedManager sharedDataFeedManager] youTubeArray]];
}

- (void)didReceiveMemoryWarning{
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
    return [self.youTubeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //sets the dictionary which contains the content for youtube video to the array object at indexpath
    [self setVideoContent:[self.youTubeArray objectAtIndex:[indexPath row]]];
    //creates the cell
    static NSString *CellIdentifier = @"VideoCell";
    HMVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HMVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //configures the webview to clear and not opaque
    [cell.videoWebView setBackgroundColor:[UIColor clearColor]];
    [cell.videoWebView setOpaque:NO];
    //starts the indicatior to animatin
    [cell.largeActivityIndicator startAnimating];
    
    //sets up the embeded youtube view
    [self embedYouTube:[self.VideoContent objectForKey:@"link"] webView:cell.videoWebView view:cell.videoWebView];
    //sets the scroll view to enabled no
    [cell.videoWebView.scrollView setScrollEnabled:NO];
    //sets the title for the video
    [cell.videoTitle setText:[self.VideoContent objectForKey:@"title"]];
    //returns the cell
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //get the application frame
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];

    //set the width to the size of application frame.size.width and lenght
    NSInteger height = applicationFrame.size.height;

    //for iphone5's landscape view
    if (height == 568) {
        return 345;
    }
    //for iphone4S's landscape view
    else if (height == 480) {
        return 281;
    }
    //for iphone's portrait view
    else {
        return 205;
    }
}


-(void) embedYouTube: (NSString *)url webView:(UIWebView *)webView view:(UIView *)view{
    
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    NSInteger width = applicationFrame.size.width;
    NSInteger height = applicationFrame.size.height;
    //for iphone's portrait view
    if (width == 320) {
        NSString *embeddedHTML = [[NSString alloc]initWithFormat: @"<html><head><title>.</title><style>body,html,iframe{margin:0; margin-top:-10;padding:0;}</style></head><body><iframe width=\"321\" height=\"194\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe></body></html>" , url];
        [webView loadHTMLString:embeddedHTML baseURL:nil];
    }
    
    //for iphone5's landscape view
    else if (height == 568) {
        NSString *embeddedHTML = [[NSString alloc]initWithFormat: @"<html><head><title>.</title><style>body,html,iframe{margin:0; margin-top:-13;padding:0;}</style></head><body><iframe width=\"569\" height=\"345\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe></body></html>" , url];
        [webView loadHTMLString:embeddedHTML baseURL:nil];
    }
    //for iphone4S's landscape view
    else if (height == 480) {
        NSString *embeddedHTML = [[NSString alloc]initWithFormat: @"<html><head><title>.</title><style>body,html,iframeiframe{margin:0; margin-top:-13;padding:0;}</style></head><body><iframe width=\"481\" height=\"270\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe></body></html>" , url];
        [webView loadHTMLString:embeddedHTML baseURL:nil];
    }
    
}


@end
