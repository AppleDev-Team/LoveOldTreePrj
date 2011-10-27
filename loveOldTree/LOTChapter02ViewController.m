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
#import "SearchTreeData.h"

@implementation LOTChapter02ViewController
@synthesize busyOverlay;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self)
        return nil;
        
    self.title = @"尋找老樹";
    self.tabBarItem.image = [UIImage imageNamed:@"LOTTabBarChapter02"];
    
    /*self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"LOTPin"] style:UIBarButtonItemStyleBordered target:self action:@selector(centerToCurrentLocation:)] autorelease];*/

    // Create location manager object 
    locationManager = [[CLLocationManager alloc] init];
        
    // There will be a warning from this line of code; ignore it for now 
    [locationManager setDelegate:self];
    
    // We want all results from the location manager 
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    // And we want it to be as accurate as possible // regardless of how much time/power it takes 
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    // Tell our manager to start looking for its location immediately 
    [locationManager startUpdatingLocation];
    
    return self;
}

-(void)initCoordinate {
    userCoordinate.latitude = 25.041702;
    userCoordinate.longitude = 121.550128;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userCoordinate, 500, 500); 
    [mapView setRegion:region animated:YES];
    
//   [self addPOI];
}

- (void) viewDidLoad {
    [super viewDidLoad];

    //init map properties
    [mapView setDelegate:self];
    [mapView setMapType:MKMapTypeStandard];
    [mapView setShowsUserLocation:YES];
    
    self.busyOverlay.layer.cornerRadius = 4.0f;
    
    [self initCoordinate];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    #ifdef TARGET_IPHONE_SIMULATOR
//      userCoordinate = newLocation.coordinate;
        userCoordinate.latitude = 25.041702;
        userCoordinate.longitude = 121.550128;
    #else
        userCoordinate = [userLocation coordinate]; 
    #endif
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userCoordinate, 500, 500); 
    [mapView setRegion:region animated:YES];
    
    NSLog(@"didUpdateToLocation userlocation %f %f", userCoordinate.latitude, userCoordinate.longitude);
//    [self addPOI];
}

- (void) viewDidUnload {
    
    locationManager = nil;
    mapView = nil;
    activityIndicator = nil;
    [self setBusyOverlay:nil];
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
        500, 
        500
    ) animated:YES];

}

- (IBAction)centerToCurrentLocation:(id)sender {
	[self centerPosition];
}

# pragma mark - MKMapViewDelegate events

//新增據點
-(void)addPOI {
    
    [mapView removeAnnotations:mapView.annotations];

/*    for (int i=0; i<[mapView.annotations count]; i++) {
        LOTAnnotation *annos = (LOTAnnotation *)([mapView.annotations objectAtIndex:i]);
        [mapView removeAnnotation:annos];
    }*/
    
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    
    // 建立一個CLLocationCoordinate2D
    CLLocationCoordinate2D coord;
    
    //core data init
    SearchTreeData *testTrees = [[[SearchTreeData alloc]init]autorelease];
    NSMutableArray *testTreeArray = [testTrees searchUseTreeDataInMapOfInputLatitude:userCoordinate.latitude inputLongitude:userCoordinate.longitude];
    //[testTrees searchTreesNotUse];
    //NSArray *testTreeArray = [testTrees searchTreesNotUse];
    
    //    NSLog(@"tree count %@", [testTreeArray count]);
    for (int i = 0; i<[testTreeArray count]; i++) {
        TheTreesListInMap *personEntity = [testTreeArray objectAtIndex:i];
        
        NSLog(@"tree %@", personEntity.treeID);
        coord.latitude = [personEntity.treeLatitude doubleValue];
        coord.longitude = [personEntity.treeLongitude doubleValue];
        
        LOTAnnotation *anno = [[[LOTAnnotation alloc] initWithRootView:personEntity.treeID subtitle:personEntity.treeDistance coordinate:coord userCoordinate:userCoordinate treeId:personEntity.treeID treeDistance:personEntity.treeDistance] autorelease];
        
        /*LOTAnnotation *anno = [[[LOTAnnotation alloc] initWithLocationTitle:personEntity.treeID subtitle:personEntity.treeDistance coordinate:coord userCoordinate:userCoordinate treeId:personEntity.treeID treeKind:personEntity.treeKind treeDistance:personEntity.treeDistance treeAddress:personEntity.treeAddress treeHeight:personEntity.treeHight treeSource:personEntity.treeSoutce treeAge:personEntity.treeAge treeShape:personEntity.treeShape treeBust:personEntity.treeBust treeLocation:personEntity.treeLocation treeBackground:personEntity.treeBackground treeManagement:personEntity.treeManagement] autorelease];*/
        
        // 把annotation加進MapView裡
        [annotations addObject:anno];
    }
    
    [mapView addAnnotations:annotations];   
    [annotations release];
    
}

