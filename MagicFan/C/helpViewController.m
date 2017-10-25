//
//  helpViewController.m
//  MagicFan
//
//  Created by zc on 2017/5/24.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

#import "helpViewController.h"
#import "UIViewController+Cloudox.h"
#import "ValueCodex.h"
@interface helpViewController ()

@end

@implementation helpViewController

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
    
    for (int i = 0; i<6; i++) {
        Byte *outByte = (Byte *)malloc(3);
        Byte *inByte  = (Byte *)malloc(4) ;
        
        memcpy(inByte, &ecodeChar[4*i], 4) ;
        
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor] ;
    self.navBarBgAlpha = @"0.0";
    
    
    
#if  0
    
    private byte[] parse18Byte(byte[] date) {
        byte[] foot = new byte[6];
        System.arraycopy(date, 12, foot, 0, 6);
        // LogUtils.e(bytesToHexString(foot));
        byte[] src = new byte[12];//原来的字节的
        System.arraycopy(date, 0, src, 0, 12);
        byte[] result = new byte[24];
        byte[] temp = new byte[12];//6字节转12字节的
        
        for (int i = 0; i < foot.length; i++) {
            byte h = (byte) ((foot[i] & 0xf0) >> 4);//0x01 h=0 l=1;
            byte l = (byte) (foot[i] & 0x0f);
            temp[i * 2] = l;
            temp[i * 2 + 1] = h;
        }
        // LogUtils.e(bytesToHexString(temp));
        for (int i = 0; i < result.length; i++) {
            if (i % 2 == 0) {
                result[i] = src[i / 2]; 
            } else { 
                result[i] = temp[i / 2]; 
            } 
        } 
        LogUtils.e(bytesToHexString(result)); 
        return result; 
    }
    
    public byte[] byte4tobyte3(byte[] arr){
        byte[] newarr = new byte[3];
        newarr[0] = arr[0];
        newarr[1] = (byte) (((arr[1]&0x0f))|(arr[2]&0x0f)<<4);
        newarr[2] = (byte) (((arr[3]&0x0f)<<4)|((arr[2]&0xf0)>>4));
        return newarr; 
    }
#endif
    
    [self CreateBackBtnWithTitle:NSLocalizedString(@"Help", nil)];
    
    NSString *tiptext = NSLocalizedString(@"HelpTip", nil) ;
    
    UITextView *textView =[[UITextView alloc]initWithFrame:CGRectMake(15, 60, self.view.frame.size.width -30, 400)];
    textView.editable = NO ;
    textView.text = tiptext ;
    textView.textColor = [UIColor whiteColor] ;
    textView.font = [UIFont systemFontOfSize:15] ;
    textView.backgroundColor =[UIColor blackColor] ;
    
    [self.view addSubview:textView];

}

 - (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];   
    }   
    return hexStr;   
}


#pragma mark -- 创建导航栏返回按钮
-(void)CreateBackBtnWithTitle:(NSString *)title {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    backBtn.frame = CGRectMake(0, 0, 50, 30) ;
    [backBtn setTitle:NSLocalizedString(@"Back", nil) forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:16] ;
    backBtn.backgroundColor = [UIColor clearColor] ;
    [self.navigationController.navigationBar bringSubviewToFront:backBtn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn] ;
    self.navigationItem.title = title ;
    
}
-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
