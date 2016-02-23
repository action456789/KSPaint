//
//  KSPenWeightToolView.h
//  KSPaint
//
//  Created by KeSen on 16/2/18.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KSPenWeightToolView;

@protocol KSPenWeightToolViewDelegate <NSObject>

@optional
- (void)penWeightToolView:(KSPenWeightToolView *)view sliderValueDidChanged:(CGFloat)value;

@end

@interface KSPenWeightToolView : UIView

- (void)showWithAnimate:(BOOL)animate;

- (void)hideWithAnimate:(BOOL)animate;

@property (nonatomic, strong) UISlider *slider;

@property (nonatomic, weak) id <KSPenWeightToolViewDelegate> delegate;

@end
