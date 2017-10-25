//
//  ViewController.m
//  MagicFan
//
//  Created by zc on 2017/5/22.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "Header.h"
#import "UIView+ChompFan.h"
#import "searchViewController.h"
#import "helpViewController.h"

#define channelOnCharacteristicView @"CharacteristicView"

@interface ViewController ()<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    BOOL firstBool ;
    NSString *oneLineStr, *twoLineStr ,*threeLineStr,*fourLineStr,*fiveLineStr ;
}
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) int AniType ;
@property(nonatomic,strong) MBProgressHUD *progressHUD ;
@property(nonatomic,strong) UIView *StrView;// 第一个按钮弹出的视图
@property(nonatomic,strong) UIScrollView *twoScroll ;
@property(nonatomic,strong) NSMutableArray *oneView_arr, *twoView_arr;
@property(nonatomic,strong) UIView *containerView  ;
@property(nonatomic,strong) UIView *threeView ;
@property(nonatomic,strong) UILabel *startLB , *endLB ,*twiceLB ;
@end

@implementation ViewController

// 自动测试开始时间
-(UILabel *)startLB{
    if (!_startLB) {
        _startLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 200, 30)];
        _startLB.backgroundColor = [UIColor blackColor] ;
        _startLB.textAlignment = NSTextAlignmentLeft ;
        _startLB.textColor = [UIColor whiteColor] ;
        _startLB.font = [UIFont systemFontOfSize:14*Chomp_WIDTHLAYOUT] ;
        [self.view addSubview:_startLB];
    }
    return _startLB ;
}

// 自动测试结束时间
-(UILabel *)endLB{
    if (!_endLB) {
        _endLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 140, 200, 30)];
        _endLB.backgroundColor = [UIColor blackColor] ;
        _endLB.textAlignment = NSTextAlignmentLeft ;
        _endLB.textColor = [UIColor whiteColor] ;
        _endLB.font = [UIFont systemFontOfSize:14*Chomp_WIDTHLAYOUT] ;
        [self.view addSubview:_endLB];
    }
    return _endLB ;
}

// 自动测试 间隔时间
-(UILabel *)twiceLB{
    if (!_twiceLB) {
        _twiceLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 180, 200, 30)];
        _twiceLB.backgroundColor = [UIColor blackColor] ;
        _twiceLB.textAlignment = NSTextAlignmentLeft ;
        _twiceLB.textColor = [UIColor whiteColor] ;
        _twiceLB.font = [UIFont systemFontOfSize:14*Chomp_WIDTHLAYOUT] ;
        [self.view addSubview:_twiceLB];
    }
    return _twiceLB ;
}


// 第一个弹出视图
-(UIView *)StrView{
    if (!_StrView) {
        _StrView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, Chomp_WIDTH, Chomp_HEIGHT)];
        _StrView.center = self.view.center ;
        _StrView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5] ;
        
        UITableView *strTable = [[UITableView alloc]initWithFrame:CGRectMake(0, Chomp_HEIGHT - 200, Chomp_WIDTH, 200) style:UITableViewStylePlain] ;
        strTable.delegate = self ;
        strTable.dataSource =  self ;
        
        [_StrView addSubview:strTable];
        [self.view addSubview:_StrView];
    }
    return _StrView ;
}

-(UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Chomp_WIDTH, Chomp_HEIGHT)];
        _containerView.center = self.view.center ;

        _containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5] ;
        
        
        [_containerView addSubview:self.twoScroll];
        [self.view addSubview:_containerView];

    }
    return _containerView ;
}

// 第二个弹出视图
-(UIScrollView *)twoScroll{
    if (!_twoScroll) {
        _twoScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Chomp_WIDTH, 220)];
        _twoScroll.center = CGPointMake(Chomp_WIDTH /2, Chomp_HEIGHT - 100) ;
        _twoScroll.contentSize = CGSizeMake(Chomp_WIDTH, 330 *Chomp_WIDTHLAYOUT) ;
        
        _twoScroll.backgroundColor = [UIColor whiteColor];
        _twoScroll.userInteractionEnabled = YES ;
        
        NSArray *strArr = [NSArray arrayWithObjects:@"❤", @"☆", @"★", @"●", @"◀",
                           @"▶", @"♠" , @"♣",  @"♥", @"♦",
                           @"☂", @"✈", @"☀", @"♀", @"♂",
                           @"®", @"©", @"℗", @"™", @"Ψ",
                           @"╂", @"@", @"¥", @"$",@"2", nil];
        
        float btnWidth = (Chomp_WIDTH - 4*20 - 20) / 5 ;
        for (int i = 0 ; i<5; i++) {
            for (int j = 0; j<5; j ++) {
                
                UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoScrollBtnClick:)];
                
                UILabel *button = [[UILabel alloc]initWithFrame:CGRectMake(10 +j*(btnWidth+20), 10 +i*(10+btnWidth), btnWidth, btnWidth)]; ;
                button.textColor = [UIColor blackColor] ;
                button.textAlignment = NSTextAlignmentCenter ;
                button.font = [UIFont systemFontOfSize:20] ;
                button.text = strArr[i*5 + j] ;
                button.tag = i*5 +j + 100 ;
                [button addGestureRecognizer:tapOne] ;
                button.userInteractionEnabled = YES ;
                [_twoScroll addSubview:button];
            }
        }
        
        [self.view addSubview:_twoScroll];
    }
    return _twoScroll ;
}

-(NSMutableArray *)oneView_arr{
    if (!_oneView_arr) {
        _oneView_arr = [NSMutableArray arrayWithObjects:@"❤我爱你❤",@"宝贝生日快乐",@"我的女神",@"喜欢你",@"生日快乐",@"★想你★",@"幸运☀",@"幸福♀", nil] ;
    }
    return _oneView_arr ;
}

