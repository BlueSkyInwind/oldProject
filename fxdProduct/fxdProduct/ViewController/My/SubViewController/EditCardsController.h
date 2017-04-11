//
//  EditCardsController.h
//  fxdProduct
//
//  Created by zy on 16/1/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^AddCarBlock)();


@interface EditCardsController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSString *cardName;//卡名
@property (strong,nonatomic) NSString *intNum;
@property (strong,nonatomic) NSString *cardNum;//卡号
@property (strong,nonatomic) NSString *typeFlag;//信用卡或储蓄卡识别标识
@property (strong,nonatomic) NSString *cardCode;//银行卡编码
@property (strong,nonatomic) NSString *reservedTel;//预留手机号
@property (strong,nonatomic) NSString *accountId;
@property (strong,nonatomic) NSString *verCode;//验证码
@property (weak, nonatomic) IBOutlet UIButton *btnSaveInfo;

@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@property (weak, nonatomic) IBOutlet UILabel *userReadLabel;


- (IBAction)btnSave:(id)sender;

@property (nonatomic, strong) AddCarBlock addCarSuccess;

@end
