//
//  KSTopButton.h
//  KSPaint
//
//  Created by KeSen on 15/9/22.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface KSTopButton : UIButton

typedef void (^ButtomClickblock)(KSTopButton *sender);

/**
 *  按钮点击时 block
 */
@property (nonatomic, copy) ButtomClickblock btnBlock;

- (instancetype)initWithImageName:(NSString *)normal highlight:(NSString *)highlight block:(ButtomClickblock)block;

+ (instancetype)buttonWithImageName:(NSString *)normal highlight:(NSString *)highlight block:(ButtomClickblock)block;

@end
