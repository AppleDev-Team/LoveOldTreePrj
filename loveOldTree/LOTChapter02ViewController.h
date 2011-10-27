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

@interface LOTChapter02ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
    CLLocationManager *locationManager;
    IBOutlet MKMapView *mapView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    CLLocationCoordinate2D userCoordinate;
	BOOL hasShownUserLocationInMap;
}
@property (retain, nonatomic) IBOutlet UIView *busyOverlay;

-(void) addPOI;
-(UIImage *)reSizeImageInPath:(NSString *)path withWidth:(CGFloat)width andHeight:(CGFloat)height;

- (IBAction)centerToCurrentLocation:(id)sender;
//- (void) updateRegionForLocation:(CLLocation *) newLocation keepSpan:(BOOL) keepSpan;

@end
