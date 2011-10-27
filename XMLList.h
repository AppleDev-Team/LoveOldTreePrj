//
//  XMLList.h
//  XMLUse
//
//  Created by yimyo on 2011/10/10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMLList : NSObject {
	// <title>
	NSString *treeID;
	// <description>
	NSString *treeKind;
	// <link>
	NSString *treeAddress;
    
    NSString *treeLongitude;
    
    NSString *treeLatitude;
    
    NSString *treeManagement;   //樹木管理者
    NSString *treeHight;        //樹木高度
    NSString *treeSoutce;       //樹木原生種
    NSString *treeAge;          //樹木年紀
    NSString *treeShape;        //樹形
    NSString *treeBust;         //樹圍
    NSString *treeLocation;     //樹木所在區域類型
    NSString *treeBackground;   //樹木背景資訊
    BOOL treePluck;
}


@property(nonatomic,retain)NSString *treeID;
@property(nonatomic,retain)NSString *treeKind;
@property(nonatomic,retain)NSString *treeAddress;
@property(nonatomic,retain)NSString *treeLongitude;
@property(nonatomic,retain)NSString *treeLatitude;
@property(nonatomic,retain)NSString *treeManagement;   
@property(nonatomic,retain)NSString *treeHight;        
@property(nonatomic,retain)NSString *treeSoutce;       
@property(nonatomic,retain)NSString *treeAge;          
@property(nonatomic,retain)NSString *treeShape;        
@property(nonatomic,retain)NSString *treeBust;         
@property(nonatomic,retain)NSString *treeLocation;     
@property(nonatomic,retain)NSString *treeBackground;   

@end
