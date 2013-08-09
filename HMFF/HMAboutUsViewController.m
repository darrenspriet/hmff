//
//  HMAboutUsViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-07-23.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMAboutUsViewController.h"

@interface HMAboutUsViewController ()

@end

@implementation HMAboutUsViewController

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
    //set the title of the navigation item to "About Us"
    [self.navigationItem setTitle:@"About Us"];
    //set the blackview to .4 alpha
    [self.blackView setAlpha:.4f];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
