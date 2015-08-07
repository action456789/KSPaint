//
//  KSPaintView.h
//  KSPaint
//
//  Created by KeSen on 15/7/31.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^paintViewTapBlock)();

@interface KSPaintView : UIView

@property (nonatomic, copy) paintViewTapBlock tapBlock;

@end
