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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//checks the rotation and returns accurate position
-(BOOL)shouldAutorotate{
        return YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //sets the image to the large image that was passed
    
    [self.imageView setImage: self.largePhotos];
    //hides the navigation and tool bar
    [self hideBars];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareButton:(UIBarButtonItem *)sender {
    //If it is iOS 6 and up this will come up
    if(NSClassFromString(@"UIActivityViewController")!=nil){
        [self showActivityViewController];
        //Or for pre iOS 6 and it will show the Action sheet
    }else {
        [self showActionSheet];
    }
}

//show the activity view controller
-(void)showActivityViewController{
    //-- set up the data objects
    NSString *text = @"Check out HMFF!";
    NSURL *url = [NSURL URLWithString:@"http://www.hmff.com"];
    UIImage *image = [UIImage imageNamed:@"hmffRedLogo.png"];
    NSArray *activityItems = [NSArray arrayWithObjects:text, url, image, nil];
    
    //-- initialising the activity view controller
    UIActivityViewController *avc = [[UIActivityViewController alloc]
                                     initWithActivityItems:activityItems
                                     applicationActivities:nil];
    
    //-- define the activity view completion handler
    avc.completionHandler = ^(NSString *activityType, BOOL completed){
        //        NSLog(@"Activity Type selected: %@", activityType);
        if (completed) {
            //            NSLog(@"Selected activity was performed.");
            
        } else {
            if (activityType == NULL) {
                //                NSLog(@"User dismissed the view controller without making a selection.");
                
            } else {
                //                NSLog(@"Activity was not performed.");
            }
        }
    };
    //-- define activity to be excluded (if any)
    avc.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypeAssignToContact,UIActivityTypePostToWeibo,UIActivityTypePrint, UIActivityTypeCopyToPasteboard, nil];
    
    //-- show the activity view controller
    [self presentViewController:avc animated:YES completion:^{
        
    }];
    
}
//This is for Pre iOS 6
-(void)showActionSheet{
    UIActionSheet *as = [[UIActionSheet alloc]initWithTitle:@"choose"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancels"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:@"Email", nil];
    [as showInView:self.view];
}
//if the image is tapped it checks the alpha of the navigation bar and shows them or hides them accordingly
- (IBAction)imageTapped:(UITapGestureRecognizer *)sender {
    if (([self.navigationController.navigationBar alpha]!=1.0f)) {
        [self showBars];
    }
    else {
        [self hideBars];
    }
}
//hides the navigation and tool bar
- (void)hideBars{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.navigationController.navigationBar setAlpha:0.0f];
    [self.toolBar setAlpha:0.0f];
    [UIView commitAnimations];
}
//shows the navigation and tool bar
- (void)showBars{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.navigationController.navigationBar setAlpha:1.0f];
    [self.toolBar setAlpha:1.0f];
    [UIView commitAnimations];
}
@end
