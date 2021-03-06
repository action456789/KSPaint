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
@property (nonatomic, strong) UIScrollView *colorsBarView;
@end

@implementation KSPenWeightToolView

#pragma mark - lifecycle

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
    
    _sliderBarview = [[UIView alloc] init];
    
    // 添加 slider
    [_sliderBarview addSubview:self.slider];
    _sliderBarview.backgroundColor = [UIColor grayColor];
    [self addSubview:_sliderBarview];
    
    // 添加颜色选择View
    _colorsBarView = [[UIScrollView alloc] init];
    _colorsBarView.backgroundColor = [UIColor redColor];
    [self addSubview:_colorsBarView];
}

- (void)layoutSubviews {
    [self.sliderBarview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.33);
        make.height.equalTo(self);
    }];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sliderBarview.mas_left).offset(10);
        make.centerY.equalTo(self.sliderBarview);
        make.right.equalTo(self.sliderBarview.mas_right).offset(-10);
    }];
    
    [self.colorsBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sliderBarview.mas_right);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
}

#pragma mark - getter 
- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc] init];
        _slider.minimumValue = 1.f;
        _slider.maximumValue = 20.f;
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

#pragma mark - private method
- (void)sliderValueChanged:(UISlider *)sender {
    if ([self.delegate respondsToSelector:@selector(penWeightToolView:sliderValueDidChanged:)]) {
        [self.delegate penWeightToolView:self sliderValueDidChanged:self.slider.value];
    }
}

#pragma mark - public method
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