-(NSMutableArray *)twoView_arr{
    if (!_twoView_arr) {
        _twoView_arr = [NSMutableArray arrayWithObjects:@"❤", @"☆", @"★", @"●", @"◀",
                        @"▶", @"♠", @"♣", @"♥", @"♦",
                        @"☂", @"✈", @"☀", @"♀", @"♂",
                        @"®", @"©", @"℗", @"™", @"Ψ",
                        @"╂", @"@", @"¥", @"$",@"$", nil];
    }
    return _twoView_arr ;
}


-(UIView *)threeView{
    if (!_threeView) {
        _threeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Chomp_WIDTH, Chomp_HEIGHT)];
        _threeView.center = self.view.center ;
        _threeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5] ;
        
        UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(20*Chomp_WIDTHLAYOUT, 0, Chomp_WIDTH - 40*Chomp_WIDTHLAYOUT, Chomp_WIDTH - 30*Chomp_WIDTHLAYOUT)];
        containerView.center = _threeView.center ;
        containerView.backgroundColor = [UIColor whiteColor] ;
        containerView.layer.masksToBounds = YES ;
        containerView.layer.cornerRadius = 10 ;
        
        UIColor *themeColor = [UIColor colorWithRed:51/255.0 green:147/255.0 blue:229/255.0 alpha:1.f];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
        cancelBtn.frame = CGRectMake(20*Chomp_WIDTHLAYOUT, 20*Chomp_WIDTHLAYOUT, 60*Chomp_WIDTHLAYOUT, 40*Chomp_WIDTHLAYOUT) ;
        cancelBtn.layer.masksToBounds = YES ;
        cancelBtn.layer.cornerRadius = 20*Chomp_WIDTHLAYOUT ;
        cancelBtn.backgroundColor = themeColor  ;
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16*Chomp_WIDTHLAYOUT] ;
        [cancelBtn addTarget:self action:@selector(threeCancel:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:cancelBtn];
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [sureBtn setTitle:NSLocalizedString(@"Sure", nil) forState:UIControlStateNormal];
        sureBtn.layer.masksToBounds = YES ;
        sureBtn.layer.cornerRadius = 20*Chomp_WIDTHLAYOUT ;
        sureBtn.frame = CGRectMake(Chomp_WIDTH - 120*Chomp_WIDTHLAYOUT, 20*Chomp_WIDTHLAYOUT, 60*Chomp_WIDTHLAYOUT, 40*Chomp_WIDTHLAYOUT) ;
        sureBtn.backgroundColor = themeColor  ;
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:16*Chomp_WIDTHLAYOUT] ;
        [sureBtn addTarget:self action:@selector(threeSure:) forControlEvents:UIControlEventTouchUpInside];

        [containerView addSubview:sureBtn];

        
        for (int i = 0; i<5; i++) {
         
            UILabel *lineLB = [[UILabel alloc]initWithFrame:CGRectMake(15*Chomp_WIDTHLAYOUT,i*50*Chomp_WIDTHLAYOUT +80*Chomp_WIDTHLAYOUT, 50*Chomp_WIDTHLAYOUT, 40*Chomp_WIDTHLAYOUT)];
            lineLB.text = [NSString stringWithFormat:@"第%d行",i+1] ;
            lineLB.backgroundColor = themeColor ;
            lineLB.textAlignment = NSTextAlignmentCenter ;
            lineLB.textColor = [UIColor whiteColor] ;
            lineLB.font = [UIFont systemFontOfSize:14*Chomp_WIDTHLAYOUT] ;
            lineLB.layer.masksToBounds = YES ;
            lineLB.layer.cornerRadius = 20*Chomp_WIDTHLAYOUT ;
            [containerView addSubview:lineLB];
            
            UITextField *inputText = [[UITextField alloc]initWithFrame:CGRectMake(80*Chomp_WIDTHLAYOUT,i*50*Chomp_WIDTHLAYOUT +80*Chomp_WIDTHLAYOUT, Chomp_WIDTH - 140*Chomp_WIDTHLAYOUT, 40*Chomp_WIDTHLAYOUT)];
            inputText.layer.cornerRadius = 20*Chomp_WIDTHLAYOUT ;
            inputText.layer.masksToBounds = YES ;
            inputText.layer.borderColor = themeColor.CGColor ;
            inputText.layer.borderWidth = 0.5 ;
            inputText.delegate = self ;
            inputText.tag = 200 +i ;
            [containerView addSubview:inputText];
        }
    
        [_threeView addSubview:containerView];
        [self.view addSubview:_threeView ];
    }
    return _threeView ;
}

-(MBProgressHUD *)progressHUD{
    self.progressHUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES] ;
    
    // Set the bar determinate mode to show task progress.
    self.progressHUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    self.progressHUD.label.text = NSLocalizedString(@"正在发送数据...", @"HUD loading title");
    // 发送进度显示
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        // Do something useful in the background and update the HUD periodically.
        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.125f;
            dispatch_async(dispatch_get_main_queue(), ^{
                // Instead we could have also passed a reference to the HUD
                // to the HUD to myProgressTask as a method parameter.
                [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow].progress = progress;
            });
            usleep(50000);
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressHUD hideAnimated:YES afterDelay:3];
        });
    });
    return  self.progressHUD ;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navBarBgAlpha = @"0.0";
    
    self.AniView2.string = NSLocalizedString(@"defaultTip", nil);
    self.textView.text = NSLocalizedString(@"defaultTip", nil);
    self.AniView2.fontSize = 30.0f ;
    [self.xuanzhuanImg startXuanZhuanAnimationWithDuration:2.0 repeatCount:999999999];
    self.AniType =  0 ;
    // 切换特效
    if (self.AniType == 0) {
        self.magicLable.text = NSLocalizedString(@"defaultMagic", nil) ;
        
    }else    self.magicLable.text = [NSString stringWithFormat:@"%@:%d",NSLocalizedString(@"Effects", nil),self.AniType] ;
    [self animationWithIndexo:self.AniType];
    [self autolayout];
    [self configView];
    NSLog(@"self.currPeripheral ---  %@,self.service ----  %@",self.currPeripheral,self.service) ;
    
    if (self.currPeripheral && self.service) {
        
        for (CBCharacteristic *characteristic in self.service.characteristics) {
            NSString *str = [NSString stringWithFormat:@"%@",characteristic.UUID] ;
            if ([str isEqualToString:@"00010203-0405-0607-0809-0A0B0C0D2B10"]) {
                self.characteristicNoti = characteristic ;
            }else if ([str isEqualToString:@"00010203-0405-0607-0809-0A0B0C0D2B11"]){
                self.characteristicWrite = characteristic ;
            }else{
                NSLog(@"---------------  %@",characteristic) ;
            }
        }
        
        //配置ble委托
        [self babyDelegate];
        
        [baby notify:self.currPeripheral characteristic:self.characteristicNoti block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
            NSLog(@"resume notify block");
        }];
