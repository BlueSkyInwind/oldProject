//
//  GlobalConfig.h
//  fxdProduct
//
//  Created by dd on 15/8/4.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#ifndef fxdProduct_GlobalConfig_h
#define fxdProduct_GlobalConfig_h

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"File_name:%s\nFuntion_Name:%s\nlines:%d \n" fmt), [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String] , __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

typedef void(^ReturnValueBlock)(id returnValue);
typedef void(^FaileBlock)();

//十六进制色值
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 设置三原色
#define RGBColor(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define _view_width    self.view.frame.size.width
#define _view_height   self.view.frame.size.height
#define _k_w           [UIScreen mainScreen].bounds.size.width
#define _k_h           [UIScreen mainScreen].bounds.size.height
#define _k_WSwitch     [UIScreen mainScreen].bounds.size.width/375.0f

#define UI_IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define UI_IS_IPHONE5           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define UI_IS_IPHONE6P            (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define UI_IS_IPHONE6            (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define UI_IS_IPHONE4           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0)
#define UI_IS_IPHONEX           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)
#define BarHeightNew [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height

#define UI_IS_IPAD           ([[UIScreen mainScreen] bounds].size.height == 768.0)

#define UI_MAIN_COLOR [UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1]

#define KCharacterNumber @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

UIKIT_EXTERN NSString * const _main_url;
UIKIT_EXTERN NSString * const _main_new_url;
UIKIT_EXTERN NSString * const _mainTwo_new_url;
UIKIT_EXTERN NSString * const _ValidESB_url;
UIKIT_EXTERN NSString * const _P2P_url;
UIKIT_EXTERN NSString * const _H5_url;
UIKIT_EXTERN NSString * const _ZMXY_url;
UIKIT_EXTERN NSString * const _SETP_url;
UIKIT_EXTERN NSString * const _ZhimaBack_url;
UIKIT_EXTERN NSString * const _p2P_url;
UIKIT_EXTERN NSString * const _agreement_url;


UIKIT_EXTERN NSString * const       _getCode_url;                            //获取验证码
UIKIT_EXTERN NSString * const       _regCode_url;                            //注册验证码
UIKIT_EXTERN NSString * const       _reg_url;                                //注册
UIKIT_EXTERN NSString * const       _login_url;                              //登陆
UIKIT_EXTERN NSString * const       _loginOut_url;                           //退出登陆
UIKIT_EXTERN NSString * const       _updateDevID_url;                        //更改设备号
UIKIT_EXTERN NSString * const       _forget_url;                             //忘记密码
UIKIT_EXTERN NSString * const       _changePassword_url;                     //更换密码
UIKIT_EXTERN NSString * const       _userState_url;                          //首页查询用户借款状态
UIKIT_EXTERN NSString * const       _secondApply_url;                        //二次进件
UIKIT_EXTERN NSString * const       _updateUserById_url;                     //提交用户信息
UIKIT_EXTERN NSString * const       _saveLoanApplicant_url;                  //进件
UIKIT_EXTERN NSString * const       _findLoanAuditProgress_url;              //进度审核
UIKIT_EXTERN NSString * const       _userSureRefuseLoanAction_url;           //用户拒绝与接收
UIKIT_EXTERN NSString * const       _updateAvatar_url;                       //上传照片
UIKIT_EXTERN NSString * const       _feedBack_url;                           //意见反馈
UIKIT_EXTERN NSString * const       _getMoneyHistory_url;                    //借款记录
UIKIT_EXTERN NSString * const       _getRepayHistory_url;                    //还款记录
UIKIT_EXTERN NSString * const       _schoolList_url;                         //学校列表
UIKIT_EXTERN NSString * const       _BankNumCheck_url;                       //银行卡校验
UIKIT_EXTERN NSString * const       _getCustomerAuth_jhtml;                  //获取手机认证信息
UIKIT_EXTERN NSString * const       _getFristRepaymentDate;                  //提款获取第一个还款日
UIKIT_EXTERN NSString * const       _getMobileOpera_url;                     //获取手机运营商
UIKIT_EXTERN NSString * const       _getTianChuangCertification_url;         //手机号认证 (天创)

