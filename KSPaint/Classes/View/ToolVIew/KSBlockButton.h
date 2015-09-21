//
//  KSBlockButton.h
//  KSPaint
//
//  Created by KeSen on 15/9/1.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KSBlockButton;

typedef void (^ButtomClickblock)(KSBlockButton *sender);

@interface KSBlockButton : UIButton
/**
 *  按钮点击时 block
 */
@property (nonatomic, copy) ButtomClickblock btnBlock;

- (instancetype)initWithImageName:(NSString *)normal selected:(NSString *)selected block:(ButtomClickblock)block;

+ (instancetype)buttonWithImageName:(NSString *)normal selected:(NSString *)selected block:(ButtomClickblock)block;


@end
