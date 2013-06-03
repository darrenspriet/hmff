//
//  HMLargePhotoViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-05-09.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMLargePhotoViewController.h"

@interface HMLargePhotoViewController ()

@end

@implementation HMLargePhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"VIEW DID APPEAR");
    [self hideBars];
    
}
- (void)viewDidLoad{
    NSLog(@"VIEW DID LOAD");
    [super viewDidLoad];
    NSData *imageData = [NSData dataWithContentsOfURL:self.largePhotos];
    UIImage *largeImage= [UIImage imageWithData:imageData];
    self.imageView.image = largeImage;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageTapped:(UITapGestureRecognizer *)sender {
    if ((self.navigationController.navigationBar.alpha!=1.0f)) {
        NSLog(@"NOT HIDDEN IMAGE TAPPED");
        [self showBars];
    }
    else {
        NSLog(@"HIDDEN IMAGE TAPPED");
        [self hideBars];
    }
}

- (void)hideBars{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.navigationController.navigationBar setAlpha:0.0f];
    [self.tabBarController.tabBar setAlpha:0.0f];
    [UIView commitAnimations];
}

- (void)showBars{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.navigationController.navigationBar setAlpha:1.0f];
    [self.tabBarController.tabBar setAlpha:1.0f];
    [UIView commitAnimations];
}
@end
