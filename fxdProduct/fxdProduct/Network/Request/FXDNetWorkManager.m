//
//  FXDNetWorkManager.m
//  fxdProduct
//
//  Created by dd on 15/9/21.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "FXDNetWorkManager.h"
#import "AppDelegate.h"
#import "BaseNavigationViewController.h"
#import "LoginViewController.h"
#import "AFHTTPSessionManager.h"
#import "GTMBase64.h"
#import "DataWriteAndRead.h"

@implementation FXDNetWorkManager

+ (FXDNetWorkManager *)sharedNetWorkManager
{
    static FXDNetWorkManager *sharedNetWorkManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedNetWorkManagerInstance = [[self alloc] init];
    });
    return sharedNetWorkManagerInstance;
}

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

- (void)POSTWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure
{
    DLog(@"%d",[Utility sharedUtility].userInfo.isUpdate);
    if ([Utility sharedUtility].userInfo.isUpdate) {
        [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:@"您当前使用版本太低,请前往APP Store更新后再使用!" cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
            if (index == 1) {
                return;
            }
        }];
    } else {
        if (![Utility sharedUtility].networkState) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请确认您的手机是否连接到网络!"];
            return;
        } else {
            MBProgressHUD *_waitView = [self loadingHUD];
            [_waitView show:YES];
            [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
            NSDictionary *paramDic = [NSDictionary dictionary];
            DLog(@"请求url:---%@\n加密前参数:----%@",strURL,parameters);
            
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            
            if (parameters) {
                if ([Tool dicContainsKey:parameters keyValue:@"Encrypt"]) {
                    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
                    [muDic removeObjectForKey:@"Encrypt"];
                    paramDic = [muDic copy];
                } else {
                    paramDic = [Tool getParameters:parameters];
                }
            }
            DLog(@"加密后参数:---%@",paramDic);
            //        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
            //        securityPolicy.allowInvalidCertificates = YES;
            //        securityPolicy setPinnedCertificates:
            //        securityPolicy.validatesDomainName = YES;
            //        manager.securityPolicy = securityPolicy;
            //            manager.requestSerializer=[AFHTTPRequestSerializer serializer];
            
            DLog(@"juid --- %@\n token --- %@",[Utility sharedUtility].userInfo.juid,[Utility sharedUtility].userInfo.tokenStr);
            if ([Utility sharedUtility].userInfo.juid != nil && ![[Utility sharedUtility].userInfo.juid isEqualToString:@""]) {
                if ([Utility sharedUtility].userInfo.tokenStr != nil && ![[Utility sharedUtility].userInfo.tokenStr isEqualToString:@""]) {
                    [manager.requestSerializer setValue:[Utility sharedUtility].userInfo.tokenStr forHTTPHeaderField:[NSString stringWithFormat:@"%@token",[Utility sharedUtility].userInfo.juid]];
                    [manager.requestSerializer setValue:[Utility sharedUtility].userInfo.juid forHTTPHeaderField:@"juid"];
                }
            }
            //@"text/plain",@"text/xml",@"text/html",, @"text/json", @"text/javascript"
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/x-www-form-urlencoded",@"application/json",@"charset=UTF-8",@"text/plain", nil];
            
            manager.requestSerializer.timeoutInterval = 30.0;
            DLog(@"%@",parameters);
            [manager POST:strURL parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([[responseObject objectForKey:@"flag"] isEqualToString:@"0003"] || [[responseObject objectForKey:@"flag"] isEqualToString:@"0016"] || [[responseObject objectForKey:@"flag"] isEqualToString:@"0015"]) {
                    UIViewController *vc = [self getCurrentVC];
                    [vc.navigationController popToRootViewControllerAnimated:YES];
                    [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:[responseObject objectForKey:@"msg"] cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
                        if (index == 1) {
                            [EmptyUserData EmptyData];
                            
                            LoginViewController *loginView = [LoginViewController new];
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
                DLog(@"error---%@",error.description);
                [_waitView removeFromSuperview];
                [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
            }];
        }
    }
}

- (void)JXLPOSTWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure
{
    DLog(@"%d",[Utility sharedUtility].userInfo.isUpdate);
    if ([Utility sharedUtility].userInfo.isUpdate) {
        [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:@"您当前使用版本太低,请前往APP Store更新后再使用!" cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
            if (index == 1) {
                return;
            }
        }];
    } else {
        if (![Utility sharedUtility].networkState) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请确认您的手机是否连接到网络!"];
            return;
        } else {
            MBProgressHUD *_waitView = [self loadingHUD];
            [_waitView show:YES];
            [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
            DLog(@"请求url:---%@\n加密前参数:----%@",strURL,parameters);
            
            
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
           
            //@"text/plain",@"text/xml",@"text/html",, @"text/json", @"text/javascript"
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"charset=UTF-8",@"text/html",@"text/json",@"text/plain", nil];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            
            manager.requestSerializer.timeoutInterval = 30.0;
            DLog(@"%@",parameters);
            [manager POST:strURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([[responseObject objectForKey:@"flag"] isEqualToString:@"0003"] || [[responseObject objectForKey:@"flag"] isEqualToString:@"0016"] || [[responseObject objectForKey:@"flag"] isEqualToString:@"0015"]) {
                    UIViewController *vc = [self getCurrentVC];
                    [vc.navigationController popToRootViewControllerAnimated:YES];
                    [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:[responseObject objectForKey:@"msg"] cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
                        if (index == 1) {
                            [EmptyUserData EmptyData];
                            
                            LoginViewController *loginView = [LoginViewController new];
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
                DLog(@"error---%@",error.description);
                [_waitView removeFromSuperview];
                [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
            }];
        }
    }
}


- (void)CheckVersion:(NSString *)strUrl paramters:(id)paramters finished:(FinishedBlock)finished failure:(FailureBlock)failure
{
    MBProgressHUD *_waitView = [self loadingHUD];
    [_waitView show:YES];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    NSDictionary *paramDic = [NSDictionary dictionary];
    DLog(@"请求url:---%@\n加密前参数:----%@",strUrl,paramters);
    if (paramters) {
        paramDic = [Tool getParameters:paramters];
    }
    DLog(@"加密后参数:---%@",paramDic);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/xml",@"text/html",@"application/x-www-form-urlencoded",@"application/json", @"text/json", @"text/javascript",@"charset=UTF-8", nil];
    manager.requestSerializer.timeoutInterval = 30.0;
    DLog(@"%@",paramters);
    [manager POST:strUrl parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
        if ([[responseObject objectForKey:@"flag"] isEqualToString:@"0013"]) {
            [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:[responseObject objectForKey:@"msg"] cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
                if (index == 1) {
                    [EmptyUserData EmptyData];
                    LoginViewController *loginView = [LoginViewController new];
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
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(Enum_FAIL,error);
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"服务器请求失败,请重试!"];
        DLog(@"error---%@",error.description);
        [_waitView removeFromSuperview];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
    }];
}

- (void)POSTHideHUD:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure
{
    DLog(@"%d",[Utility sharedUtility].userInfo.isUpdate);
    if ([Utility sharedUtility].userInfo.isUpdate) {
        [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:@"您当前使用版本太低,请前往APP Store更新后再使用!" cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
            if (index == 1) {
                return;
            }
        }];
    } else {
        //        if (![Utility sharedUtility].networkState) {
        //            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请确认您的手机是否连接到网络!"];
        //            return;
        //        } else {
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        NSDictionary *paramDic = [NSDictionary dictionary];
        DLog(@"请求url:---%@\n加密前参数:----%@",strURL,parameters);
        if (parameters) {
            paramDic = [Tool getParameters:parameters];
        }
        DLog(@"加密后参数:---%@",paramDic);
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        //        securityPolicy.allowInvalidCertificates = YES;
        //        securityPolicy setPinnedCertificates:
        //        securityPolicy.validatesDomainName = YES;
        //        manager.securityPolicy = securityPolicy;
        DLog(@"juid --- %@\n token --- %@",[Utility sharedUtility].userInfo.juid,[Utility sharedUtility].userInfo.tokenStr);
        if ([Utility sharedUtility].userInfo.juid != nil && ![[Utility sharedUtility].userInfo.juid isEqualToString:@""]) {
            if ([Utility sharedUtility].userInfo.tokenStr != nil && ![[Utility sharedUtility].userInfo.tokenStr isEqualToString:@""]) {
                [manager.requestSerializer setValue:[Utility sharedUtility].userInfo.tokenStr forHTTPHeaderField:[NSString stringWithFormat:@"%@token",[Utility sharedUtility].userInfo.juid]];
                [manager.requestSerializer setValue:[Utility sharedUtility].userInfo.juid forHTTPHeaderField:@"juid"];
            }
        }
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/xml",@"text/html",@"application/x-www-form-urlencoded",@"application/json", @"text/json", @"text/javascript",@"charset=UTF-8", nil];
        
        manager.requestSerializer.timeoutInterval = 30.0;
        DLog(@"%@",parameters);
        [manager POST:strURL parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
            if ([[responseObject objectForKey:@"flag"] isEqualToString:@"0003"] || [[responseObject objectForKey:@"flag"] isEqualToString:@"0016"] || [[responseObject objectForKey:@"flag"] isEqualToString:@"0015"]) {
                [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:[responseObject objectForKey:@"msg"] cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
                    if (index == 1) {
                        [EmptyUserData EmptyData];
                        LoginViewController *loginView = [LoginViewController new];
                        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
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
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(Enum_FAIL,error);
            DLog(@"error---%@",error.description);
            [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
        }];
    }
}


- (void)POSTUpLoadImage:(NSString *)strURL FilePath:(NSDictionary *)images  parameters:(id)parameters finished:(FinishedBlock)finshed failure:(FailureBlock)failure
{
    if ([Utility sharedUtility].userInfo.isUpdate) {
        [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:@"您当前使用版本太低,请前往APP Store更新后再使用!" cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
            return;
        }];
    } else {
        MBProgressHUD *_waitView = [self loadingHUD];
        [_waitView show:YES];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        DLog(@"请求url:---%@\n 参数:----%@",strURL,parameters);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 30.0;
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        if ([Utility sharedUtility].userInfo.juid != nil && ![[Utility sharedUtility].userInfo.juid isEqualToString:@""]) {
            if ([Utility sharedUtility].userInfo.tokenStr != nil && ![[Utility sharedUtility].userInfo.tokenStr isEqualToString:@""]) {
                [manager.requestSerializer setValue:[Utility sharedUtility].userInfo.tokenStr forHTTPHeaderField:[NSString stringWithFormat:@"%@token",[Utility sharedUtility].userInfo.juid]];
                [manager.requestSerializer setValue:[Utility sharedUtility].userInfo.juid forHTTPHeaderField:@"juid"];
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
//                        [GTMBase64 encodeData:data];
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



- (void)P2POSTWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure
{
    DLog(@"%d",[Utility sharedUtility].userInfo.isUpdate);
    if ([Utility sharedUtility].userInfo.isUpdate) {
        [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:@"您当前使用版本太低,请前往APP Store更新后再使用!" cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
            if (index == 1) {
                return;
            }
        }];
    } else {
        if (![Utility sharedUtility].networkState) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请确认您的手机是否连接到网络!"];
            return;
        } else {
            MBProgressHUD *_waitView = [self loadingHUD];
            [_waitView show:YES];
            [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
            //            NSDictionary *paramDic = [NSDictionary dictionary];
            //            DLog(@"请求url:---%@\n加密前参数:----%@",strURL,parameters);
            //            if (parameters) {
            //                paramDic = [Tool getParameters:parameters];
            //            }
            //            DLog(@"加密后参数:---%@",paramDic);
            
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            //        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
            //        securityPolicy.allowInvalidCertificates = YES;
            //        securityPolicy setPinnedCertificates:
            //        securityPolicy.validatesDomainName = YES;
            //        manager.securityPolicy = securityPolicy;
            manager.requestSerializer=[AFHTTPRequestSerializer serializer];
            //            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            DLog(@"juid --- %@\n token --- %@",[Utility sharedUtility].userInfo.juid,[Utility sharedUtility].userInfo.tokenStr);
            if ([Utility sharedUtility].userInfo.juid != nil && ![[Utility sharedUtility].userInfo.juid isEqualToString:@""]) {
                if ([Utility sharedUtility].userInfo.tokenStr != nil && ![[Utility sharedUtility].userInfo.tokenStr isEqualToString:@""]) {
                    [manager.requestSerializer setValue:[Utility sharedUtility].userInfo.tokenStr forHTTPHeaderField:[NSString stringWithFormat:@"%@token",[Utility sharedUtility].userInfo.juid]];
                    [manager.requestSerializer setValue:[Utility sharedUtility].userInfo.juid forHTTPHeaderField:@"juid"];
                }
            }
            
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/xml",@"text/html",@"application/x-www-form-urlencoded",@"application/json", @"text/json", @"text/javascript",@"charset=UTF-8", nil];
            
            manager.requestSerializer.timeoutInterval = 30.0;
            DLog(@"%@",parameters);
            [manager POST:strURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
                //            if ([Tool dicContainsKey:[operation.response allHeaderFields] keyValue:@"token"]) {
                //                [Utility sharedUtility].userInfo.tokenStr = [[operation.response allHeaderFields] objectForKey:@"token"];
                //            }
                if ([[responseObject objectForKey:@"flag"] isEqualToString:@"0003"] || [[responseObject objectForKey:@"flag"] isEqualToString:@"0016"] || [[responseObject objectForKey:@"flag"] isEqualToString:@"0015"]) {
                    [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:[responseObject objectForKey:@"msg"] cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
                        if (index == 1) {
                            [EmptyUserData EmptyData];
                            LoginViewController *loginView = [LoginViewController new];
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

- (void)GetWithURL:(NSString *)strURL parameters:(id)parameters finished:(FinishedBlock)finished failure:(FailureBlock)failure
{
    DLog(@"%d",[Utility sharedUtility].userInfo.isUpdate);
    if ([Utility sharedUtility].userInfo.isUpdate) {
        [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:@"您当前使用版本太低,请前往APP Store更新后再使用!" cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
            if (index == 1) {
                return;
            }
        }];
    } else {
        if (![Utility sharedUtility].networkState) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请确认您的手机是否连接到网络!"];
            return;
        } else {
            MBProgressHUD *_waitView = [self loadingHUD];
            [_waitView show:YES];
            [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
            //            NSDictionary *paramDic = [NSDictionary dictionary];
            //            DLog(@"请求url:---%@\n加密前参数:----%@",strURL,parameters);
            //            if (parameters) {
            //                paramDic = [Tool getParameters:parameters];
            //            }
            //            DLog(@"加密后参数:---%@",paramDic);
            
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            //        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
            //        securityPolicy.allowInvalidCertificates = YES;
            //        securityPolicy setPinnedCertificates:
            //        securityPolicy.validatesDomainName = YES;
            //        manager.securityPolicy = securityPolicy;
            manager.requestSerializer=[AFHTTPRequestSerializer serializer];
            //            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            DLog(@"juid --- %@\n token --- %@",[Utility sharedUtility].userInfo.juid,[Utility sharedUtility].userInfo.tokenStr);
            if ([Utility sharedUtility].userInfo.juid != nil && ![[Utility sharedUtility].userInfo.juid isEqualToString:@""]) {
                if ([Utility sharedUtility].userInfo.tokenStr != nil && ![[Utility sharedUtility].userInfo.tokenStr isEqualToString:@""]) {
                    [manager.requestSerializer setValue:[Utility sharedUtility].userInfo.tokenStr forHTTPHeaderField:[NSString stringWithFormat:@"%@token",[Utility sharedUtility].userInfo.juid]];
                    [manager.requestSerializer setValue:[Utility sharedUtility].userInfo.juid forHTTPHeaderField:@"juid"];
                }
            }
            
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/xml",@"text/html",@"application/x-www-form-urlencoded",@"application/json", @"text/json", @"text/javascript",@"charset=UTF-8", nil];
            
            manager.requestSerializer.timeoutInterval = 30.0;
            DLog(@"%@",parameters);
            
            [manager GET:strURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([[responseObject objectForKey:@"flag"] isEqualToString:@"0003"] || [[responseObject objectForKey:@"flag"] isEqualToString:@"0016"] || [[responseObject objectForKey:@"flag"] isEqualToString:@"0015"]) {
                    [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:[responseObject objectForKey:@"msg"] cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
                        if (index == 1) {
                            [EmptyUserData EmptyData];
                            LoginViewController *loginView = [LoginViewController new];
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
                DLog(@"error---%@",error.description);
                [_waitView removeFromSuperview];
                [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
            }];
        }
    }
}

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
