//
//  KSMobShareToolVC.m
//  KSPaint
//
//  Created by KeSen on 16/2/24.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "KSMobShareToolVC.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

// 第三方登录
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import <ShareSDKUI/SSUITypeDef.h>
#import "KSUser.h"

@interface KSMobShareToolVC ()

@property (nonatomic, strong) KSUser *thirdPartyLoginUser;

@end

static KSMobShareToolVC *sharedInstance = nil;

@implementation KSMobShareToolVC


+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)shareImage:(NSArray *)images text:(NSString *)text target:(UIViewController *)target {
    
    //1、创建分享参数
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (images) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:images
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:target.view //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}

- (void)thirdPartyLoginSuccess:(successBlock)success failure:(failureBlock)failure {
    
    // QQ的登录
    // 方式一
    self.thirdPartyLoginUser = nil;
    
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       associateHandler (user.uid, user, user);
//                                       NSLog(@"user.rawData:%@",user.rawData);
//                                       NSLog(@"user.credential:%@",user.credential);

                                       KSUser *tempUser = [[KSUser alloc] init];
                                       
                                       tempUser.uid = user.uid;
                                       tempUser.nickname = user.nickname;
                                       tempUser.icon = user.icon;
                                       tempUser.gender = (NSInteger)user.gender;
                                       
                                       self.thirdPartyLoginUser = tempUser;
                                       
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    
                                    if (state == SSDKResponseStateSuccess) {
                                        
                                    }

                                }];
    
    // 方式二
//    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
//           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
//     {
//         if (state == SSDKResponseStateSuccess) {
//             
//             NSLog(@"__uid=%@",user.uid);
//             NSLog(@"__%@",user.credential);
//             NSLog(@"__token=%@",user.credential.token);
//             NSLog(@"__nickname=%@",user.nickname);
//             
//             if (success) {
//                 success(user);
//             }
//         } else {
//             if (failure) {
//                 failure(error);
//             }
//         }
//         
//     }];
}

#pragma mark - getter
- (void)setThirdPartyLoginUser:(KSUser *)thirdPartyLoginUser {
    _thirdPartyLoginUser = thirdPartyLoginUser;
    if (thirdPartyLoginUser != nil) {
        NSDictionary *info = @{@"thirdPartyLoginUser": thirdPartyLoginUser};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getThiredPartyLoginUserNotificationSuccess" object:self userInfo:info];
    }
}

@end
