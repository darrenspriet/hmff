//
//  HMPhotoCollectionViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-05-09.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMPhotoCollectionViewController.h"


@interface HMPhotoCollectionViewController ()

@end

@implementation HMPhotoCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    // this will unhide the navigation bar
    [self.navigationController.navigationBar setHidden:NO];
}

//checks the rotation and returns accurate position
-(BOOL)shouldAutorotate{
    if (self.interfaceOrientation==UIInterfaceOrientationPortrait) {
        return NO;
    }
    else{
        return YES;
    }
}

//returns the accurate rotation position
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //set the title to "photos"
    [self.navigationItem setTitle:@"Photos"];
    //loads up the data for the page
    [self loadData];
    [self createLargePhotos];
    
}

-(void)createLargePhotos{
    //initalizes the large photos array
    [self setLargePhotos : [[NSMutableArray alloc] init] ];
    //loops through all the data sent from the data feed manager and adds them to the photo array
    for(NSData *data in self.largePhotosData){
          UIImage *largeImage= [UIImage imageWithData:data];
         [self.largePhotos addObject:largeImage];

    }
    
}
-(void)loadData{
    //sets the small photos array
    [self setSmallPhotos:  [[HMDataFeedManager sharedDataFeedManager] smallPhotos]];
    
    //sets the large photos array
    [self setLargePhotosData:  [[HMDataFeedManager sharedDataFeedManager] largePhotosData]];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.smallPhotos count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //initializes the photo collection cell
    HMPhotoCollectionCell *cell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"collectionCell"
                                    forIndexPath:indexPath];
    //holds the data for the small photo
    NSData *imageData = [self.smallPhotos objectAtIndex:indexPath.row];
    //sets the image with the image data
    UIImage *image = [UIImage imageWithData:imageData];
    //sets the imageview image to the one above
    [cell.imageView setImage:image];
    //returns the cell
    return cell;
}

#pragma mark - Prepare for Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //Goes to the the show large photo segue
    if ([segue.identifier isEqualToString:@"showLargePhoto"]) {
        NSArray *indexpaths = [self.collectionView indexPathsForSelectedItems];
        //sets the image with the image from the self.largePhotos
        UIImage *image = [self.largePhotos objectAtIndex:[[indexpaths objectAtIndex:0] row]];
        HMLargePhotoViewController *largePhotoView = segue.destinationViewController;
        //sets the largeimage to the above image
        [largePhotoView setLargePhotos:image]; 
    }
}

@end
