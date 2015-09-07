//
//  KSToolScrollView.m
//  KSPaint
//
//  Created by KeSen on 15/8/8.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//  画笔工具条父类

#import "KSToolScrollView.h"
#import "KSBlockButton.h"

#define kItemW 44
#define kItemH kItemW

@interface KSToolScrollView()

@end

@implementation KSToolScrollView


- (void)selectedButton:(KSBlockButton *)sender {
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}

- (void)layoutSubviews {
    NSInteger count = self.subviews.count;
    for (NSInteger i=0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat X = i*kItemW;
        btn.frame = CGRectMake(X, 0, kItemW, kItemH);
    }
}

- (void)setFrame:(CGRect)frame {
    
    CGFloat brusherViewW = [UIScreen mainScreen].applicationFrame.size.width;
    CGFloat brusherViewY = [UIScreen mainScreen].bounds.size.height - kBottomItemViweH - kBrusherViewH;
    frame = CGRectMake(0, brusherViewY, brusherViewW, kBrusherViewH);
    
    [super setFrame:frame];
}

@end
