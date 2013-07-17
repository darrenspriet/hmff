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
    [self.blackView setAlpha:.3f];

    [self.detailsLabel setText:self.detailString];
    [self.addressLabel setText:self.addressString];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
