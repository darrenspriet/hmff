//
//  HMLargePhotoViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-05-09.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMLargePhotoViewController.h"

@interface HMLargePhotoViewController ()
-(void)showActivityViewController;
-(void)showActionSheet;

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
   
   // [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
       [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
    [self hideBars];
   
    
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"VIEW WILL APPEAR");
     

}
- (void)viewDidLoad{
    NSLog(@"VIEW DID LOAD");
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
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

- (IBAction)shareButton:(UIBarButtonItem *)sender {
    if(NSClassFromString(@"UIActivityViewController")!=nil){
        [self showActivityViewController];
    }else {
        [self showActionSheet];
    }
}

-(void)showActivityViewController
{
    //-- set up the data objects
    NSString *textObject = @"Check out this Picture!";
    NSURL *url = [NSURL URLWithString:@"http://www.hmff.com"];
    UIImage *image = self.imageView.image;
    NSArray *activityItems = [NSArray arrayWithObjects:textObject, url, image, nil];
    
    //-- initialising the activity view controller
    UIActivityViewController *avc = [[UIActivityViewController alloc]
                                     initWithActivityItems:activityItems
                                     applicationActivities:nil];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:34.0/255.0 green:97.0/255.0 blue:221.0/255.0 alpha:1]];
    
    //-- define the activity view completion handler
    avc.completionHandler = ^(NSString *activityType, BOOL completed){
        NSLog(@"Activity Type selected: %@", activityType);
        if (completed) {

            NSLog(@"Selected activity was performed.");
            [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];

        } else {
            if (activityType == NULL) {
                NSLog(@"User dismissed the view controller without making a selection.");
                [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];

            } else {
                NSLog(@"Activity was not performed.");
                [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];

            }
        }
    };
    
    //-- define activity to be excluded (if any)
    avc.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypeAssignToContact,UIActivityTypePostToWeibo,UIActivityTypePrint, UIActivityTypeCopyToPasteboard, nil];
 
    //-- show the activity view controller
    [self presentViewController:avc animated:YES completion:^{
 
        [self hideBars];
    }];
    
}
//This is for pre ios 6
-(void)showActionSheet
{
    UIActionSheet *as = [[UIActionSheet alloc]initWithTitle:@"choose"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancels"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:@"Email", nil];
    [as showInView:self.view];
}

#pragma mark - UIActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            NSLog(@"Email");
            break;
        case 1:
            NSLog(@"Cancel");
            break;
        default:
            break;
    }
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
    [self.toolBar setAlpha:0.0f];
    [UIView commitAnimations];
}

- (void)showBars{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.navigationController.navigationBar setAlpha:1.0f];
    [self.toolBar setAlpha:1.0f];
    [UIView commitAnimations];
}
@end
