//
//  XMLParser.h
//  XMLUse
//
//  Created by yimyo on 2011/10/10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLList.h"

@interface XMLParser : NSObject <NSXMLParserDelegate>{ 
    BOOL idFound;
    BOOL kindFound;
    BOOL addressFound;
    BOOL longitudeFound;
    BOOL latitudeFound;
    BOOL managementFound;
    BOOL hightFound;
    BOOL soutceFound;
    BOOL ageFound;
    BOOL shapeFound;
    BOOL bustFound;
    BOOL locationFound;
    BOOL backgroundFound;
    BOOL itemFound;
    
    NSString *treeID;
    NSString *treeKind;
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
    
    NSMutableArray *treeItems;
}
-(id)initWrithData:(NSData*) data;
-(NSMutableArray *)result;
@end
