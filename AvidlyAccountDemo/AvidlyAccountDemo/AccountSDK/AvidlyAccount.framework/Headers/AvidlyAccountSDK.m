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

+ (void)setUserChangeCallback:(void (^)(NSString *gameGuestId))callback {
    [AASCallback shareInstance].userChangeBlock = [callback copy];
}

+ (void)loginWithProductId:(NSString *)productId
              succeedBlock:(void (^)(NSString *gameGuestId))succeedBlock
                errorBlock:(void (^)(NSError *error))errorBlock {
    if (productId == nil || [productId isEqualToString:@""]) {
        NSLog(@"[AvidlyAccountSDK Error] productId is nil, SDK not initialized successfully. Please check!");
    }
    [AASBaseParameter shareInstance].productId = [productId copy];
    [AASCallback shareInstance].loginSucceedBlock = [succeedBlock copy];
    [AASCallback shareInstance].loginErrorBlock = [errorBlock copy];
    
    [[AASLoginUserManager shareInstance] freshUserCache];
    
    BOOL isLoginedNow = [[AASLoginUserManager shareInstance] isLoginedNow];
    if (isLoginedNow) {
        NSString *gameGuestId = [[AASLoginUserManager shareInstance] getCurrentGGID];
        if (gameGuestId != nil && ![gameGuestId isEqualToString:@""]) {
            succeedBlock(gameGuestId);
            return;
        }
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
