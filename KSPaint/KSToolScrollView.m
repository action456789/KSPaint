//
//  KSToolScrollView.m
//  KSPaint
//
//  Created by KeSen on 15/8/8.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//  画笔工具条

#import "KSToolScrollView.h"

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
    
    [self addBtnWithTarget:self action:@"click1:"];
    
    [self addBtnWithTarget:self action:@"click2:"];
    
    [self addBtnWithTarget:self action:@"click3:"];
}

- (void)click1:(UIButton *)btn {
    if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedForm:)]) {
        [self.tollScrolViewDelegate toolScrolView:self selectedForm:KSLine];
    }
}

- (void)click2:(UIButton *)btn {
    if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedForm:)]) {
        [self.tollScrolViewDelegate toolScrolView:self selectedForm:KSRect];
    }
}

- (void)click3:(UIButton *)btn {
    if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedForm:)]) {
        [self.tollScrolViewDelegate toolScrolView:self selectedForm:KSOval];
    }
}

- (void)addBtnWithTarget:(id)target action:(NSString *)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [btn addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
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
