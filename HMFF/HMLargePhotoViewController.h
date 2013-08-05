//
//  HMLargePhotoViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-05-09.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMLargePhotoViewController : UIViewController <UIActionSheetDelegate>

//holds the large image
@property (strong, nonatomic) UIImage *largePhotos;
//is the property to the ImageView on the storyboard
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//share button
- (IBAction)shareButton:(UIBarButtonItem *)sender;
//UITapGestureRecognizer added to the image tapped
- (IBAction)imageTapped:(UITapGestureRecognizer *)sender;
//a property to the toolbar
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@end
