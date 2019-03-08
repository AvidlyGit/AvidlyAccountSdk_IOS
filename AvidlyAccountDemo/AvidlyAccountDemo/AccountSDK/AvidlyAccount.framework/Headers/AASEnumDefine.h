//
//  AASEnumDefine.h
//  AvidlyAccountSDK
//
//  Created by samliu on 2019/1/23.
//  Copyright © 2019年 Avidly Technology Co.,Ltd. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef AASEnumDefine_h
#define AASEnumDefine_h

#define AAS_USER_SERVICE_AGREEMENT_URL @"https://d5q0hty07mfa4.cloudfront.net/privacy_policy/pp_cn.html"

#define ACCOUNT_MODE_GUEST 1
#define ACCOUNT_MODE_AVIDLY  2
#define ACCOUNT_MODE_FACEBOOK  3
#define ACCOUNT_MODE_GOOGLEPLAY  4
#define ACCOUNT_MODE_TWITTER  6
#define ACCOUNT_MODE_INSTAGRAM 8

#define AACOUNT_NAME @"accountName"
#define AACOUNT_NICK_NAME @"nickname"
#define AACOUNT_PASSWORD @"accountPwd"
#define AACOUNT_MODE @"mode"
#define AACOUNT_BINDED @"isBinded"
#define AACOUNT_FB_APPID @"fbAppId"
#define AACOUNT_FB_TOKEN @"fbToken"

#define ALOGIN_USER_GGID @"ggid"
#define ALOGIN_USER_TOKEN @"token"
#define ALOGIN_USER_LOGIN_MODE @"loginedMode"
#define ALOGIN_USER_ACTIVED @"actived"
#define ALOGIN_USER_ACCOUNTS @"accounts"

#define USERDEFAULT_KEY_GUEST_USER  @"guest_user"
#define USERDEFAULT_KEY_ACCOUNT_USER  @"account_user"

#endif /* AASEnumDefine_h */
