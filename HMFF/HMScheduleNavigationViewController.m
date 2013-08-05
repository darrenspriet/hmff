//
//  HMScheduleNavigationViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMScheduleNavigationViewController.h"

@interface HMScheduleNavigationViewController ()

@end

@implementation HMScheduleNavigationViewController

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
    //launches the Schedule storyboard at the begining of the app
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Schedule" bundle:nil];
    //sets it to the initialViewController on that storyboard
    UIViewController *initialViewController = [storyboard instantiateInitialViewController];
    //pushes the view controller onto the stack
    [self pushViewController:initialViewController animated:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
