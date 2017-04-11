//
//  Utility.h
//  fxdProduct
//
//  Created by dd on 15/9/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoObj.h"
#import "GetMoneyInfo.h"

@interface Utility : NSObject

@property (nonatomic,strong) UserInfoObj *userInfo;
@property (nonatomic,strong) GetMoneyInfo *getMineyInfo;
@property (nonatomic,assign) BOOL loginFlage;
@property (nonatomic,assign) BOOL networkState;
@property (nonatomic,retain) NSMutableDictionary *getMoneyParam;


+ (Utility *)sharedUtility;

@end
