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
    self.keychain =
    [[KeychainItemWrapper alloc] initWithIdentifier:@"followTwitter" accessGroup:nil];
    NSLog(@"what is in here: %@", [self.keychain objectForKey:(__bridge id)(kSecAttrAccount)]);
    if ([[self.keychain objectForKey:(__bridge id)(kSecAttrAccount)] isEqualToString:@"following"]) {
        [self.TwitterButtonOutlet setTitle:@"          FOLLOWING" forState:UIControlStateNormal];
        [self.TwitterButtonOutlet setTitle:@"          FOLLOWING" forState:UIControlStateSelected];

        [self.TwitterButtonOutlet setTitle:@"          FOLLOWING" forState:UIControlStateHighlighted];
        [self.TwitterButtonOutlet setBackgroundImage:[UIImage imageNamed:@"Following.png"] forState:UIControlStateNormal];
        [self.TwitterButtonOutlet setBackgroundImage:[UIImage imageNamed:@"Following.png"] forState:UIControlStateHighlighted];
        [self.TwitterButtonOutlet setBackgroundImage:[UIImage imageNamed:@"Following.png"] forState:UIControlStateSelected];
        NSLog(@"followTwitter works");
    }
    else{
        [self.TwitterButtonOutlet setBackgroundImage:[UIImage imageNamed:@"Twitter_Follow_1x.png"] forState:UIControlStateNormal];
        [self.TwitterButtonOutlet setBackgroundImage:[UIImage imageNamed:@"Twitter_Follow_1x.png"] forState:UIControlStateHighlighted];
        [self.TwitterButtonOutlet setBackgroundImage:[UIImage imageNamed:@"Twitter_Follow_1x.png"] forState:UIControlStateSelected];
        NSLog(@"followTwitter not in the system");
    }
    
    [self setHTMLString:[[HMDataFeedManager sharedDataFeedManager] HTMLString]];
    self.tweets = [[HMDataFeedManager sharedDataFeedManager] tweets];
    NSNumber *totalFollowers;
    for(NSDictionary *diction in self.tweets){
        if ([[[diction objectForKey:@"user"] objectForKey:@"name"] isEqualToString:@"HMFF"]) {
            totalFollowers=[[diction objectForKey:@"user"] objectForKey:@"followers_count"];
            
        }
    }
    NSLog(@"TOTAL FOLLOWERS IS: %@", totalFollowers);
    // [self.totalFollowers setText:[NSString stringWithFormat:@"%@",totalFollowers]];
    
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

//Used to post a tweet
- (IBAction)postTweet:(UIButton *)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        //Sets the initial text for the twitter message
        [tweetSheet setInitialText:@"@HMFFEST"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}
- (IBAction)followTapped:(UIButton *)sender {
    
    if (![[self.keychain objectForKey:(__bridge id)(kSecAttrAccount)] isEqualToString:@"following"]) {
        
        
        self.accountStore = [[ACAccountStore alloc] init];
        self.profileImages = [NSMutableDictionary dictionary];
        
        ACAccountType *twitterType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        [self.accountStore requestAccessToAccountsWithType:twitterType options:nil completion:^(BOOL granted, NSError *error) {
            
            if(granted) {
                NSArray *twitterAccounts = [self.accountStore accountsWithAccountType:twitterType];
                
                if ([twitterAccounts count])
                {
                    self.userAccount = [twitterAccounts objectAtIndex:0];
                    
                    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
                    [tempDict setValue:@"HMFFEST" forKey:@"screen_name"];
                    [tempDict setValue:@"true" forKey:@"follow"];
                    NSLog(@"*******tempDict %@*******",tempDict);
                    
                    
                    
                    SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:[NSURL URLWithString:@"http://api.twitter.com/1.1/friendships/create.json"] parameters:tempDict];
                    [postRequest setAccount:self.userAccount];
                    [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                        NSString *output = [NSString stringWithFormat:@"HTTP response status: %i Error %d", [urlResponse statusCode],error.code];
                        NSLog(@"%@error %@", output,error.description);
                        [self.TwitterButtonOutlet setTitle:@"          FOLLOWING" forState:UIControlStateNormal];
                        [self.TwitterButtonOutlet setTitle:@"          FOLLOWING" forState:UIControlStateSelected];
                        
                        [self.TwitterButtonOutlet setTitle:@"          FOLLOWING" forState:UIControlStateHighlighted];
                        
                        [self.TwitterButtonOutlet setBackgroundImage:[UIImage imageNamed:@"Following.png"] forState:UIControlStateNormal];
                        [self.TwitterButtonOutlet setBackgroundImage:[UIImage imageNamed:@"Following.png"] forState:UIControlStateHighlighted];
                        [self.TwitterButtonOutlet setBackgroundImage:[UIImage imageNamed:@"Following.png"] forState:UIControlStateSelected];
                        NSLog(@"followTwitter works");
                        
                        
                        
                        [self.keychain setObject:@"following" forKey:(__bridge id)(kSecAttrAccount)];
                        
                        

                        NSLog(@"Data saved");
                        
                    }];
                }
                else
                {
                    NSLog(@"No Twitter Accounts");
                }
                
                
            }
            
            
        }];
        
    }
    else{
        NSLog(@"We are already following");
    }
}
@end
