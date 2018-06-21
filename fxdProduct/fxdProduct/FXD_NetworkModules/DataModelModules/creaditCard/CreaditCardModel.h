//
//  CreaditCardModel.h
//  fxdProduct
//
//  Created by admin on 2018/6/21.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@class CreaditCardLevelModel;
@protocol CreaditCardBanksListModel <NSObject>

@end
@protocol CreaditCardListModel <NSObject>

@end
@protocol CreaditCardLevelModel <NSObject>

@end

@interface CreaditCardModel : JSONModel

@property (nonatomic, strong)NSArray<CreaditCardBanksListModel,Optional> * banks;
@property (nonatomic, strong)NSArray<CreaditCardListModel,Optional> * cards;
@property (nonatomic, strong)NSArray <CreaditCardLevelModel,Optional> * levelDic;

@end

@interface CreaditCardBanksListModel : JSONModel

@property (nonatomic, strong)NSString<Optional> * bankPriority;
@property (nonatomic, strong)NSString<Optional> * cardBankName;
@property (nonatomic, strong)NSString<Optional> * createTime;
@property (nonatomic, strong)NSString<Optional> * _id;
@property (nonatomic, strong)NSString<Optional> * logoUrl;
@property (nonatomic, strong)NSString<Optional> * status;

@end


@interface CreaditCardListModel : JSONModel

@property (nonatomic, strong)NSString<Optional> * applicantsCount;   //申请万人数
@property (nonatomic, strong)NSString<Optional> * bankInfoId;
@property (nonatomic, strong)NSString<Optional> * cardHighlights;
@property (nonatomic, strong)NSString<Optional> * cardLevel;
@property (nonatomic, strong)NSString<Optional> * cardLevelName;  //等级描述
@property (nonatomic, strong)NSString<Optional> * cardLogoUrl;
@property (nonatomic, strong)NSString<Optional> * cardName;
@property (nonatomic, strong)NSString<Optional> * contactAddress;
@property (nonatomic, strong)NSString<Optional> * contactName;
@property (nonatomic, strong)NSString<Optional> * contactPhone;
@property (nonatomic, strong)NSString<Optional> * cooperativeState;
@property (nonatomic, strong)NSString<Optional> * corporateName;
@property (nonatomic, strong)NSString<Optional> * createTime;
@property (nonatomic, strong)NSString<Optional> * hotRecommend;
@property (nonatomic, strong)NSString<Optional> * _id;
@property (nonatomic, strong)NSString<Optional> * linkAddress;
@property (nonatomic, strong)NSString<Optional> * operSettlementMethods;
@property (nonatomic, strong)NSString<Optional> * priority;


@property (nonatomic, strong)NSString<Optional> * applicants_count_;
@property (nonatomic, strong)NSString<Optional> * card_highlights_;
@property (nonatomic, strong)NSString<Optional> * card_level_name_;
@property (nonatomic, strong)NSString<Optional> * card_logo_url_;
@property (nonatomic, strong)NSString<Optional> * card_name_;
@property (nonatomic, strong)NSString<Optional> * id_;
@property (nonatomic, strong)NSString<Optional> * link_address_;

@end

@interface CreaditCardLevelModel : JSONModel

@property (nonatomic, strong)NSString<Optional> * name;
@property (nonatomic, strong)NSString<Optional> * value;

@end

@interface CreaditCardConditionParam : JSONModel

@property (nonatomic, strong)NSString<Optional> * bankInfoId; //不传默认查全部
@property (nonatomic, strong)NSString<Optional> * cardLevel;
@property (nonatomic, strong)NSString<Optional> * sort; //申请人数正序 ASC 倒叙DESC 不传默认倒叙

@end





