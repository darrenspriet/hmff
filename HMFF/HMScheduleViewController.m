//
//  HMScheduleViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-12.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMScheduleViewController.h"

@interface HMScheduleViewController ()

@end

@implementation HMScheduleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    //sets up the navigation bar
    [self setUpNavigationBar];
    //loads Data into the app
    [self loadData];
    //sets the image for the forward button on load
    [self imagesForButton:@"" andFrontImage:@"forwardButton.png"];    
}
//sets up the navigation bar
-(void)setUpNavigationBar{
    //sets the icon in the Navigation bar
    UIImage *image = [UIImage imageNamed:@"hmffLogoIconSplash.png"];
    //sets the title to the image above
    [self.navigationItem setTitleView: [[UIImageView alloc] initWithImage:image]];
    //the image for the tickets button
    UIImage *barImage = [UIImage imageNamed:@"ticketsButton.png"];
    //grabbing a frame to put the button image into
    CGRect frameImage = CGRectMake(0, 0, barImage.size.width, barImage.size.height);
    //sets the right bar button to the frame above
    UIButton *rightBarButtton = [[UIButton alloc] initWithFrame:frameImage];
    //As well sets the button to the image above and its state to normal
    [rightBarButtton setBackgroundImage:barImage forState:UIControlStateNormal];
    //Adds the action to the button
    [rightBarButtton addTarget:self action:@selector(buyTicketPressed:) forControlEvents:UIControlEventTouchUpInside];
    //adds the button to the Navigation Controller
    UIBarButtonItem *barButton =[[UIBarButtonItem alloc] initWithCustomView:rightBarButtton];
    [[self navigationItem] setRightBarButtonItem:barButton];
    
}
//loads Data into the app
-(void)loadData{
    //sets the date from the Data Manager
    [self setDate:[[HMDataFeedManager sharedDataFeedManager] date]];
    //sets the HTMLString from the Data Manager
    [self setHTMLString:[[HMDataFeedManager sharedDataFeedManager] HTMLString]];
    //sets the image for the date to the initial date
    [self.dateForEvent setText:[self.date objectAtIndex:0]];
    
    [self setLinkObject:[[HMDataFeedManager sharedDataFeedManager] linkObject]];
    //parses the TicketLink into a HTMLString
    [self parseTicketLink:self.linkObject];
    //parses through the Social links to save to an array
    [self parseSocialLinks:self.linkObject];
    
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buyTicketPressed:(id)sender{
    //calls the performsegueWith Identifier Buy Tickets
    [self performSegueWithIdentifier:@"BuyTickets" sender:sender];    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //When the View is loaded it this container sets the delegates
    if ([segue.identifier isEqualToString:@"container"]){
        [(HMScheduleScrollViewController*)segue.destinationViewController setDelegate:self];
        [self setDelegate:(id<HMScheduleViewControllerDelegate>)segue.destinationViewController];
    }
    //if the user clicks buy tickets this segue is called
    else if([segue.identifier isEqualToString:@"BuyTickets"]){
        UINavigationController * navController =segue.destinationViewController;
        HMBuyTicketsViewController *buyTickets = (HMBuyTicketsViewController *)navController.topViewController;
        //passes the schedule
        [buyTickets setPagePushed:@"Schedule"];
    }
}

//changes the Date when the Delegate calls it
-(void)changeDate:(NSString *)date{
    [self.dateForEvent setText:date];
}
//changes the images for front and back images
-(void)imagesForButton:(NSString*)backImage andFrontImage:(NSString*)frontImage{
    if (backImage!=nil) {
        
        
        [self.backButtonImage setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
    }
    if (frontImage!=nil) {
        if ([frontImage isEqualToString:@""]) {
            [self.forwardButtonImage setEnabled:NO];
        }
        else{
            [self.forwardButtonImage setEnabled:YES];
        }
        [self.forwardButtonImage setImage:[UIImage imageNamed:frontImage] forState:UIControlStateNormal];
        
    }
    
}
//Tells the delegate, scroll view to scroll forward
- (IBAction)forwardButton:(UIButton *)sender {
    [self.delegate scrollForward];    
}
//Tells the delegate, scroll view to scroll backward
- (IBAction)backButton:(UIButton *)sender {
    [self.delegate scrollBack];
}




//parses through the social links
-(void)parseSocialLinks:(NSArray*)array{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //        NSLog(@"parseLinks dispach started");
                
        //allocating arrays
        NSString *finalLink;
        [self setLinksArray: [[NSMutableArray alloc]init]];
        
        //iterates through the array and puts it into the linksArray
        for (NSDictionary *diction in array){
            NSString * string=[diction objectForKey:@"name"];
            
            //if the name is equal to hmff
            if ([string isEqualToString:@"hmff"]) {
                
                //adds it to the links Array
                [self.linksArray addObject:diction];
                
                //Then builds a HTMLString of the Website
                finalLink= [self buildLinkData:[diction objectForKey:@"link"]];
                
                //builds a temporary NSDictionary with the final Link
                NSDictionary *tempDict=[[NSDictionary alloc]initWithObjectsAndKeys:@"htmlLink", @"name",finalLink,@"link", nil];
                
                //adds the dictionary to the linksArray
                [self.linksArray addObject:tempDict];
            }
            else{
                //adds the dictionary to the links array
                [self.linksArray addObject:diction];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //            NSLog(@"parseLinks dispach finished");
            [[HMDataFeedManager sharedDataFeedManager] setLinksArray:self.linksArray];
            ;
            
        });
    });
}

//parses through to get the ticket link
-(void)parseTicketLink:(NSArray*)array{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //        NSLog(@"single link");
            
        //initializes the strings
        [self setHTMLString: [[NSString alloc]init]];
        
        //iterates through the array to find the ticket
        for (NSDictionary *diction in array){
            NSString * string=[diction objectForKey:@"name"];
            if ([string isEqualToString:@"ticket"]) {
                
                //calls the build link data and sets it to the HTMLString
                [self setHTMLString: [self buildLinkData:[diction objectForKey:@"link"]]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //            NSLog(@"single link finished");
            [[HMDataFeedManager sharedDataFeedManager] setHTMLString:self.HTMLString];
            ;
        });
    });
}

//builds Link Data sending in a string and returning a string
-(NSString*)buildLinkData:(NSString*)string{
    //intialize a NSData
    NSData *urlData;
    //sets up a request with the string passed in
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:string] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval: 10.0];
    //initializes an NSError, and NSURLResponse
    NSError *error = nil;
    NSURLResponse* response = nil;
    //sets the url data with the request and response and error
    urlData  = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //sets up the string with the url data from above
    NSString *returnString= [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    //returnts the return string from above
    return returnString;
}


@end
