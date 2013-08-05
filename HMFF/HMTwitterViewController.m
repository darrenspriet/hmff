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

- (void)viewDidLoad{
    [super viewDidLoad];
    //sets up the navigation bar
    [self setUpNavigationBar];
    //loads Data into the app
    [self loadData];
    
   ////////////////////////////////////////////
    
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
    //////////////////////////////////////////
    
    
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
////////////////////////////////////
- (IBAction)followTapped:(UIButton *)sender {
    
    if (![[self.keychain objectForKey:(__bridge id)(kSecAttrAccount)] isEqualToString:@"following"]) {
        
        
        self.accountStore = [[ACAccountStore alloc] init];
        
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
////////////////////////////////////////

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
