//
//  KSToolScrollView.h
//  KSPaint
//
//  Created by KeSen on 15/8/8.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSPaint.h"
@class KSToolScrollView;



@protocol KSToolScrolViewDelegate <NSObject>

@optional
- (void)toolScrolView:(KSToolScrollView *)toolScrolView selectedForm:(KSSelectedForm)form;

@end

@interface KSToolScrollView : UIScrollView

@property (nonatomic, getter=isShow) BOOL show;
@property (nonatomic, assign) id <KSToolScrolViewDelegate> tollScrolViewDelegate;

@end
