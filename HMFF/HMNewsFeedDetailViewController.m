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

- (void)viewDidLoad{
    [super viewDidLoad];
    [self configureView];

	// Do any additional setup after loading the view.
}

- (void)configureView
{
    if (self.detailItem) {
        NSDictionary *newsFeed = self.detailItem;
        NSString *title=[self decodeHtmlUnicodeCharactersToString:[newsFeed objectForKey:@"title"]];
        
        NSString  *content = [self decodeHtmlUnicodeCharactersToString:[newsFeed objectForKey:@"content"]];
        
        [self.newsTitle setText: title];
        [self.content setText: content];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) decodeHtmlUnicodeCharactersToString:(NSString*)str{
    NSMutableString* string = [[NSMutableString alloc] initWithString:str];
    NSString* uniCodeString = nil;
    NSString* replaceString = nil;
    int counter = -1;
    
    for(int i = 0; i < [string length]; ++i)
    {
        unichar character1 = [string characterAtIndex:i];
        for (int k = i + 1; k < [string length] - 1; ++k)
        {
            unichar character2 = [string characterAtIndex:k];

            //Add a 3rd character that looks for ands and dismisses it all together?????????
            if (character1 == '&'  && character2 == '#')
            {
                ++counter;
                uniCodeString = [string substringWithRange:NSMakeRange(i + 3 , 2)];
                replaceString = [string substringWithRange:NSMakeRange (i, 8)];
                [string replaceCharactersInRange: [string rangeOfString:replaceString] withString:[NSString stringWithFormat:@"%c",[uniCodeString intValue]]];
            }
        }
        
    }
    if (counter > 1)
        return  [self decodeHtmlUnicodeCharactersToString:string];
    else
        return string;
}

@end
