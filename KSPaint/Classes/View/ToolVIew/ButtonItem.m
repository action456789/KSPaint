//
//  ButtonItem.m
//  KSPaint
//
//  Created by KeSen on 15/7/16.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "ButtonItem.h"
#import "KSToolScrollView.h"

// 按钮 img 与 title 宽度比例
#define kButtonItemImgRatio 0.6

#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 按钮 title 的颜色
#define kButtonItemTitleColor [UIColor whiteColor]
#define kButtonItemTitleSelectedColor kColor(0, 147, 221)

// 按钮 title 的字体
#define kButtonItemTitleFont [UIFont systemFontOfSize:14]

@implementation ButtonItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;

        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.titleLabel.font = kButtonItemTitleFont;
        
        [self setTitleColor:kButtonItemTitleColor forState:UIControlStateNormal];
        [self setTitleColor:kButtonItemTitleSelectedColor forState:UIControlStateSelected];

        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat W = contentRect.size.width;
    CGFloat H = contentRect.size.height * kButtonItemImgRatio;
    
    return CGRectMake(0, 0, W, H);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat Y = contentRect.size.height * kButtonItemImgRatio;
    CGFloat W = contentRect.size.width;
    CGFloat H = contentRect.size.height - Y;
    
    return CGRectMake(0, Y, W, H);
}

- (void)setHighlighted:(BOOL)highlighted {}


@end
