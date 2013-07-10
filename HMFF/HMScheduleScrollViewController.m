//
//  HMScheduleScrollViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMScheduleScrollViewController.h"
#import "HMThirdTableViewController.h"
#import "HMSecondTableViewController.h"


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
    [self.scrollView setContentSize:CGSizeMake(([self.date count])*320, self.scrollView.frame.size.height)];
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
    NSString *forwardString =@"forwardButton.png";
    NSString *backString =@"backButton.png";
    NSString *noButtonString=@"";
    NSString *buttonString;

//    NSLog(@"the x is: %f", x);
//    NSLog(@"what is self.count %d",[self.date count]);
    if (x >= 0 && x < 160) {
        if ([self.date count]>1) {buttonString=forwardString;}
        else{buttonString=noButtonString;}
        [self.delegate changeDate:[self.date objectAtIndex:0]];
        [self.delegate imagesForButton:noButtonString andFrontImage:buttonString];

    }
    else if (x >= 320 && x < 480) {
        if ([self.date count]>2) {buttonString=forwardString;}
        else{buttonString=noButtonString;}
        [self.delegate changeDate:[self.date objectAtIndex:1]];
        [self.delegate imagesForButton:backString andFrontImage:buttonString];
    }
    else if (x >= 640 && x < 800) {
        if ([self.date count]>3) {buttonString=forwardString;}
        else{buttonString=noButtonString;}
        [self.delegate changeDate:[self.date objectAtIndex:2]];
        [self.delegate imagesForButton:backString andFrontImage:buttonString];
    }
    else if (x >= 960 && x < 1120) {
        if ([self.date count]>4) {buttonString=forwardString;}
        else{buttonString=noButtonString;}
        [self.delegate changeDate:[self.date objectAtIndex:3]];
        [self.delegate imagesForButton:backString andFrontImage:buttonString];
    }
    else if (x >= 1280 && x < 1440) {
        if ([self.date count]>5) {buttonString=forwardString;}
        else{buttonString=noButtonString;}
        [self.delegate changeDate:[self.date objectAtIndex:4]];
        [self.delegate imagesForButton:backString andFrontImage:buttonString];
    }
    else if (x >= 1600 && x < 1760) {
        if ([self.date count]>6) {buttonString=forwardString;}
        else{buttonString=noButtonString;}
        [self.delegate changeDate:[self.date objectAtIndex:5]];
        [self.delegate imagesForButton:backString andFrontImage:buttonString];
    }
    else if (x >= 1920 && x < 2080) {
        if ([self.date count]>7) {buttonString=forwardString;}
        else{buttonString=noButtonString;}
        [self.delegate changeDate:[self.date objectAtIndex:6]];
        [self.delegate imagesForButton:backString andFrontImage:buttonString];
    }
    else if (x >= 2240 && x < 2400) {
        if ([self.date count]>8) {buttonString=forwardString;}
        else{buttonString=noButtonString;}
        [self.delegate changeDate:[self.date objectAtIndex:7]];
        [self.delegate imagesForButton:backString andFrontImage:buttonString];
    }
    else if (x >= 2560 && x < 2720) {
        if ([self.date count]>9) {buttonString=forwardString;}
        else{buttonString=noButtonString;}
        [self.delegate changeDate:[self.date objectAtIndex:8]];
        [self.delegate imagesForButton:backString andFrontImage:buttonString];
    }
    else if (x >= 2880 && x < 3040) {
        if ([self.date count]>10) {buttonString=forwardString;}
        else{buttonString=noButtonString;}
        [self.delegate changeDate:[self.date objectAtIndex:9]];
        [self.delegate imagesForButton:backString andFrontImage:buttonString];
    }
}

-(void)scrollBack{
    float x = self.scrollView.contentOffset.x;
    //NSLog(@"the x is: %f", x);
    if (x > 0 && x < 160) {
       // Do Nothing
    }
    else if (x >= 320 && x < 480) {
       [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if (x >= 640 && x < 800) {
        [self.scrollView setContentOffset:CGPointMake(320, 0) animated:YES];
    }
    else if (x >= 960 && x < 1120) {
        [self.scrollView setContentOffset:CGPointMake(640, 0) animated:YES];

    }
    else if (x >= 1280 && x < 1440) {
        [self.scrollView setContentOffset:CGPointMake(960, 0) animated:YES];
    }
    else if (x >= 1600 && x < 1760) {
        [self.scrollView setContentOffset:CGPointMake(1280, 0) animated:YES];
    }
    else if (x >= 1920 && x < 2080) {
        [self.scrollView setContentOffset:CGPointMake(1600, 0) animated:YES];
    }
    else if (x >= 2240 && x < 2400) {
        [self.scrollView setContentOffset:CGPointMake(1920, 0) animated:YES];
    }
    else if (x >= 2560 && x < 2720) {
        [self.scrollView setContentOffset:CGPointMake(2240, 0) animated:YES];
    }
    else if (x >= 2880 && x < 3040) {
        [self.scrollView setContentOffset:CGPointMake(2560, 0) animated:YES];
    }
}
-(void)scrollForward{
    float x = self.scrollView.contentOffset.x;
    //NSLog(@"the x is: %f", x);
    if (x >= 0 && x < 160) {
        [self.scrollView setContentOffset:CGPointMake(320, 0) animated:YES];
    }
    else if (x >= 320 && x < 480) {
        [self.scrollView setContentOffset:CGPointMake(640, 0) animated:YES];
    }
    else if (x >= 640 && x < 800) {
        [self.scrollView setContentOffset:CGPointMake(960, 0) animated:YES];
    }
    else if (x >= 960 && x < 1120) {
        [self.scrollView setContentOffset:CGPointMake(1280, 0) animated:YES];
        
    }
    else if (x >= 1280 && x < 1440) {
        [self.scrollView setContentOffset:CGPointMake(1600, 0) animated:YES];
    }
    else if (x >= 1600 && x < 1760) {
        [self.scrollView setContentOffset:CGPointMake(1920, 0) animated:YES];
    }
    else if (x >= 1920 && x < 2080) {
        [self.scrollView setContentOffset:CGPointMake(2240, 0) animated:YES];
    }
    else if (x >= 2240 && x < 2400) {
        [self.scrollView setContentOffset:CGPointMake(2560, 0) animated:YES];
    }
    else if (x >= 2560 && x < 2720) {
        [self.scrollView setContentOffset:CGPointMake(2880, 0) animated:YES];
    }
    else if (x >= 2880 && x < 3040) {
        //Do Nothing
    }

}

@end
