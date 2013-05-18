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
    [self setDate:[[HMDataFeedManager sharedDataFeedManager] date]];
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
        [self.delegate imagesForButton:@"" andFrontImage:@"forwardButton.png"];

    }
    else if (x > 160 && x < 320) {
        [self.delegate changeDate:[self.date objectAtIndex:1]];
        [self.delegate imagesForButton:@"backButton.png" andFrontImage:@"forwardButton.png"];
    }
}

-(void)scrollBack{
    NSLog(@"Scroll Back");
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(void)scrollForward{
    [self.scrollView setContentOffset:CGPointMake(320, 0) animated:YES];

    NSLog(@"Scroll Forward");

}

@end
