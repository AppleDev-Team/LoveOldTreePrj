//
//  LOTLeaf.m
//  loveOldTree
//
//  Created by Hanpo on 11/10/18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LOTLeaf.h"

@implementation LOTLeaf

static int treeCount = 0;

- (id)initWithFrame:(CGRect)frame
{
    if (treeCount>19) treeCount=0;
    treeCount++;
    self = [super initWithFrame:frame];
    if (self) {
        UIImage* normalImage =  [UIImage imageNamed:@"leaf.png"];
        UIImage* flippedImage = [UIImage imageWithCGImage:normalImage.CGImage scale:1.0 orientation: UIImageOrientationUpMirrored];
        if (treeCount==1||treeCount==3||treeCount==5||treeCount==7||treeCount==9||treeCount==10||treeCount==11||treeCount==16||treeCount==18) {
            [self setImage:flippedImage];
        } else {
            [self setImage:normalImage];
        }
        
        
        self.opaque = YES;
    }
    return self;
}



@end
