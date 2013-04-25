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



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    UIImage *barImage = [UIImage imageNamed:@"ticketButton.png"];
    UIImage *barImageSelected = [UIImage imageNamed:@"ticketButtonSelected.png"];
    
    CGRect frameImage = CGRectMake(0, 0, barImage.size.width, barImage.size.height);
    UIButton *rightBarButtton = [[UIButton alloc] initWithFrame:frameImage];
    [rightBarButtton setBackgroundImage:barImage forState:UIControlStateNormal];
    [rightBarButtton setBackgroundImage:barImageSelected forState:UIControlStateHighlighted];
    
    
    [rightBarButtton addTarget:self action:@selector(buyTicketPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton =[[UIBarButtonItem alloc] initWithCustomView:rightBarButtton];
    [[self navigationItem] setRightBarButtonItem:barButton];
    
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"BuyTickets"]){
        HMBuyTicketsViewController *buyTickets = segue.destinationViewController;
        [buyTickets setPassedURL:@"http://www.hmff.com/?page_id=161"];
    }
}

-(void)buyTicketPressed:(id)sender{
    [self performSegueWithIdentifier:@"BuyTickets" sender:sender];
    
}


- (IBAction)postTweet:(UIButton *)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"@HMFFEST"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}
@end
