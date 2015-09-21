//
//  TopView.m
//  KSPaint
//
//  Created by KeSen on 15/9/14.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "KSTopView.h"
#import "ButtonItem.h"
#import "KSPaint.h"

@implementation KSTopView

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    for (int i=0; i<count; i++) {
        
        ButtonItem *btn = self.subviews[i];
        btn.tag = i;
        
        CGFloat buttonY = StatusBarHeight;
        CGFloat buttonW = self.frame.size.width / count;
        CGFloat buttonH = self.frame.size.height - StatusBarHeight;
        CGFloat buttonX = i * buttonW;
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}

@end
