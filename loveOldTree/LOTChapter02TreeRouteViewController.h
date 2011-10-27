//
//  LOTChapter02TreeRouteViewController.h
//  loveOldTree
//
//  Created by Miriam on 2011/10/24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LOTChapter02TreeRouteViewController : UIViewController {
    UIWebView *webView;
}
@property (nonatomic, retain) IBOutlet UIWebView *webView;

-(id)initWithMapRoute:(CLLocationCoordinate2D)theUserCoordinate goalCoordinate:(CLLocationCoordinate2D)theGoalCoordinate;

@end
