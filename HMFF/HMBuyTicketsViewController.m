//
//  HMBuyTicketsViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-24.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMBuyTicketsViewController.h"

@interface HMBuyTicketsViewController ()

@end

@implementation HMBuyTicketsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //this checks whether the internet is accessible and if it isn't, it will display a message
    HMCheckInternetAccess *internetAccess = [[HMCheckInternetAccess alloc]init];
    if ([internetAccess isInternetReachable]) {
        NSLog(@"Internet is Working!");
    }
    else{
        NSLog(@"Something wrong with the internet");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Internet is not Working" message:@"This page requires access to the internet. Please try again later." delegate:self cancelButtonTitle:nil otherButtonTitles: @"Dismiss", nil];
        [alert show];
    }
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.webView.scalesPageToFit = YES;
    NSURL *url =[NSURL URLWithString:self.passedURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self updateButtons];
    
}
-(id)init{
    self=[super init];
    if (self) {
        self.webView.scalesPageToFit = YES;
        NSURL *url =[NSURL URLWithString:self.passedURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        [self updateButtons];
        
    }
    
    return self;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)shareButtonPressed:(UIBarButtonItem*)sender{
    NSLog(@"Share button Pressed");
}

#pragma WEB VIEW DELEGATE
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    self.title=@"Loading...";
    
    //activity Indicator in Navigation Bar
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [self.activityIndicator setColor:[UIColor blackColor]];
    UIBarButtonItem * barButton =
    [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
    
    // Set to Left or Right
    [[self navigationItem] setRightBarButtonItem:barButton];
    [self.activityIndicator startAnimating];
    [self updateButtons];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.activityIndicator stopAnimating];
    [self updateTitle:webView];
    [self updateButtons];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}

- (void)updateButtons{
    
    [self.forward setEnabled:self.webView.canGoForward];
    [self.back setEnabled:self.webView.canGoBack];
    [self.stop setEnabled: self.webView.loading];
}



#pragma  mark -  Custom Label and Setter for the title
- (void)updateTitle:(UIWebView*)aWebView{
    [NSThread sleepForTimeInterval:0.3];
    // Clever variable font size trick
    CGFloat systemFontSize = [UIFont labelFontSize];
    CGFloat headFontSize = systemFontSize * 1;
    CGFloat smallFontSize = systemFontSize * .8;
    CGFloat widthOfTitleSpace = 280.0;
    
    
    NSString* pageTitle = [aWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    [self setTitle:pageTitle];
    CGRect frame = CGRectMake(62, 0, [self.title sizeWithFont:[UIFont boldSystemFontOfSize:20.0]].width, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont boldSystemFontOfSize:17.0]];
    [self.navigationItem setTitleView:label];
    
    //label.text = self.title;
    if ([self.title sizeWithFont:[UIFont boldSystemFontOfSize:headFontSize]].width > widthOfTitleSpace){
        [label setNumberOfLines:2];
        [label setFont:[UIFont boldSystemFontOfSize:smallFontSize]];}
    else
        [label setFont:[UIFont boldSystemFontOfSize:headFontSize]];
    
    label.text =self.title;
}

//Over ride the setter for the title by adding a label over top
-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    UILabel *titleLabel = (UILabel *)self.navigationItem.titleView;
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
        [titleLabel setTextColor:[UIColor blackColor]];
        [self.navigationItem setTitleView:titleLabel];
    }
    [titleLabel setText:title];
    [titleLabel sizeToFit];
}


@end
