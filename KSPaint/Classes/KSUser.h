//
//  KSUser.h
//  KSPaint
//
//  Created by KeSen on 16/2/26.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSUser : NSObject

/**
 *  性别
 */
typedef NS_ENUM(NSUInteger, KSGender){
    /**
     *  男
     */
    KSGenderMale      = 0,
    /**
     *  女
     */
    KSGenderFemale    = 1,
    /**
     *  未知
     */
    KSGenderUnknown   = 2,
};


/**
 *  授权标记
 */
@property (nonatomic, assign) BOOL *authorizationFlag;

/**
 *  用户标识
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  昵称
 */
@property (nonatomic, copy) NSString *nickname;

/**
 *  头像
 */
@property (nonatomic, copy) NSString *icon;

/**
 *  性别
 */
@property (nonatomic) KSGender gender;

/**
 *  用户主页
 */
@property (nonatomic, copy) NSString *url;

/**
 *  用户简介
 */
@property (nonatomic, copy) NSString *aboutMe;

/**
 *  认证用户类型
 */
@property (nonatomic) NSInteger verifyType;

/**
 *  认证描述
 */
@property (nonatomic, copy) NSString *verifyReason;

/**
 *  生日
 */
@property (nonatomic, strong) NSDate *birthday;

/**
 *  粉丝数
 */
@property (nonatomic) NSInteger followerCount;

/**
 *  好友数
 */
@property (nonatomic) NSInteger friendCount;

/**
 *  分享数
 */
@property (nonatomic) NSInteger shareCount;

/**
 *  注册时间
 */
@property (nonatomic) NSTimeInterval regAt;

/**
 *  用户等级
 */
@property (nonatomic) NSInteger level;

/**
 *  教育信息
 */
@property (nonatomic, retain) NSArray *educations;

/**
 *  职业信息
 */
@property (nonatomic, retain) NSArray *works;


@end
