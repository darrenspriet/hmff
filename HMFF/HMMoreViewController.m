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
    //sets the HTMLString from the Data Manager
    [self setHTMLString:[[HMDataFeedManager sharedDataFeedManager] HTMLString]];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        //passes the More
        [buyTickets setPagePushed:@"More"];
    }
}

- (IBAction)SendAnEmail:(UIButton *)sender {
    if ([MFMailComposeViewController canSendMail]) {
        // Email Subject
        NSString *emailTitle = @"HMFF";
        // Email Content
        // NSString *messageBody = @"I love HMFF";
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:@"kevin@hmff.com"];
        //allocs and sets all of the information for the composer
        MFMailComposeViewController *messageComposer = [[MFMailComposeViewController alloc] init];
        
        [messageComposer setMailComposeDelegate: self];
        [messageComposer setSubject:emailTitle];
        // [messageComposer setMessageBody:messageBody isHTML:NO];
        [messageComposer setToRecipients:toRecipents];
        [messageComposer.navigationItem.leftBarButtonItem setTintColor:[UIColor blueColor]];
        
        // Present mail view controller on screen
        [self presentViewController:messageComposer animated:YES completion:NULL];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Unable to Send Email" message:@"You must add an email account." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

}

#pragma mark - MailComposer Delegate
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            //            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            //            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            //            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