UIKIT_EXTERN NSString * const       _getCustomerBase_url;                    //客户所有信息获取接口-点击我要借款
UIKIT_EXTERN NSString * const       _saveCustomerBase_url;                   //客户基本信息保存接口
UIKIT_EXTERN NSString * const       _getAllRegionList_url;                   //获取省市区全部数据接口
UIKIT_EXTERN NSString * const       _saveCustomerCarrer_jhtml;               //客户职业信息保存接口
UIKIT_EXTERN NSString * const       _getCustomerCarrer_jhtml;                //客户职业信息获取接口
UIKIT_EXTERN NSString * const       _createApplication_jhtml;                //进件接口
UIKIT_EXTERN NSString * const       _getProductList_jhtml;                   //产品列表获取接口
UIKIT_EXTERN NSString * const       _saveUserContacts_jhtml;                 //用户通讯录保存接口
UIKIT_EXTERN NSString * const       _updateLoginLatitude_url;                //登陆更新经纬度
UIKIT_EXTERN NSString * const       _getRegionCodeByName_jhtml;              //获取省市区编码
UIKIT_EXTERN NSString * const       _checkVersion_jhtml;                     //版本检测
UIKIT_EXTERN NSString * const       _newDrawApply_jhtml;                   //二次提款

UIKIT_EXTERN NSString * const       _getSupportBankList_url;                        //获取银行卡支持列表
UIKIT_EXTERN NSString * const       _getContractStagingInfo_url;             //合同及期供信息查询接口
UIKIT_EXTERN NSString * const       _RepayOrSettleWithPeriod_url;            //还款结清接口(新)
UIKIT_EXTERN NSString * const       _transition_url;                         //开户返回URL
UIKIT_EXTERN NSString * const       _getPicCode_url;                         //图形验证码获取
UIKIT_EXTERN NSString * const       _checkMobilePhoneAuth_url;               //手机认证有效性检查
UIKIT_EXTERN NSString * const       _authMobilePhone_url;                    //手机认证信息保存
UIKIT_EXTERN NSString * const       _aboutus_url;                            //关于我们H5
UIKIT_EXTERN NSString * const       _depHistory_url;                         //发展历程H5
UIKIT_EXTERN NSString * const       _newproductProtocol_url;                    //协议内容获取接口
UIKIT_EXTERN NSString * const       _hgLoanProtoolList_url;                    //合规的件 调用此接口 用于获取借款协议列表
UIKIT_EXTERN NSString * const       _newproductProtocolH5_url;                    //协议的h5地址
UIKIT_EXTERN NSString * const       _h5register_url;                         //H5注册
UIKIT_EXTERN NSString * const       _detectIDCardOCR_url;                    //FaceID
UIKIT_EXTERN NSString * const       _verifyLive_url;                         //FaceID人脸对比身份核实
UIKIT_EXTERN NSString * const       _customerContact_url;                    //联系人信息上传
UIKIT_EXTERN NSString * const       _saveIDInfo_url;
UIKIT_EXTERN NSString * const       _BankCardList_url;                       //银行卡列表信息
UIKIT_EXTERN NSString * const       _registerID_url;                         //上传用户的registerID
UIKIT_EXTERN NSString * const       _UserDataCertification_url;              //用户资料测评接口
UIKIT_EXTERN NSString * const       _UserDataCertificationResult_url;        //得到测评结果
UIKIT_EXTERN NSString * const       _loginOutDeleteRegisterId_url;           //退出登录删除推送id
UIKIT_EXTERN NSString * const       _creditLimitInfo_url;                    //额度页面信息获取
UIKIT_EXTERN NSString * const       _increaseAmount_url;                    //用户提额接口

UIKIT_EXTERN NSString * const       _memberShipInfo_url;                    //会员页面信息

#pragma mark - 视频认证接口
UIKIT_EXTERN NSString * const       _VideoVerify_url;                    //获取视频认证信息
UIKIT_EXTERN NSString * const       _uploadVideoVideo_url;                    //上传视频

