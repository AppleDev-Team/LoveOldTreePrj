//
//  SearchTreeData.h
//  XMLUse
//
//  Created by App on 2011/10/18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "XMLParser.h"
#import "XMLList.h"
#import "CoreDataBaseUse.h"
#import "TheTreesListInMap.h"
#import "Tools.h"

@interface SearchTreeData : NSObject{
    NSMutableArray *treeIndex;
    XMLParser *parser;
    TheTreesListInMap *treeDataListInMap;
}

@property(nonatomic,retain) NSMutableArray *dataArray;
@property (nonatomic, readwrite, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readwrite, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, readwrite, retain) TheTreesListInMap *treeDataListInMap;
-(id)searchUseTreeDataInMapOfInputLatitude:(double) treeLatitude inputLongitude:(double) treeLongitude;
-(id)searchTreeIndexOfInputTreeID:(NSString*)treeID;
-(void) pluckedTreeID:(NSString*) treeID;
-(void)updatdRound;
-(int)seedUseNumber;
-(int)leafUseNumber;
-(BOOL) canUseNextRound;
@end
