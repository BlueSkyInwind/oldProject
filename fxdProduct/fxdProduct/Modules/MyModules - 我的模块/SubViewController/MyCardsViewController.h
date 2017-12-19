//
//  MyCardsViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/14.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "BaseViewController.h"
@class BankModel;

@interface MyCardsViewController : BaseViewController
@property(nonatomic,assign)NSInteger cardMethodTag;
@property(nonatomic,strong)NSString *actualReayAmount;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) BankModel *bankModel;
@property (nonatomic, strong) NSMutableArray * supportBankListArr;


@end
