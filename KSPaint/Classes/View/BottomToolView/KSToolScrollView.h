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
- (void)toolScrolView:(KSToolScrollView *)toolScrolView selectedForm:(KSSelectedForm)form;
- (void)toolScrolView:(KSToolScrollView *)toolScrolView selectedColor:(UIColor *)color;

@end

@interface KSToolScrollView : UIScrollView

@property (nonatomic, getter=isShow) BOOL show;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) id <KSToolScrolViewDelegate> tollScrolViewDelegate;
@property (nonatomic, weak) KSBlockButton *selectedBtn; // 选中的按钮

- (void)selectedButton:(KSBlockButton *)sender;

@end
