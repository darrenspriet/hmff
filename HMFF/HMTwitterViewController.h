//
//  HMTwitterViewController.h
//  HMFF
//
//  Created by Darren Spriet on 13-03-21.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface HMTwitterViewController : UIViewController

//This is used to post a tweet and make the tweet controller appear
- (IBAction)postTweet:(UIButton *)sender;
//used to set the HTMLString
@property(strong, nonatomic)NSString*HTMLString;
//used to set the tweets array
@property (nonatomic, strong)NSArray *tweets;

@end

