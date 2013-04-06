//
//  HMMoreWebBrowserViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-05.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMMoreWebBrowserViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *moreWebBrowser;

@property (nonatomic, strong) NSString *passedURL;
@end
