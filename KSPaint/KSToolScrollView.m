//
//  KSToolScrollView.m
//  KSPaint
//
//  Created by KeSen on 15/8/8.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//  画笔工具条

#import "KSToolScrollView.h"
#import "KSBlockButton.h"

#define kItemW 44
#define kItemH kItemW

@implementation KSToolScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSet];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSet];
    }
    return self;
}

- (void)initSet {
    self.backgroundColor = [UIColor redColor];
    
    // 点击按钮时画线
    KSBlockButton *btnLine = [[KSBlockButton alloc] initWithImageName:nil selected:nil block:^(KSBlockButton *sender) {
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedForm:)]) {
            [self.tollScrolViewDelegate toolScrolView:self selectedForm:KSLine];
        }
    }];
    [self addSubview:btnLine];
    
    // 点击按钮时画矩形
    KSBlockButton *btnRect = [KSBlockButton buttonWithImageName:nil selected:nil block:^(KSBlockButton *sender) {
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedForm:)]) {
            [self.tollScrolViewDelegate toolScrolView:self selectedForm:KSRect];
        }
    }];
    [self addSubview:btnRect];
    
    // 点击按钮时画圆
    KSBlockButton *btnOral = [KSBlockButton buttonWithImageName:nil selected:nil block:^(KSBlockButton *sender) {
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedForm:)]) {
            [self.tollScrolViewDelegate toolScrolView:self selectedForm:KSOval];
        }
    }];
    [self addSubview:btnOral];
    
}

- (void)layoutSubviews {
    NSInteger count = self.subviews.count;
    for (NSInteger i=0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat X = i*kItemW;
        btn.frame = CGRectMake(X, 0, kItemW, kItemH);
    }
}

@end
