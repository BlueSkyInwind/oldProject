//
//  MoxieSDK.h
//  MoxieSDK
//
//  Created by shenzw on 6/23/16.
//  Copyright © 2016 shenzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 功能的种类
 */
typedef enum {
    MXSDKFunctionemail=0,
    MXSDKFunctionbank,
    MXSDKFunctioncarrier,
    MXSDKFunctionqq,
    MXSDKFunctionalipay,
    MXSDKFunctionalipayH5,
    MXSDKFunctiontaobao,
    MXSDKFunctionjingdong,
    MXSDKFunctionjingdongH5,
    MXSDKFunctioninsurance,
    MXSDKFunctionchsi,
    MXSDKFunctionfund,
    MXSDKFunctionzhengxin,
    MXSDKFunctionmaimai
}MXSDKFunction;

typedef void(^ResultBlock)(int,MXSDKFunction,NSString *,NSString *);
@interface MoxieSDK : NSObject
//************************基本信息，只读******************/
/**
 *  用户id标识
 */
@property (nonatomic,copy,readonly) NSString *mxUserId;
/**
 *  ApiKey
 */
@property (nonatomic,copy,readonly) NSString *mxApiKey;
/**
 *  SDK版本
 */
@property (nonatomic,copy,readonly) NSString *mxSDKVersion;
/**
 *  扩展参数类，可以自定义多种参数
 */
//@property (nonatomic,strong,readonly) MXExtendParams *extendParams;
/**********************SDK 函数接口 ******************************/
/**
 *  结果回调block
 */
@property (nonatomic,strong) ResultBlock resultBlock;

/**
 *  SDK单例
 */
+(MoxieSDK*)shared;
/**
 *  SDK初始化参数
 *
 *  @param mUserID    用户id
 *  @param mApikey    apikey
 *  @param controller 前一个controller
 *
 */
-(MoxieSDK *)initWithUserID:(NSString *)mUserID mApikey:(NSString *)mApikey controller:(UIViewController *)controller;
/**
 *  修改SDK参数
 *
 *  @param mUserID 用户id
 *  @param mApikey apikey
 */
-(void)setUserID:(NSString *)mUserID mApikey:(NSString *)mApikey;
/**
 *  打开SDK功能函数
 *
 *  @param function SDK的某个功能
 */
-(void)startFunction:(MXSDKFunction)function;

/**********************SDK 自定义参数列表*******************************/
/**
 *  导航器，支持自定义样式，可直接修改
 */
@property (nonatomic,strong) UINavigationController *mxNavigationController;
/**
 *  返回按钮图片
 */
@property (nonatomic,strong) UIImage *backImage;
/**
 *  刷新按钮图片
 */
@property (nonatomic,strong) UIImage *refreshImage;
/**
 *  主题色定义
 */
@property (nonatomic,strong) UIColor *themeColor;
/**
 *  协议地址
 */
@property (nonatomic,copy) NSString *agreementUrl;
/**
 *  项目是否可修改，默认为YES（只对下面默认设置过的参数有效）
 */
@property (nonatomic,assign) BOOL textfield_editable;
/**
 *  运营商默认手机号码
 */
@property (nonatomic,copy) NSString *carrier_phone;
/**
 *  运营商默认服务密码
 */
@property (nonatomic,copy) NSString *carrier_password;
/**
 *  运营商默认姓名
 */
@property (nonatomic,copy) NSString *carrier_name;
/**
 *  运营商默认身份证
 */
@property (nonatomic,copy) NSString *carrier_idcard;
/**
 *  邮箱列表页面的BannerView
 */
@property (nonatomic,strong) UIView *email_headerView;
/**
 *  网银列表页面的BannerView
 */
@property (nonatomic,strong) UIView *bank_headerView;
/**
 *  车险列表页面的BannerView
 */
@property (nonatomic,strong) UIView *insurance_headerView;
/**
 *  公积金列表页面的BannerView
 */
@property (nonatomic,strong) UIView *fund_headerView;
@end
