//
//  KSUMShareToolVc.h
//  KSPaint
//
//  Created by KeSen on 15/9/23.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"


typedef void (^shareResultBlock)(BOOL result);

@interface KSUMShareToolVc : UIViewController

/**
 *  友盟分享的 appKey
 */
@property (nonatomic, strong) NSString *appKey;

/**
 *  分享图片、文本
 *
 *  @param image  要分享的图片
 *  @param text   要分享的文本
 *  @param target 分享列表页面所在的 UIViewController 对象
 */
- (void)shareImage:(UIImage *)image text:(NSString *)text target:(id)target;

@end
