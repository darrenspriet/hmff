//
//  HMMoreTableViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-04.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMMoreTableViewController.h"

@interface HMMoreTableViewController ()

@end

@implementation HMMoreTableViewController

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadData];
    
}

-(void)loadData{
    [self setSubmitObject:[[HMDataFeedManager sharedDataFeedManager] submitObject]];
    for (NSDictionary *diction in self.submitObject){
         NSString * string=[diction objectForKey:@"name"];
        //if the name is entry form
         if ([string isEqualToString:@"entryformlink"]) {
            [self loadPdfData: [diction objectForKey:@"details"]];
          }
    }
}

  
//takes the string from the url and loads it into nsdata so it can be opened in a document
-(void)loadPdfData:(NSString*)string{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //        NSLog(@"parse loadPDF started dispach started");
        NSDate *startTime= [NSDate date];
        
        
        //loads the pdf data into the nsdata property
        [self setPdfData:  [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:string]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            NSLog(@"loadPDF dispach finished");
            [[HMDataFeedManager sharedDataFeedManager] setPdfData:self.pdfData];
            NSDate *endTime= [NSDate date];
            CGFloat difference= [endTime timeIntervalSinceDate:startTime];
            NSLog(@"load PDF : %f", difference);
            ;
        });
    });
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        //Changes the size if it is the iPhone 5
        if (screenSize.height > 480.0f) {
            //returns 60f if it is iPhone 5
            return 60.0f;
        }
        else {
            //else returns 47f 
            return 47.0f;
        }
}

//Creates a invisible footer to get rid of extra cells created
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Sets the text to the cells and uses the More Cell for each of the cells
    switch (indexPath.row) {
        case 0:{
            static NSString *CellIdentifier = SUBMIT_BAND_CELL;
            HMMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[HMMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell.title setText:@"Band Submission"];
            return cell;
            break;
        }
        case 1:{
            static NSString *CellIdentifier = SUBMIT_VIDEO_CELL;
            HMMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[HMMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell.title setText:@"Video Submission"];
            return cell;
            break;
        }

        case 2:{
            static NSString *CellIdentifier = PHOTO_CELL;
            HMMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[HMMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell.title setText:@"Photos"];
            return cell;
            break;
        }
        case 3:{
            static NSString *CellIdentifier = YOUTUBE_CELL;
            HMMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[HMMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell.title setText:@"Videos"];
            return cell;
            break;
        }
        default :{
            static NSString *CellIdentifier = ABOUT_US_CELL;
            HMMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[HMMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell.title setText:@"About Us"];
            return cell;
            break;
        }
    }
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
