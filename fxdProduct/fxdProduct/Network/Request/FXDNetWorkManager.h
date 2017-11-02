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

/**
 新的api请求

 @param strURL 链接
 @param isNeedNetStatus 是否需要检查网络状态
 @param isNeedWait 是否需要进度条
 @param parameters 请求参数
 @param finished 成功回调
 @param failure 失败回调
 */
- (void)DataRequestWithURL:(NSString *)strURL isNeedNetStatus:(BOOL)isNeedNetStatus isNeedWait:(BOOL)isNeedWait parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;

- (void)GetWithURL:(NSString *)strURL isNeedNetStatus:(BOOL)isNeedNetStatus parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;

#pragma mark - 旧api使用
- (void)POSTWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;
//身份证图片上传
- (void)POSTUpLoadImage:(NSString *)strURL FilePath:(NSDictionary *)images  parameters:(id)parameters finished:(FinishedBlock)finshed failure:(FailureBlock)failure;

- (void)POSTHideHUD:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;

- (void)CheckVersion:(NSString *)strUrl paramters:(id)paramters finished:(FinishedBlock)finished failure:(FailureBlock)failure;
//合规请求
- (void)P2POSTWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;

//手机运营商超时设置特殊处理
- (void)TCPOSTWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure;


@end
