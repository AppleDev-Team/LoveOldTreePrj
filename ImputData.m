//
//  ImputData.m
//  XMLUse
//
//  Created by App on 2011/10/17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ImputData.h"

@implementation ImputData

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(void)addUserTreeData:(NSString*)treeID addRound:(NSString*)userRound
{
    
    //NSInteger userRound = [[NSUserDefaults standardUserDefaults]integerForKey:kCoreDataBaseUse_DidImportData];
    
    //NSInteger thisUserRound = [[NSUserDefaults standardUserDefaults]integerForKey:kCoreDataBaseUse_DidImportData];
    
    //NSLog(@"UserRound  %i",thisUserRound);
    
    NSManagedObjectContext *context = [[CoreDataBaseUse sharedDataStore] disposableMOC];
	
    NSManagedObject *savedPerson = [[[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"UserImport" inManagedObjectContext:context] insertIntoManagedObjectContext:context] autorelease];
    
    [savedPerson setValue:treeID forKey:@"TREE_ID"];
    //[savedPerson setValue:userRound forKey:@"UseRound"];
    
    NSError *savingError = nil;
    if (![context save:&savingError])
        NSLog(@"Error saving: %@", savingError);
	
    //[contactAddVC.navigationController dismissModalViewControllerAnimated:YES];
}

@end
