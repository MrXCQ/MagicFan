//
//  UIView+ChompFan.m
//  MagicFan
//
//  Created by zc on 2017/5/22.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

#import "UIView+ChompFan.h"

@implementation UIView (ChompFan)

/**
 旋转动画
 */
-(void)startXuanZhuanAnimationWithDuration :(int)duration repeatCount:(int)count{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"] ;
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    // 围绕Z轴旋转，垂直于屏幕顺时针旋转（1.0，0.0，0.0，M_PI） 逆时针旋转（M_PI，0.0，0.0，1.0 ）
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0)] ;
    animation.duration  = duration ;
    // 顺时针效果累计，先转180 ° 接着在旋转180 实现旋转
    animation.cumulative = YES ;
    animation.repeatCount = count ;// 重复次数
    
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    
    //    CGRect imageRrect = CGRectMake(0, 0,self.frame.size.width, imageView.frame.size.height);
    //
    //    UIGraphicsBeginImageContext(imageRrect.size);
    //
    //    [self.image drawInRect:CGRectMake(1,1,imageView.frame.size.width-2,imageView.frame.size.height-2)];
    //
    //    self.image = UIGraphicsGetImageFromCurrentImageContext();
    //
    //    UIGraphicsEndImageContext();
    
    [self.layer addAnimation:animation forKey:nil];
    
}

@end
