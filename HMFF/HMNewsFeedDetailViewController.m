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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
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
    //Configures the entire View
    [self configureView];
}

- (void)configureView{
    if (self.detailItem) {
        
        //Sets title for the News feed to a String called Title
        NSString *title=[self decodeHtmlUnicodeCharactersToString:[self.detailItem objectForKey:@"title"]];
        
        //Sets content for the News feed to a String called content
        NSString  *content = [self decodeHtmlUnicodeCharactersToString:[self.detailItem objectForKey:@"content"]];
        
        //Sets the Lable for the title and content to the above Strings
        [self.newsTitle setText: title];
        [self.content setText: content];

    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Found on stack over flow at the below link:
//http://stackoverflow.com/questions/1105169/html-character-decoding-in-objective-c-cocoa-touch
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
