//
//  KSPaintPath.h
//  KSPaint
//
//  Created by KeSen on 15/9/10.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSPaintPath : NSObject

@property (nonatomic, strong) UIColor *pathColor;

@property (nonatomic, strong) UIBezierPath *bezierPath;

+ (instancetype)paintpathWithBezierpath:(UIBezierPath *)path color:(UIColor *)color;

@end
