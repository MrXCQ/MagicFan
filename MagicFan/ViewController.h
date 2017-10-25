//
//  ViewController.h
//  MagicFan
//
//  Created by zc on 2017/5/22.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "PreviewView.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BabyBluetooth.h"

@interface ViewController : UIViewController{
@public
BabyBluetooth *baby;
}

@property (weak, nonatomic) IBOutlet UILabel *tipLB;
@property (weak, nonatomic) IBOutlet UIImageView *fanImg;
@property (weak, nonatomic) IBOutlet UIButton *helpBtn;
@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *rightClick;
@property (weak, nonatomic) IBOutlet UIButton *LeftClick;

@property (weak, nonatomic) IBOutlet UIImageView *xuanzhuanImg;
@property (weak, nonatomic) IBOutlet UIView *AniView;
@property (weak, nonatomic) IBOutlet PreviewView *AniView2;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@property (weak, nonatomic) IBOutlet UIButton *smallBtn;
@property (weak, nonatomic) IBOutlet UIButton *normalBtn;
@property (weak, nonatomic) IBOutlet UIButton *bigBtn;
@property(nonatomic,strong) CBService *service ;

@property (nonatomic,strong)CBCharacteristic *characteristicWrite,*characteristicNoti;
@property (nonatomic,strong)CBPeripheral *currPeripheral;
@property (weak, nonatomic) IBOutlet UILabel *magicLable;

@property (weak, nonatomic) IBOutlet UIButton *okButton;
@end