//        //读取服务
//        baby.channel(channelOnCharacteristicView).characteristicDetails(self.currPeripheral,self.characteristicWrite);
    
    }
    
    
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"StartOne"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"End"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"response"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    self.currPeripheral = nil ;
    self.characteristicNoti = nil ;
    self.characteristicWrite = nil ;
    
    self.startLB = nil ;
    self.endLB = nil ;
    self.twiceLB = nil ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
 

    
    // 自动测试使用
//    [self addPostObserver];
}

#pragma mark -- 数据包发送完毕事件
-(void)addPostObserver{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self
               selector:@selector(BleReceiveNotificiation:)
                   name:@"BleResponse"
                 object:nil];
    
    [center addObserver:self
               selector:@selector(endTime:)
                   name:@"END"
                 object:nil];
    
}

-(void)endTime:(NSNotification *)noti{
    
    NSString *endTime = [[NSUserDefaults standardUserDefaults]valueForKey:@"End"];
    
    self.endLB.text = [NSString stringWithFormat:@"结束时间: %@",[self timeWithTimeIntervalString:endTime]] ;
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"BleResponse" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"END" object:nil];

}

-(void)BleReceiveNotificiation:(NSNotification *)noti{

    if (noti.object) {
       CBCharacteristic *characteristics = (CBCharacteristic *)noti.object ;
        NSLog(@"蓝牙响应的值 ----  %@",characteristics.value) ; // <ff07>
        NSData *dataWord = [ValueCodex stringToByte:@"ff07"] ;
        NSData *dataBigWorh = [ValueCodex stringToByte:@"FE03"] ;
        NSData *dataMagic = [ValueCodex stringToByte:@"FD00"] ;
        
        self.magicLable.text = [[[ValueCodex alloc]init] NSDataToByteTohex:characteristics.value] ;
  
        if ([characteristics.value isEqualToData:dataMagic]) {
            NSLog(@"数据包已发完") ;

            
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.23/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self MobileStrToBLEData:[self inputType:self.AniType]
                                 withStr:self.textView.text currentLine:1 allLine:1];
            });
        }else if ([characteristics.value isEqualToData:dataWord]){
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.23/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                char BigWord[]    = {0xFE,0x00,0x03};
                [self MobileToBLEWriteData:BigWord];
            });
        }else if ([characteristics.value isEqualToData:dataBigWorh]){
            
            // 获取到蓝牙回复的时间
            NSString *responseTime = [ValueCodex getCurrentTime] ;
            
            [[NSUserDefaults standardUserDefaults] setValue:responseTime forKey:@"response"];
            
            NSString *start = [[NSUserDefaults standardUserDefaults]valueForKey:@"Start"];
            
            long long twiceTime = [responseTime longLongValue] - [start longLongValue]  ;
            
            NSLog(@"间隔时间------ %lld",[responseTime longLongValue] -[start longLongValue] ) ;
            
            self.twiceLB.text = [NSString stringWithFormat:@"间隔时间 : %lldms",twiceTime];
            
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.23/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self animationWithIndexo:self.AniType];
                [self MobileToBLEWriteData:[self inputType:self.AniType]];
            });
        }else{
            NSLog(@"haha~");
        }
    }
}


#pragma mark -- configView
-(void)configView{
    self.navigationController.navigationBar.translucent = YES ;
    self.navigationItem.title = NSLocalizedString(@"APPName", nil) ;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor cyanColor]}];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    UIImage *bgImg = [UIImage imageNamed:@"wenbenkuang"] ;
    
    self.textView.delegate = self ;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.textView.frame.size.width, self.textView.frame.size.height -10)];
    imageView.image = bgImg;
    imageView.center = self.textView.center ;
    [self.textView addSubview:imageView];
    [self.textView sendSubviewToBack:imageView];
    self.textView.delegate = self ;
    [self.helpBtn addTarget:self action:@selector(helpBtn:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.refreshBtn addTarget:self action:@selector(refreshBtn:) forControlEvents:UIControlEventTouchUpInside] ;
 
    self.AniView2.layer.masksToBounds = YES ;
    self.AniView2.layer.cornerRadius = 110 * Chomp_WIDTHLAYOUT  ;
}

#pragma mark -- 检测输入框内容
- (void)textViewDidChange:(UITextView *)textView{
    
    NSLog(@"str --  %@",textView.text) ;
    
    if (self.textView.text.length) {
        if ([self inputShouldLetter:self.textView.text]) {
            if (self.textView.text.length >10) {
                self.AniView2.string = [NSString stringWithFormat:@"%@",[self.textView.text substringWithRange:NSMakeRange(0, 10)]] ;
            }else{
                self.AniView2.string = [NSString stringWithFormat:@"%@",self.textView.text] ;
            }
            
        }else{
            if (self.textView.text.length >7) {
                self.AniView2.string = [NSString stringWithFormat:@"%@",[self.textView.text substringWithRange:NSMakeRange(0, 7)]] ;
            }else{
                self.AniView2.string = [NSString stringWithFormat:@"%@",self.textView.text] ;
            }
        }
    }
}


