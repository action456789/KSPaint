//
//  BottomItemView.m
//  KSPaint
//
//  Created by KeSen on 15/7/15.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "BottomItemView.h"
#import "ButtonItem.h"


@interface BottomItemView()

@property (nonatomic, weak) ButtonItem *selectedBtn; // 选中的按钮

@end

@implementation BottomItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _show = NO;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _show = NO;
    }
    return self;
}

- (void)addButtonItemWithName:(NSString *)imgName selectedImgName:(NSString *) selectedName titleName:(NSString *)titleName{
    
    ButtonItem *drawBtn = [ButtonItem buttonWithType:UIButtonTypeCustom];
    
    [drawBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [drawBtn setImage:[UIImage imageNamed:selectedName] forState:UIControlStateSelected];
    
    [drawBtn setTitle:titleName forState:UIControlStateNormal];
    [drawBtn setTitle:titleName forState:UIControlStateSelected];

    //[drawBtn setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    //[drawBtn setBackgroundImage:[UIImage imageNamed:selName] forState:UIControlStateSelected];
    
    [drawBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:drawBtn];
    
    // 默认选中第0个按钮
//    if (self.subviews.count == 1) {
//        [self btnClick:drawBtn];
//    }
}

- (void)btnClick:(ButtonItem *)button {
    
    if ([self.delegate respondsToSelector:@selector(bottomItemView:didSelectItemFrom:to:)]) {
        [self.delegate bottomItemView:self didSelectItemFrom:self.selectedBtn.tag to:button.tag];
    }
    
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    for (int i=0; i<count; i++) {
        
        ButtonItem *btn = self.subviews[i];
        btn.tag = i;
        
        CGFloat buttonY = 0;
        CGFloat buttonW = self.frame.size.width / count;
        CGFloat buttonH = self.frame.size.height;
        CGFloat buttonX = i * buttonW;
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}


@end
