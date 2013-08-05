//
//  HMSubmitVideoViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-07-10.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMSubmitVideoViewController.h"

@interface HMSubmitVideoViewController ()

@end

@implementation HMSubmitVideoViewController

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
    //used to set the pay pal button at the beggining, init with the payPalLink
    NSString *embeddedHTML = [NSString stringWithFormat:@"<html style=\"background-color:black;\"><head><title>.</title><form action=\"https://www.paypal.com/cgi-bin/webscr\" method=\"post\" target=\"_top\"><input type=\"hidden\" name=\"cmd\" value=\"_s-xclick\"><input type=\"hidden\" name=\"hosted_button_id\" value=\"%@\"><input type=\"image\" src=\"https://www.paypalobjects.com/en_US/i/btn/btn_buynow_LG.gif\" border=\"0\" name=\"submit\" alt=\"PayPal - The safer, easier way to pay online!\"><img alt=\"\" border=\"0\" src=\"https://www.paypalobjects.com/en_US/i/scr/pixel.gif\" width=\"1\" height=\"1\"></form></body></html>", self.payPalLink];
    //loads up the HTMLString with the embeddedHTML, and no baseURL
    [self.webView loadHTMLString:embeddedHTML baseURL:nil];
    //Sets the background to clar
    [self.webView setBackgroundColor:[UIColor clearColor]];
    //sets it not to opaque
    [self.webView setOpaque:NO];
    //sets the activity indicator to hidden
    [self.activityIndicator setHidden:YES];
    //sets the title to Video Submission for when we come back from the webbrowser or detail page
    [self.navigationItem setTitle:@"Video Submission"];
}

- (void)viewDidLoad{
    //sets the alpha for the view so it dims the image
    [self.blackView setAlpha:.3f];
    //sets the title to Video Submission
    [self.navigationItem setTitle:@"Video Submission"];
    //loads all the data for the page
    [self loadData];
    //checks the screen size
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    //Sets the image at the bottom of the screen if it is iPhone 5
    if (screenSize.height > 480.0f) {
        [self.submitImage setImage:[UIImage imageNamed:@"filmSubmit@2x.png"]];
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
    NSString *typeofFormat;
    NSString *acceptableentries;
    NSString *lateentries;
    NSString *juryselection;
    
    //we iterate through the submit array to find the dictionary and set all of the labels to the proper text
    for (NSDictionary *diction in self.submit){
        NSString * string=[diction objectForKey:@"name"];
        
        if ([string isEqualToString:@"entryformlink"]) {
            [self setEntryFormLink: [diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"address"]) {
            [self setAddress: [diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"paypallink"]) {
            [self setPayPalLink: [diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"submissionfee"]) {
            [self.submissionLabel setText:[diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"submissiondeadline"]) {
            [self.submissionDeadlineLabel setText:[diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"videolength"]) {
            [self.lengthLabel setText:[diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"videooption1"]) {
            [self.option1Label setText:[diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"videooption2"]) {
            [self.option2Label setText:[diction objectForKey:@"details"]];
        }
        else if ([string isEqualToString:@"typeofformat"]) {
            typeofFormat =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"acceptableentries"]) {
            acceptableentries =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"lateentries"]) {
            lateentries =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"juryselection"]) {
            juryselection =[diction objectForKey:@"details"];
        }
    }
    [self setVideoDetail:[NSString stringWithFormat:@"\u2022 %@\n\u2022 %@\n\u2022 %@\n\u2022 %@", typeofFormat, acceptableentries, lateentries, juryselection]];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Prepare for Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    HMMoreWebBrowserViewController *webBrowser = segue.destinationViewController;
    //calls the entry form segue and passes some info to the webbrowser
    if([segue.identifier isEqualToString:@"entryForm"]){
        NSString *currentURL = [self.webView.request.URL absoluteString];
        //checks to see if the page is equal to the normal pay pal link and set pdf to no
        if (![currentURL isEqualToString:@"about:blank"]){
            [webBrowser setPassedURL: currentURL];
            [webBrowser setIsPDF: NO];
        }
        //else it is the pdf and sets the pdfData and isPDF to YES
        else{
            webBrowser.passedURL=self.entryFormLink;
            [webBrowser setIsPDF: YES];
            [webBrowser setPdfData: self.pdfData];
        }
    }
    //calls the moreDetail segue and sets the details for the controller
    else if([segue.identifier isEqualToString:@"moreDetail"]){
        HMDetailsViewController *controller = segue.destinationViewController;
        [controller setAddressString:self.address];
        [controller setDetailString:self.videoDetail];
    }
}

#pragma WEB VIEW DELEGATE
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //turns of the activity indicator
    [self.activityIndicator setHidden:NO];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    //Onces started loading set the indicator to visible and start animating
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    //also change the back ground to the black pay pal background image
    [self.imageView setImage:[UIImage imageNamed:@"blackPayPalBackground.png"]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //once it finishes loading sets the background to clar
    [self.webView setBackgroundColor:[UIColor clearColor]];
    //sets the webview to opaque
    [self.webView setOpaque:YES];
    //sets the current url to a string
    NSString *currentURL = [self.webView.request.URL absoluteString];
    //stops animating the indicator
    [self.activityIndicator stopAnimating];
    //checks to see if the current url is the pay pal page that tells you about the app and realoads the view if this is the case
    if([currentURL isEqualToString:@"https://www.paypal.com/cgi-bin/webscr#m"]){
        [self.webView reload];
    }
    //else if it is the default about:blank then you still have a normal pay pal button page and perform segue
    else if(![currentURL isEqualToString:@"about:blank"]){
        [self performSegueWithIdentifier:@"entryForm" sender:self];
        [self.activityIndicator setHidden:YES];
        
    }
    else{
        [self.activityIndicator setHidden:YES];
        [self.imageView setImage:nil];
    }
}
@end
