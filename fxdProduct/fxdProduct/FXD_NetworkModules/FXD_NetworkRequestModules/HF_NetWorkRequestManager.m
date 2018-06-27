//
//  HF_NetWorkRequestManager.m
//  fxdProduct
//
//  Created by dd on 15/9/21.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "HF_NetWorkRequestManager.h"
#import "AppDelegate.h"
#import "BaseNavigationViewController.h"
#import "LoginViewController.h"
#import "AFHTTPSessionManager.h"
#import "GTMBase64.h"
#import "DataWriteAndRead.h"

@interface HF_NetWorkRequestManager(){
    MBProgressHUD * _requestWaitView;
}
@end
@implementation HF_NetWorkRequestManager

+ (HF_NetWorkRequestManager *)sharedNetWorkManager
{
    static HF_NetWorkRequestManager *sharedNetWorkManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedNetWorkManagerInstance = [[self alloc] init];
    });
    return sharedNetWorkManagerInstance;
}
#pragma mark - 进度图
- (MBProgressHUD *)loadingHUD
{
    NSArray *arr = @[@"load4",@"load3",@"load2",@"load1"];
    UIImageView *waitImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        [imageArr addObject:[UIImage imageNamed:[arr objectAtIndex:i]]];
    }
    waitImageView.animationImages = imageArr;
    waitImageView.animationDuration = imageArr.count/3;
    waitImageView.animationRepeatCount = 0;
    [waitImageView startAnimating];
    MBProgressHUD *_waitView = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    _waitView.mode = MBProgressHUDModeCustomView;
    _waitView.customView = waitImageView;
    _waitView.dimBackground = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:_waitView];
    return _waitView;
}

-(void)removeWaitView{
    if (_requestWaitView) {
        [_requestWaitView removeFromSuperview];
    }
}
/**
 添加请求头
 */
-(void)setHttpHeaderInfo:(AFHTTPSessionManager *)manager{
    if ([FXD_Utility sharedUtility].userInfo.juid != nil && ![[FXD_Utility sharedUtility].userInfo.juid isEqualToString:@""]) {
        if ([FXD_Utility sharedUtility].userInfo.tokenStr != nil && ![[FXD_Utility sharedUtility].userInfo.tokenStr isEqualToString:@""]) {
            DLog(@"juid -- %@",[FXD_Utility sharedUtility].userInfo.juid);
            DLog(@"token -- %@",[FXD_Utility sharedUtility].userInfo.tokenStr);

            [manager.requestSerializer setValue:[FXD_Utility sharedUtility].userInfo.tokenStr forHTTPHeaderField:[NSString stringWithFormat:@"%@token",[FXD_Utility sharedUtility].userInfo.juid]];
            [manager.requestSerializer setValue:[FXD_Utility sharedUtility].userInfo.juid forHTTPHeaderField:@"juid"];
        }
    }
    [manager.requestSerializer setValue:CHANNEL forHTTPHeaderField:@"channel"];
    [manager.requestSerializer setValue:[FXD_Tool getAppVersion] forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:CODE_SERVICE_PLATFORM forHTTPHeaderField:@"platformType"];
}

#pragma mark - 发起请求

- (void)DataRequestWithURL:(NSString *)strURL isNeedNetStatus:(BOOL)isNeedNetStatus isNeedWait:(BOOL)isNeedWait parameters:(id)parameters finished:(SuccessFinishedBlock)finished failure:(FailureBlock)failure
{
    [self obtainDataWithUrl:strURL method:@"POST" parameters:parameters requestTime:30 isNeedNetStatus:isNeedNetStatus isNeedWait:isNeedWait uploadProgress:nil downloadProgress:nil finished:finished failure:failure];
}
- (void)GetWithURL:(NSString *)strURL isNeedNetStatus:(BOOL)isNeedNetStatus isNeedWait:(BOOL)isNeedWait parameters:(id)parameters finished:(SuccessFinishedBlock)finished failure:(FailureBlock)failure
{
    [self obtainDataWithUrl:strURL method:@"GET" parameters:parameters requestTime:30 isNeedNetStatus:isNeedNetStatus isNeedWait:isNeedWait uploadProgress:nil downloadProgress:nil finished:finished failure:failure];
}
- (void)TCPOSTWithURL:(NSString *)strURL parameters:(id)parameters finished:(SuccessFinishedBlock)finished failure:(FailureBlock)failure
{
    [self obtainDataWithUrl:strURL method:@"POST" parameters:parameters requestTime:360.0 isNeedNetStatus:true isNeedWait:true uploadProgress:nil downloadProgress:nil finished:finished failure:failure];
}

