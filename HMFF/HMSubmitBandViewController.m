//
//  HMSubmitBandViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-07-10.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMSubmitBandViewController.h"

@interface HMSubmitBandViewController ()

@end

@implementation HMSubmitBandViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.blackView setAlpha:.3f];
    [self setSubmit:[[HMDataFeedManager sharedDataFeedManager] submitArray]];
    [self setPdfData:[[HMDataFeedManager sharedDataFeedManager] pdfData]];

    NSString *lateentries;
    NSString *juryselection;
    for (NSDictionary *diction in self.submit){
        NSString * string=[diction objectForKey:@"name"];
        
        if ([string isEqualToString:@"submissionfee"]) {
            self.submissionFee =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"submissiondeadline"]) {
            self.submissionDeadline =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"entryformlink"]) {
            self.entryFormLink =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"address"]) {
            self.address =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"sonicbidslink"]) {
            self.sonicBidsLink =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"lateentries"]) {
            lateentries =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"juryselection"]) {
            juryselection =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"bandlength"]) {
            self.bandLength =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"bandoption1"]) {
            self.bandOption1 =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"bandoption2"]) {
            self.bandOption2 =[diction objectForKey:@"details"];
        }
        
    }

self.bandDetail=[NSString stringWithFormat:@"\u2022 %@\n\u2022 %@", lateentries, juryselection];

    [self.submissionLabel setText:self.submissionFee];
    [self.lengthLabel setText:self.bandLength];
    [self.submissionDeadlineLabel setText:self.submissionDeadline];
    [self.option1Label setText:self.bandOption1];
    [self.option2Label setText:self.bandOption2];

    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f) {
            [self.noteIcon setImage:[UIImage imageNamed:@"hmffRedLogo@2x.png"]];
        } else {
           // [self.splashImage setImage:[UIImage imageNamed:@"Default.png"]];
        }
    } else {
        /*Do iPad stuff here.*/
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Prepare for Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    HMMoreWebBrowserViewController *webBrowser = segue.destinationViewController;
    //Calls the submit a band segue
    if ([segue.identifier isEqualToString:@"sonicBids"]){
        webBrowser.passedURL=self.sonicBidsLink;
        webBrowser.isPDF=NO;

    }
    else if([segue.identifier isEqualToString:@"entryForm"]){
        webBrowser.passedURL=self.entryFormLink;
        webBrowser.isPDF=YES;
        webBrowser.pdfData=self.pdfData;
        
    }
    else if([segue.identifier isEqualToString:@"moreDetail"]){
        HMDetailsViewController *controller = segue.destinationViewController;
        [controller setAddressString:self.address];
        [controller setDetailString:self.bandDetail];

        
    }
  
}

@end
