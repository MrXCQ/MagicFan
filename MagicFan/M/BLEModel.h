//
//  BLEModel.h
//  MagicFan
//
//  Created by zc on 2017/5/25.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BabyBluetooth.h"

@interface BLEModel : NSObject
@property(nonatomic,copy) NSString *BLEName;
@property(nonatomic,copy) NSString *BLESSI ;
@property(nonatomic,strong) NSDictionary *advertisementData ;
@end
