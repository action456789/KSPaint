//
//  KSHandleImageView.h
//  KSPaint
//
//  Created by KeSen on 15/9/21.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSHandleImageView;


typedef void (^HandleImageViewLongPressBlock)(UIImage *image);


@protocol HandleImageViewDelegate <NSObject>

@optional

/**
 *  完成编辑图片
 */
- (BOOL)handleImageView:(KSHandleImageView *)view finishEditImage:(UIImage *)image;

/**
 *  手势开始
 */
- (BOOL)handleImageView:(KSHandleImageView *)view gestureStart:(BOOL)isStart;

/**
 *  手势结束
 */
- (BOOL)handleImageView:(KSHandleImageView *)view gestureEnd:(BOOL)isEnd;

@end

@interface KSHandleImageView : UIView

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) HandleImageViewLongPressBlock block;

@end
