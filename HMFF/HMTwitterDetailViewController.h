//
//  HMTwitterDetailViewController.h
//  HMFF
//
//  Created by Darren Spriet on 2013-04-02.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMTwitterDetailViewController : UIViewController

//Image on the detail view
@property (nonatomic, weak) IBOutlet UIImageView *profileImage;

//Label of the name on the detail view
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

//Textview used for the main tweet on the detail view
@property (weak, nonatomic) IBOutlet UITextView *tweetLabel;

//the detailItem that is passed with all of the information
@property (nonatomic)NSDictionary *detailItem;


@end
