//
//  KSPaint.h
//  KSPaint
//
//  Created by KeSen on 15/8/26.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#ifndef KSPaint_KSPaint_h
#define KSPaint_KSPaint_h
#import "Colours.h"

#define kBrusherViewH    44            // 画笔按钮宽度
#define kBottomItemViweH 60            // 底部按钮的高度

#define kRedoBtnMargin   12            // 隐藏的按钮距离边框的间隙
#define kUndoBtnMargin   kRedoBtnMargin

// 获得RGB颜色
#define KSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#define kToolViewColor [UIColor cardTableColor];

// 自定义Log
#ifdef DEBUG
#define KSLog(...) NSLog(__VA_ARGS__)
#else
#define KSLog(...)
#endif

// 判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 判断是否为iOS8
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

// 判断是否是横屏
#define Landscape UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)

// 宽度
#define  Width    (Landscape ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
// 高度
#define  Height   (Landscape ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen]  bounds].size.height)

// 状态栏高度
#define  StatusBarHeight                   20.f

// 导航栏高度
#define  NavigationBarHeight               44.f

// 标签栏高度
#define  TabbarHeight                      49.f

// 状态栏高度 + 导航栏高度
#define  StatusBarAndNavigationBarHeight   (20.f + 44.f)

#define  iPhone4_4s   (Width == 320.f && Height == 480.f ? YES : NO)
#define  iPhone5_5s   (Width == 320.f && Height == 568.f ? YES : NO)
#define  iPhone6      (Width == 375.f && Height == 667.f ? YES : NO)
#define  iPhone6_plus (Width == 414.f && Height == 736.f ? YES : NO)

#endif