- (void)refreshBtn:(UIButton *)sender {
    NSLog(@"刷新") ;
    __weak typeof(self) weakSelf = self ;
    searchViewController *searchVC = [[searchViewController alloc]init] ;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        searchVC.BleBlock = ^(CBService *service,CBPeripheral *currPeripheral){
            NSLog(@"str ---- %@",service) ;
            if (service) {
                weakSelf.service = service ;
                weakSelf.currPeripheral = currPeripheral ;
            }
        } ;
        
        [weakSelf presentViewController:searchVC animated:YES completion:^{
            
        }];
    }) ;
}
- (void)helpBtn:(UIButton *)sender {
    NSLog(@"帮助") ;
    [self.navigationController pushViewController:[[helpViewController alloc]init] animated:YES];

}
- (IBAction)rightBtnClick:(id)sender {
    self.AniType ++ ;
    if (self.AniType == 10) {
        self.AniType = 0 ;
    }
    [self animationWithIndexo:self.AniType];

    // 切换特效
    if (self.AniType == 0) {
        self.magicLable.text = NSLocalizedString(@"defaultMagic", nil) ;
    }else    self.magicLable.text = [NSString stringWithFormat:@"%@:%d",NSLocalizedString(@"Effects", nil),self.AniType] ;
}
- (IBAction)leftBtnClick:(id)sender {
    self.AniType -- ;
    if (self.AniType < 0) {
        self.AniType = 9 ;
    }
    [self animationWithIndexo:self.AniType];

    // 切换特效
    if (self.AniType == 0) {
        self.magicLable.text = NSLocalizedString(@"defaultMagic", nil) ;
    }else    self.magicLable.text = [NSString stringWithFormat:@"%@:%d",NSLocalizedString(@"Effects", nil),self.AniType] ;
}

#pragma mark -- 确认发送特效
- (IBAction)okMagicBtn:(id)sender {
    [self MobileToBLEWriteData:[self inputType:self.AniType]];
}

#pragma mark -- 第1个按钮
- (IBAction)writeWord:(id)sender {
    
    UIButton *button = (UIButton *)sender ;
    button.selected = !button.selected ;
    
    self.StrView.hidden = NO ;

}

#pragma mark -- 第2个按钮
- (IBAction)like:(id)sender {
    NSLog(@"喜欢") ;
    
    UIButton *button = (UIButton *)sender ;
    button.selected = !button.selected ;
    
    self.containerView.hidden = NO ;
}

#pragma mark -- 第3个按钮
- (IBAction)add:(id)sender {
    NSLog(@"添加") ;
    self.threeView.hidden =NO ;
}

// 弹窗取消按钮
-(void)threeCancel:(UIButton *)btn{
    self.threeView.hidden =YES ;
    self.threeView = nil  ;

    [self.view endEditing:YES];
}
// 弹窗确定按钮
-(void)threeSure:(UIButton *)btn{
    
    for (UIView *view in self.threeView.subviews) {
        UITextField *one = (UITextField *)[view viewWithTag:200] ;
        UITextField *two = (UITextField *)[view viewWithTag:201] ;
        UITextField *three = (UITextField *)[view viewWithTag:202] ;
        UITextField *four = (UITextField *)[view viewWithTag:203] ;
        UITextField *five = (UITextField *)[view viewWithTag:204] ;
        
        oneLineStr = [NSString stringWithFormat:@"%@",one.text];
        twoLineStr = [NSString stringWithFormat:@"%@",two.text];
        threeLineStr = [NSString stringWithFormat:@"%@",three.text];
        fourLineStr = [NSString stringWithFormat:@"%@",four.text];
        fiveLineStr = [NSString stringWithFormat:@"%@",five.text];
        
        if (oneLineStr.length >10) {
            oneLineStr = [oneLineStr substringWithRange:NSMakeRange(0, 10)];
        }
    }
    
    NSLog(@"1 --- %@,2 ---  %@,3--- %@,4 --- %@,5 ---- %@",oneLineStr,twoLineStr,threeLineStr,fourLineStr,fiveLineStr) ;
    NSMutableArray *lineArr = [NSMutableArray arrayWithObjects:oneLineStr,twoLineStr,threeLineStr,fourLineStr,fiveLineStr, nil] ;
    
    if (self.currPeripheral && self.service) {
        
        // 判断行数 多屏发送
        NSString *inputS = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@",oneLineStr,twoLineStr,threeLineStr,fourLineStr,fiveLineStr] ;
        
        if (lineArr.count) {
            self.AniView2.string = [NSString stringWithFormat:@"%@",lineArr[0]] ;
            self.textView.text = [inputS substringWithRange:NSMakeRange(0, 7)] ;
        }
        int currentLine ;
        
        if (lineArr.count) {
            for (int i = 0; i< lineArr.count; i++) {
                currentLine = i ;
                
                [NSThread sleepForTimeInterval:0.25] ;
                
                [self MobileStrToBLEData:[self inputType:self.AniType]
                                 withStr:lineArr[i]
                             currentLine:currentLine
                                 allLine:(int)lineArr.count-1];
            }
        }
    }else{
        [MBProgressHUD showTipMessageInWindow:NSLocalizedString(@"PleaseConnect", nil)];
    }

    
}

#pragma mark -- 确认按钮
- (IBAction)sureBtn:(id)sender {
    NSLog(@"点击了确定");
  
    self.StrView.hidden = YES ;
    self.containerView.hidden = YES ;
    [self.textView resignFirstResponder];
    
    if (self.currPeripheral && self.service) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ackBLEDataHUD];
        });
        // 判断行数 多屏发送
        NSString *inputS = [NSString stringWithFormat:@"%@",self.textView.text] ;
        NSArray *lineArr = [NSArray array] ;
        
        if ([inputS containsString:@"\n"]) {
            lineArr = [inputS componentsSeparatedByString:@"\n"] ;
            NSLog(@"行数 --  %d",lineArr.count) ;
        }
        
        if (self.textView.text.length) {
            if ([self inputShouldLetter:self.textView.text]) {
                if (self.textView.text.length >10) {
                    self.AniView2.string = [NSString stringWithFormat:@"%@",[self.textView.text substringWithRange:NSMakeRange(0, 10)]] ;
                }else{
                    self.AniView2.string = [NSString stringWithFormat:@"%@",self.textView.text] ;
                }
                
            }else{
                if (self.textView.text.length >7) {
                    self.AniView2.string = [NSString stringWithFormat:@"%@",[self.textView.text substringWithRange:NSMakeRange(0, 7)]] ;
                }else{
                    self.AniView2.string = [NSString stringWithFormat:@"%@",self.textView.text] ;
                }
            }
            
        }
        #pragma mark -- 多屏发送判断
        int currentLine ;
        int allLine  ;
        if (lineArr.count == 0) {
            allLine = 1 ;
            lineArr = [NSArray arrayWithObjects:self.textView.text, nil];
        }else if (lineArr.count > 5){
            allLine = 5 ;
        }else{
            allLine =(int)lineArr.count;
        }
        
        for (int i = 0; i< allLine; i++) {
            currentLine = i ;
            
            [NSThread sleepForTimeInterval:0.25] ;
            [self MobileStrToBLEData:[self inputType:self.AniType]
                             withStr:lineArr[i] currentLine:currentLine allLine:allLine-1];
        }
        
    }else{
        [MBProgressHUD showTipMessageInWindow:NSLocalizedString(@"PleaseConnect", nil)];
    }
}

