//
//  ValueCodex.h
//  MagicFan
//
//  Created by zc on 2017/5/25.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

/** 字库运用 */
#import <Foundation/Foundation.h>

@interface ValueCodex : NSObject

// 获取到一个字体的十进制
-(NSData *)GetStringTenStr:(NSString *)inputStr;

/** data转string(去转义符) */
- (NSString *)NSDataToByteTohex:(NSData *)data;

/** //string转data (加转义符) */
+ (NSData *)stringToByte:(NSString*)string;

/** //10转2进制 */
+ (NSString *)toBinary:(int)input;

/** //Unicode转汉字 */
- (NSString *)replaceUnicode:(NSString*)aUnicodeString;

/** 判断是否为纯字母 */
+(BOOL)PureLetters:(NSString*)str ;

/** 获取当前时间戳 */
+(NSString *)getCurrentTime ;
@end
