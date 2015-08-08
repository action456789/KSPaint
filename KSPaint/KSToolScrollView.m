//
//  KSToolScrollView.m
//  KSPaint
//
//  Created by KeSen on 15/8/8.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

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
    [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn1];
}

- (void)click:(UIButton *)btn {
    NSLog(@"click");
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
