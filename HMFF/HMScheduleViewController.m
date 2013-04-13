//
//  HMScheduleViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMScheduleViewController.h"

@interface HMScheduleViewController ()

@end

@implementation HMScheduleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.dateForEvent setText:@"September 14, 2013"];
    UIImage *image = [UIImage imageNamed:@"HMFFlogo.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //When the View is loaded it this container sets the delegats
    if ([segue.identifier isEqualToString:@"container"]){
        [(HMScheduleScrollViewController*)segue.destinationViewController setDelegate:self];
        
        //Sets itself as the delegate of the TableView Controller
    }
}
-(void)changeDate:(NSString *)date{
    [self.dateForEvent setText:date];

}
@end
