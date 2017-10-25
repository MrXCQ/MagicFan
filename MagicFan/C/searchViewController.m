//
//  searchViewController.m
//  MagicFan
//
//  Created by zc on 2017/5/24.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

#import "searchViewController.h"
#import "UIViewController+Cloudox.h"
#import "searchTableViewCell.h"
#import "Header.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BabyBluetooth.h"

#define channelOnCharacteristicView @"CharacteristicView"
#define channelOnPeropheralView @"peripheralView"



@interface searchViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BabyBluetooth *baby;
}

@property(nonatomic,strong) UITableView *searchTable ;
@property(nonatomic,strong) NSMutableArray *peripheralDataArray ; // 外设设备数量
@property(nonatomic,strong) UIButton *doneBtn,*refreshBtn,*cutConnectBtn ;
@property(nonatomic,strong) UIImageView *aniImgView ;
@property(nonatomic,strong) UIActivityIndicatorView *JuHuaView ;
@end

@implementation searchViewController

-(NSMutableArray *)peripheralDataArray
{
    if (!_peripheralDataArray) {
        _peripheralDataArray = [NSMutableArray array] ;
    }
    return _peripheralDataArray ;
}


-(UIActivityIndicatorView *)JuHuaView{
    if (!_JuHuaView) {
        _JuHuaView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _JuHuaView.center = self.view.center ;
        
        [[UIApplication sharedApplication].keyWindow addSubview:_JuHuaView];
    }
    return _JuHuaView ;
}

-(UIImageView *)aniImgView{
    if (!_aniImgView) {
        _aniImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        UIImage *img = [UIImage imageNamed:@"tooth_donghua"] ;
        _aniImgView.center = self.view.center ;
        _aniImgView.animationImages = @[img] ;
        
        [[UIApplication sharedApplication].keyWindow addSubview:_aniImgView];
    }
    return _aniImgView ;
}

-(UIButton *)refreshBtn{
    if (!_refreshBtn) {
        _refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _refreshBtn.frame = CGRectMake(0, 0, 120, 40) ;
        _refreshBtn.center = CGPointMake(Chomp_WIDTH/4, Chomp_HEIGHT -60) ;
        _refreshBtn.backgroundColor = [UIColor greenColor] ;
        [_refreshBtn setTitle:NSLocalizedString(@"Refresh", nil) forState:UIControlStateNormal];
        [_refreshBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _refreshBtn.titleLabel.font = [UIFont systemFontOfSize:13] ;
        _refreshBtn.layer.masksToBounds = YES ;
        _refreshBtn.layer.cornerRadius = 10 ;
        [_refreshBtn addTarget:self
                        action:@selector(reSearch)
              forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_refreshBtn];
    }
    return  _refreshBtn ;
}


-(UIButton *)cutConnectBtn{
    if (!_cutConnectBtn) {
        _cutConnectBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _cutConnectBtn.frame = CGRectMake(0, 0, 120, 40) ;
        _cutConnectBtn.center = CGPointMake(Chomp_WIDTH/4*3, Chomp_HEIGHT -60) ;
        _cutConnectBtn.backgroundColor = [UIColor greenColor] ;
        [_cutConnectBtn setTitle:NSLocalizedString(@"Disconnected", nil) forState:UIControlStateNormal];
        [_cutConnectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cutConnectBtn.titleLabel.font = [UIFont systemFontOfSize:13] ;
        _cutConnectBtn.layer.masksToBounds = YES ;
        _cutConnectBtn.layer.cornerRadius = 10 ;
        
        [_cutConnectBtn addTarget:self
                           action:@selector(cutConnected)
                 forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_cutConnectBtn];
    }
    return  _refreshBtn ;
}

-(UIButton *)doneBtn{
    
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _doneBtn.frame = CGRectMake(Chomp_WIDTH -90, 25, 60, 30) ;
        [_doneBtn setTitle:NSLocalizedString(@"Done", nil)
                  forState:UIControlStateNormal];
        _doneBtn.backgroundColor = [UIColor blackColor] ;
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:16] ;
        
        [_doneBtn setTitleColor:[UIColor cyanColor]
                       forState:UIControlStateNormal];
        
        [_doneBtn addTarget:self
                     action:@selector(dissVC)
           forControlEvents:UIControlEventTouchUpInside] ;
        
        [self.view addSubview:_doneBtn];
    }
    return _doneBtn ;
}

