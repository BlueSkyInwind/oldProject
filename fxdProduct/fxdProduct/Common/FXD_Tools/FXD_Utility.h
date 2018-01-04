//
//  FXD_Utility.h
//  fxdProduct
//
//  Created by dd on 15/9/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXD_UserInfoConfiguration.h"
#import "GetMoneyInfo.h"

@interface FXD_Utility : NSObject

@property (nonatomic,strong) FXD_UserInfoConfiguration *userInfo;
@property (nonatomic,strong) GetMoneyInfo *getMineyInfo;
@property (nonatomic,assign) BOOL loginFlage;
@property (nonatomic,assign) BOOL networkState;
@property (nonatomic,retain) NSMutableDictionary *getMoneyParam;
@property (nonatomic, assign) BOOL isObtainUserLocation;
@property (nonatomic,strong) NSString *amount;
@property (nonatomic,strong) NSString *operateType;

+ (FXD_Utility *)sharedUtility;

@end
