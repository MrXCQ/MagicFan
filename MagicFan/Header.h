//
//  Header.h
//  MagicFan
//
//  Created by zc on 2017/5/22.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

#ifndef Header_h
#define Header_h
#import "UINavigationController+Cloudox.h"
#import "UIViewController+Cloudox.h"
#import "UIView+ChompFan.h"
#import "MBProgressHUD+XCQ_HUD.h"
#import "ValueCodex.h"

// 特效
static char magic0[] = {0xFD,0x00,0x00} ;
// 特效1
static char magic1[] = {0xFD,0x00,0x01} ;
// 特效2
static char magic2[] = {0xFD,0x00,0x02} ;
// 特效3
static char magic3[] = {0xFD,0x00,0x03} ;
// 特效4
static char magic4[] = {0xFD,0x00,0x04} ;
// 特效5
static char magic5[] = {0xFD,0x00,0x05} ;
// 特效6
static char magic6[] = {0xFD,0x00,0x06} ;
// 特效7
static char magic7[] = {0xFD,0x00,0x07} ;
// 特效8
static char magic8[] = {0xFD,0x00,0x08} ;
// 特效9
static char magic9[] = {0xFD,0x00,0x09} ;


/*
 屏幕宽度
 **/
#define Chomp_WIDTH ([UIScreen mainScreen].bounds.size.width)
/*
 屏幕高度
 **/
#define Chomp_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/*
 适配屏幕宽度
 **/
#define Chomp_WIDTHLAYOUT ([UIScreen mainScreen].bounds.size.width/375.0)

/*
 适配屏幕高度
 **/
#define Chomp_HEIGHTLAYOUT ([UIScreen mainScreen].bounds.size.height/667.0)


#endif /* Header_h */