#pragma mark -- 返回特效
-(char *)inputType:(int)type{
    if (self.AniType == 0) {
        return magic0 ;
    }else if (self.AniType == 1){
        return magic1 ;
    }else if (self.AniType == 2){
        return magic2 ;
    }else if (self.AniType == 3){
        return magic3 ;;
    }else if (self.AniType == 4){
        return magic4 ;
    }else if (self.AniType == 5){
        return magic5 ;
    }else if (self.AniType == 6){
        return magic6 ;;
    }else if (self.AniType == 7){
        return magic7 ;
    }else if (self.AniType == 8){
        return magic8 ;
    }else return magic9 ;
}

#pragma mark -- 蓝牙写值
-(void)MobileToBLEWriteData:(char *)byte
{
    if (self.currPeripheral && self.service) {

#pragma mark -- 自动测试
 
            // 保存开始时间
            NSString *StartTime = [ValueCodex getCurrentTime] ;
            
            [[NSUserDefaults standardUserDefaults] setValue:StartTime forKey:@"Start"];
            
            NSLog(@"数据发送时间 ----  %@",StartTime) ;

            [self setNotifiy:nil];
        
            NSData * data = [NSData dataWithBytes:byte length:sizeof(byte)];
            
            [self.currPeripheral writeValue:data
                          forCharacteristic:self.characteristicWrite
                                       type:CBCharacteristicWriteWithoutResponse];
            // 主线程执行：
            dispatch_async(dispatch_get_main_queue(), ^{
                // something
                [self ackBLEDataHUD];
            });
        
    }else{
       [MBProgressHUD showTipMessageInWindow:NSLocalizedString(@"PleaseConnect", nil)];
    }
}

#pragma mark -- 字体发送的数据居中显示
-(NSData *)inputWordNum:(int)num iputData:(NSData *)inData{

    // 需要左右补得字节数
    int needNum = 7 - num ;
    
    NSString *oneByte = @"000000000000000000" ;
    
    //真实有效的数据
    NSString *realDataStr = [[[ValueCodex alloc]init] NSDataToByteTohex:inData] ;
    
    for (int i = 0; i< needNum; i++) {
        
        realDataStr = [NSString stringWithFormat:@"%@%@%@",oneByte,realDataStr,oneByte] ;
    }
    
    if (num == 7) {
        return inData ;
    }else{
        return [ValueCodex stringToByte:realDataStr] ; ;
    }
}

#pragma mark -- 蓝牙分包发送数据
-(void)MobileStrToBLEData:(char *)byte withStr:(NSString *)inputStr currentLine:(int)currenline allLine:(int)allLine{
    
    if (self.currPeripheral && self.service) {
        
        [self setNotifiy:nil];
        ValueCodex *codeX = [[ValueCodex alloc]init];
        
        // 如果是全英文 截取前 10
        if ([self inputShouldLetter:inputStr]) {
            if (inputStr.length > 10) {
                inputStr = [inputStr substringWithRange:NSMakeRange(0, 10)];
            }
        }else{
            if (inputStr.length > 7) {
                inputStr = [inputStr substringWithRange:NSMakeRange(0, 7)];
            }
        }
        
        NSData *data1 = [codeX GetStringTenStr:inputStr];
        
        char container[128] = {0} ;

        [data1 getBytes:&container[0] range:NSMakeRange(0, data1.length)];
        
        NSData *containerData = [NSData dataWithBytes:container length:128] ;
        
        #pragma mark -- 居中显示
        
        // 多少个字
        int index = (int) data1.length/18 ;
        if (data1.length == 120) {
            index = 7 ;
        }
        containerData = [self inputWordNum:index iputData:containerData];
        
        char SmallWord1[]  = {0xFF,0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00};
        
        [containerData getBytes:&SmallWord1[3] range:NSMakeRange(0, 16)];
        
        char SmallWord2[]  = {0xFF,0x00,0x01,0x01,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00};
        
        [containerData getBytes:&SmallWord2[3] range:NSMakeRange(16, 16)];
        
        char SmallWord3[]  = {0xFF,0x00,0x02,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00};
        
        [containerData getBytes:&SmallWord3[3] range:NSMakeRange(32, 16)];
        
        char SmallWord4[]  = {0xFF,0x00,0x03,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00};
        
        [containerData getBytes:&SmallWord4[3] range:NSMakeRange(48, 16)];
        
        char SmallWord5[]  = {0xFF,0x00,0x04,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00};
        
        [containerData getBytes:&SmallWord5[3] range:NSMakeRange(64, 16)];
        
        char SmallWord6[]  = {0xFF,0x00,0x05,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00};
        
        [containerData getBytes:&SmallWord6[3] range:NSMakeRange(80, 16)];
        
        char SmallWord7[]  = {0xFF,0x00,0x06,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00};
        [containerData getBytes:&SmallWord7[3] range:NSMakeRange(96, 16)];
        
        NSString *current = [NSString stringWithFormat:@"0%d",currenline] ;
        NSString *all = [NSString stringWithFormat:@"0%d",allLine] ;
        
        #pragma mark -- 多屏发送的数据
        NSData *lastData = [ValueCodex stringToByte:[current stringByAppendingString:all]];
        
        char SmallWord8[]  = {0xFF,0x00,0x07,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00,
            0x00,0x00};
        
        [containerData getBytes:&SmallWord8[3] range:NSMakeRange(112, 16)];
        [lastData getBytes:&SmallWord8[17] range:NSMakeRange(0, 2)];
 
        for (int i = 1; i<=8; i++) {
            
            if (i == 1) {
#pragma mark -- 自动测试
                NSString *saveTime = [[NSUserDefaults standardUserDefaults]valueForKey:@"StartOne"];
                if (!saveTime.length) {
                    NSString *StartTime = [ValueCodex getCurrentTime] ;
                    
                    [[NSUserDefaults standardUserDefaults] setValue:StartTime forKey:@"StartOne"];
                    
                    self.startLB.text = [NSString stringWithFormat:@"开始时间: %@", [self timeWithTimeIntervalString:StartTime]] ;
                    
                    NSLog(@"数据发送时间 ----  %@",StartTime) ;
                }
            }
            
            Byte *fireByte = (Byte *)malloc(19) ;
            if (i==1) {
                memcpy(fireByte, SmallWord1, 19) ;
            }else if (i==2){
                memcpy(fireByte, SmallWord2, 19) ;
            }
            else if (i==3){
                memcpy(fireByte, SmallWord3, 19) ;
            }
            else if (i==4){
                memcpy(fireByte, SmallWord4, 19) ;
            }
            else if (i==5){
                memcpy(fireByte, SmallWord5, 19) ;
            }
            else if (i==6){
                memcpy(fireByte, SmallWord6, 19) ;
            }
            else if (i==7){
                memcpy(fireByte, SmallWord7, 19) ;
            }
            else{
                memcpy(fireByte, SmallWord8, 19) ;
            }
            
            NSData *fireData = [NSData dataWithBytes:fireByte length:19] ;
            
            NSLog(@"每一次发送的数据 ---  %@",[[[ValueCodex alloc]init] NSDataToByteTohex:fireData]);
            
            [NSThread sleepForTimeInterval:0.2] ;

            [self.currPeripheral writeValue:fireData
                          forCharacteristic:self.characteristicWrite
                                       type:CBCharacteristicWriteWithoutResponse];
            
            free(fireByte);
        }
    }else{
        [MBProgressHUD showTipMessageInWindow:NSLocalizedString(@"PleaseConnect", nil)];
    }
}

