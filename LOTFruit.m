//
//  LOTFruit.m
//  loveOldTree
//
//  Created by Hanpo on 11/10/22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LOTFruit.h"

@implementation LOTFruit

static int fruitCount = 0;

- (id)initWithFrame:(CGRect)frame
{
    if (fruitCount>7) fruitCount=0;
    fruitCount++;
    self = [super initWithFrame:frame];
    if (self) {
        UIImage* seed01 =  [UIImage imageNamed:@"seed01.png"];
        UIImage* seed02 =  [UIImage imageNamed:@"seed02.png"];
        UIImage* seed03 =  [UIImage imageNamed:@"seed03.png"];
        UIImage* seed04 =  [UIImage imageNamed:@"seed04.png"];
        UIImage* seed05 =  [UIImage imageNamed:@"seed05.png"];
        UIImage* seed06 =  [UIImage imageNamed:@"seed06.png"];
        UIImage* seed07 =  [UIImage imageNamed:@"seed07.png"];
        UIImage* seed08 =  [UIImage imageNamed:@"seed08.png"];
        
        switch (fruitCount) {
            case 1:
                [self setImage:seed01];
                break;
            case 2:
                [self setImage:seed02];
                break;
            case 3:
                [self setImage:seed03];
                break;
            case 4:
                [self setImage:seed04];
                break;
            case 5:
                [self setImage:seed05];
                break;
            case 6:
                [self setImage:seed06];
                break;
            case 7:
                [self setImage:seed07];
                break;
            case 8:
                [self setImage:seed08];
                break;
            default:
                break;
        }
        
        
        self.opaque = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
