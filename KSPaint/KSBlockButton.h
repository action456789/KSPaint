//
//  KSBlockButton.h
//  KSPaint
//
//  Created by KeSen on 15/9/1.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^Buttomblock)();

@interface KSBlockButton : UIButton

@property (nonatomic, copy) Buttomblock btnBlock;

@end
