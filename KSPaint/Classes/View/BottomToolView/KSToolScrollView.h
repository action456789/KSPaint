//
//  KSToolScrollView.h
//  KSPaint
//
//  Created by KeSen on 15/8/8.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSPaint.h"

@class KSBlockButton;
@class KSToolScrollView;


@protocol KSToolScrolViewDelegate <NSObject>

@optional
/**
 *  选中了某个形状时调用
 */
- (void)toolScrolView:(KSToolScrollView *)toolScrolView selectedForm:(KSSelectedForm)form;

/**
 *  选中了某个颜色时调用
 */
- (void)toolScrolView:(KSToolScrollView *)toolScrolView selectedColor:(UIColor *)color;

/**
 *  选中了某个画笔时调用
 */
- (void)toolScrolView:(KSToolScrollView *)toolScrolView selectedPen:(KSPen)pen;

@end

@interface KSToolScrollView : UIScrollView

@property (nonatomic, getter = isShow) BOOL show;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) UIButton *selectedBtn; // 选中的按钮

@property (nonatomic, assign) id <KSToolScrolViewDelegate> tollScrolViewDelegate;

- (void)selectedButton:(UIButton *)sender;

@end
