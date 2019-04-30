//
//  AvidlyAccountSDK.h
//  AvidlyAccountSDK
//
//  Created by steve on 2019/1/24.
//  Copyright © 2019 Avidly Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AASEnumDefine.h"
#import "AvidlyAccountLoginModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AvidlyAccountSDK : NSObject

+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

+ (void)initSDK:(NSString *)productId;

+ (void)setLoginCallback:(void (^)(AvidlyAccountLoginModel *model))succeedCallback errorCallback:(void (^)(NSError *error))errorCallback;

+ (void)login;

+ (NSString *)getFacebookLoginedToken;

+ (void)showUserCenter:(UIViewController *)vc;


@end

NS_ASSUME_NONNULL_END
