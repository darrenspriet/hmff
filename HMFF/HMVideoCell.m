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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    NSLog(@"clicked");
    [self.videoWebView setBackgroundColor:[UIColor clearColor]];
    [self.videoWebView setOpaque:NO];
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma WEB VIEW DELEGATE

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"viewdidstarload");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.largeActivityIndicator setColor:[UIColor whiteColor]];
    [self.largeActivityIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"viewdidfinishload");
    
    [webView setBackgroundColor:[UIColor blackColor]];
    [webView setOpaque:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.largeActivityIndicator stopAnimating];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"shouldstartloadwithrequest");
    
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"didfailloadwitherror");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end