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
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [btn1 addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    btn2.frame = CGRectMake(20, 0, 20, 20);
    [btn2 addTarget:self action:@selector(click2:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn2];
}

- (void)click1:(UIButton *)btn {
    NSLog(@"click1");
    if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedForm:)]) {
        [self.tollScrolViewDelegate toolScrolView:self selectedForm:KSLine];
    }
}

- (void)click2:(UIButton *)btn {
    NSLog(@"click2");
    if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedForm:)]) {
        [self.tollScrolViewDelegate toolScrolView:self selectedForm:KSRect];
    }
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
