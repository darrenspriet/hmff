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
    
    //Adds a notification for the network status
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    //Checks the internet for reachability
    [self setInternetReachable:  [Reachability reachabilityForInternetConnection]];
    [self.internetReachable startNotifier];
    
    // check if a pathway to a random host exists
    [self setHostReachable: [Reachability reachabilityWithHostName: @"http://www.apple.com"] ];
    [self.hostReachable startNotifier];
    //    NSLog(@"view will appear");
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    NSLog(@"view will dissapear");
    
}
-(void)viewDidDisappear:(BOOL)animated{
    //    NSLog(@"view did disaper");
}
-(void) checkNetworkStatus:(NSNotification *)notice
{
    // called after network status changes
    NetworkStatus internetStatus = [self.internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            //NSLog(@"The internet is down.");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Internet is not Working" message:@"This app requires access to the internet. Please try again later." delegate:self cancelButtonTitle:nil otherButtonTitles: @"Dismiss", nil];
            [alert show];
            [self.largeActivitiyIndicator setAlpha:0.0f];
            
            
            break;
        }
        case ReachableViaWiFi:
        {
            //NSLog(@"The internet is working via WIFI.");
            [self loadUpApp];
            [self.largeActivitiyIndicator setAlpha:1.0f];
            
            
            break;
        }
        case ReachableViaWWAN:
        {
            //NSLog(@"The internet is working via WWAN.");
            [self loadUpApp];
            [self.largeActivitiyIndicator setAlpha:1.0f];
            
            break;
        }
    }
    
    NetworkStatus hostStatus = [self.hostReachable currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            //            NSLog(@"A gateway to the host server is down.");
            break;
        }
        case ReachableViaWiFi:
        {
            //            NSLog(@"A gateway to the host server is working via WIFI.");
            break;
        }
        case ReachableViaWWAN:
        {
            //            NSLog(@"A gateway to the host server is working via WWAN.");
            break;
        }
    }
}
//shows the Labels once the Data Manager is finished
-(void)showLabels{
    [UIView animateWithDuration:.5f animations:^{
        
        [self.dateLabel setAlpha:1.0f];
        [self.cityLabel setAlpha:1.0f];
    }];
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
    //starts loading the data for the app
    [HMDataFeedManager sharedDataFeedManager];
    //set the splash page to 0.0
    [self.splashImage setAlpha:0.0f];
    [self.largeActivitiyIndicator setAlpha:0.0f];
    //start the activity indicator
    [self.largeActivitiyIndicator startAnimating];
    
    //centers the hmff image
    self.hmffImage.center = CGPointMake(164, 236);
    
    [self.hmffImage setHidden:NO];
    [self.hmffImage removeFromSuperview];
    [self.hmffImage setTranslatesAutoresizingMaskIntoConstraints:YES];
    if ([self isSmallScreen]) {
        [self.hmffImage setFrame:CGRectMake(160-self.hmffImage.frame.size.width/2, 150, self.hmffImage.frame.size.width, self.hmffImage.frame.size.height)];
    }
    else{
        [self.hmffImage setFrame:CGRectMake(160-self.hmffImage.frame.size.width/2, 236, self.hmffImage.frame.size.width, self.hmffImage.frame.size.height)];
    }
    
    [self.view addSubview:self.hmffImage];
    
    //Gets the screen size
    //    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    //    //if screen size is iphone 5 then load the iphone 5 image...else load default one
    //    if (screenSize.height > 480.0f) {
    //        [self.splashImage setImage:[UIImage imageNamed:@"openingImage-iph5.png"]];
    //    } else {
    [self.splashImage setImage:[UIImage imageNamed:@"openingImage.png"]];
    //    }
    //start the move up of the hmff logo
    [UIView transitionWithView:nil
                      duration:2.5f
                       options:UIViewAnimationOptionCurveEaseIn
                    animations:^(void) {
                        if ([self isSmallScreen]) {
                            self.hmffImage.frame = CGRectMake(160-self.hmffImage.frame.size.width/2, 60.0f, self.hmffImage.frame.size.width, self.hmffImage.frame.size.height);
                        }
                        else{
                            self.hmffImage.frame = CGRectMake(160-self.hmffImage.frame.size.width/2, 100.0f, self.hmffImage.frame.size.width, self.hmffImage.frame.size.height);
                        }
                        
                        [self.largeActivitiyIndicator setAlpha:1.0f];
                    }
                    completion:^(BOOL finished) {
                    }];
    //fades in the splash image
    [UIView animateWithDuration:2.0f animations:^{
        [self.splashImage setAlpha:.3f];
    }];
    
}

//load the data into the app
-(void)loadUpApp{
    //        NSDate *startTime = [NSDate date];
    
    //set the date and city label to 0.0 alpha
    [self.cityLabel setAlpha:0.0f];
    [self.dateLabel setAlpha:0.0f];
    //holds the schedule objects
    //query from parse
    
    PFQuery *scheduleQuery = [PFQuery queryWithClassName:@"splash"];
    //Puts all of the querys into an object
    NSArray *scheduleObjects= [scheduleQuery findObjects];
    //Goes through and pulls out the date and location
    for(NSDictionary *diction in scheduleObjects){
        [self.dateLabel setText:[diction objectForKey:@"dates"]];
        [self.cityLabel setText:[diction objectForKey:@"location"]];
    }
    //stops the animating and removes the large activity indicator from the view
    [self.largeActivitiyIndicator stopAnimating];
    [self.largeActivitiyIndicator removeFromSuperview];
    //show the labels
    [self showLabels];
    
    
    
    //completion block for the data loading, and will call the segue when it does
    [HMDataFeedManager sharedDataFeedManager].completionBlock = ^(BOOL success){
        if (success)
        {
            //            NSDate *endTime= [NSDate date];
            //            CGFloat difference= [endTime timeIntervalSinceDate:startTime];
            //            NSLog(@"Total Time: %f", difference);
              [self performSegueWithIdentifier:@"splashSegue" sender:self];
        }
        else{
            //            NSLog(@"app did not load successfully");
        }
    };
}

//Check what size the screen is
-(BOOL)isSmallScreen{
    if([UIScreen mainScreen].bounds.size.height != 568){
        return YES;
    }
    else{
        return NO;
    }
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
