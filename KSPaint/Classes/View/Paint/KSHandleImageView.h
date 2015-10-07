//
//  KSHandleImageView.h
//  KSPaint
//
//  Created by KeSen on 15/9/21.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSHandleImageView;


typedef void (^HandleImageViewLongPressBlock)(UIImage *image);

@interface KSHandleImageView : UIView

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) HandleImageViewLongPressBlock block;

@end