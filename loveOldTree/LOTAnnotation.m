//
//  MyAnnotation.m
//  loveOldTree
//
//  Created by  on 2011/10/7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LOTAnnotation.h"

@implementation LOTAnnotation

@synthesize image;
@synthesize title;
@synthesize subtitle;
@synthesize coordinate;
@synthesize userCoordinate;
@synthesize treeId;
@synthesize treeDistance;
@synthesize treeKind;
@synthesize treeAddress;
@synthesize treeHeight;
@synthesize treeSource;
@synthesize treeAge;
@synthesize treeShape;
@synthesize treeBust;
@synthesize treeLocation;
@synthesize treeBackground;
@synthesize treeManagement;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
    }
    
    return self;
}

-(id)initWithRootView:(NSString *)theTitle subtitle:(NSString *)theSubTitle coordinate:(CLLocationCoordinate2D)theCoordinate userCoordinate:(CLLocationCoordinate2D)theUserCoordinate treeId:(NSString *)theTreeId treeDistance:(NSString *)theTreeDistance {
   self = [super init];
    if (self) {
        coordinate = theCoordinate;
        userCoordinate = theUserCoordinate;
        [self setTitle:[NSString stringWithFormat:@"老木編號 %@", theTitle]];
        
        double dValue = [theSubTitle doubleValue];
        [self setSubtitle:[NSString stringWithFormat:@"距離 %.1f M", dValue]];
        [self setTreeId:theTreeId];
        [self setTreeDistance:theTreeDistance];
    }
    return self;
}

-(id)initWithLocationTitle:(NSString *)theTitle subtitle:(NSString *)theSubTitle coordinate:(CLLocationCoordinate2D)theCoordinate userCoordinate:(CLLocationCoordinate2D)theUserCoordinate treeId:(NSString *)theTreeId treeKind:(NSString *)theTreeKind treeDistance:(NSString *)theTreeDistance treeAddress:(NSString *)theTreeAddress treeHeight:(NSString *)theTreeHeight treeSource:(NSString *)theTreeSource treeAge:(NSString *)theTreeAge treeShape:(NSString *)theTreeShape treeBust:(NSString *)theTreeBust treeLocation:(NSString *)theTreeLocation treeBackground:(NSString *)theTreeBackground treeManagement:(NSString *)theTreeManagement {

    self = [super init];
    if (self) {
        coordinate = theCoordinate;
        userCoordinate = theUserCoordinate;
        [self setTitle:[NSString stringWithFormat:@"老木編號 %@", theTitle]];
        
        double dValue = [theSubTitle doubleValue];
        [self setSubtitle:[NSString stringWithFormat:@"距離 %.1f M", dValue]];
        [self setTreeId:theTreeId];
        [self setTreeDistance:theTreeDistance];
        [self setTreeKind:theTreeKind];
        [self setTreeAddress:theTreeAddress];
        [self setTreeHeight:theTreeHeight];
        [self setTreeSource:theTreeSource];
        [self setTreeAge:theTreeAge];
        [self setTreeShape:theTreeShape];
        [self setTreeBust:theTreeBust];
        [self setTreeLocation:theTreeLocation];
        [self setTreeBackground:theTreeBackground];
        [self setTreeManagement:theTreeManagement];
    }
    return self;
}

-(void)dealloc {
    [title release];
    [subtitle release];
    [treeId release];
    [treeDistance release];
    [treeKind release];
    [treeAddress release];
    [treeHeight release];
    [treeSource release];
    [treeAge release];
    [treeShape release];
    [treeBust release];
    [treeLocation release];
    [treeBackground release];
    [treeManagement release];
    [super dealloc];
}

@end
