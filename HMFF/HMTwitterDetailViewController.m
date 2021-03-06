//
//  HMTwitterDetailViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-02.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMTwitterDetailViewController.h"

@interface HMTwitterDetailViewController ()

@end

@implementation HMTwitterDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)shouldAutorotate{
    
    if (self.interfaceOrientation==UIInterfaceOrientationPortrait) {
        return NO;
    }
    else{
        return YES;
    }
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    //Sets the title to "Twitter"
    [self.navigationItem setTitle:@"Twitter"];
    //sets the alpha to .3 and dims down the background
    [self.controllerView setAlpha:0.3f];
    //sets that background to black
    [self.controllerView setBackgroundColor:[UIColor blackColor]];
    //loads the data for the view
    [self loadData];
}

- (void)loadData{
    //Sets the tweet to the detail item that was passed
    NSDictionary *tweet = self.detailItem;
    NSString *name;
    NSString *imageUrl;
    
    //Getting the title for the tweet
    NSString *title = [tweet objectForKey:@"text"];
    
    //Checks to see if this is a retweeted status, if so gets the original user
    if ([tweet objectForKey:@"retweeted_status"]) {
        name = [[[tweet objectForKey:@"retweeted_status"] objectForKey:@"user"] objectForKey:@"name"];
        imageUrl= [[[tweet objectForKey:@"retweeted_status"] objectForKey:@"user"] objectForKey:@"profile_image_url"];
    }
    //else just grabs the name and imageurl of initial user
    else{
        name = [[tweet objectForKey:@"user"] objectForKey:@"name"];
        imageUrl= [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
        
    }
    //Sets the above propertys for the cell
    [self.nameLabel setText:[NSString stringWithFormat:@"by %@", name]];
    //sets the text to the tweet label
    [self.tweetLabel setText: title];
    
    //Starts a dispatch to get the image and once finished sets it to the cell
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.profileImage.image = [UIImage imageWithData:data];
        });
    });
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
