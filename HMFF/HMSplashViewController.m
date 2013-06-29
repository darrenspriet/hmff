//
//  HMSplashViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-05-17.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMSplashViewController.h"
#import "Reachability.h"

@interface HMSplashViewController ()

@end

@implementation HMSplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"view will appear");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    self.internetReachable = [Reachability reachabilityForInternetConnection];
    [self.internetReachable startNotifier];
    
    // check if a pathway to a random host exists
    self.hostReachable = [Reachability reachabilityWithHostName: @"http://www.apple.com"] ;
    [self.hostReachable startNotifier];
    
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"view did appear");

}

-(void)viewWillDisappear:(BOOL)animated{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
-(void) checkNetworkStatus:(NSNotification *)notice
{
    // called after network status changes
    NetworkStatus internetStatus = [self.internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Internet is not Working" message:@"This app requires access to the internet. Please try again later." delegate:self cancelButtonTitle:nil otherButtonTitles: @"Dismiss", nil];
            [alert show];
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            [self loadUpApp];
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            [self loadUpApp];
            
            break;
        }
    }
    
    NetworkStatus hostStatus = [self.hostReachable currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            NSLog(@"A gateway to the host server is down.");
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"A gateway to the host server is working via WIFI.");            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"A gateway to the host server is working via WWAN.");            
            break;
        }
    }
}
-(void)showLabels{
    
    
    [UIView animateWithDuration:.5f animations:^{
        [self.dateLabel setAlpha:1.0f];
        [self.cityLabel setAlpha:1.0f];
    }];
    
    
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
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f) {
            [self.splashImage setImage:[UIImage imageNamed:@"Default-568h@2x.png"]];
        } else {
            [self.splashImage setImage:[UIImage imageNamed:@"Default.png"]];
        }
    } else {
        /*Do iPad stuff here.*/
    }
    NSLog(@"VIEW DID APPEAR");
    
    
	// Do any additional setup after loading the view.
}
-(void)loadUpApp{
    [self.cityLabel setAlpha:0.0f];
    [self.dateLabel setAlpha:0.0f];
    
    
    NSLog(@"get parse dates started");
    
    
    NSArray *scheduleObjects = [[NSMutableArray alloc]init];
    PFQuery *scheduleQuery = [PFQuery queryWithClassName:@"splash"];
    //Puts all of the querys into an object
    scheduleObjects= [scheduleQuery findObjects];
    
    NSLog(@"get parse dates finished");
    for(NSDictionary *diction in scheduleObjects){
        [self.dateLabel setText:[diction objectForKey:@"dates"]];
        [self.cityLabel setText:[diction objectForKey:@"location"]];
       
    }
     [self showLabels];
    
    
    
    [HMDataFeedManager sharedDataFeedManager];
    
    [HMDataFeedManager sharedDataFeedManager].completionBlock = ^(BOOL success){
        if (success)
        {
            NSLog(@"Finished loading data");
            [self performSegueWithIdentifier:@"splashSegue" sender:self];
        }
        else{
            NSLog(@"app did not load successfully");
        }
    };
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //When the View is loaded it this container sets the delegats
    if ([segue.identifier isEqualToString:@"splashSegue"]){
        
    }
}

@end
