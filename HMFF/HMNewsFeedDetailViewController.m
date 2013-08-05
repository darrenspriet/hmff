//
//  HMNewsFeedDetailViewController.m
//  HMFF
//
//  Created by Darren Spriet on 2013-04-08.
//  Copyright (c) 2013 HMFF. All rights reserved.
//

#import "HMNewsFeedDetailViewController.h"

@interface HMNewsFeedDetailViewController ()

@end

@implementation HMNewsFeedDetailViewController

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

- (void)viewDidLoad{
    [super viewDidLoad];
    //Sets the title to "News
    [self.navigationItem setTitle:@"News"];
    //sets the alpha to .3 and dims down the background
    [self.controllerView setAlpha:0.3f];
    //sets that background to black
    [self.controllerView setBackgroundColor:[UIColor blackColor]];
    //Configures the entire View with data
    [self loadData];
}

- (void)loadData{
        
        //Sets title for the News feed to a String called Title
        NSString *title=[self decodeHtmlUnicodeCharactersToString:[self.detailItem objectForKey:@"title"]];
        
        //Sets content for the News feed to a String called content
        NSString  *content = [self decodeHtmlUnicodeCharactersToString:[self.detailItem objectForKey:@"content"]];
        
        //Sets the Label for the title to the above Strings
        [self.newsTitle setText: title];
        //Sets the label for the content to the above string
        [self.content setText: content];
        
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