-(UITableView *)searchTable{
    if (!_searchTable) {
        _searchTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, Chomp_WIDTH, Chomp_HEIGHT-200)
                                                   style:UITableViewStylePlain];
        _searchTable.delegate = self ;
        _searchTable.dataSource = self ;
        _searchTable.tableFooterView = [UIView new] ;
        _searchTable.showsVerticalScrollIndicator = NO ;
        _searchTable.separatorStyle = UITableViewCellSeparatorStyleNone ;
        [self.view addSubview:_searchTable];
    }
    return _searchTable ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor] ;
    
    self.searchTable.backgroundColor = [UIColor blackColor] ;
    
    self.doneBtn.hidden = YES ;
    
    UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(30, 80, Chomp_WIDTH -60, 30)];
    titleLB.backgroundColor = [UIColor clearColor] ;
    
    titleLB.text= NSLocalizedString(@"APPName", nil) ; ;
    titleLB.textColor = [UIColor cyanColor] ;
    titleLB.textAlignment = NSTextAlignmentCenter ;
    titleLB.font = [UIFont systemFontOfSize:24] ;
    
    [self.view addSubview:titleLB];
    
    self.JuHuaView.hidden = NO ;
    
    //初始化BabyBluetooth 蓝牙库
    baby = [BabyBluetooth shareBabyBluetooth];
    //设置蓝牙委托
    [self babyDelegate];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
    //停止之前的连接
    [baby cancelAllPeripheralsConnection];
    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态。
    baby.scanForPeripherals().begin();
    //baby.scanForPeripherals().begin().stop(10);
}

#pragma mark -蓝牙配置和操作

//蓝牙网关初始化和委托方法设置
-(void)babyDelegate{
    
    __weak typeof(self) weakSelf = self;
    [baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state == CBManagerStatePoweredOn) {
            [MBProgressHUD showTipMessageInWindow:NSLocalizedString(@"OpenFan", nil)];
            
            [weakSelf.JuHuaView startAnimating];
        }else{
            [weakSelf.JuHuaView stopAnimating];
        }
    }];
    
    //设置扫描到设备的委托
    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"搜索到了设备:%@",peripheral.name);
        [weakSelf.JuHuaView stopAnimating];
        weakSelf.JuHuaView.hidden = YES ;
        weakSelf.doneBtn.hidden = NO ;
        weakSelf.refreshBtn.hidden = NO ;
        weakSelf.cutConnectBtn.hidden = NO ;
        [weakSelf insertTableView:peripheral advertisementData:advertisementData RSSI:RSSI];
    }];
  
   #pragma mark -- 发现可用的服务
    //设置发现设service的Characteristics的委托
    [baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        
        for (CBCharacteristic *c in service.characteristics) {
            NSLog(@"charateristic name is :%@",c.UUID);
        }
    }];
    //设置读取characteristics的委托
    [baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        NSLog(@"1characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
    }];
    //设置发现characteristics的descriptors的委托
    [baby setBlockOnDiscoverDescriptorsForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"2===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CBDescriptor name is :%@",d.UUID);
        }
    }];
    //设置读取Descriptor的委托
    [baby setBlockOnReadValueForDescriptors:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
    }];
    
    
    //设置查找设备的过滤器
    [baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        
        //最常用的场景是查找某一个前缀开头的设备
        //        if ([peripheralName hasPrefix:@"Pxxxx"] ) {
        //            return YES;
        //        }
        //        return NO;
        
        //设置查找规则是名称大于0 ， the search rule is peripheral.name length > 0
        if (peripheralName.length >0) {
            return YES;
        }
        return NO;
    }];
    
    
    [baby setBlockOnCancelAllPeripheralsConnectionBlock:^(CBCentralManager *centralManager) {
        NSLog(@"setBlockOnCancelAllPeripheralsConnectionBlock");
    }];
    
    [baby setBlockOnCancelScanBlock:^(CBCentralManager *centralManager) {
        NSLog(@"setBlockOnCancelScanBlock");
    }];
    
    
    /*设置babyOptions
     
     参数分别使用在下面这几个地方，若不使用参数则传nil
     - [centralManager scanForPeripheralsWithServices:scanForPeripheralsWithServices options:scanForPeripheralsWithOptions];
     - [centralManager connectPeripheral:peripheral options:connectPeripheralWithOptions];
     - [peripheral discoverServices:discoverWithServices];
     - [peripheral discoverCharacteristics:discoverWithCharacteristics forService:service];
     
     该方法支持channel版本:
     [baby setBabyOptionsAtChannel:<#(NSString *)#> scanForPeripheralsWithOptions:<#(NSDictionary *)#> connectPeripheralWithOptions:<#(NSDictionary *)#> scanForPeripheralsWithServices:<#(NSArray *)#> discoverWithServices:<#(NSArray *)#> discoverWithCharacteristics:<#(NSArray *)#>]
     */
    
    //示例:
    //扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:忽略同一个Peripheral端的多个发现事件被聚合成一个发现事件
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
    //连接设备->
    [baby setBabyOptionsWithScanForPeripheralsWithOptions:scanForPeripheralsWithOptions
                             connectPeripheralWithOptions:nil
                           scanForPeripheralsWithServices:nil
                                     discoverWithServices:nil
                              discoverWithCharacteristics:nil];
    
    [self.searchTable reloadData];

}