- (void) mapViewWillStartLoadingMap:(MKMapView *) theMapView {
    /*if(activityIndicator == nil) {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		activityIndicator.frame = CGRectMake(120, 180, 80, 80);
		[self.view addSubview:activityIndicator];
	}
	activityIndicator.hidesWhenStopped = YES;
	[activityIndicator startAnimating];*/
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
//    [activityIndicator stopAnimating];
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^(void) {
        
        self.busyOverlay.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        if (finished)
            [self.busyOverlay removeFromSuperview];
        
    }];
}

-(void)viewWillDisappear:(BOOL)animated {
    [locationManager stopUpdatingLocation];
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"viewDidAppear");
    [self addPOI];
}

/*- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {

    [self updateRegionForLocation:userLocation.location keepSpan:hasShownUserLocationInMap];
    hasShownUserLocationInMap = YES;
    [self centerPosition];
}*/

//完成移動地圖動作 重新計算 地圖中心點／地圖邊界
-(void)mapView:(MKMapView *)theMapView regionDidChangeAnimated:(BOOL)animated {
    MKCoordinateRegion region;
    CLLocationCoordinate2D centerCoordinate=theMapView.region.center;
    region.center= centerCoordinate;

//    NSLog(@"regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
}

// 更新顯示的視野
/*- (void) updateRegionForLocation:(CLLocation *) newLocation keepSpan:(BOOL) keepSpan{
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
//    [self addDefaultAnnotations];
}*/

- (MKAnnotationView *) mapView:(MKMapView *)theMapView viewForAnnotation:(id<MKAnnotation>)annotation {

    static NSString *const kTreeAnnotation = @"TreeAnnotation";
    static NSString *const kUserLocationAnnotation = @"UserLocationAnnotation";

    NSString *usedIdentifier = kTreeAnnotation;

    if (theMapView.userLocation) {
        
        CLLocationCoordinate2D annotationCoordinate = [annotation coordinate];
        CLLocationCoordinate2D mapUserLocationCoordinate = theMapView.userLocation.coordinate;
        
        BOOL (^locationCoordinatesAreEqual)(CLLocationCoordinate2D lhs, CLLocationCoordinate2D rhs) = ^ (CLLocationCoordinate2D lhs, CLLocationCoordinate2D rhs) {
        
            if (lhs.longitude != rhs.longitude)
                return NO;
            
            if (lhs.latitude != rhs.latitude)
                return NO;
            
            return YES;
        
        };
        
        if (locationCoordinatesAreEqual(annotationCoordinate, mapUserLocationCoordinate))
            usedIdentifier = kUserLocationAnnotation;
        
    }
    
    MKAnnotationView *pin = (MKAnnotationView *) [theMapView dequeueReusableAnnotationViewWithIdentifier:usedIdentifier];
    
    if (pin == nil) {
        
        pin = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:usedIdentifier] autorelease];
        
        if (usedIdentifier == kTreeAnnotation) {

            pin.image = [self reSizeImageInPath:@"OldTree.png" withWidth:35 andHeight:25];
            pin.canShowCallout = YES;

            UIButton* detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pin.rightCalloutAccessoryView = detailButton;

        } else if (usedIdentifier == kUserLocationAnnotation) {
        
            //  default
        }
        
    }
    pin.annotation = annotation;
    return pin;
    
}

//POI tap 後切換至 childview(DetailView)
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [view setHidden:YES];
    LOTChapter02TreeDetailViewController *childView = [[[LOTChapter02TreeDetailViewController alloc] initWithMapAnnotation:view.annotation] autorelease];
    [self.navigationController pushViewController:childView animated:YES];
    
    
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
    if([locationManager delegate] == self) 
        [locationManager setDelegate:nil];
    [locationManager release];
    [mapView release];
    [activityIndicator release];
    [busyOverlay release];
    [super dealloc];
}
@end
