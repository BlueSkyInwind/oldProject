//
//  BSFingerSDK.h
//  BSFingerSDK
//
//  Created by Scorpio on 12/21/15.
//  Copyright © 2015 bsfit. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 设备指纹插件回调协议 : 由客户端实现.
 *
 */
@protocol BSFingerCallBack <NSObject>

/**
 * 设备指纹回调方法: 设备指纹生成成功
 *
 */
- (void)generateOnSuccess :(NSString *) fingerPrint andTraceId :(NSString *)traceId;

/**
 * 设备指纹回调方法: 设备指纹生成失败
 *
 */
- (void)generateOnFailed :(NSError *) error;

@end


@interface BSFingerSDK : NSObject

/**
 *
 * 是否需要显示设备指纹插件的日志.
 *
 */
@property BOOL isDebug;

/**
 * 设备指纹生成类的单例.
 *
 * 调用方式 :
 *
 * [BSFingerSDK sharedInstance];
 *
 */
+ (instancetype)sharedInstance;

/**
 * 生成设备指纹的方法.
 *
 * 调用方式 :
 *
 * [[BSFingerSDK shardInstance] getFingerPrint:self];
 *
 * 注意 :
 *
 * 1. self 必须是实现了BSFingerCallBack协议的类或是其他.
 *
 */
- (void)getFingerPrint: (id<BSFingerCallBack>)delegate withKey: (NSString *)key;

/**
 * 恢复所有设备指纹后台服务
 *
 */
- (void)resumeAll;

/**
 * 停止所有设备指纹后台服务
 *
 */
- (void)cancelAll;

@end
