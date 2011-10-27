//
//  MyAnnotation.h
//  loveOldTree
//
//  Created by  on 2011/10/7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LOTAnnotation : NSObject <MKAnnotation> {
    UIImage *image;
    NSString *title;
    NSString *subtitle;
    NSString *treeId;
    NSString *treeDistance;
    NSString *treeKind;
    NSString *treeAddress;
    NSString *treeHeight;
    NSString *treeSource;
    NSString *treeAge;
    NSString *treeShape;
    NSString *treeBust;
    NSString *treeLocation;
    NSString *treeBackground;
    NSString *treeManagement;
    CLLocationCoordinate2D coordinate;
    CLLocationCoordinate2D userCoordinate;
}

@property (nonatomic, retain) UIImage *image;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *subtitle;
@property(nonatomic, copy)NSString *treeId;
@property(nonatomic, copy)NSString *treeDistance;
@property(nonatomic, copy)NSString *treeKind;
@property(nonatomic, copy)NSString *treeAddress;
@property(nonatomic, copy)NSString *treeHeight;
@property(nonatomic, copy)NSString *treeSource;
@property(nonatomic, copy)NSString *treeAge;
@property(nonatomic, copy)NSString *treeShape;
@property(nonatomic, copy)NSString *treeBust;
@property(nonatomic, copy)NSString *treeLocation;
@property(nonatomic, copy)NSString *treeBackground;
@property(nonatomic, copy)NSString *treeManagement;

@property(nonatomic, readonly)CLLocationCoordinate2D coordinate;
@property(nonatomic, readonly)CLLocationCoordinate2D userCoordinate;

-(id)initWithRootView:(NSString *)theTitle subtitle:(NSString *)theSubTitle coordinate:(CLLocationCoordinate2D)theCoordinate userCoordinate:(CLLocationCoordinate2D)theUserCoordinate treeId:(NSString *)theTreeId treeDistance:(NSString *)theTreeDistance;

-(id)initWithLocationTitle:(NSString *)theTitle subtitle:(NSString *)theSubTitle coordinate:(CLLocationCoordinate2D)theCoordinate userCoordinate:(CLLocationCoordinate2D)theUserCoordinate treeId:(NSString *)theTreeId treeKind:(NSString *)theTreeKind treeDistance:(NSString *)theTreeDistance treeAddress:(NSString *)theTreeAddress treeHeight:(NSString *)theTreeHeight treeSource:(NSString *)theTreeSource treeAge:(NSString *)theTreeAge treeShape:(NSString *)theTreeShape treeBust:(NSString *)theTreeBust treeLocation:(NSString *)theTreeLocation treeBackground:(NSString *)theTreeBackground treeManagement:(NSString *)theTreeManagement;

@end
