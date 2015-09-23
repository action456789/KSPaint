//
//  TopView.h
//  KSPaint
//
//  Created by KeSen on 15/9/14.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "BottomItemView.h"

@interface KSTopView : UIView

typedef void (^ItemBlock)(id sender);

// 通过 block 添加一个按钮
- (void)addButtonWithImgName:(NSString *)imgName highlightImgName:(NSString *) highlightImgName titleName:(NSString *)titleName block:(ItemBlock)block;

@end
