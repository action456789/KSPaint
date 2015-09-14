//
//  KSColorToolScrollView.m
//  KSPaint
//
//  Created by KeSen on 15/9/7.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//  颜色工具条

#import "KSColorToolScrollView.h"
#import "KSBlockButton.h"

@implementation KSColorToolScrollView

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
    return 1;
}

- (void)initSet {
    self.backgroundColor = [UIColor redColor];
    
    // 点击按钮时画线
    KSBlockButton *btnLine = [[KSBlockButton alloc] initWithImageName:@"btn_colorpicker" selected:@"btn_fillpel_normal" block:^(KSBlockButton *sender) {
        [self selectedButton:sender];
        
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedColor:)]) {
            [self.tollScrolViewDelegate toolScrolView:self selectedColor:[UIColor blackColor]];
        }
    }];
    [self addSubview:btnLine];
    
    // 点击按钮时画矩形
    KSBlockButton *btnRect = [[KSBlockButton alloc] initWithImageName:@"btn_colorpicker" selected:@"btn_fillpel_normal" block:^(KSBlockButton *sender) {
        [self selectedButton:sender];
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedColor:)]) {
            [self.tollScrolViewDelegate toolScrolView:self selectedColor:[UIColor redColor]];
        }
    }];
    [self addSubview:btnRect];
    
    // 点击按钮时画圆
    KSBlockButton *btnOral = [[KSBlockButton alloc] initWithImageName:@"btn_colorpicker" selected:@"btn_fillpel_normal" block:^(KSBlockButton *sender) {
        [self selectedButton:sender];
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedColor:)]) {
            [self.tollScrolViewDelegate toolScrolView:self selectedColor:[UIColor blueColor]];
        }
    }];
    [self addSubview:btnOral];
}

@end
