//
//  SearchTreeData.m
//  XMLUse
//
//  Created by App on 2011/10/18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchTreeData.h"
//NSString * const kLeafNumber = @"kLeafNumber";
@implementation SearchTreeData

@synthesize dataArray,managedObjectContext, fetchedResultsController, treeDataListInMap;

- (id)init
{
    self = [super init];
    
    
    if (self) {
        dataArray = [[NSMutableArray alloc]init];
        treeDataListInMap = [[[TheTreesListInMap alloc]init]autorelease];
        managedObjectContext = [[[CoreDataBaseUse sharedDataStore] disposableMOC] retain];
    }
    
    return self;
}



//----------給定為點坐標的資料,回傳所有可以拔葉子的樹木資料----------
-(id)searchUseTreeDataInMapOfInputLatitude:(double) treeLatitude inputLongitude:(double) treeLongitude
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
     
    [request setEntity:[NSEntityDescription entityForName:@"Tree" inManagedObjectContext:self.managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"pluck == YES"]];
    [request setSortDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"tree_id" ascending:YES],nil]];
    [request setReturnsObjectsAsFaults:NO];
    
    NSArray  *searchDataArray= [self.managedObjectContext executeFetchRequest:request error:nil];
   
    
    for (int i=0; i<[searchDataArray count]; i++) {
        
        NSManagedObject *personEntity = [searchDataArray objectAtIndex:i];    
        TheTreesListInMap *treelist = [[[TheTreesListInMap alloc]init]autorelease];
        
        NSString *lat = [personEntity valueForKey:@"latitude"];
        NSString *longti = [personEntity valueForKey:@"longitude"];
        
        double distance = [Tools cal2pointWithlatitude1:[lat doubleValue] longitude1:[longti doubleValue] latitude2:treeLatitude longitude2:treeLongitude];
        NSString *SD = [[NSString alloc]initWithFormat:@"%f",distance];
        
        treelist.treeID = [personEntity valueForKey:@"tree_id"];
        treelist.treeName = [personEntity valueForKey:@"tree_id"];
        treelist.treeDistance = SD;
        treelist.treeLongitude = [personEntity valueForKey:@"longitude"];
        treelist.treeLatitude = [personEntity valueForKey:@"latitude"];
        
        [dataArray addObject:treelist];
        
    }
    
    return dataArray;
}

//----------給樹木的ＩＤ,給樹木所有的資料----------
-(id)searchTreeIndexOfInputTreeID:(NSString*)treeID
{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
     
    [request setEntity:[NSEntityDescription entityForName:@"Tree" inManagedObjectContext:self.managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"tree_id == %@",treeID]];
    
    NSArray  *searchDataArray= [self.managedObjectContext executeFetchRequest:request error:nil];
    NSManagedObject *personEntity = [searchDataArray objectAtIndex:0];
    
    TheTreesListInMap *treelist = [[[TheTreesListInMap alloc]init]autorelease];    
    treelist.treeID = treeID;
    treelist.treeName = treeID;        
    treelist.treeAddress = [personEntity valueForKey:@"tree_address"];
    treelist.treeKind =  [personEntity valueForKey:@"tree_kind"];
    treelist.treeManagement = [personEntity valueForKey:@"management"];
    treelist.treeHight = [personEntity valueForKey:@"hight"];
    treelist.treeSoutce = [personEntity valueForKey:@"soutce"];
    treelist.treeAge = [personEntity valueForKey:@"age"];
    treelist.treeShape = [personEntity valueForKey:@"shape"];
    treelist.treeBust = [personEntity valueForKey:@"bust"];
    treelist.treeLocation = [personEntity valueForKey:@"location"];
    treelist.treeBackground = [personEntity valueForKey:@"background"];
    return treelist;
    
}

//----------給樹的ＩＤ拔樹葉----------
-(void) pluckedTreeID:(NSString*) treeID
{
    //int leafNumber = [self leafUseNumber];
    if ([self canUseNextRound]) {
  
        NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
     
        [request setEntity:[NSEntityDescription entityForName:@"Tree" inManagedObjectContext:self.managedObjectContext]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"tree_id == %@",treeID]];
    
        NSArray  *searchDataArray= [self.managedObjectContext executeFetchRequest:request error:nil];
        NSManagedObject *personEntity = [searchDataArray objectAtIndex:0];
        if([[personEntity valueForKey:@"pluck"]isEqualToNumber:[NSNumber numberWithBool:YES]]){
        
            [personEntity setValue:[NSNumber numberWithBool:NO] forKey:@"pluck"];
    
            NSError *savingError = nil;
            if (![self.managedObjectContext save:&savingError])
                NSLog(@"Error saving: %@", savingError);
            NSInteger userLeaf = [[NSUserDefaults standardUserDefaults]integerForKey:@"kLeafNumber"];
            userLeaf += 1;
            [[NSUserDefaults standardUserDefaults] setInteger:userLeaf forKey:@"kLeafNumber"];
        
            if (userLeaf == 20) {
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kUserRound"];
            }
        }
    }
}

//------------讀取目前樹葉數目 種子數目---------
-(int)seedUseNumber
{
    NSInteger seedNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"kUserSeedsNumber"];
    return seedNumber;
}

-(int)leafUseNumber
{
    NSInteger leafNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"kLeafNumber"];
    return leafNumber;
}

-(BOOL) canUseNextRound
{
    Boolean nexRoundTest = [[NSUserDefaults standardUserDefaults]boolForKey:@"kUserRound"];
    return nexRoundTest;
}
//---------UPData回合樹跟葉子---------
-(void)updatdRound
{
    int round = [[NSUserDefaults standardUserDefaults] integerForKey:@"kUserSeedsNumber"];
    round += 1;
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"kLeafNumber"];
    [[NSUserDefaults standardUserDefaults] setInteger:round forKey:@"kUserSeedsNumber"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kUserRound"];
    
    //
    
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:[NSEntityDescription entityForName:@"Tree" inManagedObjectContext:self.managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"pluck == NO"]];
    
    NSArray  *searchDataArray= [self.managedObjectContext executeFetchRequest:request error:nil];
    for (int i=0; i<[searchDataArray count]; i++) {
        
        NSManagedObject *personEntity = [searchDataArray objectAtIndex:i];    
        
        [personEntity setValue:[NSNumber numberWithBool:YES] forKey:@"pluck"];
        
        NSError *savingError = nil;
        if (![self.managedObjectContext save:&savingError])
            NSLog(@"Error saving: %@", savingError);        
    }
    
}
//--------獲得種子,葉子數目---------


-(void)dealloc{

    [managedObjectContext release];
    [fetchedResultsController release];
    [dataArray release];
    [super dealloc];
    
}

@end
