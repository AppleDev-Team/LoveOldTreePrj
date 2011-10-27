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
#import <QuartzCore/QuartzCore.h>

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
    
    CALayer *messageLayer;
    CALayer *textLayer;
}

-(void)setLeaf;

-(void)upadteLeaf:(int)leafInt;

-(void)setFruit;

-(void)upadteFruit:(int)fruitInt;

-(void)lotMessage;

@end
