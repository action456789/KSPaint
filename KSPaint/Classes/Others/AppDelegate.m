//
//  AppDelegate.m
//  KSPaint
//
//  Created by KeSen on 15/7/15.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import "KSPaint.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

/**
 *  KSPaint 分享帐号信息
 
 AppKey
	fb59f9409af6
 
 WeChat
	AppID: wx19387ca65e96af7e
	AppSecret: 64020361b8ec4c99936c0e3999a9f249
 
 QQ
	AppID: 1105201574
	AppKey: UWsrARpZu2ke7KUq
 
 SinaWeibo
	AppKey: 568898243
	AppSecret: 38a4f8204cc784f81f9f0daaf31e02e3
 
 */

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 集成 Crashlytics
    [Fabric with:@[[Crashlytics class]]];
    
    // TODO: Move this to where you establish a user session
    [self logUser];

    // 集成友盟社交分享
    [self registerUmShare];
    
    // 集成 mob 社交分享
    [self registerMobShare];
    return YES;
}

- (void)registerUmShare {
    [UMSocialData setAppKey:@"5601fdf967e58e5731001bbd"];
}

- (void)registerMobShare {

    // 第三方帐号分享
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"fb1cf45999f2"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeSinaWeibo)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx19387ca65e96af7e"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105201574"
                                      appKey:@"UWsrARpZu2ke7KUq"
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
    
    // 第三方帐号登录
    
}

- (void) logUser {
    // TODO: Use the current user's information
    // You can call any combination of these three methods
    [CrashlyticsKit setUserIdentifier:@"12345"];
    [CrashlyticsKit setUserEmail:@"user@fabric.io"];
    [CrashlyticsKit setUserName:@"Test User"];
}


@end
