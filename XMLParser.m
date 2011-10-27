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
        }else if([elementName isEqualToString:@"TREE_XADDRESS"]){
            addressFound = YES;
        }else if([elementName isEqualToString:@"TREE_KIND"]){
            kindFound = YES;
        }else if([elementName isEqualToString:@"TREE_LATITUDE"]){
            latitudeFound  = YES;
        }else if([elementName isEqualToString:@"TREE_LONGITUDE"]){
            longitudeFound = YES;
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
        }else if([elementName isEqualToString:@"TREE_XADDRESS"]){
            addressFound = NO;
        }else if([elementName isEqualToString:@"TREE_KIND"]){
            kindFound = NO;
        }else if([elementName isEqualToString:@"TREE_LATITUDE"]){
           latitudeFound = NO;
        }else if([elementName isEqualToString:@"TREE_LONGITUDE"]){
            longitudeFound = NO;
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
        }
        if(addressFound){
            treeAddress = string;
        }
        if(kindFound){
            treeKind = string;
        }
        if(longitudeFound){
            //treeLongitude = [NSNumber numberWithInteger: [string integerValue]];
            treeLongitude = string;
        }
        if (latitudeFound) {
            //treeLatitude = [NSNumber numberWithInteger: [string integerValue]];
            treeLatitude = string;
        }
        if(managementFound){
            treeManagement = string;
        }
        if(hightFound){
            treeHight = string;
        }
        if(soutceFound){
            treeSoutce = string;
        }
        if(ageFound){
            treeAge = string;
        }
        if(shapeFound){
            treeShape = string;
        }
        if(bustFound){
            treeBust = string;
        }
        if(locationFound){
            treeLocation = string;
        }
        if(backgroundFound){
            
            XMLList *list = [[XMLList alloc]init];
            list.treeID = treeID;
            list.treeKind = treeKind;
            list.treeLongitude = treeLongitude;
            list.treeLatitude = treeLatitude;
            list.treeAddress = string;
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
