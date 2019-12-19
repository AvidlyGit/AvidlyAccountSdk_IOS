//
//  ViewController.m
//  AvidlyAccountDemo
//
//  Created by 何健 on 3/4/19.
//  Copyright © 2019 何健. All rights reserved.
//

#import "ViewController.h"
#import <AASAccount/AASAccountSDK.h>

@interface ViewController () {
    UIButton *_loginButton;
    UIButton *_initButton;
    UIButton *_userInfoButton;
    UIButton *_getFBTokenButton;
    UITextField *_pdtID;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pdtID = [[UITextField alloc]init];
    _pdtID.backgroundColor = [UIColor whiteColor];
    _pdtID.layer.borderWidth = 1.0f;
    _pdtID.layer.borderColor = [UIColor colorWithRed:0xbf/255.0f green:0xbf/255.0f blue:0xbf/255.0f alpha:1].CGColor;;
    _pdtID.placeholder = @"请输入产品ID,默认1000152";
    _pdtID.frame = CGRectMake(60, 100, 250, 40);
    [self.view addSubview:_pdtID];
    
    _initButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _initButton.backgroundColor = [UIColor orangeColor];
    _initButton.frame = CGRectMake(60, 170, 255, 40);
    [_initButton setTitle:@"初始化" forState:UIControlStateNormal];
    [_initButton addTarget:self action:@selector(initSDK) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_initButton];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _loginButton.backgroundColor = [UIColor orangeColor];
    _loginButton.frame = CGRectMake(60, 240, 255, 40);
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    _userInfoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _userInfoButton.backgroundColor = [UIColor orangeColor];
    _userInfoButton.frame = CGRectMake(60, 310, 255, 40);
    [_userInfoButton setTitle:@"用户中心" forState:UIControlStateNormal];
    [_userInfoButton addTarget:self action:@selector(userInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_userInfoButton];
    
    _getFBTokenButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _getFBTokenButton.backgroundColor = [UIColor orangeColor];
    _getFBTokenButton.frame = CGRectMake(60, 380, 255, 40);
    [_getFBTokenButton setTitle:@"获取FBToken" forState:UIControlStateNormal];
    [_getFBTokenButton addTarget:self action:@selector(getFBToken) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getFBTokenButton];
    
    
}

- (void)adjustCenterH:(UIView*)v{
    CGPoint center = self.view.center;
    center.y = v.frame.origin.y + v.frame.size.height/2;
    v.center = center;
}

-(void)initSDK {
    /* 第一步 初始化AccountSDK
     @param productId 产品ID，需要找项目经理获取
     */
    [AASAccountSDK initSDK:_pdtID.text];
    [self->_initButton setTitle:@"初始化成功" forState:UIControlStateNormal];
    self->_initButton.backgroundColor = [UIColor greenColor];
    self->_initButton.userInteractionEnabled = NO;
    
}

-(void)login {
    
    
    // 第二步 用户登陆
    [AASAccountSDK login];
    
    /*
     第三步 获取登陆回调
     @param model 登录类型
     model.gameGuestId 获取gameGuestId
     model.signedRequest 获取token
     */
    [AASAccountSDK setLoginCallback:^(AASAccountLoginModel * _Nonnull model) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ->_loginButton setTitle:[NSString stringWithFormat:@"ID:%@",model.gameGuestId] forState:UIControlStateNormal];
            int loginModel = model.loginMode;
            NSLog(@"loginModel is %d",loginModel);
            self->_loginButton.userInteractionEnabled = NO;
            NSLog(@"signedRequest is :%@",model.signedRequest);
        });
    } errorCallback:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ->_loginButton setTitle:[NSString stringWithFormat:@"error:%i",(int)error.code] forState:UIControlStateNormal];
        });
    }];
    

}

-(void)userInfo {
    // 用户中心
    [AASAccountSDK showUserCenter:self];
}

-(void)getFBToken {
    NSString *string = [AASAccountSDK getFacebookLoginedToken];
    NSLog(@"FB token is %@",string);
}


@end
