//
//  BottomItemView.h
//  KSPaint
//
//  Created by KeSen on 15/7/15.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BottomItemView;

@protocol BottomItemViewDelegate <NSObject>

@optional
- (void)bottomItemView:(BottomItemView *)bottomItemView didSelectItemFrom:(NSInteger)from to:(NSInteger)to;

@end

typedef void (^ItemBlock)(id sender);

@interface BottomItemView : UIView

@property (nonatomic, getter=isShow) BOOL show;

@property (nonatomic, weak) id <BottomItemViewDelegate>delegate;

// 通过代理添加一个按钮
- (void)addButtonItemWithName:(NSString *)imgName selectedImgName:(NSString *) selectedName titleName:(NSString *)titleName;

// 通过 block 添加一个按钮
- (void)addButtonItemWithImgName:(NSString *)imgName selectedImgName:(NSString *) selectedName titleName:(NSString *)titleName block:(ItemBlock)block;

@end
