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

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if (viewController == [self.viewControllers objectAtIndex:0]){
//        HMLineUpViewController *linup =(HMLineUpViewController*)[[self.viewControllers objectAtIndex:0]topViewController];
//        [linup.scrollView setContentOffset:CGPointZero];
////        [linup.scrollView scrollRectToVisible:CGRectMake(-320, 0, linup.tableViewOne.frame.size.width, linup.tableViewOne.frame.size.height) animated:YES];
//        [linup.tableViewOne setContentOffset:CGPointZero];
//        [linup.tableViewTwo setContentOffset:CGPointZero];
//        [linup.scrollView setPagingEnabled:YES];
//        [linup.scrollView setFrame:CGRectMake(0, 0, linup.scrollView.frame.size.width, linup.scrollView.frame.size.height)];
//        
//        [linup.tableViewTwo reloadData];
//        [linup.tableViewOne reloadData];
//        [linup setPassed:@"num1"];
//        NSLog(@"what is table 2 set to %f", linup.tableViewTwo.frame.origin.x);
//
//        NSLog(@"what is scrollview set to %f", linup.scrollView.frame.origin.x);
//        NSLog(@"Line Up Tab");
//    }
//    else if (viewController == [self.viewControllers objectAtIndex:1]){
//        NSLog(@"News Feed Tab");

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
