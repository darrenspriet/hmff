//
//  HMTabBarViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-03-26.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMTabBarViewController.h"

@interface HMTabBarViewController ()

@end

@implementation HMTabBarViewController

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
    [self setDelegate:self];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Logs the Tabs being pressed
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if (viewController == [self.viewControllers objectAtIndex:0]){
        NSLog(@"Line Up Tab");
    }
    else if (viewController == [self.viewControllers objectAtIndex:1]){
        NSLog(@"News Feed Tab");

    }
    else if (viewController == [self.viewControllers objectAtIndex:2]){
        NSLog(@"Twitter Tab");
        
    }
    else if (viewController == [self.viewControllers objectAtIndex:3]){
        NSLog(@"Social Tab");
        
    }
    else {
        NSLog(@"More Tab");
        
    }
}

@end
