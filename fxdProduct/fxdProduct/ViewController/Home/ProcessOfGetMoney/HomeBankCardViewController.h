//
//  HomeBankCardViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/30.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "BaseViewController.h"
#import "BankModel.h"

@protocol BankTableViewSelectDelegate <NSObject>

//-(void)BankTableViewSelect:(NSString *)CurrentRow andBankInfoList:(NSString *)bankNum andSectionRow:(NSInteger)SectionRow;

- (void)BankSelect:(BankList *)bankInfo andSectionRow:(NSInteger)sectionRow;

@end

@interface HomeBankCardViewController : BaseViewController


@property(weak,nonatomic)id <BankTableViewSelectDelegate>delegate;


@property (nonatomic, strong) BankModel *bankModel;

//@property(assign,nonatomic)NSInteger bankFlag;
@property(assign,nonatomic)NSInteger cardTag;


@end
