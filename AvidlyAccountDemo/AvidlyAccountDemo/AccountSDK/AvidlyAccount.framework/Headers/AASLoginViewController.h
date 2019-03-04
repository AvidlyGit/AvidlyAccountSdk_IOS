//
//  AASLoginViewController.h
//  AvidlyAccountSDK
//
//  Created by steve on 2019/1/31.
//  Copyright © 2019 Avidly Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AASLoginViewController : UIViewController

+ (instancetype)shareInstance;

- (void)showAutoLogin;

- (void)showHomepageLogin;

- (void)showSignupAndBindding;

@end

NS_ASSUME_NONNULL_END
