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

@property (nonatomic, assign) CGFloat           width;

@property (nonatomic, strong) UIColor           *color;

@property (nonatomic, strong) UIImage           *image;

@property (nonatomic, copy  ) paintViewTapBlock tapBlock;

@property (nonatomic, assign) KSSelectedForm    selectedForm;

/***  存放所有路径数组 */
@property (nonatomic, strong) NSMutableArray    *paths;

/***  存放一次绘图时，其他形状的路径*/
@property (nonatomic, strong) NSMutableArray    *graphs;

/***  存放被撤销的路径*/
@property (nonatomic, strong) NSMutableArray    *undoPaths;


- (void)redo;
- (void)undo;

@end
