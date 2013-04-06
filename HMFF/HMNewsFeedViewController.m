//
//  HMNewsFeedViewController.m
//  HMFF
//
//  Created by Darren Spriet on 13-03-21.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMNewsFeedViewController.h"

@interface HMNewsFeedViewController ()@end

@implementation HMNewsFeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"HMFFlogo.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
  }

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

