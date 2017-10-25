//
//  PreviewView.m
//  Core Graphics Test
//
//  Created by Eleven Chen on 15/6/30.
//  Copyright (c) 2015年 Eleven. All rights reserved.
//

#import "PreviewView.h"
#import "UIBezierPath+Text.h"
/*
 适配屏幕宽度
 **/
#define Chomp_WIDTHLAYOUT ([UIScreen mainScreen].bounds.size.width/375.0)
#define INTERVAL 0.05
static inline float radians(double degrees) { return degrees * M_PI / 180; }

@interface PreviewView(){
    BOOL flag ;// 逆时针动画flag
    BOOL TX6Flag ; // 特效6 flag
}

@property float angle;  // 变化中的角度
@property float radius; // 变化中的半径
@property int count;    // 闪烁的次数
@property float rotation; // 旋转角度
@property int openEffect;
@property int middleEffect;
@property int closeEffect;
@property (nonatomic, strong) NSTimer* timer;
@property int currentIndex; // 目前是进行哪一个效果 0开幕，1中间，2闭幕
@property (copy, nonatomic) FinishBlock finishBlock;
@property float startAngle;
@property float endAngle;
@property float maxRadius;
@property float minRadius;
@property float MorenRadius;// 文字半径


@end

@implementation PreviewView


- (void) runActionWithOpenEffect: (int)openEffect middleEffect: (int) middleEffect closeEffect: (int) closeEffect finishBlock: (FinishBlock) block
{
    
    NSLog(@"open ---  %d,middle -- %d ,close -- %d",openEffect,middleEffect,closeEffect) ;
    self.tempString =  self.string ;
    self.openEffect = openEffect;
    self.middleEffect = middleEffect;
    self.closeEffect = closeEffect;
    self.finishBlock = block;
    self.MorenRadius = self.frame.size.width * 0.4;
    [self runActionWithEffect:self.openEffect index:0];
}

- (int) nextEffect
{
    if (self.currentIndex == 0) {
        return self.middleEffect;
    } else if (self.currentIndex == 1) {
        return self.closeEffect;
    } else {
        return 255;
    }
}

- (void) runActionWithEffect:(int) effect index:(int) index;
{
    
    NSLog(@"当前下标 ---- %d",index) ;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (index > 2) {
        self.MorenRadius = self.frame.size.width * 0.4;
        [self finishAction];
        return;
    }
    self.currentIndex = index;
    if (effect == 255) {
        [self runActionWithEffect:[self nextEffect] index:index+1];
        return;
    }
    // 开幕
    if (effect == PREVIEW_LEFT2RIGHT) {
        NSLog(@"从左到右");
        self.angle = self.startAngle;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL target:self selector:@selector(updateLeft2Right: ) userInfo:nil repeats:YES];
    }
    else if (effect == PREVIEW_RIGHT2LEFT) {
        NSLog(@"从右到左");
        self.angle = self.endAngle;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL target:self selector:@selector(updateRight2Left: ) userInfo:nil repeats:YES];
    }
