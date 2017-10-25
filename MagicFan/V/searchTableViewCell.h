//
//  searchTableViewCell.h
//  MagicFan
//
//  Created by zc on 2017/5/24.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bluetoothImgView;
@property (weak, nonatomic) IBOutlet UILabel *BLENameLB;
@property (weak, nonatomic) IBOutlet UIImageView *pointImg;

@end
