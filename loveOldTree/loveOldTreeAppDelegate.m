//
//  loveOldTreeAppDelegate.m
//  loveOldTree
//
//  Created by  on 11/10/3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "loveOldTreeAppDelegate.h"
#import "LOTChapter01ViewController.h"
#import "LOTChapter02ViewController.h"
#import "LOTChapter03ViewController.h"

@implementation loveOldTreeAppDelegate

@synthesize window = _window;

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UITabBarController *tabBarController = [[[UITabBarController alloc] init] autorelease];
    
    tabBarController.viewControllers = [NSArray arrayWithObjects:
        
        [[[LOTChapter01ViewController alloc] initWithNibName:@"LOTChapter01ViewController" bundle:nil] autorelease],
        
        [[[UINavigationController alloc] initWithRootViewController:
            [[[LOTChapter02ViewController alloc] initWithNibName:@"LOTChapter02ViewController" bundle:nil] autorelease]
        ] autorelease],
        
        [[[LOTChapter03ViewController alloc] initWithNibName:@"LOTChapter03ViewController" bundle:nil] autorelease],
        
    nil];
    
    _window.rootViewController = tabBarController;
    [_window makeKeyAndVisible];
    
    return YES;
    
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end

//------CustomImage------
@implementation UITabBar (CustomImage)   
- (void) drawRect:(CGRect)rect {   
    UIImage *image = [UIImage imageNamed:@"LOTTabBarBackground"];   
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];   
}   

@end
