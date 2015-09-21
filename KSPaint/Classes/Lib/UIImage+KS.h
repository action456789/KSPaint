//
//  UIImage+Tool.h
//  KSTools
//
//  Created by KeSen on 15/9/11.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KS)

/**
 *  获取圆形带边框图片
 *
 *  @param name   图片的名称
 *  @param borderWidth 圆环的宽度
 *  @param borderColor  圆环的颜色
 *
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  截屏
 *
 *  @param view 需要截屏的视图
 *
 */
+ (instancetype)imageWithCaptureView:(UIView *)view;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

@end
