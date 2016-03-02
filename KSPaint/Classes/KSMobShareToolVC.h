//
//  KSMobShareToolVC.h
//  KSPaint
//
//  Created by KeSen on 16/2/24.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KSUser;

@interface KSMobShareToolVC : UIViewController

typedef void (^successBlock)(KSUser *user);
typedef void (^failureBlock)(NSError *error);

+ (instancetype)sharedInstance;

- (void)shareImage:(NSArray *)images text:(NSString *)text target:(UIViewController *)target;

- (void)thirdPartyLoginSuccess:(successBlock)success failure:(failureBlock)failure;

@end
