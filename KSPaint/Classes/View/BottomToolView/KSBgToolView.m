//
//  KSBgToolView.m
//  KSPaint
//
//  Created by KeSen on 15/9/22.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import "KSBgToolView.h"
#import "KSBlockButton.h"

@implementation KSBgToolView

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
    
    KSBlockButton *btnWhite = [[KSBlockButton alloc] initWithImageName:@"bg_white" selected:@"bg_white" block:^(KSBlockButton *sender) {
        
        [self selectedButton:sender];
        
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedBgImage:)]) {
//            [self.tollScrolViewDelegate toolScrolView:self selectedBgImage:]
        }
    }];
    [self addSubview:btnWhite];
    
    KSBlockButton *btnSky = [[KSBlockButton alloc] initWithImageName:@"bg_sky" selected:@"bg_sky" block:^(KSBlockButton *sender) {
        
        [self selectedButton:sender];
        
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedPen:)]) {
            [self.tollScrolViewDelegate toolScrolView:self selectedPen:KSPenDash];
        }
    }];
    [self addSubview:btnSky];
    
    KSBlockButton *btnPaper = [[KSBlockButton alloc] initWithImageName:@"bg_paper" selected:@"bg_paper" block:^(KSBlockButton *sender) {
        [self selectedButton:sender];
        
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedPen:)]) {
            [self.tollScrolViewDelegate toolScrolView:self selectedPen:KSPenEraser];
        }
    }];
    [self addSubview:btnPaper];
    
    KSBlockButton *btnFibre = [[KSBlockButton alloc] initWithImageName:@"bg_fibre" selected:@"bg_fibre" block:^(KSBlockButton *sender) {
        [self selectedButton:sender];
        
        if ([self.tollScrolViewDelegate respondsToSelector:@selector(toolScrolView:selectedPen:)]) {
            [self.tollScrolViewDelegate toolScrolView:self selectedPen:KSPenEraser];
        }
    }];
    [self addSubview:btnFibre];
    
    
    [self selectedButton:btnWhite];
}

@end
