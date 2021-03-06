//
//  HMSocialWebBrowserViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-10.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMSocialWebBrowserViewController.h"

@interface HMSocialWebBrowserViewController ()

//Activitiy indicatior used in the Navigaition bar
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation HMSocialWebBrowserViewController

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
-(void)viewDidDisappear:(BOOL)animated{
    //if the Webview is loading stop loading and turn off the ActivityIndicator in the status bar
    if([self.webView isLoading])
    {   [self.webView stopLoading];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    //calls savecookies
    [self saveCookies];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //loads the cookies
    [self loadCookies];
    //this checks whether the internet is accessible and if it isn't, it will display a message
    HMCheckInternetAccess *internetAccess = [[HMCheckInternetAccess alloc]init];
    if ([internetAccess isInternetReachable]) {
        //        NSLog(@"Internet is Working!");
    }
    else{
        //        NSLog(@"Something wrong with the internet");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Internet is not Working" message:@"This page requires access to the internet. Please try again later." delegate:self cancelButtonTitle:nil otherButtonTitles: @"Dismiss", nil];
        [alert show];
    }
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    //sets the background colour to clear color
    [self.webView setBackgroundColor:[UIColor clearColor]];
    //sets the webview not to opaque
    [self.webView setOpaque:NO];
    //Sets the scalePageToFit to yes
    [self.webView setScalesPageToFit: YES];
    
    //Sets up the Web page and loads it either with a HTML string or not
    if(self.HTMLString!=NULL){
        //sets the base url 
        NSURL *baseURLString = [NSURL URLWithString:self.passedURL];
        //loads the HTMLString and the base url
        [self.webView loadHTMLString:self.HTMLString baseURL:baseURLString];
    }
    else{
        //sets the url to the one passed from the previous page
        NSURL *url =[NSURL URLWithString:self.passedURL];
        //loads the request witht the url
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //loads the request in the webview
        [self.webView loadRequest:request];

    }
    [self updateButtons];
}
//saves the cookies to NSUserDefaults
- (void)saveCookies{
    //adds the cookies to NSUserDefaults
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //sets the object for cookies
    [defaults setObject: cookiesData forKey: @"cookies"];
    [defaults synchronize];
}
//loads the cookies from the NSUserDefaults
- (void)loadCookies{
    //grabs the cookie from the NSUserDefault
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"cookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //iterates through the cookies and sets the cookie to the cookies above
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
//When the share button is pressed, brings up one of the following
-(IBAction)shareButtonPressed:(UIBarButtonItem*)sender{
    //If it is iOS 6 and up this will come up
    if(NSClassFromString(@"UIActivityViewController")!=nil){
        [self showActivityViewController];
        //Or for pre iOS 6 and it will show the Action sheet
    }else {
        [self showActionSheet];
    }
}


-(void)showActivityViewController{
    //-- set up the data objects
    NSString *text = @"Check out HMFF!";
    NSURL *url = [NSURL URLWithString:self.passedURL];
    UIImage *image = [UIImage imageNamed:@"hmffRedLogo.png"];
    NSArray *activityItems = [NSArray arrayWithObjects:text, url, image, nil];
    
    //-- initialising the activity view controller
    UIActivityViewController *avc = [[UIActivityViewController alloc]
                                     initWithActivityItems:activityItems
                                     applicationActivities:nil];
    
    //-- define the activity view completion handler
    avc.completionHandler = ^(NSString *activityType, BOOL completed){
        //        NSLog(@"Activity Type selected: %@", activityType);
        if (completed) {
            //            NSLog(@"Selected activity was performed.");
            
        } else {
            if (activityType == NULL) {
                //                NSLog(@"User dismissed the view controller without making a selection.");
                
            } else {
                //                NSLog(@"Activity was not performed.");
            }
        }
    };
    //-- define activity to be excluded (if any)
    avc.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypeAssignToContact,UIActivityTypePostToWeibo,UIActivityTypePrint, UIActivityTypeCopyToPasteboard, nil];
    
    //-- show the activity view controller
    [self presentViewController:avc animated:YES completion:^{
        
    }];
    
}
//This is for Pre iOS 6
-(void)showActionSheet{
    UIActionSheet *as = [[UIActionSheet alloc]initWithTitle:@"choose"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancels"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:@"Email", nil];
    [as showInView:self.view];
}

#pragma mark Web View Delegate
//returns yes when the web shouldStartLoadWithREquest
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
//When the webView starts to load
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //turns on the network activity indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //sets the title to Loading
    self.title=@"Loading...";
    //activity Indicator in Navigation Bar
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    //set the color for the activity indicator
    [self.activityIndicator setColor:[UIColor whiteColor]];
    //puts the activitiy indicator in the Navigation bar
    UIBarButtonItem * barButton =
    [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
    // set the indicator in the right  bar button item
    [[self navigationItem] setRightBarButtonItem:barButton];
    //starts the animating of the indicators
    [self.largeActivityIndicator startAnimating];
    [self.activityIndicator startAnimating];
    //updates the buttons
    [self updateButtons];
}
//web view finished loading
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //sets eh background color to the webview to black
    [self.webView setBackgroundColor:[UIColor blackColor]];
    //sets the webview to opaque
    [self.webView setOpaque:YES];
    //turns on the network activity indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //stops the animating of the indicators
    [self.largeActivityIndicator stopAnimating];
    [self.activityIndicator stopAnimating];
    //updates the title to the webview
    [self updateTitle:webView];
    //updates the buttons to the webview
    [self updateButtons];
}
//called when there is an error loading the webview
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //turns on the network activity indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //updates the buttons to the webview
    [self updateButtons];
}
//Enabling the buttons
- (void)updateButtons{
    [self.forward setEnabled:self.webView.canGoForward];
    [self.back setEnabled:self.webView.canGoBack];
    [self.stop setEnabled: self.webView.loading];
}

#pragma  mark -  Custom Label and Setter for the title
- (void)updateTitle:(UIWebView*)aWebView{
    //puts the thread to sleep
    [NSThread sleepForTimeInterval:0.3];
    // Clever variable font size trick
    CGFloat systemFontSize = [UIFont labelFontSize];
    CGFloat normalFontSize = systemFontSize * 1;
    CGFloat smallFontSize = systemFontSize * .8;
    CGFloat widthOfTitleSpace = 280.0;
    //grabs the page title
    NSString* pageTitle = [aWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //Sets the title to above title
    [self setTitle:pageTitle];
    //creates a frame at the top for the label
    CGRect frame = CGRectMake(62, 0, [self.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0f]}].width,44);
    //places the label in the frame
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    //sets the label background to clear
    [label setBackgroundColor:[UIColor clearColor]];
    //sets the label text color to white
    [label setTextColor:[UIColor whiteColor]];
    //sets the font size to 17
    [label setFont:[UIFont boldSystemFontOfSize:17.0]];
    //sets the label in the navigation bar title view
    [self.navigationItem setTitleView:label];
    
    //label.text = self.title;
    if ([self.title sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:normalFontSize]}].width > widthOfTitleSpace){        [label setNumberOfLines:2];
        //set the font to small font size
        [label setFont:[UIFont boldSystemFontOfSize:smallFontSize]];
    }
    else
        //sets the font size to the normal font size
        [label setFont:[UIFont boldSystemFontOfSize:normalFontSize]];
    //sets the text to the title
    [label setText: self.title];
}

//Over ride the setter for the title by adding a label over top
-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    UILabel *titleLabel = (UILabel *)self.navigationItem.titleView;
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [self.navigationItem setTitleView:titleLabel];
    }
    [titleLabel setText:title];
    [titleLabel sizeToFit];
}

@end