-(void)magic{
    [self animationWithIndexo:self.AniType];
}

#pragma mark -- 特效
-(void)animationWithIndexo:(int)type{
    __weak typeof(self) weakSelf = self ;
    
    NSLog(@"特效 --------- %d",type) ;
    
    // 默认状态
    if (type == 0) {
        [self.AniView2 runActionWithOpenEffect:PREVIEW_Default middleEffect:255 closeEffect:PREVIEW_DOWN2UP finishBlock:^{
            NSLog(@"finish");
            [weakSelf magic];
        }];
    }else if (type == 1){
        
        [self.AniView2 runActionWithOpenEffect:PREVIEW_MIDDLE2NEARBY middleEffect:255 closeEffect:PREVIEW_MIDDLE2NEARBY finishBlock:^{
            NSLog(@"finish");
            [weakSelf magic];
        }];
        
    }else if (type == 2){
        
        [self.AniView2 runActionWithOpenEffect:PREVIEW_LEFT2RIGHT middleEffect:PREVIEW_REMAIN closeEffect:PREVIEW_RIGHT2LEFT finishBlock:^{
            [weakSelf magic];
        }];
        
    }else if (type == 3){
        [self.AniView2 runActionWithOpenEffect:PREVIEW_NEARBY2MIDDLE middleEffect:255 closeEffect:PREVIEW_NEARBY2MIDDLE finishBlock:^{
            NSLog(@"finish");
            [weakSelf magic];
        }];
    }else if (type == 4){
        [self.AniView2 runActionWithOpenEffect:PREVIEW_ALL_DISPLAY middleEffect:PREVIEW_ANTICLOCKWISE closeEffect:PREVIEW_ALL_DISPLAY finishBlock:^{
            NSLog(@"finish");
            [weakSelf magic];
        }];
        
    }else if (type == 5){
        [self.AniView2 runActionWithOpenEffect:PREVIEW_WORDDOWNTOUP middleEffect:PREVIEW_ANTICLOCKWISE closeEffect:PREVIEW_ALLWORD_DISPLAY finishBlock:^{
            NSLog(@"finish");
            [weakSelf magic];
        }];
    }else if (type == 6){
        // 存在问题 文字从右往左 然后遮罩从左往右回去
        [self.AniView2 runActionWithOpenEffect:PREVIEW_WORDRIGHTTOLEFT_DISPLAY middleEffect:PREVIEW_WORDRIGHTTOLEFT_DISPLAY closeEffect:PREVIEW_WORDRIGHTTOLEFT_DISPLAY finishBlock:^{
            NSLog(@"finish");
            [weakSelf magic];
        }];
    }else if (type == 7 ){
        [self.AniView2 runActionWithOpenEffect:PREVIEW_UP2DOWN middleEffect:255 closeEffect:PREVIEW_UP2DOWN finishBlock:^{
            NSLog(@"finish");
            [weakSelf magic];
        }];
    }else if (type == 8){
        [self.AniView2 runActionWithOpenEffect:PREVIEW_WORDUPORDOWN_DISPLAY middleEffect:PREVIEW_WORDUPORDOWN_DISPLAY closeEffect:PREVIEW_WORDUPORDOWN_DISPLAY finishBlock:^{
            NSLog(@"finish");
            [weakSelf magic];
        }];
    }else{
        [self.AniView2 runActionWithOpenEffect:PREVIEW_DOWN2UP middleEffect:255 closeEffect:PREVIEW_DOWN2UP finishBlock:^{
            NSLog(@"finish");
            [weakSelf magic];
        }];
    }
}

