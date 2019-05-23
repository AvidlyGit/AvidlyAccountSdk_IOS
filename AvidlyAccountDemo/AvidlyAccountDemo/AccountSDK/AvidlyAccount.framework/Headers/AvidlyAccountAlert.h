//
//  STShowGameAlert.h
//  HolaGames
//
//  Created by steve on 16/3/30.
//  Copyright © 2016年 steve. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AvidlyAccountAlertDelegate;

@interface AvidlyAccountAlert : UIViewController

@property (nonatomic,assign) id<AvidlyAccountAlertDelegate> delegate;

@property (nonatomic) UIView *contentView;

- (void)show;

- (void)changeContentView:(UIView *)contentView;

- (void)showCompletion:(void (^)(BOOL finished))completion;

- (void)hideView;

- (void)hideViewCompletion:(void (^)(BOOL finished))completion;

#pragma mark - UIKeyboardNotification

- (void)addKeyBoardNotification;
- (void)removeKeyBoardNotification;

@end


@protocol AvidlyAccountAlertDelegate <NSObject>

@optional
- (void)alertHiddenWithClickBg;

@end
