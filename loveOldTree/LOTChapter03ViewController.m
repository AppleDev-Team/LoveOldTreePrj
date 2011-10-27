//
//  ChapterThree.m
//  loveOldTree
//
//  Created by  on 11/10/3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LOTChapter03ViewController.h"

@implementation LOTChapter03ViewController

// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
        self.title = @"相關資訊";
        self.tabBarItem.image = [UIImage imageNamed:@"LOTTabBarChapter03"];
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)viewDidLoad
{
    /*
    NSURL *url =[NSURL URLWithString:@"http://tw.yahoo.com"]; //開啓網頁
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
    */
    
    
    //讀取本地端檔案
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:@"game.html"];
    
    // encoding:NSUTF8StringEncoding error:nil 這一段一定要加，不然中文字會亂碼
    NSString *htmlstring=[[NSString alloc] initWithContentsOfFile:filePath  encoding:NSUTF8StringEncoding error:nil];   
    
    [webview loadHTMLString:htmlstring  baseURL:[NSURL fileURLWithPath:[ [NSBundle mainBundle] bundlePath]]];
}
- (void)dealloc {
    [webview release];
    [super dealloc];
}
@end
