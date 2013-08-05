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

//checks the rotation and returns accurate position
-(BOOL)shouldAutorotate{
    if (self.interfaceOrientation==UIInterfaceOrientationPortrait) {
        return NO;
    }
    else{
        return YES;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    //sets the title when we come back from the web browser or the detail view
    [self.navigationItem setTitle:@"Band Submission"];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //sets the alpha for the view so it dims the image
    [self.blackView setAlpha:.3f];
    //sets the title to Band Submission
    [self.navigationItem setTitle:@"Band Submission"];
    //loads all the data for the page
    [self loadData];
    //checks the screen size
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    //Sets the image at the bottom of the screen if it is iPhone 5
    if (screenSize.height > 480.0f) {
        [self.submitImage setImage:[UIImage imageNamed:@"musicSubmit@2x.png"]];
    } else {
        [self.submitImage setImage:nil];
    }
}
-(void)loadData{
    //loads the submit data to the submitArray
    [self setSubmit:[[HMDataFeedManager sharedDataFeedManager] submitArray]];
    //loads the pdfData to local pdfData
    [self setPdfData:[[HMDataFeedManager sharedDataFeedManager] pdfData]];
    
    //These are NSString to hold a few needed strings for below
    NSString *lateentries;
    NSString *juryselection;
    
    //we iterate through the submit array to find the dictionary and set all of the labels to the proper text
    for (NSDictionary *diction in self.submit){
        NSString * string=[diction objectForKey:@"name"];
        
        if ([string isEqualToString:@"entryformlink"]) {
            [self setEntryFormLink :[diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"address"]) {
            [self setAddress :[diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"sonicbidslink"]) {
            [self setSonicBidsLink :[diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"submissionfee"]) {
            [self.submissionLabel setText:[diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"submissiondeadline"]) {
            [self.submissionDeadlineLabel setText:[diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"bandlength"]) {
            [self.lengthLabel setText:[diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"bandoption1"]) {
            [self.option1Label setText:[diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"bandoption2"]) {
            [self.option2Label setText:[diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"lateentries"]) {
            lateentries =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"juryselection"]) {
            juryselection =[diction objectForKey:@"details"];
        }
        
    }
    //sets the band detail with the lateentries and juryselection
    [self setBandDetail:[NSString stringWithFormat:@"\u2022 %@\n\u2022 %@", lateentries, juryselection]];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Prepare for Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    HMMoreWebBrowserViewController *webBrowser = segue.destinationViewController;
    //calls the sonic bids segue and passes some info to the webbrowser
    if ([segue.identifier isEqualToString:@"sonicBids"]){
        [webBrowser setPassedURL: self.sonicBidsLink];
        [webBrowser setIsPDF: NO];
        
    }
    //calls the entryform segue and passes some info to the webbrowser
    else if([segue.identifier isEqualToString:@"entryForm"]){
        [webBrowser setPassedURL:self.entryFormLink];
        [webBrowser setIsPDF: YES];
        [webBrowser setPdfData: self.pdfData];
        
    }
    //calls the more detail segue and passes some info to the controller
    else if([segue.identifier isEqualToString:@"moreDetail"]){
        HMDetailsViewController *controller = segue.destinationViewController;
        [controller setAddressString:self.address];
        [controller setDetailString:self.bandDetail];
    }
}

- (IBAction)detailsButton:(UIButton *)sender {
}
@end
