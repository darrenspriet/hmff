//
//  HMSplashViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-05-17.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMSplashViewController.h"

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
    
}

-(void)showLabels{
    
    [self.cityLabel setAlpha:0.0f];
    [self.dateLabel setAlpha:0.0f];
    [self.cityLabel setText:@"Hamilton, Ontario"];
    [self.dateLabel setText:@"Sept 17-18  2013"];
    [UIView animateWithDuration:2 animations:^{
        [self.dateLabel setAlpha:1.0f];
        [self.cityLabel setAlpha:1.0f];
    }];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
	// Do any additional setup after loading the view.
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
