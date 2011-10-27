//
//  ChapterOne.h
//  loveOldTree
//
//  Created by  on 11/10/3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOTLeaf.h"
#import "LOTFruit.h"
#import "SearchTreeData.h"

@interface LOTChapter01ViewController : UIViewController  <UIAccelerometerDelegate>
{
    NSString *accelY;
    UIImageView *myTree;
    CGAffineTransform treeTransform;
    UIImageView *myBg;
    UIImageView *myMountainfFront;
    CGAffineTransform mountainfFrontTransform;
    UIImageView *myMountainfBack;
    CGAffineTransform mountainfBackTransform;
    UIImageView *myLeaf;
    UIImageView *myFruit;
    UIImageView *mySeedTitle;
    
    UIDevice *device;

    NSArray *leafXYArray;
    NSArray *leafFlipArray;
    
    NSArray *fruitXYArray;
}

-(void)setLeaf;

-(void)upadteLeaf:(int)leafInt;

-(void)setFruit;

-(void)upadteFruit:(int)fruitInt;

-(void)lotMessage;

@end
