//
//  LOTChapter02TreeRouteViewController.m
//  loveOldTree
//
//  Created by Miriam on 2011/10/24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LOTChapter02TreeRouteViewController.h"

@interface LOTChapter02TreeRouteViewController()

@property (nonatomic, readonly) CLLocationCoordinate2D userCoordiate;
@property (nonatomic, readonly) CLLocationCoordinate2D goalCoordinate;

@end

@implementation LOTChapter02TreeRouteViewController
@synthesize webView;
@synthesize userCoordiate;
@synthesize goalCoordinate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithMapRoute:(CLLocationCoordinate2D)theUserCoordinate goalCoordinate:(CLLocationCoordinate2D)theGoalCoordinate {
    self = [super initWithNibName:@"LOTChapter02TreeRouteViewController" bundle:[NSBundle bundleForClass:[LOTChapter02TreeRouteViewController class]]];
    userCoordiate = theUserCoordinate;
    goalCoordinate = theGoalCoordinate;
    return self;
}

- (void)dealloc
{
    [webView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&output=embed&z=14&&dirflg=w", userCoordiate.latitude, userCoordiate.longitude, goalCoordinate.latitude, goalCoordinate.longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    
    /*NSURL *apiUrl = [NSURL URLWithString:@"http://maps.google.com/maps?daddr=25.054606,121.548437&saddr=25.045792,121.546383&output=embed&z=14"];
    NSString *apiResponse = [NSString stringWithContentsOfURL:apiUrl];
    [webView loadHTMLString:apiResponse baseURL:nil];*/
    
    //street view
    /*NSString *htmlString = [NSString stringWithFormat:@"<html>\
							<head>\
							<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\">\
							<script src='http://maps.google.com/maps/api/js?sensor=false' type='text/javascript'></script>\
							</head>\
							<body onload=\"new google.maps.StreetViewPanorama(document.getElementById('p'),{position:new google.maps.LatLng(%f, %f)});\" style='padding:0px;margin:0px;'>\
							<div id='p' style='height:460;width:320;'></div>\
							</body>\
							</html>",25.054606,121.548437];
    [webView loadHTMLString:htmlString baseURL:nil];*/
    
    /*NSString *f = @"function directTo(str){"
    "directionsPanel = document.getElementById(\"route\");"
    "directions = new GDirections(map, directionsPanel);"
    "directions.load(str);"
    "}";
    
    NSString *s = @"from: 500 Memorial Drive, Cambridge, MA to: 4 Yawkey Way, Boston, MA 02215 (Fenway Park)";
    NSString *js = [NSString stringWithFormat:@"directTo(%@)", s];
    [webView stringByEvaluatingJavaScriptFromString:f];
    [webView stringByEvaluatingJavaScriptFromString:js];*/
    
    /*NSString *strIJs=[NSString stringWithFormat:@"<script src='http://maps.google.com/maps/api/js?sensor=false' type='text/javascript'></script>var map;"
					  "var directionsPanel;"
					  "var directions;"					  
					  "map = new oogle.maps.GMap2(document.getElementById('map_canvas'));"
					  "map.setUIToDefault();"
					  "var blueIcon = new oogle.maps.GIcon(G_DEFAULT_ICON);"
					  "blueIcon.image = \"http://appleautoglass.com/images/appleicon.gif\";"
					  "directionsPanel = document.getElementById('route');"
					  "directions = new google.maps.GDirections(map, directionsPanel);"
					  "directions.load('from: 500 Memorial Drive, Cambridge, MA to: 4 Yawkey Way, Boston, MA 02215 (Fenway Park)');"
					  "map.setCenter(new GLatLng(25.054606,121.548437), 9);"];
	[webView  stringByEvaluatingJavaScriptFromString:strIJs];*/
    
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
