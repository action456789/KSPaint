//
//  KSPaintBezierPath.h
//  KSPaint
//
//  Created by KeSen on 15/8/6.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSPaintBezierPath : UIBezierPath
/**
 *  路径宽度
 */
@property (nonatomic, assign) CGFloat pathWidth;
/**
 *  路径颜色
 */
@property (nonatomic, strong) UIColor *pathColor;
/**
 *  路径起点
 */
@property (nonatomic, assign) CGPoint startPoint;



+ (instancetype)paintBezierPathWithColor:(UIColor * )pathColor lineWidth:(CGFloat)pathWidth startPoint:(CGPoint)startPoint;



@end
