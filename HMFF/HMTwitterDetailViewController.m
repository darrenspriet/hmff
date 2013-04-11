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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureView
{
    if (self.detailItem) {
        NSDictionary *tweet = self.detailItem;
        NSString *name;
        NSString *imageUrl;
        
        if ([tweet objectForKey:@"retweeted_status"]) {
            name = [[[tweet objectForKey:@"retweeted_status"] objectForKey:@"user"] objectForKey:@"name"];
        imageUrl= [[[tweet objectForKey:@"retweeted_status"] objectForKey:@"user"] objectForKey:@"profile_image_url"];
        }
        else{
            name = [[tweet objectForKey:@"user"] objectForKey:@"name"];
             imageUrl= [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
            
        }
        NSString *text = [tweet objectForKey:@"text"];
        
        [self.nameLabel setText:[NSString stringWithFormat:@"by %@", name]];
        self.tweetLabel.text = text;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.profileImage.image = [UIImage imageWithData:data];
            });
        });
    }
}

@end
