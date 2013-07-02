//
//  HMBandWebBrowserViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-20.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMBandWebBrowserViewController.h"

@interface HMBandWebBrowserViewController ()

@end

@implementation HMBandWebBrowserViewController

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
-(void)viewDidDisappear:(BOOL)animated{
    //    NSLog(@"view did disappear");
    if([self.webView isLoading])
    {
        //        NSLog(@"webview was loading");
        [self.webView stopLoading];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    [self saveCookies];
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"VIEW DID APPEAR");
    
    // [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
    
}

-(void) viewWillAppear:(BOOL)animated {
    [self loadCookies];
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
- (void)viewDidLoad
{
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    [super viewDidLoad];
    self.webView.scalesPageToFit = YES;
    NSURL *url =[NSURL URLWithString:self.passedURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self updateButtons];

	// Do any additional setup after loading the view.
}

- (void)saveCookies
{
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"cookies"];
    [defaults synchronize];
}

- (void)loadCookies
{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"cookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookies)
    {
        [cookieStorage setCookie: cookie];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)shareButtonPressed:(UIBarButtonItem*)sender{
    NSLog(@"Share button Pressed");
    if(NSClassFromString(@"UIActivityViewController")!=nil){
        [self showActivityViewController];
    }else {
        [self showActionSheet];
    }
    
}

-(void)showActivityViewController
{
    //-- set up the data objects
    NSString *textObject = @"Check this out!";
    NSURL *url = [NSURL URLWithString:self.passedURL];
    UIImage *image = [UIImage imageNamed:@"HMFFlogo3.png"];
    NSArray *activityItems = [NSArray arrayWithObjects:textObject, url, image, nil];
    
    //-- initialising the activity view controller
    UIActivityViewController *avc = [[UIActivityViewController alloc]
                                     initWithActivityItems:activityItems
                                     applicationActivities:nil];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:34.0/255.0 green:97.0/255.0 blue:221.0/255.0 alpha:1]];
    
    //-- define the activity view completion handler
    avc.completionHandler = ^(NSString *activityType, BOOL completed){
        NSLog(@"Activity Type selected: %@", activityType);
        if (completed) {
            
            NSLog(@"Selected activity was performed.");
            [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
            
        } else {
            if (activityType == NULL) {
                NSLog(@"User dismissed the view controller without making a selection.");
                [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
                
            } else {
                NSLog(@"Activity was not performed.");
                [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
                
            }
        }
    };
    
    //-- define activity to be excluded (if any)
    avc.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypeAssignToContact,UIActivityTypePostToWeibo,UIActivityTypePrint, UIActivityTypeCopyToPasteboard, nil];
    
    //-- show the activity view controller
    [self presentViewController:avc animated:YES completion:^{
        
    }];
    
}
//This is for pre ios 6
-(void)showActionSheet
{
    UIActionSheet *as = [[UIActionSheet alloc]initWithTitle:@"choose"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancels"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:@"Email", nil];
    [as showInView:self.view];
}

#pragma mark - UIActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            NSLog(@"Email");
            break;
        case 1:
            NSLog(@"Cancel");
            break;
        default:
            break;
    }
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
    [self.largeActivityIndicator startAnimating];
    [self.activityIndicator startAnimating];
    [self updateButtons];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.webView setBackgroundColor:[UIColor blackColor]];
    [self.webView setOpaque:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.largeActivityIndicator stopAnimating];
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
