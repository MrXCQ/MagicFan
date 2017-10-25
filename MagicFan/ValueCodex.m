//
//  ValueCodex.m
//  MagicFan
//
//  Created by zc on 2017/5/25.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

#import "ValueCodex.h"
#import "BLEData.h"
@implementation ValueCodex
// 12*12字体Unicode编码字模数据地址计算公式：
// (Unicode  Mod  23)*512+(Unicode%23)*22

#if  0 
#pragma mark -- 伪代码解释
1.字库中获取数据为18 字节点阵数据
2.将18 字节前后按 12 + 6 拆分，将后6字节补0 成24 字节
3.将24字节数据压缩为18字节，一次最多传7个字，总文字字节为126 但总数据为128 字节后1 自己代表总行数，后2 代表当前行数
#endif

-(NSData *)GetStringTenStr:(NSString *)inputStr{
    
    NSMutableData *mutaData = [NSMutableData data] ;
    int strLength = [inputStr length];
    
    // 非全英文
    if (![self inputShouldLetter:inputStr]) {
        for (int i =0; i<strLength; i++) {
            
            NSString *str = [NSString stringWithFormat:@"%@",[inputStr substringWithRange:NSMakeRange(i, 1)]];
            NSLog(@"输入的字符 --  %@",str) ;
            if ([self isYingWenZiMu:str] == 53) {
                NSData *wordData = [self inputSingleStr:str] ;
                char* ecodeChar = (char *)[wordData bytes];
                //字库补0 转码
                Byte *bytes = [self inputDecode:ecodeChar];
                
                NSData *adata = [[NSData alloc] initWithBytes:bytes length:wordData.length];
                
                [mutaData appendData:adata];
                free(bytes);
                
            }else{
                // 包含英文字母的情况
                //字库补0 转码
                Byte *bytes = [self inputDecode:[self indexOfLetter:[self isYingWenZiMu:str]]];
                
                NSData *adata = [[NSData alloc] initWithBytes:bytes length:18];
                
                [mutaData appendData:adata];
                
                free(bytes) ;
            }
        }
    }else{
        //  全英文包含空格
        for (int i =0; i<strLength; i++) {
            // 包含英文字母的情况
            //字库补0 转码
            NSString *str = [NSString stringWithFormat:@"%@",[inputStr substringWithRange:NSMakeRange(i, 1)]];
            NSLog(@"输入的字符 --  %@",str) ;
            Byte *bytes ;
            // 英文输入空格的异常处理
            if ([str isEqualToString:@" "]) {
                NSData *wordData = [self inputSingleStr:str] ;
                char* ecodeChar = (char *)[wordData bytes];
                //字库补0 转码
                bytes = [self inputDecode:ecodeChar];
            }else{
                bytes = [self inputDecode:[self indexOfLetter:[self isYingWenZiMu:str]]];

            }
            
            NSData *adata = [[NSData alloc] initWithBytes:bytes length:12];
            
            [mutaData appendData:adata];
            
            free(bytes) ;
        }
    }
    
    return mutaData ;
}

#pragma mark -- 判断单个字符串是否为英文字母
-(int)isYingWenZiMu:(NSString *)inputStr{
    
    NSArray *arr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    
    if ([arr containsObject:inputStr]) {
        return (int)[arr indexOfObject:inputStr] ;
        
    }else return 53 ;
}

-(char *)indexOfLetter:(int)index{
    return  byteAll[index] ;
}


#pragma mark -- 单字查询字库
-(NSData *)inputSingleStr:(NSString *)single{
    
    NSString *unicode = [self utf8ToUnicode:single] ;
    NSLog(@"字符的unicode码 ----  %@",unicode) ;
    if ([unicode containsString:@"\\u"]) {
        unicode = [unicode componentsSeparatedByString:@"\\u"][1];
    }
    
    int num = [self numberHexString:unicode] ;
    
    int adress ;
    
    adress = (int)((num /23)*512 + (num%23)*22) ;
    
    NSString *file = [[NSBundle mainBundle]pathForResource:@"DynamicFont4_12" ofType:@"bin"];
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:file] ;
    
    [handle seekToFileOffset:adress + 4];
    
    NSData *data = [handle readDataOfLength:18] ;
    
    return data ;
}

