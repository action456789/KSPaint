//
//  KSPaintBezierPath.m
//  KSPaint
//
//  Created by KeSen on 15/8/6.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "KSPaintBezierPath.h"

@implementation KSPaintBezierPath

+ (instancetype)paintBezierPathWithColor:(UIColor *)pathColor lineWidth:(CGFloat)pathWidth startPoint:(CGPoint)startPoint {
    KSPaintBezierPath *path = [[KSPaintBezierPath alloc] init];
    [path moveToPoint:startPoint];
    path.pathColor = pathColor;
    path.pathWidth = pathWidth;
    return path;
}

@end
