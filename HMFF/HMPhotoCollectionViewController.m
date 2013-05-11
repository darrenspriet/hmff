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

- (void)viewDidLoad{
    [super viewDidLoad];
    self.smallPhotos = [(HMAppDelegate *)[[UIApplication sharedApplication] delegate]smallPhotos];
    self.largePhotos = [(HMAppDelegate *)[[UIApplication sharedApplication] delegate]largePhotos];
}

-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    UILabel *titleLabel = (UILabel *)self.navigationItem.titleView;
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:19.0f]];
        [titleLabel setTextColor:[UIColor blackColor]];
        [self.navigationItem setTitleView:titleLabel];
    }
    [titleLabel setText:title];
    [titleLabel sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HMPhotoCollectionCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"collectionCell"
                                    forIndexPath:indexPath];

    NSData *imageData = [self.smallPhotos objectAtIndex:indexPath.row];    
    myCell.imageView.image = [UIImage imageWithData:imageData];
    return myCell;
}
#pragma mark -
#pragma mark UICollectionViewFlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSData *imageData = [self.smallPhotos objectAtIndex:indexPath.row];
    UIImage *image = [UIImage imageWithData:imageData];
    
    return image.size;
}
#pragma mark -
#pragma mark UICollectionViewDelegate

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewFlowLayout *myLayout =
//    [[UICollectionViewFlowLayout alloc]init];
//    
//    myLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    [self.collectionView setCollectionViewLayout:myLayout animated:YES];
//}

#pragma mark - Prepare for Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //Goes the the show Tweet detail page sending the detail of the tweet
    if ([segue.identifier isEqualToString:@"showLargePhoto"]) {
        NSArray *indexpaths = [self.collectionView indexPathsForSelectedItems];
        NSURL *URL = [self.largePhotos objectAtIndex:[[indexpaths objectAtIndex:0] row]];
        
        HMLargePhotoViewController *largePhotoView = segue.destinationViewController;
        largePhotoView.largePhotos =URL;
    }
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    searchTextField.hidden = YES;
//    
//    // If we've created this VC before...
//    if (fullImageViewController != nil)
//    {
//        // Slide this view off screen
//        CGRect frame = fullImageViewController.frame;
//        
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:.45];
//        
//        // Off screen location
//        frame.origin.x = -320;
//        fullImageViewController.frame = frame;
//        
//        [UIView commitAnimations];
//        
//    }
//    
//    [self performSelector:@selector(showZoomedImage:) withObject:indexPath afterDelay:0.1];
//}
//
//- (void)showZoomedImage:(NSIndexPath *)indexPath
//{
//    // Remove from view (and release)
//    if ([fullImageViewController superview])
//        [fullImageViewController removeFromSuperview];
//    
//    fullImageViewController = [[ZoomedImageView alloc] initWithURL:[photoURLsLargeImage objectAtIndex:indexPath.row]];
//    
//    [self.view addSubview:fullImageViewController];
//    
//    // Slide this view off screen
//    CGRect frame = fullImageViewController.frame;
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:.45];
//    
//    // Slide the image to its new location (onscreen)
//    frame.origin.x = 0;
//    fullImageViewController.frame = frame;
//    
//    [UIView commitAnimations];
//}

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//	[textField resignFirstResponder];
//    
//    [photoTitles removeAllObjects];
//    [photoSmallImageData removeAllObjects];
//    [photoURLsLargeImage removeAllObjects];
//    
//    [self searchFlickrPhotos:searchTextField.text];
//    
//    [activityIndicator startAnimating];
//    
//	return YES;
//}

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    // Store incoming data into a string
//	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    
////    debug(@"CALLING:%@", jsonString);
//    
//    // Create a dictionary from the JSON string
//    NSError *error;
//    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
//
//	
//    // Build an array from the dictionary for easy access to each entry
//	NSArray *photos = [[self. objectForKey:@"photos"] objectForKey:@"photo"];
//    
//    // Loop through each entry in the dictionary...
//	for (NSDictionary *photo in photos)
//    {
//        // Get title of the image
//		NSString *title = [photo objectForKey:@"title"];
//        
//        // Save the title to the photo titles array
//		[photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
//		
//        // Build the URL to where the image is stored (see the Flickr API)
//        // In the format http://farmX.static.flickr.com/server/id/secret
//        // Notice the "_s" which requests a "small" image 75 x 75 pixels
//		NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
//        
//        // The performance (scrolling) of the table will be much better if we
//        // build an array of the image data here, and then add this data as
//        // the cell.image value (see cellForRowAtIndexPath:)
//		[photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
//        
//        // Build and save the URL to the large image so we can zoom
//        // in on the image if requested
//		photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
//		[photoURLsLargeImage addObject:[NSURL URLWithString:photoURLString]];
//	}
//    
//    // Update the table with data
//    [self.collectionView reloadData];
//    
//    // Stop the activity indicator
////    [activityIndicator stopAnimating];
//    
////	[jsonString release];
//}

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
//-(void)searchFlickrPhotos:(NSString *)text{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSData* data = [NSData dataWithContentsOfURL:
//                        [NSURL URLWithString:[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?&method=flickr.people.getPublicPhotos&api_key=%@&user_id=95406796@N08&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey]]];
//        
//        NSError* error;
//        
//        self.photos = [NSJSONSerialization JSONObjectWithData:data
//                                                    options:kNilOptions
//                                                      error:&error];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"Content for flicker fetcher");
//            // Build an array from the dictionary for easy access to each entry
//            NSArray *photos = [[self.photos objectForKey:@"photos"] objectForKey:@"photo"];
//            // Loop through each entry in the dictionary...
//            for (NSDictionary *photo in photos)
//            {
//                // Get title of the image
//                NSString *title = [photo objectForKey:@"title"];
//                
//                // Save the title to the photo titles array
//                [photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
//                
//                // Build the URL to where the image is stored (see the Flickr API)
//                // In the format http://farmX.static.flickr.com/server/id/secret
//                // Notice the "_s" which requests a "small" image 75 x 75 pixels
//                NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
//                
//                
//                // The performance (scrolling) of the table will be much better if we
//                // build an array of the image data here, and then add this data as
//                // the cell.image value (see cellForRowAtIndexPath:)
//                [photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
//                NSLog(@"small photos %@", [NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]);
//
//                
//                // Build and save the URL to the large image so we can zoom
//                // in on the image if requested
//                photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
//                [photoURLsLargeImage addObject:[NSURL URLWithString:photoURLString]];
////                NSLog(@"large photos %@", photoURLsLargeImage);
//
//            }
//            
//            // Update the table with data
//            NSLog(@"reloading");
//            [self.collectionView reloadData];
//        });
//    });
//    
//}
@end