//用户身份证图片上传
UIKIT_EXTERN NSString * const       _detectInfo_url;                         //活体检测信息上传
UIKIT_EXTERN NSString * const       _GetRecomfrInfo_url;                     //推荐码规则
UIKIT_EXTERN NSString * const       _topBanner_url;                          //Banner广告获取
UIKIT_EXTERN NSString * const       _question_url;                           //常见问题
UIKIT_EXTERN NSString * const       _getDicCode_url;                         //数据字典获取
UIKIT_EXTERN NSString * const       _submitZhimaCredit_url;                    //芝麻信用授权提交
UIKIT_EXTERN NSString * const       _zhimaCreditCallBack_url;                    //芝麻信用回调地址
UIKIT_EXTERN NSString * const       _sendSms_url;                     //发送短信接口
UIKIT_EXTERN NSString * const       _account_url;                    //获取合规开户信息
UIKIT_EXTERN NSString * const       _change_BankCards_url;                  //提交合规换绑银行卡信息
UIKIT_EXTERN NSString * const       _hgUser_Active_url;                  //合规获取老用户激活跳转页面参数
UIKIT_EXTERN NSString * const       _queryUserStatus_url;                  //合规用户状态查询
UIKIT_EXTERN NSString * const       _liangzihuzhu_url;                  //量子互助
UIKIT_EXTERN NSString * const       _sjRecord_url;                  //首借免息
UIKIT_EXTERN NSString * const       _shebaoupload_url;                  //社保认证信息提交
UIKIT_EXTERN NSString * const       _TheCreditCardupload_url;                  //信用卡信息提交
UIKIT_EXTERN NSString * const       _TheInternetbank_url;                  //网银信息提交
UIKIT_EXTERN NSString * const       _HighRankingStatus_url;                  //高级认证状态查询
UIKIT_EXTERN NSString * const       _UserBasicInformation_url;               //基础认证状态查询
UIKIT_EXTERN NSString * const       _UserIDCardUpload_url;       //用户身份证上传
UIKIT_EXTERN NSString * const       _UserThirdPartCertification_url;         //三方认证状态查询
UIKIT_EXTERN NSString * const       _UserContactInfo_url;                    //用户联系人信息
UIKIT_EXTERN NSString * const       _new_CreateApplication_url;                  //新版用户进件接口
UIKIT_EXTERN NSString * const       _calculateApplicationInfo_url;                  //申请信息计算
UIKIT_EXTERN NSString * const       _newApplicationViewInfo_url;                  //申请确认页数据
UIKIT_EXTERN NSString * const       _CapitalLoanBack_url;                  //联联绑卡回调地址
UIKIT_EXTERN NSString * const       _CapitalLoanFail_url;                  //app 连连绑卡页面用户放弃操作接口
UIKIT_EXTERN NSString * const       _New_DiscountTicket_url;                  //优惠券规则
UIKIT_EXTERN NSString * const       _repayDetailAmountInfo_url;                  //获取还款金额信息


UIKIT_EXTERN NSString * const       _PersonalCenterWithdrawCashAPI_url;      //个人中心（优惠券,现金红包,账户余额）
UIKIT_EXTERN NSString * const       _LoadWithdrawCash_url;                   //现金红包,账户余额（点击列表操作展示提现页）
UIKIT_EXTERN NSString * const       _WithdrawCash_url;                       //提现
UIKIT_EXTERN NSString * const       _withDrawFunds_url;                       //新版提现


