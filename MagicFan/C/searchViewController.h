//
//  searchViewController.h
//  MagicFan
//
//  Created by zc on 2017/5/24.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BabyBluetooth.h"

typedef void(^MyBlock)(CBService *,CBPeripheral *);

@interface searchViewController : UIViewController

@property(nonatomic,copy) MyBlock BleBlock ;

@property(nonatomic,strong) CBService *service ;
@property(nonatomic,strong) CBPeripheral *peripheral ;

@end
