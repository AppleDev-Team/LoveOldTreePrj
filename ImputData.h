//
//  ImputData.h
//  XMLUse
//
//  Created by App on 2011/10/17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataBaseUse.h"
@interface ImputData : NSObject
+(void)addUserTreeData:(NSString*)treeID addRound:(NSString*)userRound;
@end
