//
//  MBProgressHUD+XCQ_HUD.h
//  WiFiStory
//
//  Created by zc on 2017/4/1.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (XCQ_HUD)

+(UIViewController *)getCurrentUIVC ;

// 显示文字
+ (void)showTipMessageInWindow:(NSString*)message;

// 个性定制
+ (void)showPendulumWithMessage:(NSString *)message isWindow:(BOOL)iswindow;

// 隐藏HUD
+ (void)hideHUD;
@end