-(BOOL)shouldAutorotate{
    return NO ;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.StrView.hidden = YES ;
    self.containerView.hidden = YES ;
    [self.view endEditing:YES];

    [self.textView resignFirstResponder];
}

#pragma mark -- autolayout
-(void)autolayout{
    __weak typeof(self)weakSelf = self ;
    
    [self.tipLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 20)) ;
        make.top.equalTo(weakSelf.view).with.offset(64) ;
        make.centerX.equalTo(weakSelf.view) ;
    }];
    
    [self.magicLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 20)) ;
        make.top.equalTo(weakSelf.view).with.offset(64) ;
        make.left.equalTo(weakSelf.view).with.offset(5) ;
    }];
    
    [self.fanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(255*Chomp_HEIGHTLAYOUT, 361*Chomp_HEIGHTLAYOUT)) ;
        make.centerX.equalTo(weakSelf.view) ;
        make.top.equalTo(weakSelf.view).with.offset(86) ;
        
    }];
    
    [self.AniView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(255*Chomp_HEIGHTLAYOUT, 260*Chomp_HEIGHTLAYOUT)) ;
        make.centerX.equalTo(weakSelf.view) ;
        make.top.equalTo(weakSelf.view).with.offset(86) ;
    }];
    
    [self.xuanzhuanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(255*Chomp_HEIGHTLAYOUT, 260*Chomp_HEIGHTLAYOUT)) ;
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0)) ;
    }];
    
    [self.AniView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(220*Chomp_HEIGHTLAYOUT, 220*Chomp_HEIGHTLAYOUT)) ;
        make.centerX.equalTo(weakSelf.view) ;
        make.centerY.equalTo(weakSelf.xuanzhuanImg);
    }];
    
    [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(55*Chomp_HEIGHTLAYOUT, 55*Chomp_HEIGHTLAYOUT)) ;
        make.centerX.equalTo(weakSelf.view) ;
        make.centerY.equalTo(weakSelf.xuanzhuanImg).with.offset(-3.8*Chomp_HEIGHTLAYOUT);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 25)) ;
        make.top.equalTo(weakSelf.view).with.offset(220 *Chomp_HEIGHTLAYOUT) ;
        make.left.equalTo(weakSelf.view).with.offset(16) ;
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 25)) ;
        make.top.equalTo(weakSelf.view).with.offset(220 *Chomp_HEIGHTLAYOUT) ;
        make.right.equalTo(weakSelf.view).with.offset(-16) ;
    }];
    
    [self.LeftClick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 30)) ;
        make.top.equalTo(weakSelf.view).with.offset(220 *Chomp_HEIGHTLAYOUT) ;
        make.left.equalTo(weakSelf.view).with.offset(6) ;
    }];
    
    [self.rightClick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 30)) ;
        make.top.equalTo(weakSelf.view).with.offset(220 *Chomp_HEIGHTLAYOUT) ;
        make.right.equalTo(weakSelf.view).with.offset(-6) ;
    }];
    
    [self.smallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35)) ;
        make.top.equalTo(weakSelf.fanImg.mas_bottom).with.offset(-8) ;
        make.left.equalTo(weakSelf.view).with.offset(13) ;
    }];
    
    [self.normalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35)) ;
        make.top.equalTo(weakSelf.fanImg.mas_bottom).with.offset(-8) ;
        make.centerX.equalTo(weakSelf.view) ;
    }];
    
    [self.bigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35)) ;
        make.top.equalTo(weakSelf.fanImg.mas_bottom).with.offset(-8) ;
        make.right.equalTo(weakSelf.view).with.offset(-13) ;
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(343*Chomp_HEIGHTLAYOUT, 80 *Chomp_HEIGHTLAYOUT)) ;
        make.top.equalTo(weakSelf.fanImg.mas_bottom).with.offset(35) ;
        make.centerX.equalTo(weakSelf.view) ;
    }];
    
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(343*Chomp_HEIGHTLAYOUT, 92 *Chomp_HEIGHTLAYOUT)) ;
        make.top.equalTo(weakSelf.fanImg.mas_bottom).with.offset(40) ;
        make.centerX.equalTo(weakSelf.view) ;
    }];
    
    [self.oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40 )) ;
        make.top.equalTo(weakSelf.textView.mas_bottom).with.offset(15) ;
        make.left.equalTo(weakSelf.view).with.offset(16) ;
    }];
    
    [self.twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40 )) ;
        make.top.equalTo(weakSelf.textView.mas_bottom).with.offset(15) ;
        make.left.equalTo(weakSelf.oneBtn.mas_right).with.offset(10) ;
    }];
    
    [self.threeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40 )) ;
        make.top.equalTo(weakSelf.textView.mas_bottom).with.offset(15) ;
        make.left.equalTo(weakSelf.twoBtn.mas_right).with.offset(10) ;
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(122*Chomp_WIDTHLAYOUT, 40 )) ;
        make.top.equalTo(weakSelf.textView.mas_bottom).with.offset(15) ;
        make.right.equalTo(weakSelf.view).with.offset(-16) ;
    }];
}

// 点击return的时候
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 是textField失去第一响应者(也就是消失掉，这时候会调用textFieldDidEndEditing方法)
    [self.textView resignFirstResponder];
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self changeViewUp:YES];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    [self changeViewUp:NO];
    
}


#pragma mark - 重构代码抽取部分
- (void)changeViewUp:(BOOL)isUp
{
    // 开始动画(定义了动画的名字)
    [UIView beginAnimations:@"viewUp" context:nil];
    // 设置时长
    [UIView setAnimationDuration:0.2f];
    // 通过isUp来确定视图的移动方向
    int changedValue;
    if (Chomp_WIDTHLAYOUT <1) {
        if (isUp) {
            changedValue = -290;
        }else {
            changedValue = 290;
        }
    }else{
        if (isUp) {
            changedValue = -275;
        }else {
            changedValue = 275;
        }
    }
    
    // 设置动画内容
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + changedValue, self.view.frame.size.width, self.view.frame.size.height);
    // 提交动画
    [UIView commitAnimations];
}

