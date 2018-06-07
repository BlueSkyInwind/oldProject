//
//  FXD_HomeProductListModel.h
//  fxdProduct
//
//  Created by sxp on 2017/12/25.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol BannerListModel <NSObject>

@end

@protocol PopListModel <NSObject>

@end

@protocol RedCollarListModel <NSObject>

@end

@protocol ThirdProductListModel <NSObject>

@end


@protocol FeeTextModel <NSObject>

@end

@protocol HomeHotRecommendModel <NSObject>

@end

@protocol PlatTypeModel <NSObject>

@end


@interface DrawInfoModel : JSONModel

//金额
@property (nonatomic, strong)NSString<Optional> *amount;
//蓝色文字
@property (nonatomic, strong)NSString<Optional> *label;
//温馨提示
@property (nonatomic, strong)NSString<Optional> *warn;
//基础资料是否完整
@property (nonatomic, strong)NSString<Optional> *isComplete;
//弹窗提示内容
@property (nonatomic, strong)NSArray<Optional> *tipsContent;
//弹窗提示标题
@property (nonatomic, strong)NSString<Optional> *tipsTitle;

@end


@interface HandingAndFailModel : JSONModel

//发起时间
@property (nonatomic, strong)NSString<Optional> *createDate;
//当前状态（对应前端蓝色字体）
@property (nonatomic, strong)NSString<Optional> *currentStatus;
//当前状态提示（蓝色字下方的文字说明）
@property (nonatomic, strong)NSString<Optional> *currentStatusTips;
//上一次动作（eg:发起还款、发起提款）
@property (nonatomic, strong)NSString<Optional> *preStatus;
//上一次动作文字描述
@property (nonatomic, strong)NSString<Optional> *preStatusTips;

@end

@interface OverdueInfoModel : JSONModel

//逾期罚金
@property (nonatomic, strong)NSString<Optional> *feeAmount;
//逾期天数
@property (nonatomic, strong)NSString<Optional> *overdueDays;
//代还金额
@property (nonatomic, strong)NSString<Optional> *repayAmount;
//顶部蓝色借款提示
@property (nonatomic, strong)NSString<Optional> *repayTips;
//期供金额
@property (nonatomic, strong)NSString<Optional> *stagingAmount;
//逾期弹窗当前费用标题
@property (nonatomic, strong)NSString<Optional> *currentFeeTitle;
//逾期弹窗规则标题
@property (nonatomic, strong)NSString<Optional> *ruleTitle;
//产品id
@property (nonatomic, strong)NSArray<Optional> *ruleText;
//进件id
@property (nonatomic, strong)NSArray<FeeTextModel,Optional> *feeText;

@end

@interface RepayInfoModel : JSONModel

//下一期还款金额
@property (nonatomic, strong)NSString<Optional> *repayAmount;
//下一期还款日期
@property (nonatomic, strong)NSString<Optional> *repayDate;
//顶部蓝色借款提示
@property (nonatomic, strong)NSString<Optional> *repayTips;

@end

@interface FeeTextModel : JSONModel

//左边文字
@property (nonatomic, strong)NSString<Optional> *label;
//右边具体值
@property (nonatomic, strong)NSString<Optional> *value;

@end


@interface TestFailInfoModel : JSONModel

//三条方法文字
@property (nonatomic, strong)NSArray<Optional> *text;
//第三方产品列表
@property (nonatomic, strong)NSArray<ThirdProductListModel,Optional> *thirdProductList;
//信用评分不足蓝色提示
@property (nonatomic, strong)NSString<Optional> *tips;

@end

@interface RedCollarListModel : JSONModel

//取消按钮
@property (nonatomic, strong)NSString<Optional> *cancel;
//评测领红包文案
@property (nonatomic, strong)NSString<Optional> *collarContent;
//评测领红包按钮
@property (nonatomic, strong)NSString<Optional> *redCollar;

@end

@interface PopListModel : JSONModel

//图片url
@property (nonatomic, strong)NSString<Optional> *image;
//是否有效
@property (nonatomic, strong)NSString<Optional> *isValid;
//跳转url
@property (nonatomic, strong)NSString<Optional> *toUrl;


@end

@interface FXD_HomeProductListModel : JSONModel

