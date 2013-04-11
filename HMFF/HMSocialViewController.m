//
//  HMSocialViewController.m
//  HMFF
//
//  Created by Darren Spriet on 13-03-21.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMSocialViewController.h"

@interface HMSocialViewController ()

@end

@implementation HMSocialViewController

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
    UIImage *image = [UIImage imageNamed:@"HMFFlogo.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Prepare for Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    HMSocialWebBrowserViewController *webBrowser = segue.destinationViewController;
    //When the View is loaded it this container sets the delegats
    if ([segue.identifier isEqualToString:@"facebookSegue"]){
        webBrowser.passedURL=@"http://www.facebook.com/pages/Hmff/85087895652";
        [webBrowser setTitle:@"facebook.com/HMFF"];
    }
    else if ([segue.identifier isEqualToString:@"youTubeSegue"]){
        webBrowser.passedURL=@"http://www.youtube.com/user/HMFFESTIVAL?feature=watch";
        [webBrowser setTitle:@"youTube.com/HMFF"];
    }
    else if ([segue.identifier isEqualToString:@"twitterSegue"]){
        webBrowser.passedURL=@"http://twitter.com/HMFFEST";
        [webBrowser setTitle:@"twitter.com/HMFFEST"];
    }
    else if ([segue.identifier isEqualToString:@"vimeoSegue"]){
        webBrowser.passedURL=@"http://vimeo.com/search?q=hmff";
        [webBrowser setTitle:@"vimeo.com/HMFF"];
    }
    else if ([segue.identifier isEqualToString:@"HMFFSegue"]){
        webBrowser.passedURL=@"http://www.hmff.com";
        [webBrowser setTitle:@"HMFF.com"];
    }
}

@end