#pragma mark -- 特效 7
    else if (effect == PREVIEW_UP2DOWN) {
        NSLog(@"从上到下");
        self.radius = self.maxRadius;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL target:self selector:@selector(updateUp2Down: ) userInfo:nil repeats:YES];
    }
    else if (effect == PREVIEW_DOWN2UP) {
        NSLog(@"从下到上");
        self.radius = self.minRadius;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL target:self selector:@selector(updateDown2Up: ) userInfo:nil repeats:YES];
    }
    else if (effect == PREVIEW_MIDDLE2NEARBY) {
        NSLog(@"从中间到两边");
        self.angle = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL target:self selector:@selector(updateMiddle2Nearby: ) userInfo:nil repeats:YES];
    }
    else if (effect == PREVIEW_NEARBY2MIDDLE) {
        NSLog(@"从两边到中间");
        self.angle = self.endAngle - self.startAngle;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL target:self selector:@selector(updateNearby2Middle: ) userInfo:nil repeats:YES];
    }
    else if (effect == PREVIEW_ALL_DISPLAY) {
        NSLog(@"4文字移动");
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL target:self selector:@selector(updateAllDisplay: ) userInfo:nil repeats:YES];
        [self setNeedsDisplay];
    }
    else if (effect == PREVIEW_ALLWORD_DISPLAY) {
        NSLog(@"5文字移动");
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL * 20
                                                      target:self
                                                    selector:@selector(updateAllDisplay5: ) userInfo:nil
                                                     repeats:YES];
        [self setNeedsDisplay];
    }
    else if (effect == PREVIEW_ALL_EXTINGUISHES) {
        NSLog(@"全灭");
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL target:self selector:@selector(updateAllExit: ) userInfo:nil repeats:YES];
        [self setNeedsDisplay];
    }
    else if (effect == PREVIEW_FLASH2) {
        NSLog(@"闪烁两次");
        self.count = 0;
        self.angle = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL * 10 target:self selector:@selector(updateFlash2: ) userInfo:nil repeats:YES];
    }
    else if (effect == PREVIEW_ANTICLOCKWISE) {
        NSLog(@"逆时针旋转");
        self.rotation = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL target:self selector:@selector(updateAnticlockwise: ) userInfo:nil repeats:YES];
    }
    else if (effect == PREVIEW_CLOCKWISE) {
        NSLog(@"顺时针旋转");
        self.rotation = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL target:self selector:@selector(updateClockwise: ) userInfo:nil repeats:YES];

    }
    else if (effect == PREVIEW_REMAIN) {
        NSLog(@"停留");
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL * 40 target:self selector:@selector(updateRemain: ) userInfo:nil repeats:YES];
        [self setNeedsDisplay];
    }
    // 文字自右向左 特效6
    else if (effect == PREVIEW_WORDRIGHTTOLEFT_DISPLAY){
        NSLog(@"文字自右向左");
        self.rotation = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL target:self selector:@selector(updateRightToLeft: ) userInfo:nil repeats:YES];
    }

    // 文字从下往上
    else if (effect == PREVIEW_WORDDOWNTOUP){
        self.MorenRadius = self.frame.size.width * 0.2;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL*2
                                                      target:self
                                                    selector:@selector(wordUpdateDown2Up:)
                                                    userInfo:nil repeats:YES];
        [self setNeedsDisplay];
    }
    // 文字从上往下
    else if (effect == PREVIEW_WORDUPORDOWN_DISPLAY){
        self.MorenRadius = self.frame.size.width *0.6 ;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL*2
                                                      target:self
                                                    selector:@selector(wordUpdateUp2Down:)
                                                    userInfo:nil
                                                     repeats:YES];
        [self setNeedsDisplay];
    }
    
    // 默认特效
    else if (effect == PREVIEW_Default){
        self.MorenRadius = self.frame.size.width * 0.36;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL * 40
                                                      target:self
                                                    selector:@selector(wordUpdateDown2UpMoren:)
                                                    userInfo:nil
                                                     repeats:YES];
        [self setNeedsDisplay];
    }
    
}


#pragma mark -- block 回调
- (void) finishAction
{
    self.finishBlock();
}


#pragma mark --  所有特效定时器事件

// mor
-(void)defaultMagic:(NSTimer *)timer{
    
    [self runActionWithEffect:[self nextEffect] index:3];

}
// 从左到右
- (void) updateLeft2Right: (NSTimer*) timer
{
    // 从90度到450度
    if (self.angle >= self.endAngle) {
        [self runActionWithEffect:[self nextEffect] index:self.currentIndex+1];
    }
    self.angle += 1;
    [self setNeedsDisplay];
}

// 从右到左
- (void) updateRight2Left: (NSTimer* )timer
{
    NSLog(@"self.angle ---- %f,startAngle --- %f,特效 ----- %d，当前下标 --- %d",self.angle,self.startAngle,[self nextEffect],self.currentIndex);
    // 从endAngle到startAngle
    if (self.angle <= self.startAngle) {
        [self runActionWithEffect:[self nextEffect] index:self.currentIndex+1];
    }
    self.angle -= 1;
    [self setNeedsDisplay];
}

// 从上到下
- (void) updateUp2Down: (NSTimer*) timer
{
    // 从maxRadius到minRadius
    if (self.radius < self.minRadius) {
        [self runActionWithEffect:[self nextEffect] index:3];
    }

    self.radius -= 1;
    [self setNeedsDisplay];
}

// 从下到上
- (void) updateDown2Up: (NSTimer*) timer
{
    // 从minRadius到maxRadius
    if (self.radius > self.maxRadius) {
        [self runActionWithEffect:[self nextEffect] index:3];
    }
    self.radius += 1;
    [self setNeedsDisplay];
}

#pragma mark -- 文字从下而上特效
- (void)wordUpdateDown2Up :(NSTimer *)timer {
    
    if (self.MorenRadius > 110) {
        [self runActionWithEffect:[self nextEffect] index:3];
    }
    self.MorenRadius += 1;
    [self setNeedsDisplay];
}

#pragma mark -- 文字从上而下特效
- (void)wordUpdateUp2Down :(NSTimer *)timer {

    if (self.MorenRadius < 0) {
        [self runActionWithEffect:[self nextEffect] index:0];
    }
    self.MorenRadius -= 1;
    [self setNeedsDisplay];
}


