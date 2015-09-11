//
//  KSPaintView.h
//  KSPaint
//
//  Created by KeSen on 15/7/31.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSPaint.h"

typedef void (^paintViewTapBlock)();

@interface KSPaintView : UIView

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) paintViewTapBlock tapBlock;

@property (nonatomic, assign) KSSelectedForm selectedForm;

@end
