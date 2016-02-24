//
//  KSMobShareToolVC.h
//  KSPaint
//
//  Created by KeSen on 16/2/24.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSMobShareToolVC : UIViewController

+ (instancetype)sharedInstance;

- (void)shareImage:(NSArray *)images text:(NSString *)text target:(UIViewController *)target;

@end
