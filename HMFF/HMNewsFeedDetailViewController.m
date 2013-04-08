//
//  HMNewsFeedDetailViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-08.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMNewsFeedDetailViewController.h"

@interface HMNewsFeedDetailViewController ()

@end

@implementation HMNewsFeedDetailViewController

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
    [self configureView];

	// Do any additional setup after loading the view.
}

- (void)configureView
{
    if (self.detailItem) {
        NSDictionary *newsFeed = self.detailItem;
        NSString *title=[newsFeed objectForKey:@"title"];

          NSString  *content =[newsFeed objectForKey:@"content"];
        
        [self.newsTitle setText: title];
        [self.content setText: content];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
