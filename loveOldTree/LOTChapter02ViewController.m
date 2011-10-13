//
//  ChapterTwo.m
//  loveOldTree
//
//  Created by  on 11/10/3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LOTChapter02ViewController.h"
#import "LOTAnnotation.h"

#import "LOTChapter02TreeDetailViewController.h"

#import "UIImage+LOTAdditions.h"


@implementation LOTChapter02ViewController
@synthesize detailViewController, busyOverlay; //detailViewController目前沒有使用_20111010

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self)
        return nil;
        
    self.title = @"尋找老樹";
    self.tabBarItem.image = [UIImage imageNamed:@"LOTTabBarChapter02"];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"LOTPin"] style:UIBarButtonItemStyleBordered target:self action:@selector(centerToCurrentLocation:)] autorelease];

    return self;

}

- (void) viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];

    locManager = [[CLLocationManager alloc] init];
    [locManager startUpdatingLocation];
    //  locManager.delegate = self; ?
    
    self.busyOverlay.layer.cornerRadius = 4.0f;
	
    mapView.delegate = self;
    
}

- (void) viewDidUnload {
    
    self.detailViewController = nil;
    self.busyOverlay = nil;
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) centerPosition {

    [mapView setRegion:MKCoordinateRegionMakeWithDistance(
        mapView.userLocation.coordinate,
        100, 
        100
    ) animated:YES];

}

- (IBAction)centerToCurrentLocation:(id)sender {
	[self centerPosition];
}

# pragma mark - MKMapViewDelegate events

- (void) mapViewWillStartLoadingMap:(MKMapView *) theMapView {

    if (!self.busyOverlay.superview) {

        [self.view addSubview:self.busyOverlay];
        self.busyOverlay.center = (CGPoint){
            CGRectGetMidX(self.view.bounds),
            CGRectGetMidY(self.view.bounds)
        };
        self.busyOverlay.frame = CGRectIntegral(self.busyOverlay.frame);
        
        self.busyOverlay.alpha = 0;
    
    }
    
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^(void) {
        
        self.busyOverlay.alpha = 1;
        
    } completion:nil];
    

}

- (void) mapViewDidFinishLoadingMap:(MKMapView *) theMapView {

    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^(void) {
        
        self.busyOverlay.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        if (finished)
            [self.busyOverlay removeFromSuperview];
        
    }];

}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {

    [self updateRegionForLocation:userLocation.location keepSpan:hasShownUserLocationInMap];
    hasShownUserLocationInMap = YES;
    [self centerPosition];
    
}

// 更新顯示的視野
- (void) updateRegionForLocation:(CLLocation *) newLocation keepSpan:(BOOL) keepSpan{
    //指定中心點
    CLLocationCoordinate2D theCenter;
    theCenter.latitude = 25.054606;
    theCenter.longitude = 121.548437;
    
	MKCoordinateRegion theRegion;
    //移動地圖中心
    theRegion.center=theCenter;
    //	theRegion.center = newLocation.coordinate;
	
	if( !keepSpan ){
		MKCoordinateSpan theSpan;
		theSpan.latitudeDelta = 0.02;
		theSpan.longitudeDelta = 0.02;
		theRegion.span = theSpan;
	}else {
		theRegion.span = mapView.region.span;
	}
	[mapView setRegion:theRegion animated:YES];
    [self addDefaultAnnotations];
}

- (MKAnnotationView *) mapView:(MKMapView *)theMapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString * const identifier = @"myAnnotation";
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [theMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (pin == nil) {

        pin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
        
        pin.image = [[UIImage imageNamed:@"OldTree"] resizedImageWithSize:(CGSize){ 22, 22 }];
        pin.canShowCallout = YES;

        UIButton* detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [detailButton addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
        pin.rightCalloutAccessoryView = detailButton;

    }
    
    pin.annotation = annotation;

    return pin;
    
}


- (void) addDefaultAnnotations {

    [mapView addAnnotations:[NSArray arrayWithObjects:
       [LOTAnnotation annotationWithCoordinate:(CLLocationCoordinate2D){ 25.054606, 121.548437 } title:@"敦化店" subtitle:@"台北市敦化北路150號"],
       [LOTAnnotation annotationWithCoordinate:(CLLocationCoordinate2D){ 25.045792, 121.546383 } title:@"忠孝店" subtitle:@"台北市忠孝東路四段49巷2號"],
    nil]];
    
}

- (void)showDetails:(id)sender
{
    
     LOTChapter02TreeDetailViewController *pushedVC=[[[[self class]alloc]initWithNibName:NSStringFromClass([LOTChapter02TreeDetailViewController class]) bundle:[NSBundle bundleForClass:[LOTChapter02TreeDetailViewController class]]]autorelease];
     
     [self.navigationController pushViewController:pushedVC animated:YES]; 
    
}

- (UIImage *)reSizeImageInPath:(NSString *)path withWidth:(CGFloat)width andHeight:(CGFloat)height {
    UIImage *image = [UIImage imageNamed:path];
    CGSize newSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)dealloc {
    [busyOverlay release];
    [detailViewController release];
    [locManager stopUpdatingLocation];
    [locManager release];
    [busyIndicator release];
    [super dealloc];
}
@end