#pragma mark -- 默认特效
- (void)wordUpdateDown2UpMoren :(NSTimer *)timer {
    
}


// 从中间到两边
- (void) updateMiddle2Nearby: (NSTimer*) timer
{
    NSLog(@"angle --- %f,end --- %f , start --- %f",self.angle,self.endAngle,self.startAngle) ;
    // 从0到self.endAngle - self.startAngle
    if (self.angle > self.endAngle - self.startAngle) {
        [self runActionWithEffect:[self nextEffect] index:self.currentIndex+1];
    }
    self.angle += 1;
    [self setNeedsDisplay];
}

// 从两边到中间
- (void) updateNearby2Middle: (NSTimer*) timer
{
    // 从self.endAngle - self.startAngle 到 0
    if (self.angle <= 0) {
        [self runActionWithEffect:[self nextEffect] index:self.currentIndex+1];
    }
    self.angle--;
    [self setNeedsDisplay];
}

#pragma mark -- 第四种特效
// 全显示
- (void) updateAllDisplay: (NSTimer*) timer
{
    NSLog(@"特效种类1--- %d,当前下标index---- %d",[self nextEffect],self.currentIndex +1) ;
    [self runActionWithEffect:[self nextEffect] index:self.currentIndex+1];
    [self setNeedsDisplay];
}
#pragma mark -- 第5种特效
// 全显示
- (void) updateAllDisplay5: (NSTimer*) timer
{
    NSLog(@"特效种类1--- %d,当前下标index---- %d",[self nextEffect],self.currentIndex +1) ;
    [self runActionWithEffect:[self nextEffect] index:self.currentIndex+1];
    [self setNeedsDisplay];
}
#pragma mark -- 第5种特效
// 全显示
- (void) updateAllDisplay6: (NSTimer*) timer
{
    NSLog(@"特效种类1--- %d,当前下标index---- %d",[self nextEffect],self.currentIndex +1) ;
    [self runActionWithEffect:[self nextEffect] index:self.currentIndex+1];
    [self setNeedsDisplay];
}

// 全消失
- (void) updateAllExit: (NSTimer*) timer
{
    NSLog(@"特效种类2--- %d,当前下标index---- %d",[self nextEffect],self.currentIndex +1) ;

    [self runActionWithEffect:[self nextEffect] index:self.currentIndex+1];
    [self setNeedsDisplay];
}

// 停留
- (void) updateRemain: (NSTimer* )timer
{
    NSLog(@"特效种类3--- %d,当前下标index---- %d",[self nextEffect],self.currentIndex +1) ;

    [self runActionWithEffect:[self nextEffect] index:self.currentIndex+1];
}


#pragma arguments
// 逆时针旋转
- (void) updateAnticlockwise: (NSTimer*) timer
{
    NSLog(@"特效种类4--- %d,当前下标index---- %d",[self nextEffect],self.currentIndex +1) ;
    
    // 0 到 60
    if (flag == NO) {
        if (self.rotation < -30) {
            flag = YES ;
        }
        self.rotation -= 2;
    }else{
        if (self.rotation > 30) {
            flag = NO ;
        }
        self.rotation += 2;
    }
    
    [self setNeedsDisplay];
}


#pragma mark -- 特效 6 // 文字自右向左
- (void) updateRightToLeft: (NSTimer*) timer
{
    if (TX6Flag == NO) {
        self.rotation -= 1;
        if (self.rotation == -180) {
            TX6Flag =YES ;
        }
    }else{
        self.rotation += 1;
        if (self.rotation == 1) {
            self.rotation = 0 ;
            TX6Flag = NO ;
        }
    }
    [self setNeedsDisplay];
}

// 顺时针旋转
- (void) updateClockwise: (NSTimer*) timer
{
    // 0 到 360
    if (self.rotation > 60) {
        [self runActionWithEffect:[self nextEffect] index:self.currentIndex+1];
    }
    self.rotation += 1;
    [self setNeedsDisplay];
}

// 闪烁两次
- (void) updateFlash2: (NSTimer*) timer
{
    // 显示的时候，angle = 180
    // 隐藏的时候 angle = 0
    if (self.count % 2 == 0) {
        self.angle = 180;
    } else {
        self.angle = 0;
    }
    self.count++;
    if (self.count == 4) {
        [self runActionWithEffect:[self nextEffect] index:self.currentIndex+1];
    }
    [self setNeedsDisplay];
    
}


