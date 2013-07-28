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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"About Us"];

    
    [self.blackView setAlpha:.4f];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
