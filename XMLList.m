//
//  XMLList.m
//  XMLUse
//
//  Created by yimyo on 2011/10/10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "XMLList.h"


@implementation XMLList


@synthesize treeID;
@synthesize treeKind;
@synthesize treeAddress;
@synthesize treeLatitude;
@synthesize treeLongitude;
@synthesize treeManagement;   
@synthesize treeHight;        
@synthesize treeSoutce;       
@synthesize treeAge;          
@synthesize treeShape;        
@synthesize treeBust;         
@synthesize treeLocation;     
@synthesize treeBackground;   

-(void)dealloc{
    [treeID release];
    [treeKind release];
    [treeAddress release];
    [treeLongitude release];
    [treeLatitude release];
    [treeManagement release];   
    [treeHight release];        
    [treeSoutce release];       
    [treeAge release];          
    [treeShape release];        
    [treeBust release];         
    [treeLocation release];     
    [treeBackground release];
    [super dealloc];
}
@end