#pragma mark -- 第一个按钮页面抬起
- (void)ButtonChangeViewUp:(BOOL)isUp
{
    // 开始动画(定义了动画的名字)
    [UIView beginAnimations:@"viewUp" context:nil];
    // 设置时长
    [UIView setAnimationDuration:0.2f];
    // 通过isUp来确定视图的移动方向
    int changedValue;
    
    if (isUp) {
        changedValue = -200;
    }else {
        changedValue = 200;
    }
    
    // 设置动画内容
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + changedValue, self.view.frame.size.width, self.view.frame.size.height + 200);
    // 提交动画
    [UIView commitAnimations];
}



#pragma mark -- 小号字体
- (IBAction)smallButton:(id)sender {
    self.AniView2.fontSize = 25.0f ;
//    char SmallWord[]  = {0xFE,0x00,0x02};
    char SmallWord[]  = {0xFE,0x00,0x01};
    [self MobileToBLEWriteData:SmallWord];
}
#pragma mark -- 正常字体
- (IBAction)normalButton:(id)sender {
    self.AniView2.fontSize = 30.0f ;
//    char MiddleWord[] = {0xFE,0x00,0x03}; 
    char MiddleWord[] = {0xFE,0x00,0x02};
    [self MobileToBLEWriteData:MiddleWord];
}
#pragma mark -- 大号字体
- (IBAction)bigButton:(id)sender {
    self.AniView2.fontSize = 40.0f ;

//    char BigWord[]    = {0xFE,0x00,0x04};
    char BigWord[]    = {0xFE,0x00,0x03};
    [self MobileToBLEWriteData:BigWord];
}
#pragma mark -- 蓝牙特征值写入操作
-(void)babyDelegate{
    
    __weak typeof(self)weakSelf = self;
    //设置读取characteristics的委托
    [baby setBlockOnReadValueForCharacteristicAtChannel:channelOnCharacteristicView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        //        NSLog(@"CharacteristicViewController===characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
        //        [weakSelf insertReadValues:characteristics];
    }];
    
    
    //设置发现characteristics的descriptors的委托
    [baby setBlockOnDiscoverDescriptorsForCharacteristicAtChannel:channelOnCharacteristicView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        //        NSLog(@"CharacteristicViewController===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CharacteristicViewController CBDescriptor name is :%@",d.UUID);
            //            [weakSelf insertDescriptor:d];
        }
    }];
    
    //设置读取Descriptor的委托
    [baby setBlockOnReadValueForDescriptorsAtChannel:channelOnCharacteristicView block:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"CharacteristicViewController Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
    }];
    
    
    //设置写数据成功的block
    [baby setBlockOnDidWriteValueForCharacteristicAtChannel:channelOnCharacteristicView block:^(CBCharacteristic *characteristic, NSError *error) {
        if (error) {
            NSLog(@"蓝牙数据写入错误 ---  %@",error) ;
        }
        NSLog(@"setBlockOnDidWriteValueForCharacteristicAtChannel characteristic:%@ and new value:%@",characteristic.UUID, characteristic.value);
    }];
    
    //设置通知状态改变的block
    [baby setBlockOnDidUpdateNotificationStateForCharacteristicAtChannel:channelOnCharacteristicView block:^(CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"uid:%@,isNotifying:%@",characteristic.UUID,characteristic.isNotifying?@"on":@"off");
    }];
}

#pragma mark -- 订阅一个值
-(void)setNotifiy:(id)sender{
    
    __weak typeof(self)weakSelf = self;
    UIButton *btn = sender;
    if(self.currPeripheral.state != CBPeripheralStateConnected) {
//        [SVProgressHUD showErrorWithStatus:@"peripheral已经断开连接，请重新连接"];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:NSLocalizedString(@"PleaseConnect", nil)
                                                          delegate:self
                                                 cancelButtonTitle:@"好"
                                                 otherButtonTitles:nil, nil];
        
        [alertView show];
        
        return;
    }
    if (self.characteristicNoti.properties & CBCharacteristicPropertyNotify ||  self.characteristicNoti.properties & CBCharacteristicPropertyIndicate) {
        
        if(self.characteristicNoti.isNotifying) {
            [baby cancelNotify:self.currPeripheral characteristic:self.characteristicNoti];
            [btn setTitle:@"通知" forState:UIControlStateNormal];
        }else{
            [weakSelf.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristicNoti];
            [btn setTitle:@"取消通知" forState:UIControlStateNormal];
            [baby notify:self.currPeripheral
          characteristic:self.characteristicNoti
                   block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
                       NSLog(@"notify block");
                       //                NSLog(@"new value %@",characteristics.value);
//                       [self insertReadValues:characteristics];
                   }];
        }
    }
    else{
//        [SVProgressHUD showErrorWithStatus:@"这个characteristic没有nofity的权限"];
        return;
    }
    
}

#pragma mark -- tabble Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.oneView_arr.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_ID = @"Static" ;
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_ID];
    
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:cell_ID];
    }
    
    cell.textLabel.text = self.oneView_arr[indexPath.row] ;
    
    return cell ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40 ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *textStr = [NSString stringWithFormat:@"%@",self.oneView_arr[indexPath.row]];
    
    self.textView.text = textStr ;
    
    self.StrView.hidden = YES ;
}

#pragma mark -- 第二个视图点击
-(void)twoScrollBtnClick:(UITapGestureRecognizer *)tap{
    
    UILabel *label = (UILabel *)tap.view ;
    
    self.textView.text = [self.textView.text stringByAppendingString:label.text] ;
    self.containerView.hidden = YES ;
}

#pragma mark -- 发送数据HUD
- (void)ackBLEDataHUD {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // Set the label text.
    hud.label.text = NSLocalizedString(@"SendData", nil);
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.2f alpha:0.2f];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
}

#pragma mark -- 判断是否全为字母字符串

- (BOOL)inputShouldLetter:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[a-zA-Z|\\s]+";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}



#if 0
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
#endif

- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"dd日 HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
