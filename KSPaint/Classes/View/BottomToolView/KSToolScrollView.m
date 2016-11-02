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

- (void)selectedButton:(UIButton *)sender {
    self.selectedBtn.selected = NO;
    self.selectedBtn.layer.borderWidth = 0.0f;
    self.selectedBtn.layer.borderColor = nil;
    
    sender.selected = YES;
    sender.layer.borderWidth = 1.0;
    sender.layer.borderColor = [UIColor skyBlueColor].CGColor;
    
    self.selectedBtn = sender;
}

- (void)layoutSubviews {
    NSInteger count = self.subviews.count;
    for (NSInteger i=0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.tag = i;
        CGFloat X = i*kItemW;
        btn.frame = CGRectMake(X, 0, kItemW, kItemH);
    }
}

- (void)setShow:(BOOL)show {
    _show = show;
    if (show) {
        self.hidden = NO;
    }else {
        self.hidden = YES;
    }
}

@end
