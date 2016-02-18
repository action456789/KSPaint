//
//  KSPenWeightToolView.m
//  KSPaint
//
//  Created by KeSen on 16/2/18.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "KSPenWeightToolView.h"
#import <Masonry.h>
#import "KSPaint.h"

@interface KSPenWeightToolView()
@property (nonatomic, strong) UIView *sliderBarview;
@property (nonatomic, strong) UISlider *slider;

@property (nonatomic, strong) UIScrollView *colorsBarView;
@end

@implementation KSPenWeightToolView

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
    self.backgroundColor = [UIColor purpleColor];
    
    // 添加 slider
    _sliderBarview = [[UIView alloc] init];
    _slider = [[UISlider alloc] init];
    [_sliderBarview addSubview:_slider];
    _sliderBarview.backgroundColor = [UIColor grayColor];
    [self addSubview:_sliderBarview];
    
    // 添加颜色选择View
    _colorsBarView = [[UIScrollView alloc] init];
    _colorsBarView.backgroundColor = [UIColor redColor];
    [self addSubview:_colorsBarView];
}

- (void)setFrame:(CGRect)frame {
    frame.size.height = 44;
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height;
    frame.origin.x = 0;
    
    [super setFrame:frame];
}

- (void)layoutSubviews {
    [self.sliderBarview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.33);
        make.height.equalTo(self);
    }];
    
    [self.colorsBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sliderBarview.mas_right);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
}

- (void)showWithAnimate:(BOOL)animate {
    if (animate) {
        [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            CGFloat H = self.frame.size.height + kBottomItemViweH + kBrusherViewH;
            self.transform = CGAffineTransformMakeTranslation(0, -H);
        } completion:^(BOOL finished) {
            
        }];
    } else {
        CGFloat H = self.frame.size.height + kBottomItemViweH + kBrusherViewH;
        self.transform = CGAffineTransformMakeTranslation(0, -H);
    }
}

- (void)hideWithAnimate:(BOOL)animate {
    if (animate) {
        [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        self.transform = CGAffineTransformIdentity;
    }
}

@end
