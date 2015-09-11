//
//  KSPaintPath.m
//  KSPaint
//
//  Created by KeSen on 15/9/10.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "KSPaintPath.h"

@implementation KSPaintPath

+ (instancetype)paintpathWithBezierpath:(UIBezierPath *)path color:(UIColor *)color {
    KSPaintPath *paintPath = [[KSPaintPath alloc] init];
    paintPath.pathColor = color;
    paintPath.bezierPath = path;
    return paintPath;
}

@end