- (void) awakeFromNib
{
    self.angle = 90;
    self.openEffect = 255;
    self.middleEffect = 255;
    self.closeEffect = 255;
    [self setNeedsDisplay];
    
    [super awakeFromNib];
}


#pragma mark --  绘制的重点 FUCK
- (void) drawRect:(CGRect)rect
{
    if (self.imageName) {
        UIImage *image = [UIImage imageNamed:self.imageName];
        [image drawInRect:rect];
    }
    
    
    CGPoint centerPt = CGPointMake(rect.size.width/2, rect.size.width/2);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    CGContextMoveToPoint(ctx, centerPt.x, centerPt.y);
    float offsetLeft = 0;
    float offsetTop = 0;

    if (self.currentIndex == 0) {
        if (self.openEffect == PREVIEW_LEFT2RIGHT) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(90), radians(self.angle), 0);
            CGContextClip(ctx);
        }
        else if (self.openEffect == PREVIEW_RIGHT2LEFT) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(90), radians(450), 0);
            CGContextClosePath(ctx);
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(90), radians(self.angle), 0);
            CGContextEOClip(ctx);
        }
        else if (self.openEffect == PREVIEW_UP2DOWN) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(0), radians(360), 0);
            CGContextClosePath(ctx);
            CGContextAddArc(ctx, centerPt.x, centerPt.y, self.radius, radians(0), radians(360), 0);
            CGContextEOClip(ctx);
        }
        else if (self.openEffect == PREVIEW_DOWN2UP) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, self.radius, radians(0), radians(360), 0);
            CGContextClosePath(ctx);
            CGContextClip(ctx);
        }
        else if (self.openEffect == PREVIEW_MIDDLE2NEARBY) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(270 - self.angle/2), radians(270 + self.angle/2), 0);
            CGContextClosePath(ctx);
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(0), radians(360), 0);
            CGContextEOClip(ctx);
        }
        else if (self.openEffect == PREVIEW_NEARBY2MIDDLE) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(270 - self.angle/2), radians(270 + self.angle/2), 0);
            CGContextClosePath(ctx);
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(0), radians(360), 0);
            CGContextEOClip(ctx);
        }
        else if (self.openEffect == PREVIEW_ALL_DISPLAY) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(90), radians(90), 0);
            CGContextClosePath(ctx);
            CGContextClip(ctx);
        }
        
        else if (self.openEffect == PREVIEW_ALLWORD_DISPLAY) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(90), radians(90), 0);
            CGContextClosePath(ctx);
            CGContextClip(ctx);
        }
        // 特效 8
        else if (self.openEffect == PREVIEW_WORDUPORDOWN_DISPLAY) {
        
            float radius = rect.size.width/2  ;
            if (radius < rect.size.width/2 -10) {
                radius = rect.size.width/2 ;
            }
            radius -= 1 ;
            CGContextAddArc(ctx, centerPt.x, centerPt.y , radius, radians(180), radians(360), 0);
            CGContextClosePath(ctx);
            // 这个是绘制遮罩
            CGContextAddArc(ctx, centerPt.x, centerPt.y, 60, radians(180), radians(360), 0);
            CGContextEOClip(ctx);
        }
        // 特效5
        else if (self.openEffect == PREVIEW_WORDDOWNTOUP){
            float radius = rect.size.width *0.1  ;
            if (radius > rect.size.width/2 + 10) {
                radius = rect.size.width *0.1 ;
            }
            radius += 1 ;
            CGContextAddArc(ctx, centerPt.x, centerPt.y , radius, radians(180), radians(360), 0);
            CGContextClosePath(ctx);
            // 这个是绘制遮罩
            CGContextAddArc(ctx, centerPt.x, centerPt.y, 110*Chomp_WIDTHLAYOUT, radians(180), radians(360), 0);
            CGContextEOClip(ctx);
        }
        else if (self.openEffect == PREVIEW_WORDRIGHTTOLEFT_DISPLAY) {
            
            // 这个是绘制遮罩
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width *0.6, radians(180), radians(360), 0);
            CGContextEOClip(ctx);
            
            CGContextTranslateCTM(ctx, rect.size.width/2, rect.size.width/2);
            offsetLeft = offsetTop = rect.size.width/2;
            CGContextRotateCTM(ctx, radians(self.rotation));
            
        }
    }
    else if (self.currentIndex == 1) {
        if (self.middleEffect == PREVIEW_FLASH2) {
            // 圆心（x,y） 半径 开始弧度和结束弧度  方向
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(270-self.angle), radians(270+self.angle), 0);
            CGContextClosePath(ctx);
            CGContextClip(ctx);
        }
        // 尝试将画布文字调整
        else if (self.middleEffect == PREVIEW_ANTICLOCKWISE) {
            // 改变画布的位置
            CGContextTranslateCTM(ctx, rect.size.width/2, rect.size.width/2);
            offsetLeft = offsetTop = rect.size.width/2;
            
            NSLog(@"特效5画布半径 -----  %f,offsetLeft --- %f,offsetTop ---  %f",self.rotation,offsetLeft,offsetTop) ;
            CGContextRotateCTM(ctx, radians(self.rotation));
        }