-(void)obtainDataWithUrl:(NSString *)strURL
                  method:(NSString *)method
              parameters:(id)parameters
             requestTime:(NSTimeInterval)requestTime
         isNeedNetStatus:(BOOL)isNeedNetStatus
              isNeedWait:(BOOL)isNeedWait
          uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
        downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                finished:(SuccessFinishedBlock)finished
                 failure:(FailureBlock)failure{
    
    // 网络判断
    if (![FXD_Utility sharedUtility].networkState && isNeedNetStatus) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请确认您的手机是否连接到网络!"];
        failure(Enum_NOTNETWORK,nil);
        return;
    }
    
    //版本强制更新
    if ([FXD_Utility sharedUtility].userInfo.isUpdate) {
        [[FXD_AlertViewCust sharedHHAlertView] showFXDAlertViewTitle:nil content:@"您当前使用版本太低,请前往APP Store更新后再使用!" attributeDic:nil TextAlignment:NSTextAlignmentCenter cancelTitle:nil sureTitle:@"确定" compleBlock:^(NSInteger index) {
            if (index == 1) {
                return;
            }
        }];
    }
    
    //进度条
    MBProgressHUD *_waitView = [self loadingHUD];
    if (isNeedWait) {
        [_waitView show:YES];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = isNeedWait;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    //请求头
    [self setHttpHeaderInfo:manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/x-www-form-urlencoded",@"application/json",@"charset=UTF-8",@"text/plain", nil];
    manager.requestSerializer.timeoutInterval = requestTime;
    
    DLog(@"-----requestParam-----%@",parameters);
    DLog(@"-----requestUrl-----%@",strURL);
    
   NSError *serializationError = nil;
  NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:strURL relativeToURL:nil] absoluteString] parameters:parameters error:&serializationError];
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    
  NSURLSessionDataTask *dataTask =  [manager dataTaskWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                DLog(@"response error --- %@",error.description);
                [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"服务器请求失败,请重试!"];
                [_waitView removeFromSuperview];
                [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
                failure(Enum_FAIL,error);
            }
        } else {
            if (finished) {
                
                NSDictionary * resultDic = [NSDictionary dictionary];
                if ([responseObject isKindOfClass:[NSData class]]) {
                    resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                }else{
                    resultDic = [NSDictionary dictionaryWithDictionary:responseObject];
                    NSData *data = [NSJSONSerialization dataWithJSONObject:resultDic options:NSJSONWritingPrettyPrinted error:nil];
                    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                }
                DLog(@"response json --- %@",resultDic.description);
                if ([[resultDic objectForKey:@"errCode"] isEqualToString:@"3"] ) {
                    UIViewController *vc = [self getCurrentVC];
                    [vc.navigationController popToRootViewControllerAnimated:YES];
                    [[FXD_AlertViewCust sharedHHAlertView] showFXDAlertViewTitle:nil  content:[resultDic objectForKey:@"friendErrMsg"] attributeDic:nil TextAlignment:NSTextAlignmentCenter cancelTitle:nil sureTitle:@"确定" compleBlock:^(NSInteger index) {
                        if (index == 1) {
                            [FXD_Utility EmptyData];
                            LoginViewController *loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                            BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
                            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                                [_waitView removeFromSuperview];
                            }];
                        }
                    }];
                }
                [_waitView removeFromSuperview];
                [AFNetworkActivityIndicatorManager sharedManager].enabled = isNeedWait;
                finished(Enum_SUCCESS,responseObject);
            }
        }
    }];
    [dataTask resume];
}

- (void)POSTUpLoadImage:(NSString *)strURL FilePath:(NSDictionary *)images  parameters:(id)parameters finished:(SuccessFinishedBlock)finshed failure:(FailureBlock)failure
{
    if ([FXD_Utility sharedUtility].userInfo.isUpdate) {
        [[FXD_AlertViewCust sharedHHAlertView] showFXDAlertViewTitle:nil content:@"您当前使用版本太低,请前往APP Store更新后再使用!" attributeDic:nil TextAlignment:NSTextAlignmentCenter cancelTitle:nil sureTitle:@"确定" compleBlock:^(NSInteger index) {
            if (index == 1) {
                return;
            }
        }];
    } else {
        MBProgressHUD *_waitView = [self loadingHUD];
        [_waitView show:YES];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        DLog(@"请求url:---%@\n 参数:----%@",strURL,parameters);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 30.0;
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        if ([FXD_Utility sharedUtility].userInfo.juid != nil && ![[FXD_Utility sharedUtility].userInfo.juid isEqualToString:@""]) {
            if ([FXD_Utility sharedUtility].userInfo.tokenStr != nil && ![[FXD_Utility sharedUtility].userInfo.tokenStr isEqualToString:@""]) {
                [manager.requestSerializer setValue:[FXD_Utility sharedUtility].userInfo.tokenStr forHTTPHeaderField:[NSString stringWithFormat:@"%@token",[FXD_Utility sharedUtility].userInfo.juid]];
                [manager.requestSerializer setValue:[FXD_Utility sharedUtility].userInfo.juid forHTTPHeaderField:@"juid"];
                [manager.requestSerializer setValue:CODE_SERVICE_PLATFORM forHTTPHeaderField:@"platformType"];
            }
        }
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html"@"charset=utf-8",@"application/json", nil];
        [manager POST:strURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            if (images) {
                NSArray *allKeys = [images allKeys];
                [allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSString *imageKey = obj;
                    NSData *data = [images valueForKey:imageKey];
                    //                    UIImageJPEGRepresentation([images valueForKey:imageKey], 0.2);
                    [formData appendPartWithFileData:data name:imageKey fileName:imageKey mimeType:@"image/jpeg"];
                }];
            }
            //添加准备上传的图片
            //将UIimage 转换成NSData
            //            NSData *data=UIImageJPEGRepresentation(image,0.2);
            //            [GTMBase64 encodeData:data];
            //            [formData appendPartWithFileData:data name:@"image" fileName:@"image" mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
            NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            DLog(@"response json --- %@",jsonStr);
            finshed(Enum_SUCCESS,responseObject);
            [_waitView removeFromSuperview];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(Enum_FAIL,error);
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"认证失败!"];
            DLog(@"error---%@",error.localizedDescription);
            [_waitView removeFromSuperview];
            [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
        }];
    }
}

