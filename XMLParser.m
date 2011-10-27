//
//  XMLParser.m
//  XMLUse
//
//  Created by yimyo on 2011/10/10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"


@implementation XMLParser

-(id)initWrithData:(NSData*) data{
   
    self = [self init];
    NSXMLParser *parser = [[[NSXMLParser alloc]initWithData:data]autorelease];
    treeItems = [[NSMutableArray alloc]init];
    parser.delegate = self;
    [parser parse];
    idFound = NO;
    kindFound = NO;
    addressFound = NO;
    
    return self;
}

-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString  *) qName attributes:(NSDictionary *) attributeDict
{
    if(itemFound){
        if([elementName isEqualToString:@"TREE_ID"]){
            idFound = YES;
        }else if([elementName isEqualToString:@"TREE_KIND"]){
            kindFound = YES;
        }else if([elementName isEqualToString:@"TREE_MANAGEMENT_UNIT"]){
            managementFound = YES;
        }else if([elementName isEqualToString:@"TREE_HIGH"]){
            hightFound = YES;
        }else if([elementName isEqualToString:@"TREE_SOUTCE"]){
            soutceFound = YES;
        }else if([elementName isEqualToString:@"TREE_AGE"]){
            ageFound = YES;
        }else if([elementName isEqualToString:@"TREE_SHAPE"]){
            shapeFound = YES;
        }else if([elementName isEqualToString:@"TREE_BUST"]){
            bustFound = YES;
        }else if([elementName isEqualToString:@"TREE_Location"]){
            locationFound = YES;
        }else if([elementName isEqualToString:@"TREE_Background"]){
            backgroundFound = YES;
        }else if([elementName isEqualToString:@"TREE_XADDRESS"]){
            addressFound = YES;
        }else if([elementName isEqualToString:@"TREE_LATITUDE"]){
            latitudeFound  = YES;
        }else if([elementName isEqualToString:@"TREE_LONGITUDE"]){
            longitudeFound = YES;
        }
    }
    if([elementName isEqualToString:@"TreeIndex"]){
        itemFound = YES;
    }
}

-(void) parser:(NSXMLParser *) parser didEndElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString  *) qName
{
    
    if([elementName isEqualToString:@"TreeIndex"]){
        itemFound = NO;
    }
    if(itemFound){
        if([elementName isEqualToString:@"TREE_ID"]){
            idFound = NO;
        }else if([elementName isEqualToString:@"TREE_KIND"]){
            kindFound = NO;
        }else if([elementName isEqualToString:@"TREE_MANAGEMENT_UNIT"]){
            managementFound = NO;
        }else if([elementName isEqualToString:@"TREE_HIGH"]){
            hightFound = NO;
        }else if([elementName isEqualToString:@"TREE_SOUTCE"]){
            soutceFound = NO;
        }else if([elementName isEqualToString:@"TREE_AGE"]){
            ageFound = NO;
        }else if([elementName isEqualToString:@"TREE_SHAPE"]){
            shapeFound = NO;
        }else if([elementName isEqualToString:@"TREE_BUST"]){
            bustFound = NO;
        }else if([elementName isEqualToString:@"TREE_Location"]){
            locationFound = NO;
        }else if([elementName isEqualToString:@"TREE_Background"]){
            backgroundFound = NO;
        }else if([elementName isEqualToString:@"TREE_XADDRESS"]){
            addressFound = NO;
        }else if([elementName isEqualToString:@"TREE_LATITUDE"]){
            latitudeFound  = NO;
        }else if([elementName isEqualToString:@"TREE_LONGITUDE"]){
            longitudeFound = NO;
        }
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(itemFound){
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if([string length]==0){
            return;
        }
        if(idFound){
            treeID = string;
            //NSLog(@"ID %@",string);
        }
        if(kindFound){
            treeKind = string;
            //NSLog(@"Kind %@",string);
        }
        if(managementFound){
            treeManagement = string;
            //NSLog(@"Man %@",string);
        }
        if(hightFound){
            treeHight = string;
            //NSLog(@"hight %@",string);
        }
        if(soutceFound){
            treeSoutce = string;
            //NSLog(@"sou %@",string);
        }
        if(ageFound){
            treeAge = string;
            //NSLog(@"age %@",string);
        }
        if(shapeFound){
            treeShape = string;
            //NSLog(@"sha %@",string);
        }
        if(bustFound){
            treeBust = string;
            //NSLog(@"bus %@",string);
        }
        
        if(locationFound){
            treeLocation = string;
            //NSLog(@"location %@",string);
        }
        if(backgroundFound){
            treeBackground = string;
        }
         if(addressFound){
            treeAddress = string;
        }
        if(latitudeFound){
            //treeLongitude = [NSNumber numberWithInteger: [string integerValue]];
            treeLatitude = string;
        }     
        if(longitudeFound){
            XMLList *list = [[XMLList alloc]init];
            list.treeID = treeID;
            list.treeKind = treeKind;
            list.treeLongitude = string;
            list.treeLatitude = treeLatitude;
            list.treeManagement = treeManagement;
            list.treeHight = treeHight;
            list.treeSoutce = treeSoutce;
            list.treeAge = treeAge;
            list.treeShape = treeShape;
            list.treeBust = treeBust;
            list.treeLocation = treeLocation;
            list.treeAddress = treeAddress;
            list.treeBackground = treeBackground;
            [treeItems addObject:list];
            [list release];
        }
        
    }
}

-(NSMutableArray *)result
{
    return treeItems;
}

-(void) dealloc
{
    [super dealloc];
    [treeItems release];
}
@end