#pragma mark -UIViewController 方法
//插入table数据
-(void)insertTableView:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSArray *peripherals = [self.peripheralDataArray valueForKey:@"peripheral"];
    if(![peripherals containsObject:peripheral]) {
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:peripherals.count inSection:0];
        [indexPaths addObject:indexPath];
        
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        [item setValue:peripheral forKey:@"peripheral"];
        [item setValue:RSSI forKey:@"RSSI"];
        [item setValue:advertisementData forKey:@"advertisementData"];
        
        
        
        [self.peripheralDataArray addObject:item];
        
        [self.searchTable insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}



#pragma mark -- tabble Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.peripheralDataArray.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    searchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"searchTableViewCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"searchTableViewCell"
                                             owner:self
                                           options:nil]lastObject];
    }
    
    NSDictionary *item = [self.peripheralDataArray objectAtIndex:indexPath.row];
    CBPeripheral *peripheral = [item objectForKey:@"peripheral"];
    NSDictionary *advertisementData = [item objectForKey:@"advertisementData"];
    NSNumber *RSSI = [item objectForKey:@"RSSI"];
    
    //peripheral的显示名称,优先用kCBAdvDataLocalName的定义，若没有再使用peripheral name
    NSString *peripheralName;
    if ([advertisementData objectForKey:@"kCBAdvDataLocalName"]) {
        peripheralName = [NSString stringWithFormat:@"%@",[advertisementData objectForKey:@"kCBAdvDataLocalName"]];
    }else if(!([peripheral.name isEqualToString:@""] || peripheral.name == nil)){
        peripheralName = peripheral.name;
    }else{
        peripheralName = [peripheral.identifier UUIDString];
    }

    NSString *MacName = [peripheral.identifier UUIDString]  ;

    if (MacName.length > 6) {
        MacName = [MacName substringToIndex:6];
    }
    
    cell.BLENameLB.text = [NSString stringWithFormat:@"%@ : %@",peripheralName,MacName] ;
    
//    cell.textLabel.text = peripheralName;
//    //信号和服务
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"RSSI:%@",RSSI];
//
    return cell ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70*Chomp_HEIGHTLAYOUT;
}

-(NSMutableAttributedString *)labelWithAttributeStr:(NSString *)attributeStr
                                        andFontSize:(CGFloat)fontSize
                                       andFontColor:(UIColor*)color
                                           andRange:(NSRange)range

{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",attributeStr]];
    
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:range];
    [attStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return attStr ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //停止扫描
    [baby cancelScan];
    
   
    [self.searchTable deselectRowAtIndexPath:indexPath animated:YES];
//    PeripheralViewController *vc = [[PeripheralViewController alloc]init];
    NSDictionary *item = [self.peripheralDataArray objectAtIndex:indexPath.row];
    CBPeripheral *peripheral = [item objectForKey:@"peripheral"];
    
    
    [self readConnectBLEWith:peripheral];
    
//    vc.currPeripheral = peripheral;
//    vc->baby = self->baby;
//    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark -- 准备连接设备

-(void)readConnectBLEWith:(CBPeripheral *)peripheral{
    [MBProgressHUD showTipMessageInWindow:NSLocalizedString(@"ReadyToConnect", nil)];
    
    [self ConnectBLE];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
           baby.having(peripheral).and.channel(channelOnPeropheralView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
    });
 
}

#pragma mark -- 连接蓝牙成功，确定外接设备后的代理方法
-(void)ConnectBLE{
    
    __weak typeof(self)weakSelf = self;
    BabyRhythm *rhythm = [[BabyRhythm alloc]init];
    
    
    //设置设备连接成功的委托,同一个baby对象，使用不同的channel切换委托回调
    [baby setBlockOnConnectedAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral) {
        
        [MBProgressHUD showTipMessageInWindow:[NSString stringWithFormat:@"%@--%@",peripheral.name,NSLocalizedString(@"ConnectSuccess", nil)]];
    }];
    
    //设置设备连接失败的委托
    [baby setBlockOnFailToConnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--连接失败",peripheral.name);
        [MBProgressHUD showTipMessageInWindow:[NSString stringWithFormat:@"%@--%@",peripheral.name,NSLocalizedString(@"ConnectFail", nil)]];
    }];
    
    #pragma mark -- 蓝牙断开回复
    //设置设备断开连接的委托
    [baby setBlockOnDisconnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"%@--断开连接",peripheral.name);
        [MBProgressHUD showTipMessageInWindow:[NSString stringWithFormat:@"%@--%@",peripheral.name,NSLocalizedString(@"Disconnected", nil)]];
        
        // 获取到蓝牙回复的时间
