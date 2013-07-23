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

-(BOOL)shouldAutorotate{
    
    if (self.interfaceOrientation==UIInterfaceOrientationPortrait) {
        return NO;
    }
    else{
        return YES;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"view will appear");
    

    NSString *embeddedHTML = [NSString stringWithFormat:@"<html style=\"background-color:black;\"><head><title>.</title><form action=\"https://www.paypal.com/cgi-bin/webscr\" method=\"post\" target=\"_top\"><input type=\"hidden\" name=\"cmd\" value=\"_s-xclick\"><input type=\"hidden\" name=\"hosted_button_id\" value=\"%@\"><input type=\"image\" src=\"https://www.paypalobjects.com/en_US/i/btn/btn_buynow_LG.gif\" border=\"0\" name=\"submit\" alt=\"PayPal - The safer, easier way to pay online!\"><img alt=\"\" border=\"0\" src=\"https://www.paypalobjects.com/en_US/i/scr/pixel.gif\" width=\"1\" height=\"1\"></form></body></html>", self.payPalLink];
    [self.webView loadHTMLString:embeddedHTML baseURL:nil];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    [self.activityIndicator setHidden:YES];



}

- (void)viewDidLoad
{
    NSLog(@"view did load");
    [super viewDidLoad];    
    [self.blackView setAlpha:.3f];
    [self.navigationItem setTitle:@"Video Submission"];

    
    [self setSubmit:[[HMDataFeedManager sharedDataFeedManager] submitArray]];
     [self setPdfData:[[HMDataFeedManager sharedDataFeedManager] pdfData]];
    NSString *typeofFormat;
    NSString *acceptableentries;
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
        else if ([string isEqualToString:@"paypallink"]) {
            self.payPalLink =[diction objectForKey:@"details"];
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
        
        else if ([string isEqualToString:@"videolength"]) {
            self.videoLength =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"videooption1"]) {
            self.videoOption1 =[diction objectForKey:@"details"];
        }
        else if ([string isEqualToString:@"videooption2"]) {
            self.videoOption2 =[diction objectForKey:@"details"];
        }
        
    }
    self.videoDetail=[NSString stringWithFormat:@"\u2022 %@\n\u2022 %@\n\u2022 %@\n\u2022 %@", typeofFormat, acceptableentries, lateentries, juryselection];
    [self.submissionLabel setText:self.submissionFee];
    [self.lengthLabel setText:self.videoLength];
    [self.submissionDeadlineLabel setText:self.submissionDeadline];
    [self.option1Label setText:self.videoOption1];
    [self.option2Label setText:self.videoOption2];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f) {
            [self.noteIcon setImage:[UIImage imageNamed:@"filmSubmit@2x.png"]];
        } else {
            [self.noteIcon setImage:nil];
        }
    } else {
        /*Do iPad stuff here.*/
    }


    
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

    if([segue.identifier isEqualToString:@"entryForm"]){
        NSString *currentURL = self.webView.request.URL.absoluteString;
        if (![currentURL isEqualToString:@"about:blank"]){
             webBrowser.passedURL=currentURL;
            webBrowser.isPDF=NO;

        }
        else{
        webBrowser.passedURL=self.entryFormLink;
            webBrowser.isPDF=YES;
            webBrowser.pdfData=self.pdfData;

        }
        
    }
    else if([segue.identifier isEqualToString:@"moreDetail"]){
        HMDetailsViewController *controller = segue.destinationViewController;
        [controller setAddressString:self.address];
        [controller setDetailString:self.videoDetail];
        
        
    }
    
}

#pragma WEB VIEW DELEGATE
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self.activityIndicator setHidden:NO];

    NSLog(@"return yes");


    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"viewdidstartload");
    [self.activityIndicator setHidden:NO];

    [self.activityIndicator startAnimating];
    self.imageView.image= [UIImage imageNamed:@"blackImage.png"];

    


  
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"viewdidfinishload");
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:YES];
    NSString *currentURL = self.webView.request.URL.absoluteString;
    [self.activityIndicator stopAnimating];
    if([currentURL isEqualToString:@"https://www.paypal.com/cgi-bin/webscr#m"]){
        [self.webView reload];
    }
    else if(![currentURL isEqualToString:@"about:blank"]){
    [self performSegueWithIdentifier:@"entryForm" sender:self];
        [self.activityIndicator setHidden:YES];
        
    }
    else{
        [self.activityIndicator setHidden:YES];
        self.imageView.image=nil;
    }
    NSLog(@"what is the webview in finished load:%@", currentURL);


  
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"return fail");


}

- (IBAction)detailsButton:(UIButton *)sender {
}
@end
