//
//  HMLineUpScrollViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMLineUpScrollViewController.h"

@interface HMLineUpScrollViewController ()

@end

@implementation HMLineUpScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)setPageZero{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [UIView animateWithDuration:0
//                              delay:0 options:UIViewAnimationOptionLayoutSubviews
//                         animations:^{
//
//                             [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES]
//;                         }
//                         completion:^(BOOL finished) {                             NSLog(@"called");
//}];
//    });
//}
-(void)viewDidAppear:(BOOL)animated{
    
    
    [super viewDidAppear:animated];
    [self.scrollView setContentSize:CGSizeMake(640, self.scrollView.frame.size.height)];
    [self.scrollView setPagingEnabled:YES];
//    [self setPageZero];
    
    //
    //    [self.tableViewTwo reloadData];
    //    [self.tableViewOne reloadData];
    
    ////    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:NO];
    //    NSLog(@"view did appear");
//    [self centerScrollViewContents];
 
}
//- (void)centerScrollViewContents {
//    CGSize boundsSize = self.scrollView.bounds.size;
//    CGRect contentsFrame = self.imageView.frame;
//    
//    if (contentsFrame.size.width < boundsSize.width) {
//        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
//    } else {
//        contentsFrame.origin.x = 0.0f;
//    }
//    
//    if (contentsFrame.size.height < boundsSize.height) {
//        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
//    } else {
//        contentsFrame.origin.y = 0.0f;
//    }
//    
//    self.imageView.frame = contentsFrame;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
