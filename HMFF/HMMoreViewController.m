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
    
    // Present mail view controller on screen
    [self presentViewController:messageComposer animated:YES completion:NULL];
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
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
