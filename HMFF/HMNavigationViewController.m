//
//  HMNavigationViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-06-27.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMNavigationViewController.h"

@interface HMNavigationViewController ()

@end

@implementation HMNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//sets the supported InterfaceOrientations to the top controller
-(NSUInteger)supportedInterfaceOrientations {
    UIViewController *top = self.topViewController;
    return top.supportedInterfaceOrientations;
}
//sets the supported shouldAutoRotate to the top controller
-(BOOL)shouldAutorotate {
    UIViewController *top = self.topViewController;
    return [top shouldAutorotate];
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
