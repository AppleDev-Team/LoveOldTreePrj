//
//  ChapterTwo.h
//  loveOldTree
//
//  Created by  on 11/10/3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "LOTChapter02DetailViewController.h"

@class LOTChapter02DetailViewController;

@interface LOTChapter02ViewController : UIViewController <MKMapViewDelegate>{
    CLLocationManager *locManager;	
	IBOutlet MKMapView *mapView;
	UIActivityIndicatorView *busyIndicator;
	BOOL hasShownUserLocationInMap;
}

@property (nonatomic, retain) IBOutlet LOTChapter02DetailViewController *detailViewController;
@property (nonatomic, retain) IBOutlet UIView *busyOverlay;

- (IBAction)centerToCurrentLocation:(id)sender;
- (void) updateRegionForLocation:(CLLocation *) newLocation keepSpan:(BOOL) keepSpan;
- (void) addDefaultAnnotations;
- (UIImage *)reSizeImageInPath:(NSString *)path withWidth:(CGFloat)width andHeight:(CGFloat)height;


@end
