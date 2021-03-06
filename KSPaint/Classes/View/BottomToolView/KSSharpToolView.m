//
//  KSPanToolScrollView.m
//  KSPaint
//
//  Created by KeSen on 15/9/7.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//  画笔工具条

#import "KSSharpToolView.h"
#import "KSBlockButton.h"

@implementation KSSharpToolView

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

- (NSInteger)index {
    return 0;
}

- (void)initSet {
    self.backgroundColor = kToolViewColor;
    
    // 点击按钮时画线
    KSBlockButton *btnLine = [[KSBlockButton alloc] initWithImageName:@"btn_freehand" selected:@"btn_freehand_highlight" block:^(KSBlockButton *sender) {
        [self selectedButton:sender];
        
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedForm:)]) {
            [self.tollScrolViewDelegate toolScrolView:self selectedForm:KSLine];
        }
    }];
    [self addSubview:btnLine];
    
    // 点击按钮时画矩形
    KSBlockButton *btnRect = [[KSBlockButton alloc] initWithImageName:@"btn_rect" selected:@"btn_rect_highlight" block:^(KSBlockButton *sender) {
        [self selectedButton:sender];
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedForm:)]) {
            [self.tollScrolViewDelegate toolScrolView:self selectedForm:KSRect];
        }
    }];
    [self addSubview:btnRect];
    
    // 点击按钮时画圆
    KSBlockButton *btnOral = [[KSBlockButton alloc] initWithImageName:@"btn_oval" selected:@"btn_oval_highlight" block:^(KSBlockButton *sender) {
        [self selectedButton:sender];
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedForm:)]) {
            [self.tollScrolViewDelegate toolScrolView:self selectedForm:KSOval];
        }
    }];
    [self addSubview:btnOral];
    
    [self selectedButton:btnLine];
    
}
@end
