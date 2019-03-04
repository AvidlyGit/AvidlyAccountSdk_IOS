//
//  AASUserCenterManager.h
//  AvidlyAccountSDK
//
//  Created by steve on 2019/1/21.
//  Copyright © 2019 Avidly Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AASUserCenterManager : NSObject

+ (instancetype)shareInstance;

- (void)showUserCenter:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
