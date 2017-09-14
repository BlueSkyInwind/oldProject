//
//  ExpressCreditRefuseView.h
//  fxdProduct
//
//  Created by sxp on 17/6/12.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeProductList.h"
typedef void(^JumpBtn)();
typedef void(^ViewClick)(NSString* url);
@interface ExpressCreditRefuseView : UITableViewCell

@property (nonatomic,strong)UIImageView *firstImage;
//用钱宝产品名字
@property (nonatomic,strong)UILabel *nameFirstLabel;
//用钱宝产品额度
@property (nonatomic,strong)UILabel *quotaFirstLabel;
//用钱宝产品期限
@property (nonatomic,strong)UILabel *termFirstLabel;
//用钱宝产品费用
@property (nonatomic,strong)UILabel *feeFirstLabel;
//用钱宝产品描述
@property (nonatomic,strong)UIButton *descFirstBtn;

@property (nonatomic,strong)UIImageView *secondImage;
//贷嘛产品名字
@property (nonatomic,strong)UILabel *nameSecondLabel;
//贷嘛产品额度
@property (nonatomic,strong)UILabel *quotaSecondLabel;
//贷嘛产品期限
@property (nonatomic,strong)UILabel *termSecondLabel;
//贷嘛产品费用
@property (nonatomic,strong)UILabel *feeSecondLabel;
//贷嘛产品描述
@property (nonatomic,strong)UIButton *descSecondBtn;

@property (nonatomic,strong)UIButton *jumpBtn;

@property (nonatomic,copy)JumpBtn jumpBtnClick;
@property (nonatomic,copy)ViewClick viewClick;

@property (nonatomic,strong)NSString *firstUrl;
@property (nonatomic,strong)NSString *secondUrl;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong)HomeProductList *homeProductList;

@end
