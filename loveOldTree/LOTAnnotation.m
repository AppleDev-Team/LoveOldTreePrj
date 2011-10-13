//
//  MyAnnotation.m
//  loveOldTree
//
//  Created by  on 2011/10/7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LOTAnnotation.h"

@implementation LOTAnnotation
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

+ (id) annotationWithCoordinate:(CLLocationCoordinate2D)theCoordinate title:(NSString *)theTitle subtitle:(NSString *)theSubtitle {

    return [[[self alloc] initWithCoordinate:theCoordinate title:theTitle subtitle:theSubtitle] autorelease];

}

- (id) initWithCoordinate:(CLLocationCoordinate2D)theCoordinate title:(NSString *)theTitle subtitle:(NSString *)theSubTitle {
    
    self = [super init];
    if (!self)
        return nil;
    
    self.coordinate = theCoordinate;
    self.title = theTitle;
    self.subtitle = theSubTitle;
    
    return self;
    
}

- (void) dealloc {

    [title release];
    [subtitle release];
    [super dealloc];	

}

@end
