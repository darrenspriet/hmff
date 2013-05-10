//
//  HMLargePhotoViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-05-09.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMLargePhotoViewController : UIViewController

@property (strong, nonatomic) NSURL *largePhotos;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
