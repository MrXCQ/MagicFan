//
//  MBProgressHUD+XCQ_HUD.m
//  WiFiStory
//
//  Created by zc on 2017/4/1.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

#import "MBProgressHUD+XCQ_HUD.h"

@implementation MBProgressHUD (XCQ_HUD)

// 只显示文字
+ (void)showTipMessageInWindow:(NSString*)message{
    [self showTipMessage:message isWindow:true timer:2];
}

+ (void)showTipMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer
{
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:2];
}

#pragma mark -- 加载动画
+(void)showPendulumWithMessage:(NSString *)message isWindow:(BOOL)iswindow{
    
    MBProgressHUD *HUD = [self createMBProgressHUDviewWithMessage:message isWindiw:iswindow];
    UIImageView *backview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    backview.contentMode = UIViewContentModeScaleAspectFit ;
    
    NSMutableArray *imgArr = [NSMutableArray array] ;
    
    for (int i = 1; i<=7; i++) {
        
        [imgArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_%d",i]]];
    }
    
    for (int i = 7;i>=1; i--) {
        [imgArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_%d",i]]];
    }
    
    backview.animationImages = imgArr ;
    backview.animationDuration = 2 ;
    [backview startAnimating];
    
    HUD.customView = backview ;
    HUD.mode = MBProgressHUDModeCustomView ;
}

//获取当前屏幕显示的viewcontroller
+(UIViewController *)getCurrentWindowVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    }
    else
    {
        result = window.rootViewController;
    }
    return  result;
}

+(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [[self class]  getCurrentWindowVC ];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }
    return superVC;
}

+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow
{
    UIView  *view = isWindow? (UIView*)[UIApplication sharedApplication].delegate.window:[self getCurrentUIVC].view;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = message?message:@"加载中...";
    hud.detailsLabel.font = [UIFont systemFontOfSize:12];
    hud.removeFromSuperViewOnHide = YES;
    
//    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.7];
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.contentColor = [UIColor whiteColor];
    return hud;
}

+(void)hideHUD{
    UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:winView animated:YES];
    [self hideHUDForView:[self getCurrentUIVC].view animated:YES];
}



@end
