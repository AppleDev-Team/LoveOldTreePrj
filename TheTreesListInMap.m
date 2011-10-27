//
//  TheTreesListInMap.m
//  XMLUse
//
//  Created by App on 2011/10/20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TheTreesListInMap.h"

@implementation TheTreesListInMap

@synthesize treeID,treeName,treeDistance,treeLongitude,treeLatitude,treeAddress,treeKind,treeManagement,treeHight,treeSoutce,treeAge,treeShape,treeBust,treeLocation,treeBackground; 

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}


-(void)dealloc
{
    [super dealloc];
    [treeID release];
    [treeName release];
    [treeDistance release];
    [treeLatitude release];
    [treeLongitude release];
    
    [treeAddress release];      //樹木地址
    [treeKind release];         //樹木種類
    [treeManagement release];   //樹木管理者
    [treeHight release];        //樹木高度
    [treeSoutce release];       //樹木原生種
    [treeAge release];          //樹木年紀
    [treeShape release];        //樹形
    [treeBust release];         //樹圍
    [treeLocation release];     //樹木所在區域類型
    [treeBackground release];   //樹木背景資訊
    
}
@end
