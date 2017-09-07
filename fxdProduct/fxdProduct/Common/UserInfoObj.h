//
//  UserInfoObj.h
//  fxdProduct
//
//  Created by dd on 15/9/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginBaseClass.h"
#import "LoginParse.h"

//用户进件状态
typedef NS_ENUM(NSUInteger, ApplicationStatus) {
    InLoan = 1,      //放款中
    Repayment,       //还款中
    Staging,         //续期中
    OpenAccountStatus,     //开户处理中
    Activation,      //激活处理中
    RepaymentNormal,  //正常还款
    //    ComplianceInProcess,   //合规处理中
};

@interface UserInfoObj : NSObject

@property (nonatomic,assign) NSInteger login_flag;
@property (nonatomic,assign) double userId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,retain) NSString *tokenStr;
@property (nonatomic,retain) NSString *juid;
@property (nonatomic,retain) NSString *realName;
@property (nonatomic,assign) double creditLine;
@property (nonatomic,strong) NSString *uuidStr;
@property (nonatomic,strong) NSString *clientId;
@property (nonatomic,strong) NSString *userPass;
@property (nonatomic, copy) NSString *userIDNumber;
@property (nonatomic,strong) LoginBaseClass *userInfoModel;
@property (nonatomic,strong) LoginParse *loginMsgModel;
@property (nonatomic,assign) BOOL isUpdate;
@property (nonatomic, copy) NSString *userMobilePhone;
@property (nonatomic, copy) NSString *account_id;
@property (nonatomic, copy) NSString *pruductId;



@end