//        NSString *responseTime = [ValueCodex getCurrentTime] ;
//        
//        [[NSUserDefaults standardUserDefaults] setValue:responseTime forKey:@"End"];
//        
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"END" object:nil];
     
    }];
    
    //设置发现设备的Services的委托
    [baby setBlockOnDiscoverServicesAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, NSError *error) {
        for (CBService *s in peripheral.services) {
            
            NSString *UUID = [NSString stringWithFormat:@"%@",s.UUID] ;
            
            if ([UUID isEqualToString:@"00010203-0405-0607-0809-0A0B0C0D1910"]) {
                NSLog(@"可用的服务列表%@",s.UUID);
                
                if (s.UUID) {
                    weakSelf.service = s ;
                    weakSelf.peripheral = peripheral ;
                }
                
                for (CBCharacteristic *c in s.characteristics) {
                    NSLog(@"可用的特征名称%@",c.UUID);
                }
            }else{
//                [MBProgressHUD showTipMessageInWindow:@"请配对正确的蓝牙!"];
                NSLog(@"请配对正确的蓝牙！！！！！") ;
            }
        }
        
        [rhythm beats];
    }];
    
    #pragma mark -- 蓝牙连接
    //设置发现设service的Characteristics的委托
    [baby setBlockOnDiscoverCharacteristicsAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBService *service, NSError *error) {

        for (CBCharacteristic *c in service.characteristics) {
            NSLog(@"可用的特征名称%@",c.UUID);
        }
        
    }];
    
    #pragma mark -- 蓝牙写入数据回复
    //设置读取characteristics的委托 蓝牙回复
    [baby setBlockOnReadValueForCharacteristicAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        NSLog(@"3characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
        
       //  [[NSNotificationCenter defaultCenter]postNotificationName:@"BleResponse" object:characteristics];
    }];
    //设置发现characteristics的descriptors的委托
    [baby setBlockOnDiscoverDescriptorsForCharacteristicAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"4===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CBDescriptor name is :%@",d.UUID);
        }
    }];
    //设置读取Descriptor的委托
    [baby setBlockOnReadValueForDescriptorsAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
    }];
    
    //读取rssi的委托
    [baby setBlockOnDidReadRSSI:^(NSNumber *RSSI, NSError *error) {
        NSLog(@"setBlockOnDidReadRSSI:RSSI:%@",RSSI);
    }];
    
    
    //设置beats break委托
    [rhythm setBlockOnBeatsBreak:^(BabyRhythm *bry) {
        NSLog(@"setBlockOnBeatsBreak call");
        
        //如果完成任务，即可停止beat,返回bry可以省去使用weak rhythm的麻烦
        //        if (<#condition#>) {
        //            [bry beatsOver];
        //        }
        
    }];
    
    //设置beats over委托
    [rhythm setBlockOnBeatsOver:^(BabyRhythm *bry) {
        NSLog(@"setBlockOnBeatsOver call");
    }];
    
    //扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:忽略同一个Peripheral端的多个发现事件被聚合成一个发现事件
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
    /*连接选项->
     CBConnectPeripheralOptionNotifyOnConnectionKey :当应用挂起时，如果有一个连接成功时，如果我们想要系统为指定的peripheral显示一个提示时，就使用这个key值。
     CBConnectPeripheralOptionNotifyOnDisconnectionKey :当应用挂起时，如果连接断开时，如果我们想要系统为指定的peripheral显示一个断开连接的提示时，就使用这个key值。
     CBConnectPeripheralOptionNotifyOnNotificationKey:
     当应用挂起时，使用该key值表示只要接收到给定peripheral端的通知就显示一个提
     */
    NSDictionary *connectOptions = @{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnDisconnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnNotificationKey:@YES};
    
    [baby setBabyOptionsAtChannel:channelOnPeropheralView scanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:connectOptions scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
    
}



#pragma mark -- 完成退出
-(void)dissVC{
    __weak typeof(self) weakSelf = self ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self.service) {
           weakSelf.BleBlock(weakSelf.service,weakSelf.peripheral) ;
        }
        
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            
        }];
    });
}

#pragma mark -- 重新搜索
-(void)reSearch{
    
    NSLog(@"重新扫描") ;
    //停止扫描
    [baby cancelScan];
    
    [self.peripheralDataArray removeAllObjects];
    
    [self babyDelegate];
    
    //停止之前的连接
    [baby cancelAllPeripheralsConnection];
    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态。
    baby.scanForPeripherals().begin();
}

#pragma mark -- 断开连接
-(void)cutConnected{
    
    NSLog(@"断开当前连接") ;
    //停止之前的连接
    [baby cancelAllPeripheralsConnection];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    __weak typeof(self) weakSelf = self ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            
        }];
    });
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [baby cancelScan] ;

    [self.JuHuaView stopAnimating];
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