- (void)HG_POSTWithURL:(NSString *)strURL parameters:(id)parameters finished:(SuccessFinishedBlock)finished failure:(FailureBlock)failure
{
    DLog(@"%d",[FXD_Utility sharedUtility].userInfo.isUpdate);
    if ([FXD_Utility sharedUtility].userInfo.isUpdate) {
        [[FXD_AlertViewCust sharedHHAlertView] showFXDAlertViewTitle:nil content:@"您当前使用版本太低,请前往APP Store更新后再使用!" attributeDic:nil TextAlignment:NSTextAlignmentCenter cancelTitle:nil sureTitle:@"确定" compleBlock:^(NSInteger index) {
            if (index == 1) {
                return;
            }
        }];
    } else {
        if (![FXD_Utility sharedUtility].networkState) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请确认您的手机是否连接到网络!"];
            return;
        } else {
            MBProgressHUD *_waitView = [self loadingHUD];
            [_waitView show:YES];
            [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//            manager.requestSerializer=[AFHTTPRequestSerializer serializer];
            
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            //            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            DLog(@"juid --- %@\n token --- %@",[FXD_Utility sharedUtility].userInfo.juid,[FXD_Utility sharedUtility].userInfo.tokenStr);
            if ([FXD_Utility sharedUtility].userInfo.juid != nil && ![[FXD_Utility sharedUtility].userInfo.juid isEqualToString:@""]) {
                if ([FXD_Utility sharedUtility].userInfo.tokenStr != nil && ![[FXD_Utility sharedUtility].userInfo.tokenStr isEqualToString:@""]) {
                    [manager.requestSerializer setValue:[FXD_Utility sharedUtility].userInfo.tokenStr forHTTPHeaderField:[NSString stringWithFormat:@"%@token",[FXD_Utility sharedUtility].userInfo.juid]];
                    [manager.requestSerializer setValue:[FXD_Utility sharedUtility].userInfo.juid forHTTPHeaderField:@"juid"];
                }
            }
            [manager.requestSerializer setValue:[FXD_Tool getAppVersion] forHTTPHeaderField:@"version"];
            [manager.requestSerializer setValue:CODE_SERVICE_PLATFORM forHTTPHeaderField:@"platformType"];
            [manager.requestSerializer setValue:CHANNEL forHTTPHeaderField:@"channel"];
            [manager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/xml",@"text/html",@"application/x-www-form-urlencoded",@"application/json", @"text/json", @"text/javascript",@"charset=UTF-8", nil];
            
            manager.requestSerializer.timeoutInterval = 30.0;
            DLog(@"%@",parameters);
            [manager POST:strURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;

                if ([[responseObject objectForKey:@"flag"] isEqualToString:@"0003"] || [[responseObject objectForKey:@"flag"] isEqualToString:@"0016"] || [[responseObject objectForKey:@"flag"] isEqualToString:@"0015"]) {
                    [[FXD_AlertViewCust sharedHHAlertView] showFXDAlertViewTitle:nil  content:[responseObject objectForKey:@"msg"] attributeDic:nil TextAlignment:NSTextAlignmentCenter cancelTitle:nil sureTitle:@"确定" compleBlock:^(NSInteger index) {
                        if (index == 1) {
                            [FXD_Utility EmptyData];
                            LoginViewController *loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                            BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
                            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
                                [_waitView removeFromSuperview];
                            }];
                        }
                    }];
                }
                
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
                NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                DLog(@"response json --- %@",jsonStr);
                //            [Tool dataToDictionary:responseObject]
                finished(Enum_SUCCESS,responseObject);
                [_waitView removeFromSuperview];
                [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(Enum_FAIL,error);
                [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"服务器请求失败,请重试!"];
                DLog(@"error---%@***%ld",error.description,error.code);
                [_waitView removeFromSuperview];
                [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
            }];
        }
    }
}

#pragma mark - 获取当前视图
- (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}

@end