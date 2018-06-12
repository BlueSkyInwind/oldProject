//
//  FXD_Utility.h
//  fxdProduct
//
//  Created by dd on 15/9/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXD_UserInfoConfiguration.h"

@interface FXD_Utility : NSObject

@property (nonatomic,strong) FXD_UserInfoConfiguration *userInfo;
@property (nonatomic,assign) BOOL loginFlage;
@property (nonatomic,assign) BOOL networkState;
@property (nonatomic,retain) NSMutableDictionary *getMoneyParam;
@property (nonatomic, assign) BOOL isObtainUserLocation;
@property (nonatomic,strong) NSString *amount;
@property (nonatomic,strong) NSString *operateType;
@property (nonatomic,strong) NSMutableArray *popArray;    //全局弹窗缓存数组
@property (nonatomic,assign) BOOL isActivityShow;  //活动弹窗标识
@property (nonatomic,assign) BOOL isHomeChooseShow;


+ (FXD_Utility *)sharedUtility;

+ (void)EmptyData;

@end
