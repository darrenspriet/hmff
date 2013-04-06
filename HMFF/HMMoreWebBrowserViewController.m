//
//  HMMoreWebBrowserViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-05.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMMoreWebBrowserViewController.h"

@interface HMMoreWebBrowserViewController ()

@end

@implementation HMMoreWebBrowserViewController

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
    NSURL *url =[NSURL URLWithString:self.passedURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.moreWebBrowser setScalesPageToFit:YES];
    
    [self.moreWebBrowser loadRequest:request];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
