//
//  KSColorToolScrollView.m
//  KSPaint
//
//  Created by KeSen on 15/9/7.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//  颜色工具条

#import "KSPenToolView.h"
#import "KSBlockButton.h"


@implementation KSPenToolView

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
    self.backgroundColor = kToolViewColor;
    
    // 点击按钮时画虚线
    KSBlockButton *btnLine = [[KSBlockButton alloc] initWithImageName:@"btn_line" selected:@"btn_line_highlight" block:^(KSBlockButton *sender) {
        
        [self selectedButton:sender];
        
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedPen:)]) {
            [self.tollScrolViewDelegate toolScrolView:self selectedPen:KSPenLine];
        }
    }];
    [self addSubview:btnLine];
    
    // 点击按钮时画虚线
    KSBlockButton *btnDash = [[KSBlockButton alloc] initWithImageName:@"dash_normal" selected:@"dash_high" block:^(KSBlockButton *sender) {
        
        [self selectedButton:sender];
        
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedPen:)]) {
            [self.tollScrolViewDelegate toolScrolView:self selectedPen:KSPenDash];
        }
    }];
    [self addSubview:btnDash];

    [self selectedButton:btnLine];
}

@end