// 16进制转10进制
- (int) numberHexString:(NSString *)aHexString
{
    NSString * temp10 = [NSString stringWithFormat:@"%lu",strtoul([aHexString UTF8String],0,16)];
    int cycleNumber = [temp10 intValue];
    
    return cycleNumber;
}

// str --> Unicode
-(NSString *)utf8ToUnicode:(NSString *)string
{
    NSUInteger length = [string length];
    
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    
    for (int i = 0;i < length; i++)
        
    {
        unichar _char = [string characterAtIndex:i];
        //判断是否为英文和数字
//        if (_char <= '9' && _char >='0')
//        {
//            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
//        }
//        else
        
        if(_char >='a' && _char <= 'z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
            
        }
        else if(_char >='A' && _char <= 'Z')
            
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }
        else
        {
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
            
        }
    }
    
    return s;
}



//Byte数组－>16进制数(去转义符)
- (NSString *)NSDataToByteTohex:(NSData *)data{
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr=@"";
    BOOL isZhuanYi = NO;
    BOOL addDid = NO;
    BOOL flag =YES;
    for(int i = 0 ; i<[data length] ; i++)
    {
        NSString *newHexStr = @"";
        if (isZhuanYi) {
            isZhuanYi = NO;
            if (![[NSString stringWithFormat:@"%x",bytes[i]&0xff] isEqual:@"0"]) {
                newHexStr = [NSString stringWithFormat:@"%x",(bytes[i]-19)&0xff];///16进制数
                if ([[NSString stringWithFormat:@"%x",bytes[i]&0xff] isEqual:@"26"]) {
                    if([newHexStr length]==1)
                        hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
                    else
                        hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
                    //                        ;
                    //                }else{
                    //                    hexStr = [NSString stringWithFormat:@"%@%@",hexStr,[NSString stringWithFormat:@"%x",bytes[i]&0xff]];
                }
            }else{
                addDid = YES;
                newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];
                if([newHexStr length]==1)
                    hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
                else
                    hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
            }
        }else{
            newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        }
        
      if (!addDid){
            if([newHexStr length]==1)
                hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
            else
                hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
        //        NSLog(@"hexStr:%@",hexStr);
    }
    //    NSLog(@"hexStrhexStrhexStrhexStrhexStrhexStrhexStrhexStr:%@",hexStr);
    return hexStr;
}

//16进制转10进制
+ (int)ToHex:(NSString*)tmpid
{
    int int_ch;
    unichar hex_char1 = [tmpid characterAtIndex:0];
    
    int int_ch1;
    
    if(hex_char1 >= '0'&& hex_char1 <='9')
        int_ch1 = (hex_char1-48)*16;
    else if(hex_char1 >= 'A'&& hex_char1 <='F')
        int_ch1 = (hex_char1-55)*16;
    else
        int_ch1 = (hex_char1-87)*16;
    
    unichar hex_char2 = [tmpid characterAtIndex:1];
    int int_ch2;
    if(hex_char2 >= '0'&& hex_char2 <='9')
        int_ch2 = (hex_char2-48);
    else if(hex_char2 >= 'A'&& hex_char2 <='F')
        int_ch2 = hex_char2-55;
    else
        int_ch2 = hex_char2-87;
    
    int_ch = int_ch1+int_ch2;
    
    return int_ch;
}

