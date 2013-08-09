//
//  HMDetailsViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-07-16.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMDetailsViewController.h"

@interface HMDetailsViewController ()

@end

@implementation HMDetailsViewController

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
    //Sets the title of the screen to "Details
    [self.navigationItem setTitle:@"Details"];
    //Adjusts the alpha so the words are more readable
    [self.blackView setAlpha:.4f];
    //to set the detail label with the detail string
    [self.detailsLabel setText:self.detailString];
    //to set the address label with the address string
    [self.addressLabel setText:self.addressString];
    //Sets the leftbar button to "Back"
    [self.navigationController.navigationBar.topItem setTitle :@"Back" ];

}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
