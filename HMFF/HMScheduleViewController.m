//
//  HMScheduleViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMScheduleViewController.h"

@interface HMScheduleViewController ()

@end

@implementation HMScheduleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad{
    [super viewDidLoad];
    [self setDate:[[HMDataFeedManager sharedDataFeedManager] date]];
    [self setHTMLString:[[HMDataFeedManager sharedDataFeedManager] HTMLString]];
    [self.dateForEvent setText:[self.date objectAtIndex:0]];
    [self imagesForButton:@"" andFrontImage:@"forwardButton.png"];

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

-(void)buyTicketPressed:(id)sender{
    [self setHTMLString:[[HMDataFeedManager sharedDataFeedManager] HTMLString]];

    [self performSegueWithIdentifier:@"BuyTickets" sender:sender];


    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //When the View is loaded it this container sets the delegats
    if ([segue.identifier isEqualToString:@"container"]){
        [(HMScheduleScrollViewController*)segue.destinationViewController setDelegate:self];

    [self setDelegate:(id<HMScheduleViewControllerDelegate>)segue.destinationViewController];
    }
    else if([segue.identifier isEqualToString:@"BuyTickets"]){

        
        UINavigationController * navController =segue.destinationViewController;
        HMBuyTicketsViewController *buyTickets = (HMBuyTicketsViewController *)navController.topViewController;
            [buyTickets setPassedURL:@"http://www.hmff.com/?page_id=161"];
        [buyTickets setHTMLString: self.HTMLString];
        
    }
}

-(void)changeDate:(NSString *)date{
    [self.dateForEvent setText:date];

}
-(void)imagesForButton:(NSString*)backImage andFrontImage:(NSString*)frontImage{
    if (backImage!=nil) {
        [self.backButtonImage setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
    }
    if (frontImage!=nil) {
    [self.forwardButtonImage setImage:[UIImage imageNamed:frontImage] forState:UIControlStateNormal];
    }

}


- (IBAction)forwardButton:(UIButton *)sender {
    [self.delegate scrollForward];
    
}
- (IBAction)backButton:(UIButton *)sender {
    [self.delegate scrollBack];

}
@end
