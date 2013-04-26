//
//  HMCheckInternetAccess.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-11.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMCheckInternetAccess.h"

@implementation HMCheckInternetAccess

- (BOOL)isInternetReachable{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    if(reachability == NULL)
        return false;
    
    if (!(SCNetworkReachabilityGetFlags(reachability, &flags)))
        return false;
    
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
        // if target host is not reachable
        return false;
    
    
    BOOL isReachable = false;
    
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0){
        // if target host is reachable and no connection is required
        //  then we'll assume (for now) that your on Wi-Fi
        isReachable = true;
    }
    
    
    if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
         (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0)){
        // ... and the connection is on-demand (or on-traffic) if the
        //     calling application is using the CFSocketStream or higher APIs
        
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0){
            // ... and no [user] intervention is needed
            isReachable = true;
        }
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN){
        // ... but WWAN connections are OK if the calling application
        //     is using the CFNetwork (CFSocketStream?) APIs.
        isReachable = true;
    }
    
    
    return isReachable;
    
    
}


@end
