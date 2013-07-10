//
//  HMLargePhotoViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-05-09.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMLargePhotoViewController : UIViewController <UIActionSheetDelegate>

@property (strong, nonatomic) UIImage *largePhotos;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)shareButton:(UIBarButtonItem *)sender;
- (IBAction)imageTapped:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@end
