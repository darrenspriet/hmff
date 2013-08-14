//
//  HMTwitterViewController.m
//  HMFF
//
//  Created by Darren Spriet on 13-03-21.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMTwitterViewController.h"

@interface HMTwitterViewController ()

@end

@implementation HMTwitterViewController



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
//returns the accurate rotation position
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //sets up the navigation bar
    [self setUpNavigationBar];
    //loads Data into the app
    [self loadData];
    
}
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
-(void)loadData{
    //sets the HTMLString from the Data Manager
    [self setHTMLString:[[HMDataFeedManager sharedDataFeedManager] HTMLString]];
    //sets the tweets array to from the Data Manager
    [self setTweets :[[HMDataFeedManager sharedDataFeedManager] tweets]];
    
}

-(void)buyTicketPressed:(id)sender{
    //calls the performsegueWith Identifier Buy Tickets
    [self performSegueWithIdentifier:@"BuyTickets" sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //if the user clicks buy tickets this segue is called
    if([segue.identifier isEqualToString:@"BuyTickets"]){
        UINavigationController * navController =segue.destinationViewController;
        HMBuyTicketsViewController *buyTickets = (HMBuyTicketsViewController *)navController.topViewController;
        //passes the schedule
        [buyTickets setPagePushed:@"Twitter"];
    }
}

//Used to post a tweet
- (IBAction)postTweet:(UIButton *)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        //Sets the initial text for the twitter message
        [tweetSheet setInitialText:@"@HMFFEST"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
