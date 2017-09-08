//
//  RepayModel.h
//  fxdProduct
//
//  Created by sxp on 2017/9/4.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RepayModel : JSONModel

//账单日
@property(nonatomic,strong)NSString<Optional> * billDate;
//是否可以续期
@property(nonatomic,assign)BOOL continueStaging;
//是否可以展示
@property(nonatomic,assign)BOOL display;
//借款周期
@property(nonatomic,strong)NSString<Optional> * duration;
//借款金额
@property(nonatomic,strong)NSString<Optional> * money;
//逾期描述
@property(nonatomic,strong)NSString<Optional> * overdueDesc;
//逾期费用
@property(nonatomic,strong)NSString<Optional> * overdueFee;
//产品id
@property(nonatomic,strong)NSString<Optional> * productId;
//每期还款
@property(nonatomic,strong)NSString<Optional> * repayment;
//续期id
@property(nonatomic,strong)NSString<Optional> * stagingId;
//进件平台类型  0是发薪贷，2是合规
@property(nonatomic,strong)NSString<Optional> * platformType;
//申请件id
@property(nonatomic,strong)NSString<Optional> * applyId;
//合规标id   0 为默认值，其他大于0的数字为合规的
@property(nonatomic,strong)NSString<Optional> * bidId;
//合规用户状态   2、未开户 3、待激活 4、冻结 5、销户 6、正常7、已注册 11、开 户中 12、激活中
@property(nonatomic,strong)NSString<Optional> * userStatus;

@end
