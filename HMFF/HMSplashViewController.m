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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.splashImage setImage:[UIImage imageNamed:@"Default.png"]];
    //Builds the data manage at the beginning
    dispatch_async(dispatch_get_main_queue(), ^{
        [HMDataFeedManager sharedDataFeedManager];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Finished loading data");
            
            
            //Delays while the app gets the data it needs 
            [NSTimer scheduledTimerWithTimeInterval:1.5
                                             target:self
                                           selector:@selector(callingPerpareForSegue)
                                           userInfo:nil
                                            repeats:NO];
            

        });
    });
   
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callingPerpareForSegue{
    NSLog(@"Loading App Data done?");
    [self performSegueWithIdentifier:@"splashSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //When the View is loaded it this container sets the delegats
    if ([segue.identifier isEqualToString:@"splashSegue"]){

    }        
}

@end
