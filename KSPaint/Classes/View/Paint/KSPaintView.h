//
//  KSPaintView.h
//  KSPaint
//
//  Created by KeSen on 15/7/31.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^paintViewTapBlock)();

typedef NS_ENUM(NSInteger, KSSelectedForm) {
    KSLine,
    KSRect,
    KSOval,
};

typedef NS_ENUM(NSInteger, KSPen) {
    KSPenLine,
    KSPenDash,
    KSPenEraser,
};

@interface KSPaintView : UIView

// 线的宽度
@property (nonatomic, assign) CGFloat           width;

// 线的颜色
@property (nonatomic, strong) UIColor           *color;

// 从相册选中的图片
@property (nonatomic, strong) UIImage           *image;


@property (nonatomic, copy) paintViewTapBlock tapBlock;

/***  选中的形状 */
@property (nonatomic, assign) KSSelectedForm    selectedForm;

/***  选中的画笔 */
@property (nonatomic, assign) KSPen pen;

- (void)redo;
- (void)undo;

@end