UIKIT_EXTERN NSString * const       _CheckWithdrawCash_url;                  //校验提现条件
UIKIT_EXTERN NSString * const       _WithdrawCashDetail_url;                 //现金红包收提明细
UIKIT_EXTERN NSString * const       _verifyIdentityCard_url;                 //验证身份证
UIKIT_EXTERN NSString * const       _verifyOldPassword_url;                  //验证旧交易密码
UIKIT_EXTERN NSString * const       _verifyTradeSMS_url;                     //验证交易呀验证码
UIKIT_EXTERN NSString * const       _saveNewPassword_url;                    //设置新的交易密码、
UIKIT_EXTERN NSString * const       _modificationPassword_url;               //设置新的交易密码
UIKIT_EXTERN NSString * const       _CountStationLetterMsg_url;              //站内信用户未读信息统计接口
UIKIT_EXTERN NSString * const       _ShowMsgPreview_url;                     //站内信未读已读列表
UIKIT_EXTERN NSString * const       _DiversionProStatics_url;                //导流产品埋点接口
UIKIT_EXTERN NSString * const       _ExperienceValue_url;                    //经验值体系-展示等级
UIKIT_EXTERN NSString * const       _NewSummary_url;                         //新版首页接口
UIKIT_EXTERN NSString * const       _compQuery_url;                          //首页贷超接口
UIKIT_EXTERN NSString * const       _getCompLink_url;                          //导流平台跳转接口

UIKIT_EXTERN NSString * const   CODE_REG;          ///注册验证码
UIKIT_EXTERN NSString * const   CODE_FINDPASS;         ///密码找回验证码
UIKIT_EXTERN NSString * const   CODE_CHANGEDEVID;       ///设备号更改
UIKIT_EXTERN NSString * const   CODE_LOGIN;              ///登陆验证码
UIKIT_EXTERN NSString * const   CODE_DRAW;              ///提款
UIKIT_EXTERN NSString * const   CODE_ADDCARD;          //新增卡
UIKIT_EXTERN NSString * const   CODE_TRADEPASSWORD;                             ///修改密码验证码

UIKIT_EXTERN NSString * const SalaryLoan;          //工薪贷平台
UIKIT_EXTERN NSString * const RapidLoan;         //急速贷平台
UIKIT_EXTERN NSString * const WhiteCollarLoan;       //白领贷平台
UIKIT_EXTERN NSString * const DeriveRapidLoan;       //急速贷衍生（30天）平台
UIKIT_EXTERN NSString * const EliteLoan;       //精英贷

UIKIT_EXTERN NSString * const PLATFORM;                 //平台
UIKIT_EXTERN NSString * const CHANNEL;
UIKIT_EXTERN NSString * const SERVICE_PLATFORM;
UIKIT_EXTERN NSString * const Devcode;      //开发码

UIKIT_EXTERN NSString * const FaceIDAppKey; //FaceID

UIKIT_EXTERN NSString * const FaceIDAppSecret;

UIKIT_EXTERN NSString * const Fxd_pw;

UIKIT_EXTERN NSString * const GeTuiAppId;
UIKIT_EXTERN NSString * const GeTuiAppKey;
UIKIT_EXTERN NSString * const GeTuiAppSecret;


UIKIT_EXTERN NSString * const UmengKey;


UIKIT_EXTERN NSString * const kUserID;
UIKIT_EXTERN NSString * const kUserPass;

//juid
UIKIT_EXTERN NSString * const Fxd_JUID;
//token
UIKIT_EXTERN NSString * const Fxd_Token;

//登陆标识
UIKIT_EXTERN NSString * const kLoginFlag;
//邀请码
UIKIT_EXTERN NSString * const kInvitationCode;

UIKIT_EXTERN NSString * const kTopView;

//用户
UIKIT_EXTERN NSString * const UserName;

//通知
UIKIT_EXTERN NSString * const  kAddMaterailNotification;

UIKIT_EXTERN NSString * const isLoginFlag;

UIKIT_EXTERN NSString * const SERVERNAME;

UIKIT_EXTERN NSString * const UserInfomation;

UIKIT_EXTERN NSString * const FirstLunch;

UIKIT_EXTERN NSString * const theMoxieApiKey;            //魔蝎key

//提示语
UIKIT_EXTERN NSString * const IDOCRMarkeords;
UIKIT_EXTERN NSString * const obtainUserContactMarkeords;
UIKIT_EXTERN NSString * const IncreaseAmountLimitMarkeords;


#define MAS_SHORTHAND_GLOBALS

#endif
