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
    [self.controllerView setAlpha:0.3f];
    [self.controllerView setBackgroundColor:[UIColor blackColor]];
    
    [self setHTMLString:[[HMDataFeedManager sharedDataFeedManager] HTMLString]];
    [self setLinks:[[HMDataFeedManager sharedDataFeedManager] linksArray]];

    for (NSDictionary *diction in self.links){
        NSString * string=[diction objectForKey:@"name"];
        if ([string isEqualToString:@"facebook"]) {
            self.facebook =[diction objectForKey:@"link"];
        }
        else if ([string isEqualToString:@"youtube"]) {
            self.youtube =[diction objectForKey:@"link"];
        }
        if ([string isEqualToString:@"twitter"]) {
            self.twitter =[diction objectForKey:@"link"];
        }
        if ([string isEqualToString:@"vimeo"]) {
            self.vimeo =[diction objectForKey:@"link"];
        }
        if ([string isEqualToString:@"hmff"]) {
            self.hmffWebsite =[diction objectForKey:@"link"];
        }
    }

    //Image for the Navigation Bar
    UIImage *image = [UIImage imageNamed:@"hmffLogoIcon4.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    //Image for the Normal bar button
    UIImage *barImage = [UIImage imageNamed:@"ticketsButton.png"];
    //UIImage *barImageSelected = [UIImage imageNamed:@"ticketsButton.png"];
    
    CGRect frameImage = CGRectMake(0, 0, barImage.size.width, barImage.size.height);
    
    //Button with the frame size above
    UIButton *rightBarButtton = [[UIButton alloc] initWithFrame:frameImage];
    
    //Setting the Background for the Normal and Selected image
    [rightBarButtton setBackgroundImage:barImage forState:UIControlStateNormal];
    //[rightBarButtton setBackgroundImage:barImageSelected forState:UIControlStateHighlighted];
    
    //Setting the button so if it is tapped to call "buyTicketPressed:
    [rightBarButtton addTarget:self action:@selector(buyTicketPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //Adds the bar button to the navigation bar
    UIBarButtonItem *barButton =[[UIBarButtonItem alloc] initWithCustomView:rightBarButtton];
    [[self navigationItem] setRightBarButtonItem:barButton];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Method Gets called from the Buy Tickets Bar Button
-(void)buyTicketPressed:(id)sender{
    //Calls perform for segue with BuyTickets
    [self performSegueWithIdentifier:@"BuyTickets" sender:sender];
}

#pragma Prepare for Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    HMSocialWebBrowserViewController *webBrowser = segue.destinationViewController;
    //When the View is loaded it this container sets the delegats
    //Sends the Facebook http
    if ([segue.identifier isEqualToString:@"facebookSegue"]){
        [webBrowser setPassedURL:self.facebook];
        [webBrowser setHTMLString:NULL];

    }
    //Sends the YouTube http
    else if ([segue.identifier isEqualToString:@"youTubeSegue"]){
        [webBrowser setPassedURL:self.youtube];
        [webBrowser setHTMLString:NULL];


    }
    //Sends the TWITTER http
    else if ([segue.identifier isEqualToString:@"twitterSegue"]){
        [webBrowser setPassedURL:self.twitter];
        [webBrowser setHTMLString:NULL];


    }
    //Sends the Vimeo http
    else if ([segue.identifier isEqualToString:@"vimeoSegue"]){
        [webBrowser setPassedURL:self.vimeo];
        [webBrowser setHTMLString:NULL];


    }
    //Sends the HMFF http
    else if ([segue.identifier isEqualToString:@"HMFFSegue"]){
        webBrowser.passedURL=@"http://www.hmff.com";
        [webBrowser setHTMLString:self.hmffWebsite];

    }
    //Segue for the Buying tickets
    else if ([segue.identifier isEqualToString:@"BuyTickets"]){
        UINavigationController * navController =segue.destinationViewController;
        HMBuyTicketsViewController *buyTickets = (HMBuyTicketsViewController *)navController.topViewController;
        [buyTickets setPassedURL:@"http://www.hmff.com/?page_id=161"];
        [buyTickets setHTMLString: self.HTMLString];
        [buyTickets setPagePushed:@"Social"];


    }
}

@end
