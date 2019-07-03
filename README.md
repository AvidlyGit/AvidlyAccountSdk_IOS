# AvidlyAccountSdk_IOS
*仅以Xcode工程作示例讲解*

# 一、工程接入
## 1.1 获取SDK包 
1.首先从github:(https://github.com/AvidlyGit/AvidlyAccountSdk_IOS)
上获取工程，在目录:(AvidlyAccountSdk_IOS/AvidlyAccountDemo/AvidlyAccountDemo/)中找到AccountSDK和FacebookSDK

AccountSDK目录包含如下文件：
* AASAccount.framework
* AASAccount.bundle

FacebookSDK目录包含如下文件：
* FBSDKLoginKit.framework
* FBSDKCoreKit.framework
* Bolts.framework

## 1.2 Xcode工程添加SDK包
1. 添加AccountSDK和Facebook的SDK

请将AASAccount.framework与AASAccountSDK.bundle两个文件同时添加到你的Xcode工程目录下；

如果需要Facebook登录，请将下载下来的Facebook SDK添加到Xcode工程目录下。

2. 添加第三方依赖库

在 *TARGETS → General → Link Binary With Libraries* 中添加依赖库:

AdSupport.framework

## 1.3 工程配置
1. 添加分类编译符

在 *TARGETS → Build Setting → Linking → Other Linker Flags* 中加入 *** -ObjC ***

2. 在info.plist中加入以下节点，以兼容http模式
```
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```
3.在info.plist中加入以下节点，以便使用Facebook的登陆和对话框

*需要在Facebook的后台注册应用信息后复制粘贴，以下参数仅供参考*

```
<key>CFBundleURLTypes</key>
<array>
<dict>
<key>CFBundleURLSchemes</key>
<array>
<string>FB应用信息</string>
</array>
</dict>
</array>
<key>CFBundleVersion</key>
<string>1</string>
<key>FacebookAppID</key>
<string>FBAppID</string>
<key>FacebookDisplayName</key>
<string>FB应用名称</string>
```
FB的对话框：
```
<key>LSApplicationQueriesSchemes</key>
<array>
<string>fbapi</string>
<string>fb-messenger-share-api</string>
<string>fbauth2</string>
<string>fbshareextension</string>
</array>
```

4. 在Xcode的PROJECT -> Info -> Localizations中点击"+"，添加多语言

目前支持简体中文、繁体中文和英文三种语言

# 二、SDK接入
## 1、设置SDK
1. 在AppDelegate.m添加如下引用
```
#import <AvidlyAccountSDK.h>
```
2. 在App启动入口方法中初始化SDK
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

[AASAccountSDK application:application didFinishLaunchingWithOptions:launchOptions];  
return YES;
}
```
3. 在AppDelegate.m中添加唤醒第三方App
```
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

[AASAccountSDK application:application openURL:url
sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];

return YES;
}
```

## 2、用户登录
1. 初始化SDK

### 初始化SDK共分为三步，请依次进行：

第一步 初始化SDK
```
/**
* @ param productId：产品ID
**/
+ (void)initSDK:(NSString *)productId
```

### 示例代码：
```
/* 
初始化AccountSDK
@param productId 产品ID，需要找项目经理获取
*/
[AASAccountSDK initSDK:@"123456"];
```

第二步 用户登陆
```
+ (void)login;
```

### 示例代码：
```
[AASAccountSDK login];
```

第三步 获取登陆回调
```
/*
@param model 登录类型
model.gameGuestId 获取gameGuestId
model.signedRequest 获取token
*/
+ (void)setLoginCallback:(void (^)(AASAccountLoginModel *model))succeedCallback errorCallback:(void (^)(NSError *error))errorCallback;
```

### 示例代码：
```
[AASAccountSDK setLoginCallback:^(AASAccountLoginModel * _Nonnull model) {
dispatch_async(dispatch_get_main_queue(), ^{
[self ->_loginButton setTitle:[NSString stringWithFormat:@"ID:%@",model.signedRequest] forState:UIControlStateNormal];
});
} errorCallback:^(NSError * _Nonnull error) {
dispatch_async(dispatch_get_main_queue(), ^{
[self ->_loginButton setTitle:[NSString stringWithFormat:@"error:%i",(int)error.code] forState:UIControlStateNormal];
});
}];
```

2. 进入用户中心
```
-(void)showUserCenter:(UIViewController *)vc;
```
### 示例代码
```
[AASAccountSDK showUserCenter:self];
```
3. 获取Facebook的token值
```
+ (NSString *)getFacebookLoginedToken;
```
### 示例代码
```
NSString *string = [AASAccountSDK getFacebookLoginedToken];
```
