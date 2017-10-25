//
//  searchTableViewCell.m
//  MagicFan
//
//  Created by zc on 2017/5/24.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

#import "searchTableViewCell.h"
#import "Masonry.h"
#import "Header.h"

@implementation searchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.BLENameLB.font = [UIFont systemFontOfSize:16 *Chomp_HEIGHTLAYOUT] ;
    __weak typeof(self) weakSelf = self ;
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300*Chomp_HEIGHTLAYOUT, 70*Chomp_HEIGHTLAYOUT));
        make.top.equalTo(weakSelf.contentView).with.offset(0) ;
        make.centerX.equalTo(weakSelf.contentView);
    }];
    
    [self.bluetoothImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40*Chomp_HEIGHTLAYOUT, 40*Chomp_HEIGHTLAYOUT)) ;
        make.left.equalTo(weakSelf.bgView.mas_left).with.offset(8) ;
        make.centerY.equalTo(weakSelf.bgView) ;
    }];
    
    [self.BLENameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(166*Chomp_HEIGHTLAYOUT, 21)) ;
        make.center.equalTo(weakSelf.bgView);
    }];
    
    [self.pointImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15*Chomp_HEIGHTLAYOUT, 15*Chomp_HEIGHTLAYOUT)) ;
        make.right.equalTo(weakSelf.bgView).with.offset(-20);
        make.centerY.equalTo(weakSelf.bgView) ;
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
