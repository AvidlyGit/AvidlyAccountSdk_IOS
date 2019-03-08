//
//  AvidlyAccountSDK.m
//  AvidlyAccountSDK
//
//  Created by steve on 2019/1/24.
//  Copyright © 2019 Avidly Technology Co.,Ltd. All rights reserved.
//

#import "AvidlyAccountSDK.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "AASBaseParameter.h"
#import "AASLoginUserManager.h"
#import "AASLoginViewController.h"
#import "AASUserCenterManager.h"
#import "AASCallback.h"

@implementation AvidlyAccountSDK

+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation];
}

+ (void)initSDK:(NSString *)productId {
    if (productId == nil || [productId isEqualToString:@""]) {
        NSLog(@"[AvidlyAccountSDK Error] productId is nil, SDK not initialized successfully. Please check!");
        return ;
    }
    [AASBaseParameter shareInstance].productId = [productId copy];
}

+ (void)setLoginCallback:(void (^)(AvidlyAccountLoginModel *model))succeedCallback errorCallback:(void (^)(NSError *error))errorCallback {
    [AASCallback shareInstance].loginSucceedBlock = [succeedCallback copy];
    [AASCallback shareInstance].loginErrorBlock = [errorCallback copy];
}

+ (void)login {
    NSString *productId = [AASBaseParameter shareInstance].productId;
    if (productId == nil || [productId isEqualToString:@""]) {
        NSLog(@"[AvidlyAccountSDK Error] productId is nil, SDK not initialized successfully. Please check!");
        return;
    }

    [[AASLoginUserManager shareInstance] freshUserCache];
    BOOL isLoginedNow = [[AASLoginUserManager shareInstance] isLoginedNow];
    if (isLoginedNow) {
        NSString *gameGuestId = [[AASLoginUserManager shareInstance] getCurrentGGID];
        NSString *token = [[AASLoginUserManager shareInstance] getCurrentToken];
        int loginMode = [[AASLoginUserManager shareInstance] getCurrentActiveLoginUser].loginedMode;
        
        AvidlyAccountLoginModel *model = [[AvidlyAccountLoginModel alloc] init];
        model.gameGuestId = gameGuestId;
        model.signedRequest = token;
        model.loginMode = loginMode;
        
        CallbackBlock succeedBlock = [AASCallback shareInstance].loginSucceedBlock;
        succeedBlock(model);
        return;
    }
    
    AASLoginUser *loginUser = [[AASLoginUserManager shareInstance] getCurrentActiveLoginUser];
    if (loginUser != nil) {
        BOOL isActived = loginUser.isActived;
        if (isActived) {
            [[AASLoginViewController shareInstance] showAutoLogin];
        }
    }
    else {
        [[AASLoginViewController shareInstance] showHomepageLogin];
    }
}

+ (void)showUserCenter:(UIViewController *)vc {
    [[AASUserCenterManager shareInstance] showUserCenter:vc];
}

@end
