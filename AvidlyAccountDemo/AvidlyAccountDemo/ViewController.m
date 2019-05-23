//
//  ViewController.m
//  AvidlyAccountDemo
//
//  Created by 何健 on 3/4/19.
//  Copyright © 2019 何健. All rights reserved.
//

#import "ViewController.h"
#import <AvidlyAccount/AvidlyAccountSDK.h>

@interface ViewController () {
    UIButton *_loginButton;
    UIButton *_userInfoButton;
    UIButton *_getFBTokenButton;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _loginButton.backgroundColor = [UIColor orangeColor];
    _loginButton.frame = CGRectMake(60, 100, 255, 40);
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    _userInfoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _userInfoButton.backgroundColor = [UIColor orangeColor];
    _userInfoButton.frame = CGRectMake(60, 170, 255, 40);
    [_userInfoButton setTitle:@"用户中心" forState:UIControlStateNormal];
    [_userInfoButton addTarget:self action:@selector(userInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_userInfoButton];
    
    _getFBTokenButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _getFBTokenButton.backgroundColor = [UIColor orangeColor];
    _getFBTokenButton.frame = CGRectMake(60, 240, 255, 40);
    [_getFBTokenButton setTitle:@"获取FBToken" forState:UIControlStateNormal];
    [_getFBTokenButton addTarget:self action:@selector(getFBToken) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getFBTokenButton];
    
    /* 第一步 初始化AccountSDK
     @param productId 产品ID，需要找项目经理获取
     */
    [AvidlyAccountSDK initSDK:@"600151"];
    
    /*
     第二步 获取登陆回调
     @param model 登录类型
     model.gameGuestId 获取gameGuestId
     model.signedRequest 获取token
     */
    [AvidlyAccountSDK setLoginCallback:^(AvidlyAccountLoginModel * _Nonnull model) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ->_loginButton setTitle:[NSString stringWithFormat:@"ID:%@",model.gameGuestId] forState:UIControlStateNormal];
            self->_loginButton.userInteractionEnabled = NO;
            NSLog(@"signedRequest is :%@",model.signedRequest);
        });
    } errorCallback:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ->_loginButton setTitle:[NSString stringWithFormat:@"error:%i",(int)error.code] forState:UIControlStateNormal];
        });
    }];
}

- (void)adjustCenterH:(UIView*)v{
    CGPoint center = self.view.center;
    center.y = v.frame.origin.y + v.frame.size.height/2;
    v.center = center;
}

-(void)login {
    
    
    // 第三步 用户登陆
    [AvidlyAccountSDK login];
    

}

-(void)userInfo {
    // 用户中心
    [AvidlyAccountSDK showUserCenter:self];
}

-(void)getFBToken {
    NSString *string = [AvidlyAccountSDK getFacebookLoginedToken];
    NSLog(@"FB token is %@",string);
}


@end
