//
//  TheTreesListInMap.h
//  XMLUse
//
//  Created by App on 2011/10/20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TheTreesListInMap : NSObject
{
    NSString *treeID;           //樹ID
    NSString *treeName;         //樹名
    NSString *treeDistance;     //樹木距離
    NSString *treeLongitude;    //樹木經度（大的）
    NSString *treeLatitude;     //樹木緯度（小的）
    
    NSString *treeAddress;      //樹木地址
    NSString *treeKind;         //樹木種類
    NSString *treeManagement;   //樹木管理者
    NSString *treeHight;        //樹木高度
    NSString *treeSoutce;       //樹木原生種
    NSString *treeAge;          //樹木年紀
    NSString *treeShape;        //樹形
    NSString *treeBust;         //樹圍
    NSString *treeLocation;     //樹木所在區域類型
    NSString *treeBackground;   //樹木背景資訊
}

@property(nonatomic,retain,readwrite) NSString *treeID;
@property(nonatomic,retain,readwrite) NSString *treeName;
@property(nonatomic,retain,readwrite)NSString *treeDistance;
@property(nonatomic,retain,readwrite)NSString *treeLongitude;
@property(nonatomic,retain,readwrite)NSString *treeLatitude;

@property(nonatomic,retain,readwrite)NSString *treeAddress;      //樹木地址
@property(nonatomic,retain,readwrite)NSString *treeKind;         //樹木種類
@property(nonatomic,retain,readwrite)NSString *treeManagement;   //樹木管理者
@property(nonatomic,retain,readwrite)NSString *treeHight;        //樹木高度
@property(nonatomic,retain,readwrite)NSString *treeSoutce;       //樹木原生種
@property(nonatomic,retain,readwrite)NSString *treeAge;          //樹木年紀
@property(nonatomic,retain,readwrite)NSString *treeShape;        //樹形
@property(nonatomic,retain,readwrite)NSString *treeBust;         //樹圍
@property(nonatomic,retain,readwrite)NSString *treeLocation;     //樹木所在區域類型
@property(nonatomic,retain,readwrite)NSString *treeBackground;   //樹木背景資訊   

@end
