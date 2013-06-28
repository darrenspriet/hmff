//
//  HMMoreViewController.m
//  HMFF
//
//  Created by Darren Spriet on 13-03-21.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMMoreViewController.h"

@interface HMMoreViewController ()

@end

@implementation HMMoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setHTMLString:[[HMDataFeedManager sharedDataFeedManager] HTMLString]];

    //Image for the Navigation Bar
    UIImage *image = [UIImage imageNamed:@"HMFFlogo3.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    //Image for the Normal bar button
    UIImage *barImage = [UIImage imageNamed:@"ticketButton.png"];
    //Image for the Selected bar button
    UIImage *barImageSelected = [UIImage imageNamed:@"ticketButtonSelected.png"];
    
    //Frame size of the image so the button is that size
    CGRect frameImage = CGRectMake(0, 0, barImage.size.width, barImage.size.height);
    
    //Button with the frame size above
    UIButton *rightBarButtton = [[UIButton alloc] initWithFrame:frameImage];
    
    //Setting the Background for the Normal and Selected image
    [rightBarButtton setBackgroundImage:barImage forState:UIControlStateNormal];
    [rightBarButtton setBackgroundImage:barImageSelected forState:UIControlStateHighlighted];
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //Segue for the Buying tickets
    if ([segue.identifier isEqualToString:@"BuyTickets"]){
        UINavigationController * navController =segue.destinationViewController;
        HMBuyTicketsViewController *buyTickets = (HMBuyTicketsViewController *)navController.topViewController;
        [buyTickets setPassedURL:@"http://www.hmff.com/?page_id=161"];
        [buyTickets setHTMLString: self.HTMLString];

    }
}

- (IBAction)SendAnEmail:(UIButton *)sender {
    // Email Subject
    NSString *emailTitle = @"HMFF Support";
    // Email Content
    NSString *messageBody = @"I love HMFF";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"support@hmff.com"];
    
    MFMailComposeViewController *messageComposer = [[MFMailComposeViewController alloc] init];
    [messageComposer setMailComposeDelegate: self];
    [messageComposer setSubject:emailTitle];
    [messageComposer setMessageBody:messageBody isHTML:NO];
    [messageComposer setToRecipients:toRecipents];
    [messageComposer.navigationItem.leftBarButtonItem setTintColor:[UIColor blueColor]];
    
    // Present mail view controller on screen
    [self presentViewController:messageComposer animated:YES completion:NULL];
}

#pragma mark - MailComposer Delegate
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
