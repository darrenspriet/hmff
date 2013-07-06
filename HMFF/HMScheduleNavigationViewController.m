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
-(NSUInteger)supportedInterfaceOrientations {
    UIViewController *top = self.topViewController;
    return top.supportedInterfaceOrientations;
}

-(BOOL)shouldAutorotate {
    UIViewController *top = self.topViewController;    
    return [top shouldAutorotate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDate:[[HMDataFeedManager sharedDataFeedManager] date]];
    NSLog(@"the date count is: %d", [self.date count]);

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Schedule" bundle:nil];
    UIViewController *initialViewController = [storyboard instantiateInitialViewController];
    [self pushViewController:initialViewController animated:YES];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
