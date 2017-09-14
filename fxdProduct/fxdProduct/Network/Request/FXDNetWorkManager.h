//
//  FXDNetWorkManager.h
//  fxdProduct
//
//  Created by dd on 15/9/21.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkActivityIndicatorManager.h"
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>


//连接状态
typedef enum {
    ///返回数据正确
    Enum_SUCCESS = 0,
    ///返回数据出错
    Enum_FAIL = 1,
    ///连接不上服务器
    Enum_NOTCONNECTED = 2,
    ///超时连接
    Enum_CONNECTEDTIMEOUT = 3
} EnumServerStatus;

typedef void (^FinishedBlock)(EnumServerStatus status, id object);
typedef void (^FailureBlock)(EnumServerStatus status, id object);

@interface FXDNetWorkManager : NSObject{
    
}

+ (FXDNetWorkManager *)sharedNetWorkManager;

- (void)DataRequestWithURL:(NSString *)strURL isNeedNetStatus:(BOOL)isNeedNetStatus isNeedWait:(BOOL)isNeedWait parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;

- (void)POSTWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;

- (void)JXLPOSTWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;

- (void)POSTUpLoadImage:(NSString *)strURL FilePath:(NSDictionary *)images  parameters:(id)parameters finished:(FinishedBlock)finshed failure:(FailureBlock)failure;

- (void)POSTHideHUD:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;

- (void)CheckVersion:(NSString *)strUrl paramters:(id)paramters finished:(FinishedBlock)finished failure:(FailureBlock)failure;

- (void)P2POSTWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;

- (void)TCPOSTWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;


- (void)GetWithURL:(NSString *)strURL isNeedNetStatus:(BOOL)isNeedNetStatus parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;
@end
