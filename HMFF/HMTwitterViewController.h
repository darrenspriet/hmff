//
//  HMTwitterViewController.h
//  HMFF
//
//  Created by Darren Spriet on 13-03-21.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "KeychainItemWrapper.h"

@interface HMTwitterViewController : UIViewController

//This is used to post a tweet and make the tweet controller appear
- (IBAction)postTweet:(UIButton *)sender;

@property(strong, nonatomic)NSString*HTMLString;
- (IBAction)followTapped:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *TwitterButtonOutlet;

@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) NSMutableDictionary *profileImages;
@property (strong, nonatomic) ACAccount *userAccount;
@property (weak, nonatomic) IBOutlet UILabel *totalFollowers;

@property (nonatomic, strong)NSArray *tweets;
@property (nonatomic, strong) KeychainItemWrapper *keychain;


@end