//string转data (加转义符)
+ (NSData*)stringToByte:(NSString*)string
{
    NSString *hexString = [[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger length = hexString.length;
//    for (int i = 2; i < length - 2; i += 2) {
//        if ([[hexString substringWithRange:NSMakeRange(i, 2)] isEqualToString:@"11"]) {
//            hexString = [hexString stringByReplacingCharactersInRange:NSMakeRange(i, 2) withString:@"1324"];
//            i += 2;
//            length += 2;
//        }else if([[hexString substringWithRange:NSMakeRange(i, 2)] isEqualToString:@"12"]){
//            hexString = [hexString stringByReplacingCharactersInRange:NSMakeRange(i, 2) withString:@"1325"];
//            i += 2;
//            length += 2;
//        }else if([[hexString substringWithRange:NSMakeRange(i, 2)] isEqualToString:@"13"]){
//            hexString = [hexString stringByReplacingCharactersInRange:NSMakeRange(i, 2) withString:@"1326"];
//            i += 2;
//            length += 2;
//        }
//    }
    Byte tempbyt[1]={0};
    NSMutableData* bytes = [NSMutableData data];
    for (int i = 0; i < hexString.length; i++)
    {
        tempbyt[0] = [self ToHex:[hexString substringWithRange:NSMakeRange(i, 2)]];  ///将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
        i++;
    }
    return bytes;
}

//10转2进制
+ (NSString *)toBinary:(int)input
{
    if (input == 1 || input == 0) {
        return [NSString stringWithFormat:@"%d", input];
    }
    else {
        return [NSString stringWithFormat:@"%@%d", [self toBinary:input / 2], input % 2];
    }
}

//Unicode转汉字
- (NSString*) replaceUnicode:(NSString*)aUnicodeString
{
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    //    NSString *result = [[NSString alloc] initWithData:tempData  encoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListMutableContainers
                                                                     format:NULL
                                                           errorDescription:NULL];
    NSLog(@"qwertyui%@",tempStr1);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}



#pragma mark --  字库取数据编码 data 补0操作
-(Byte *)inputDecode:(char *)ecodeChar{
    
    Byte *fore12Byte = (Byte *)malloc(12) ;// 前12 字节
    Byte *last6byte  = (Byte *)malloc(6) ; // 后6字节
    Byte *tempByte   = (Byte *)malloc(12) ;// 后6字节容器
    Byte *allByte    = (Byte *)malloc(24) ;// 合并后的24字节
    
    memcpy(fore12Byte, ecodeChar, 12) ;
    memcpy(last6byte, &ecodeChar[12], 6) ;
    
    for (int i = 0; i < 6; i++) {
        Byte h = (Byte) ((last6byte[i] & 0xf0) >> 4);//0x01 h=0 l=1;
        Byte l = (Byte) (last6byte[i] & 0x0f);
        tempByte[i * 2] = l;
        tempByte[i * 2 + 1] = h;
    }
    
    for (int i = 0; i < 24; i++) {
        if (i % 2 == 0) {
            allByte[i] = fore12Byte[i/2];
        } else {
            allByte[i] = tempByte[i/2];
        }
    }
    
    free(fore12Byte);
    free(last6byte);
    free(tempByte);
    
    Byte *lastOutByte = (Byte *)malloc(18) ;
    
    // 24 -> 18 位
    for (int i = 0; i<6; i++) {
        Byte *outByte = (Byte *)malloc(3);
        Byte *inByte  = (Byte *)malloc(4) ;
        
        memcpy(inByte, &allByte[4*i], 4) ;
        
        outByte[0] = inByte[0];
        outByte[1] = (Byte) (((inByte[1]&0x0f))|(inByte[2]&0x0f)<<4);
        outByte[2] = (Byte) (((inByte[3]&0x0f)<<4)|((inByte[2]&0xf0)>>4));
        
        memcpy(&lastOutByte[3*i], outByte, 3) ;
        free(inByte);
        free(outByte);
    }
    
    free(allByte) ;
    
    return lastOutByte ;
}


#pragma mark -- 判断是否为纯字母
+(BOOL)PureLetters:(NSString*)str{
    
    for(int i=0;i<str.length;i++){
        
        unichar c=[str characterAtIndex:i];
        
        if((c<'A'||c>'Z')&&(c<'a'||c>'z'))
            
            return NO;
    }
    
    return YES;
    
}


#pragma mark -- 判断是否全为字母字符串

- (BOOL)inputShouldLetter:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[a-zA-Z|\\s]+";

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}


#pragma mark -- 获取当前时间戳返回为字符串
+(NSString *)getCurrentTime{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a= [dat timeIntervalSince1970]*1000; // 精确到毫秒
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    return timeString ;
}


@end
