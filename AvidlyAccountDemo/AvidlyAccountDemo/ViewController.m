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
}

- (void)adjustCenterH:(UIView*)v{
    CGPoint center = self.view.center;
    center.y = v.frame.origin.y + v.frame.size.height/2;
    v.center = center;
}

-(void)login {
    [AvidlyAccountSDK loginWithProductId:@"610322" succeedBlock:^(NSString * _Nonnull gameGuestId) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ->_loginButton setTitle:[NSString stringWithFormat:@"ID:%@",gameGuestId] forState:UIControlStateNormal];
        });
        NSLog(@"GameGuestID:%@",gameGuestId);
    } errorBlock:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ->_loginButton setTitle:[NSString stringWithFormat:@"error:%i",(int)error.code] forState:UIControlStateNormal];
        });
    }];
    
//    [AvidlyAccountSDK setUserChangeCallback:^(NSString * _Nonnull gameGuestId) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self->_loginButton setTitle:[NSString stringWithFormat:@"ID:%@",gameGuestId] forState:UIControlStateNormal];
//            self->_userInfoButton.hidden = NO;
//        });
//        NSLog(@"AvidlyAccountSDK userChange gameGuestId:%@",gameGuestId);
//    }];
}

-(void)userInfo {
    [AvidlyAccountSDK showUserCenter:self];
}

@end