//        else if (self.middleEffect == PREVIEW_WORDRIGHTTOLEFT_DISPLAY) {
//            NSLog(@"特效6画布半径 -----  %f,offsetLeft --- %f,offsetTop ---  %f",self.rotation,offsetLeft,offsetTop) ;
//
//            CGContextTranslateCTM(ctx, rect.size.width/2, rect.size.width/2);
//            offsetLeft = offsetTop = rect.size.width/2;
//            CGContextRotateCTM(ctx, radians(self.rotation));
//        }
        else if (self.middleEffect == PREVIEW_CLOCKWISE) {
            CGContextTranslateCTM(ctx, rect.size.width/2, rect.size.width/2);
            offsetLeft = offsetTop = rect.size.width/2;
            CGContextRotateCTM(ctx, radians(self.rotation));
        }
        else if (self.middleEffect == PREVIEW_REMAIN) {
            // do noting
        }
    } else if (self.currentIndex == 2) {
        if (self.closeEffect == PREVIEW_LEFT2RIGHT) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(90), radians(450), 0);
            CGContextClosePath(ctx);
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(90), radians(self.angle), 0);
            
            CGContextEOClip(ctx);
        }
        else if (self.closeEffect == PREVIEW_RIGHT2LEFT) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(90), radians(self.angle), 0);
            CGContextClip(ctx);
        }
        else if (self.closeEffect == PREVIEW_UP2DOWN) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, self.radius, radians(0), radians(360), 0);
            CGContextClosePath(ctx);
            CGContextClip(ctx);
        }
        else if (self.closeEffect == PREVIEW_DOWN2UP) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(0), radians(360), 0);
            CGContextClosePath(ctx);
            CGContextAddArc(ctx, centerPt.x, centerPt.y, self.radius, radians(0), radians(360), 0);
            CGContextEOClip(ctx);
        }
        else if (self.closeEffect == PREVIEW_MIDDLE2NEARBY) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(270 - self.angle/2), radians(270 + self.angle/2), 0);
            CGContextClosePath(ctx);
            CGContextClip(ctx);
        }
        else if (self.closeEffect == PREVIEW_NEARBY2MIDDLE) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(270 - self.angle/2), radians(270 + self.angle/2), 0);
            CGContextClosePath(ctx);
            CGContextClip(ctx);
        }
        else if (self.closeEffect == PREVIEW_ALL_EXTINGUISHES) {
            CGContextAddArc(ctx, centerPt.x, centerPt.y, rect.size.width/2, radians(90), radians(91), 0);
            CGContextClosePath(ctx);
            CGContextClip(ctx);
        }
    }else if (self.currentIndex == 3){
        
    
    }
    
    UIImage *textImage = [self drawText:CGSizeMake(rect.size.width, rect.size.width)];
    [textImage drawInRect:CGRectMake(0 - offsetLeft, 0 - offsetTop, rect.size.width, rect.size.width)];
    
    CGContextRestoreGState(ctx);
    
}


#pragma mark --- 文本绘图 包含文字半径
- (UIImage*) drawText: (CGSize) size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    float r = self.MorenRadius ;
    float fontSize = self.fontSize ;
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:r startAngle:radians(0) endAngle:radians(360) clockwise:0];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.string];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, string.length)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, string.length)];

    CGRect bounding = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 context:nil];
    CGFloat length = bounding.size.width;
    CGFloat c = 2 * M_PI * r; // 控制字体的初始位置
    float offest = c / 4 * 3 - length/2; // 字体在路径上的偏移量
    float angle = (offest / c) * 360.0f; // 偏移角度
    // 特效6 的特殊处理 画布翻转
    if (self.openEffect == PREVIEW_WORDRIGHTTOLEFT_DISPLAY) {
        angle = 0 ;
    }else{
        angle = (offest / c) * 360.0f; // 偏移角度
    }
    
    self.startAngle = angle;
    self.endAngle = angle + ((length / c) * 360.0f);
    self.maxRadius = r + fontSize; // 半径减字体大小
    self.minRadius = r - fontSize;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, size.width/2, size.height/2);
    CGContextRotateCTM(ctx, radians(angle));
    [path.reversed drawAttributedString:string];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
