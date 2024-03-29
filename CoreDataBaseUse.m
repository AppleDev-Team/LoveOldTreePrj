//
//  CoreDataBaseUse.m
//  XMLUse
//
//  Created by App on 2011/10/13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CoreDataBaseUse.h"

//自定UserDefault的名稱
NSString * const kCoreDataBaseUse_DidImportData = @"kCoreDataBaseUse_DidImportData";
//NSString * const kLeafNumber = @"kLeafNumber";
//NSString * const kUserRound = @"kUserRound";

@interface CoreDataBaseUse ()

@property (nonatomic, readwrite, retain) NSPersistentStoreCoordinator *coordinator;

@end

@implementation CoreDataBaseUse
@synthesize coordinator;

+ (id) sharedDataStore 
{
    
	static __typeof__(self) returnedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^ {
		returnedInstance = [[self alloc] init];
	});
	//[[self alloc] init];
	return returnedInstance;
    
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    //建立coreData資料庫
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TreeModle" withExtension:@"momd"];
    NSManagedObjectModel *model = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] autorelease];
    
	NSString *documentDirectory =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSURL *storeURL = [NSURL fileURLWithPath:[documentDirectory stringByAppendingPathComponent:@"TreeModle.sqlite"]];
	
	self.coordinator = [[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model] autorelease];
	
    
	NSError *storeAddingError = nil;
	if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,[NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,nil] error:&storeAddingError]) {
		NSLog(@"storeAddingError %@", storeAddingError);
	}
    
    //建立使用者初始本機資料
    BOOL hasImportedData = [[NSUserDefaults standardUserDefaults] boolForKey:kCoreDataBaseUse_DidImportData];
	
    if (!hasImportedData) {
        [self setXMLData];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kCoreDataBaseUse_DidImportData];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"kLeafNumber"];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"kUserSeedsNumber"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kUserRound"];
    }
    return self;
}

-(void)dealloc
{
    [coordinator release];
	[super dealloc];
}

//產生NSManagedObjectContext
- (NSManagedObjectContext *) disposableMOC 
{
    
	NSManagedObjectContext *context = [[[NSManagedObjectContext alloc] init] autorelease];
    
	[context setPersistentStoreCoordinator:self.coordinator];
    
	return context;
    
}

-(void) setXMLData
{
    NSManagedObjectContext *context = [[[NSManagedObjectContext alloc] init] autorelease];
    [context setPersistentStoreCoordinator:self.coordinator];
  
    
    NSMutableArray *treeIndex;
    //產生用來解析ＸＭＬ的物件
    XMLParser *parser;
    
    NSData *mydata = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Tree_Test_Data.xml"]];
    parser = [[XMLParser alloc]initWrithData:mydata]; 
	treeIndex = [parser result];
    
    //利用回全寫入CoreData資料庫
    for (int i = 0; i < [treeIndex count]; i++) {
            NSManagedObject *savedPerson = [[[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"Tree" inManagedObjectContext:context] insertIntoManagedObjectContext:context] autorelease];
        
            XMLList *index = [treeIndex objectAtIndex:i];
        
            [savedPerson setValue:index.treeID forKey:@"tree_id"];
            [savedPerson setValue:index.treeKind forKey:@"tree_kind"];
            [savedPerson setValue:index.treeLongitude forKey:@"longitude"];
            [savedPerson setValue:index.treeLatitude forKey:@"latitude"];
            [savedPerson setValue:index.treeAddress forKey:@"tree_address"];
            [savedPerson setValue:index.treeManagement forKey:@"management"];
            [savedPerson setValue:index.treeHight forKey:@"hight"];
            [savedPerson setValue:index.treeSoutce forKey:@"soutce"];
            [savedPerson setValue:index.treeAge forKey:@"age"];
            [savedPerson setValue:index.treeShape forKey:@"shape"];
            [savedPerson setValue:index.treeBust forKey:@"bust"];
            [savedPerson setValue:index.treeLocation forKey:@"location"];
            [savedPerson setValue:index.treeBackground forKey:@"background"];
            [savedPerson setValue:[NSNumber numberWithBool:YES] forKey:@"pluck"];
            NSError *savingError = nil;
            if (![context save:&savingError])
                NSLog(@"Error saving: %@", savingError);
        
            [index release];

        }
}

@end
