//
//  HG_OpenAccountAddBankCardModules.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/28.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"
#import "DrawingsInfoModel.h"

@interface HG_OpenAccountAddBankCardModules : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureBtn:(id)sender;

@property (nonatomic, assign) NSInteger periodSelect;
@property (nonatomic, assign)NSString  * purposeSelect;

@property (nonatomic, strong) NSString *idString;
@property (nonatomic, strong) NSString *drawAmount;
@property (nonatomic, strong) NSString *flagString;

@property (nonatomic, strong) NSString *bankMobile;
@property (nonatomic, strong)NSMutableArray *bankArray;

@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (nonatomic, strong) DrawingsInfoModel * drawingsInfoModel;



@end
