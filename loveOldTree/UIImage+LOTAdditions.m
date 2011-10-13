//
//  UIImage+LOTAdditions.m
//  loveOldTree
//
//  Created by  on 2011/10/7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIImage+LOTAdditions.h"

@implementation UIImage (LOTAdditions)

- (UIImage *) resizedImageWithSize:(CGSize)newSize {

    UIGraphicsBeginImageContext(newSize);
    
    [self drawInRect:(CGRect){ CGPointZero, newSize }];
    
    UIImage *returnedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return returnedImage;

}

@end
