//
//  HMNewsFeedTableViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-06.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMNewsFeedTableViewController.h"

@interface HMNewsFeedTableViewController ()@end

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
    
    self.news = [(HMAppDelegate *)[[UIApplication sharedApplication] delegate]news];
    [self loadNewsFeedData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    NSLog(@"news count %d" ,[self.news count]);
    return [self.news count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"newsCell";
    HMNewsFeedCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell){
        cell = [[HMNewsFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *date =  [self.dateArray objectAtIndex:indexPath.row];
    NSArray *array = [date componentsSeparatedByString:@"-"];
    NSString *month = [self getMonth:array];
    NSString *dateString = [NSString stringWithFormat:@"%@%@%@%@%@",month, @" ", [array objectAtIndex:1],@" ", [array  objectAtIndex:0]];
    NSString *title =[self decodeHtmlUnicodeCharactersToString:[self.titleArray objectAtIndex:indexPath.row]];
    [cell.title setText:title];
    [cell.date setText:dateString];
    return cell;
}

-(void)loadNewsFeedData{
    self.titleArray = [[NSMutableArray alloc]init];
    self.contentArray = [[NSMutableArray alloc]init];
    self.dateArray =[[NSMutableArray alloc]init];
    
    NSArray *title = [self.news objectForKey:@"posts"];
    NSArray *content =[self.news objectForKey:@"posts"];
    NSArray *date =[self.news objectForKey:@"posts"];
    
    
    for(NSDictionary *diction in title){
        NSString *title =[diction objectForKey:@"title"];
//        NSLog(@"title %@", title);
        [self.titleArray addObject:title];
    }
    for(NSDictionary *diction in date){
        NSString  *date =[diction objectForKey:@"date"];
//        NSLog(@"this is the date %@", date);
        [self.dateArray addObject:date];
    }
    for(NSDictionary *diction in content){
        NSString  *content =[diction objectForKey:@"excerpt"];
//        NSLog(@"this is the content %@", content);
        [self.contentArray addObject:content];
    }
}
        


#pragma mark - Prepare for Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showNewsDetail"]) {
        
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *newsFeed =[[NSDictionary alloc]initWithObjectsAndKeys:[self.titleArray objectAtIndex:row],@"title", [self.contentArray objectAtIndex:row], @"content", nil];
        HMNewsFeedDetailViewController *newsFeedDetailViewController = segue.destinationViewController;
        newsFeedDetailViewController.detailItem = newsFeed;
    }
}
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
- (NSString*) decodeHtmlUnicodeCharactersToString:(NSString*)passedString{
    NSMutableString* string = [[NSMutableString alloc] initWithString:passedString];
    NSString* uniCodeString = nil;
    NSString* replaceString = nil;
    int counter = -1;
    
    for(int i = 0; i < [string length]; ++i)
    {
        unichar character1 = [string characterAtIndex:i];
        for (int k = i + 1; k < [string length] - 1; ++k)
        {
            unichar character2 = [string characterAtIndex:k];
            
            if (character1 == '&'  && character2 == '#')
            {
                ++counter;
                uniCodeString = [string substringWithRange:NSMakeRange(i + 3 , 2)];
                replaceString = [string substringWithRange:NSMakeRange (i, 8)];    
                [string replaceCharactersInRange: [string rangeOfString:replaceString] withString:[NSString stringWithFormat:@"%c",[uniCodeString intValue]]];
                break;
            }
        }
    }
    if (counter > 1)
        return  [self decodeHtmlUnicodeCharactersToString:string];
    else
        return string;
}

@end
