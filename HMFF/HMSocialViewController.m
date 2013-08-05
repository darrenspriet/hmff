//
//  HMSocialViewController.m
//  HMFF
//
//  Created by Darren Spriet on 13-03-21.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMSocialViewController.h"

@interface HMSocialViewController ()

@end

@implementation HMSocialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//checks the rotation and returns accurate position
-(BOOL)shouldAutorotate{
    if (self.interfaceOrientation==UIInterfaceOrientationPortrait) {
        return NO;
    }
    else{
        return YES;
    }
}
- (void)viewDidLoad{
    [super viewDidLoad];
    //sets up the navigation bar
    [self setUpNavigationBar];
    //loads Data into the app
    [self loadData];
    //sets the alpha to .3 and dims down the background
    [self.controllerView setAlpha:0.3f];
    //sets that background to black
    [self.controllerView setBackgroundColor:[UIColor blackColor]];

    //Iterates through the links array and sets each of the links for the strings
    for (NSDictionary *diction in self.links){
        NSString * string=[diction objectForKey:@"name"];
        if ([string isEqualToString:@"facebook"]) {
            [self setFacebook: [diction objectForKey:@"link"]];
        }
        else if ([string isEqualToString:@"youtube"]) {
            [self setYoutube: [diction objectForKey:@"link"]];
        }
        if ([string isEqualToString:@"twitter"]) {
            [self setTwitter: [diction objectForKey:@"link"]];
        }
        if ([string isEqualToString:@"vimeo"]) {
            [self setVimeo: [diction objectForKey:@"link"]];
        }
        if ([string isEqualToString:@"hmff"]) {
            [self setHmffWebsite: [diction objectForKey:@"link"]];
        }
        if ([string isEqualToString:@"htmlLink"]) {
            [self setHTMLString: [diction objectForKey:@"link"]];
        }
    }
}
//sets up the navigation bar
-(void)setUpNavigationBar{
    //sets the icon in the Navigation bar
    UIImage *image = [UIImage imageNamed:@"hmffLogoIconSplash.png"];
    //sets the title to the image above
    [self.navigationItem setTitleView: [[UIImageView alloc] initWithImage:image]];
    //the image for the tickets button
    UIImage *barImage = [UIImage imageNamed:@"ticketsButton.png"];
    //grabbing a frame to put the button image into
    CGRect frameImage = CGRectMake(0, 0, barImage.size.width, barImage.size.height);
    //sets the right bar button to the frame above
    UIButton *rightBarButtton = [[UIButton alloc] initWithFrame:frameImage];
    //As well sets the button to the image above and its state to normal
    [rightBarButtton setBackgroundImage:barImage forState:UIControlStateNormal];
    //Adds the action to the button
    [rightBarButtton addTarget:self action:@selector(buyTicketPressed:) forControlEvents:UIControlEventTouchUpInside];
    //adds the button to the Navigation Controller
    UIBarButtonItem *barButton =[[UIBarButtonItem alloc] initWithCustomView:rightBarButtton];
    [[self navigationItem] setRightBarButtonItem:barButton];
    
}
//loads Data into the app
-(void)loadData{

    //sets the links array from the Data Manager
    [self setLinks:[[HMDataFeedManager sharedDataFeedManager] linksArray]];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buyTicketPressed:(id)sender{
    //calls the performsegueWith Identifier Buy Tickets
    [self performSegueWithIdentifier:@"BuyTickets" sender:sender];
}

#pragma Prepare for Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    HMSocialWebBrowserViewController *webBrowser = segue.destinationViewController;
    //Sends the Facebook url
    if ([segue.identifier isEqualToString:@"facebookSegue"]){
        [webBrowser setPassedURL:self.facebook];
        [webBrowser setHTMLString:NULL];

    }
    //Sends the YouTube url
    else if ([segue.identifier isEqualToString:@"youTubeSegue"]){
        [webBrowser setPassedURL:self.youtube];
        [webBrowser setHTMLString:NULL];


    }
    //Sends the TWITTER url
    else if ([segue.identifier isEqualToString:@"twitterSegue"]){
        [webBrowser setPassedURL:self.twitter];
        [webBrowser setHTMLString:NULL];


    }
    //Sends the Vimeo url
    else if ([segue.identifier isEqualToString:@"vimeoSegue"]){
        [webBrowser setPassedURL:self.vimeo];
        [webBrowser setHTMLString:NULL];


    }
    //Sends the HMFF url and the HTMLSTRING
    else if ([segue.identifier isEqualToString:@"HMFFSegue"]){
        [webBrowser setPassedURL:self.hmffWebsite];
        [webBrowser setHTMLString:self.HTMLString];

    }
    //if the user clicks buy tickets this segue is called
    else if([segue.identifier isEqualToString:@"BuyTickets"]){
        UINavigationController * navController =segue.destinationViewController;
        HMBuyTicketsViewController *buyTickets = (HMBuyTicketsViewController *)navController.topViewController;
        //passes the schedule
        [buyTickets setPagePushed:@"Social"];
    }
}

@end
