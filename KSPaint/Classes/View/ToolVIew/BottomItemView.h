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

@interface BottomItemView : UIView

@property (nonatomic, getter=isShow) BOOL show;

@property (nonatomic, weak) id <BottomItemViewDelegate>delegate;

- (void)addButtonItemWithName:(NSString *)imgName selectedImgName:(NSString *) selectedName titleName:(NSString *)titleName;



@end
