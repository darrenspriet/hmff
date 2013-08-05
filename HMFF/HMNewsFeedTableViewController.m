//
//  HMNewsFeedTableViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-06.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMNewsFeedTableViewController.h"

@interface HMNewsFeedTableViewController ()
@property(nonatomic, strong) NSMutableArray *titleArray;
@property(nonatomic, strong) NSMutableArray *contentArray;
@property(nonatomic, strong) NSMutableArray *dateArray;
@end

@implementation HMNewsFeedTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //Getting the data that holds the news feed that is sent from App Delegate
    [self setNews: [[HMDataFeedManager sharedDataFeedManager] news]];
    //loads all of the arrays from the Data Feed Manager
    [self loadNewsFeedData];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //returns the count of the title Array which is how many rows
    return [self.titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Sets the Cell to the News Feed Cell
    static NSString *CellIdentifier = @"newsCell";
    HMNewsFeedCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell){
        cell = [[HMNewsFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //Gets the date for the Cell
    NSString *date =  [self.dateArray objectAtIndex:indexPath.row];
    
    //Converts the date to an Array
    NSArray *dateArray= [date componentsSeparatedByString:@"-"];
    
    //Gets the month by calling the method below get Month
    NSString *month = [self getMonth:dateArray];
    
    //Formats the dates into a string
    NSString *dateString = [NSString stringWithFormat:@"%@%@%@%@%@",month, @" ", [dateArray objectAtIndex:1],@" ", [dateArray  objectAtIndex:0]];
    
    //Decods the Title so it removes the wierd Unicode characters
    NSString *title =[self decodeHtmlUnicodeCharactersToString:[self.titleArray objectAtIndex:indexPath.row]];
    //Sets the title to the cell
    [cell.title setText:title];
    //Sets the date to the Cell
    [cell.date setText:dateString];
    
    return cell;
}

-(void)loadNewsFeedData{
    //initializes the arrays
    [self setTitleArray : [[NSMutableArray alloc]init] ];
    [self setContentArray : [[NSMutableArray alloc]init] ];
    [self setDateArray : [[NSMutableArray alloc]init] ];
    
    //Creates new Arrays of the news feeds one object in at "posts"
    NSArray *title = [self.news objectForKey:@"posts"];
    NSArray *content =[self.news objectForKey:@"posts"];
    NSArray *date =[self.news objectForKey:@"posts"];
    
    //Gets all of the titles out of the dictionary and adds it to the Title Array
    for(NSDictionary *diction in title){
        NSString *title =[diction objectForKey:@"title"];
        [self.titleArray addObject:title];
    }
    //Gets all of the dates out of the dictionary and adds it to the dates Array
    for(NSDictionary *diction in date){
        NSString  *date =[diction objectForKey:@"date"];
        [self.dateArray addObject:date];
    }
    //Gets all of the content out of the dictionary and adds it to the content array
    for(NSDictionary *diction in content){
        NSString  *content =[diction objectForKey:@"excerpt"];
        [self.contentArray addObject:content];
    }
}



#pragma mark - Prepare for Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //Goes the segue to show the detail view for the news details
    if ([segue.identifier isEqualToString:@"showNewsDetail"]) {
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        
        //Puts all of the information for the news feed with keys into a dictionary
        NSDictionary *newsFeed =[[NSDictionary alloc]initWithObjectsAndKeys:[self.titleArray objectAtIndex:row],@"title", [self.contentArray objectAtIndex:row], @"content", nil];
        HMNewsFeedDetailViewController *newsFeedDetailViewController = segue.destinationViewController;
        //Passes the news feed to the the next view controller detail item
        [newsFeedDetailViewController setDetailItem:newsFeed];
    }
}

//Goes through and takes an array and returns a string based on the if statement below
-(NSString*)getMonth:(NSArray*)array{
    if ([array[1] isEqualToString:@"01"]) {
        return @"JAN";
    }
    else if ([array[1] isEqualToString:@"02"]) {
        return @"FEB";
    }
    else if ([array[1] isEqualToString:@"03"]) {
        return @"MAR";
    }
    else if ([array[1] isEqualToString:@"04"]) {
        return @"APR";
    }
    else if ([array[1] isEqualToString:@"05"]) {
        return @"MAY";
    }
    else if ([array[1] isEqualToString:@"06"]) {
        return @"JUN";
    }
    else if ([array[1] isEqualToString:@"07"]) {
        return @"JUL";
    }
    else if ([array[1] isEqualToString:@"08"]) {
        return @"AUG";
    }
    else if ([array[1] isEqualToString:@"09"]) {
        return @"SEP";
    }
    else if ([array[1] isEqualToString:@"10"]) {
        return @"OCT";
    }
    else if ([array[1] isEqualToString:@"11"]) {
        return @"NOV";
    }
    else  {
        return @"DEC";
    }
}

//Decodes the strings if there are any characters in the news feed
- (NSString*) decodeHtmlUnicodeCharactersToString:(NSString*)passedString{
    //Sets the string to the passed string
    NSMutableString* string = [[NSMutableString alloc] initWithString:passedString];
    //initializes 2 strings
    NSString* uniCodeString = nil;
    NSString* replaceString = nil;
    //sets the counter to -1
    int counter = -1;
    //iterates through the letters
    for(int i = 0; i < [string length]; ++i){
        unichar character1 = [string characterAtIndex:i];
        for (int k = i + 1; k < [string length] - 1; ++k){
            unichar character2 = [string characterAtIndex:k];
            //if the character is & or # then set the range on
            if (character1 == '&'  && character2 == '#'){
                ++counter;
                uniCodeString = [string substringWithRange:NSMakeRange(i + 3 , 2)];
                replaceString = [string substringWithRange:NSMakeRange (i, 8)];
                //set the string to replace the string
                [string replaceCharactersInRange: [string rangeOfString:replaceString] withString:[NSString stringWithFormat:@"%c",[uniCodeString intValue]]];
                break;
            }
        }
    }
    //if the counter is greater than 1 then return the string
    if (counter > 1){
        return  [self decodeHtmlUnicodeCharactersToString:string];
    }
    //else return the string
    else{
        return string;
    }
}
@end
