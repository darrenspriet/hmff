//
//  HMVideoCell.m
//  HMFF
//
//  Created by Darren Spriet on 2013-05-10.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMVideoCell.h"

@implementation HMVideoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    //initializes the cells with backgroudn and not opaque
    [self.videoWebView setBackgroundColor:[UIColor clearColor]];
    [self.videoWebView setOpaque:NO];
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma WEB VIEW DELEGATE
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //sets the network activity indicator to yes
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //sets the color to white
    [self.largeActivityIndicator setColor:[UIColor whiteColor]];
    //starts it to animate
    [self.largeActivityIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //sets the webview background to black
    [webView setBackgroundColor:[UIColor blackColor]];
    //sets the webview to opaque
    [webView setOpaque:YES];
    //sets the activity indicatory to not visible
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //stop the animation
    [self.largeActivityIndicator stopAnimating];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end