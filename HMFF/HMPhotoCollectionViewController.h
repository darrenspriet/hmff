//
//  HMPhotoCollectionViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-05-09.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMPhotoCollectionCell.h"
#import "HMLargePhotoViewController.h"

@interface HMPhotoCollectionViewController : UICollectionViewController
//array that holds the small photos
@property (strong, nonatomic) NSMutableArray *smallPhotos;
//array that holds the large photos
@property (strong, nonatomic) NSMutableArray *largePhotos;

@end
