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
    

    
   // [self.splashImage setImage:[UIImage imageNamed:@"Default.png"]];
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
