//
//  CardInfo.h
//  fxdProduct
//
//  Created by dd on 16/7/29.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardInfo : JSONModel


@property (nonatomic, copy)NSString<Optional> *cardIdentifier;

@property (nonatomic, copy)NSString<Optional> *tailNumber;

@property (nonatomic, copy)NSString<Optional> *cardlNumber;

@property (nonatomic, copy)NSString<Optional> *phoneNum;

//新的Key值
@property (nonatomic, copy)NSString<Optional> *cardIcon;

@property (nonatomic, copy)NSString<Optional> *bankName;
@property (nonatomic, copy)NSString<Optional> *cardId;
@property (nonatomic, copy)NSString<Optional> *cardNo;
@property (nonatomic, copy)NSString<Optional> *cardShortName;
@property (nonatomic, copy)NSString<Optional> *cardType;  //1:信用卡，2:借记卡









@end