//首页banner列表
@property(nonatomic,strong)NSArray<BannerListModel,Optional> * bannerList;
//按钮文字
@property (nonatomic, strong)NSString<Optional> *buttonText;
//带进件或者待提款时数据
@property(nonatomic,strong)DrawInfoModel<Optional> * drawInfo;
//首页不同标识  1:资料测评前 2:资料测评后 可进件 3:资料测评后:两不可申请（评分不足且高级认证未填完整） 4:资料测评后:两不可申请（其他原因，续贷规则不通过） 5:待提款 6:放款中 7:待还款 8:还款中 9 延期中 10 延期失败 11合规标的处理中 12测评中 13提款失败 14逾期 15还款失败
@property (nonatomic, strong)NSString<Optional> *flag;
//产品id
@property (nonatomic, strong)NSString<Optional> *productId;
//0 发薪贷 2 合规
@property (nonatomic, strong)NSString<Optional> *platfromType;
//1:未开户 2：开户中 3:已开户 4:待激活
@property (nonatomic, strong)NSString<Optional> *userStatus;
//进件id
@property (nonatomic, strong)NSString<Optional> *applicationId;
//首页各个状态对应金额
@property (nonatomic, strong)NSString<Optional> *amount;
//借款期数
@property (nonatomic, strong)NSString<Optional> *periods;
//中间状态（测评中、放款中、还款中） 和失败状态（放款失败、还款失败）数据
@property(nonatomic,strong)HandingAndFailModel<Optional> * handingAndFailText;
//跳转弹窗1跳转资料补全页
@property (nonatomic, strong)NSString<Optional> *jumpBomb;
//逾期信息
@property(nonatomic,strong)OverdueInfoModel<Optional> * overdueInfo;
//弹窗广告列表
@property(nonatomic,strong)NSArray<PopListModel,Optional> * popList;
//弹窗广告列表
@property(nonatomic,strong)NSArray<Optional> * paidList;
//评测领红包活动内容
@property(nonatomic,strong)RedCollarListModel<Optional> * redCollarList;
//正常还款信息
@property(nonatomic,strong)RepayInfoModel<Optional> * repayInfo;
//测评失败信息
@property(nonatomic,strong)TestFailInfoModel<Optional> * testFailInfo;
//帮助中心url
@property (nonatomic, strong)NSString<Optional> *qaUrl;
//还款方式
@property (nonatomic, strong)NSString<Optional> *stagingType;

//热门推荐
@property(nonatomic,strong)NSArray<HomeHotRecommendModel,Optional> * hotRecommend;

//贷款、热门
@property(nonatomic,strong)NSArray<PlatTypeModel,Optional> * platType;

@end


@interface HomeHotRecommendModel : JSONModel

//链接地址
@property (nonatomic, strong)NSString<Optional> *id_;
//链接地址
@property (nonatomic, strong)NSString<Optional> *linkAddress;
//平台LOGO
@property (nonatomic, strong)NSString<Optional> *plantLogo;
//平台名称
@property (nonatomic, strong)NSString<Optional> *plantName;
//平台简介
@property (nonatomic, strong)NSString<Optional> *platformIntroduction;
//1 日利率 2 月利率 3 年利率
@property (nonatomic, strong)NSString<Optional> *referenceMode;
//借款利率
@property (nonatomic, strong)NSString<Optional> *referenceRate;
//0已收藏 1 未收藏
@property (nonatomic, strong)NSString<Optional> *isCollect;
//最高额度
@property (nonatomic, strong)NSString<Optional> *maximumAmountUnit;
//期限
@property (nonatomic, strong)NSString<Optional> *unitStr;
//最高额度
@property (nonatomic, strong)NSString<Optional> *maximumAmount;
//1:贷款、2:游戏、3:旅游
@property (nonatomic, strong)NSString<Optional> *moduletype;


@end

@interface PlatTypeModel : JSONModel

//图片url
@property (nonatomic, strong)NSString<Optional> *code_;
//是否有效
@property (nonatomic, strong)NSString<Optional> *desc_;
//跳转url
@property (nonatomic, strong)NSString<Optional> *key_;
//跳转url
@property (nonatomic, strong)NSString<Optional> *name_;

@end

@interface BannerListModel : JSONModel

//图片url
@property (nonatomic, strong)NSString<Optional> *image;
//是否有效
@property (nonatomic, strong)NSString<Optional> *isValid;
//跳转url
@property (nonatomic, strong)NSString<Optional> *toUrl;

@end


@interface ExtAttrModel : JSONModel

//取消按钮
@property (nonatomic, strong)NSString<Optional> *amt_desc_;
//评测领红包文案
@property (nonatomic, strong)NSString<Optional> *charge_desc_;
//评测领红包按钮
@property (nonatomic, strong)NSString<Optional> *icon_;
//取消按钮
@property (nonatomic, strong)NSString<Optional> *pass_level_;
//评测领红包文案
@property (nonatomic, strong)NSString<Optional> *path_;
//评测领红包按钮
@property (nonatomic, strong)NSString<Optional> *period_desc_;
//评测领红包按钮
@property (nonatomic, strong)NSArray<Optional> *tags;

@end


@interface ThirdProductListModel : JSONModel

//取消按钮
@property (nonatomic, strong)NSString<Optional> *dayServiceFeeRate;
//评测领红包文案
@property (nonatomic, strong)ExtAttrModel<Optional> *extAttr;
//评测领红包按钮
@property (nonatomic, strong)NSString<Optional> *id_;
//取消按钮
@property (nonatomic, strong)NSString<Optional> *isOverLimit;
//评测领红包文案
@property (nonatomic, strong)NSString<Optional> *liquidatedDamages;
//评测领红包按钮
@property (nonatomic, strong)NSString<Optional> *name;
//取消按钮
@property (nonatomic, strong)NSString<Optional> *platformType;
//评测领红包文案
@property (nonatomic, strong)NSString<Optional> *principalBottom;
//评测领红包按钮
@property (nonatomic, strong)NSString<Optional> *principalTop;
//取消按钮
@property (nonatomic, strong)NSString<Optional> *stagingBottom;
//评测领红包文案
@property (nonatomic, strong)NSString<Optional> *stagingDuration;
//评测领红包按钮
@property (nonatomic, strong)NSString<Optional> *stagingTop;

@end


