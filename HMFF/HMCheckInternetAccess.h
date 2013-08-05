//
//  HMCheckInternetAccess.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-11.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <netinet6/in6.h>

@interface HMCheckInternetAccess : NSObject

//This method is called to see if the internet is Reachable or if theuy are online
- (BOOL)isInternetReachable;

@end
