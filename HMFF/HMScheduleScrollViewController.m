//
//  HMScheduleScrollViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMScheduleScrollViewController.h"

@interface HMScheduleScrollViewController ()

@end

@implementation HMScheduleScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.scrollView setContentSize:CGSizeMake([self.date count]*320, self.scrollView.frame.size.height)];
    [self.scrollView setPagingEnabled:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDate:[(HMAppDelegate *)[[UIApplication sharedApplication] delegate] date]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)changeDate{
    
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float x = scrollView.contentOffset.x;

    if (x > 0 && x < 160) {
        [self.delegate changeDate:[self.date objectAtIndex:0]];

    }
    else if (x > 160 && x < 320) {
        [self.delegate changeDate:[self.date objectAtIndex:1]];
    }
}

@end
