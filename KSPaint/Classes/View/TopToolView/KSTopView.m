//
//  TopView.m
//  KSPaint
//
//  Created by KeSen on 15/9/14.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "KSTopView.h"
#import "KSTopButton.h"
#import "KSPaint.h"

@implementation KSTopView

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    for (int i=0; i<count; i++) {
        
        KSTopButton *btn = self.subviews[i];
        CGFloat buttonY = StatusBarHeight;
        CGFloat buttonW = self.frame.size.width / count;
        CGFloat buttonH = self.frame.size.height - StatusBarHeight;
        CGFloat buttonX = i * buttonW;
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}


- (void)addButtonWithImgName:(NSString *)imgName highlightImgName:(NSString *)highlightImgName titleName:(NSString *)titleName block:(ItemBlock)block {
    
    KSTopButton *drawBtn = [KSTopButton buttonWithType:UIButtonTypeCustom];
    
    [drawBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [drawBtn setImage:[UIImage imageNamed:highlightImgName] forState:UIControlStateHighlighted];
    
    [drawBtn setTitle:titleName forState:UIControlStateNormal];
    [drawBtn setTitle:titleName forState:UIControlStateHighlighted];
    
    drawBtn.btnBlock = block;
    
    [self addSubview:drawBtn];
}
@end
