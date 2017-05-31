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
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif


typedef void(^ReturnValueBlock)(id returnValue);
typedef void(^FaileBlock)();

 
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
#define UI_IS_IPHONE4           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0)

#define UI_MAIN_COLOR [UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1]


UIKIT_EXTERN NSString * const _main_url;
UIKIT_EXTERN NSString * const _ValidESB_url;
UIKIT_EXTERN NSString * const _P2P_url;
UIKIT_EXTERN NSString * const _H5_url;
UIKIT_EXTERN NSString * const _ZMXY_url;
UIKIT_EXTERN NSString * const _SETP_url;
UIKIT_EXTERN NSString * const _ZhimaBack_url;
UIKIT_EXTERN NSString * const _p2P_url;

UIKIT_EXTERN NSString * const       _getCode_url;                            //获取验证码
UIKIT_EXTERN NSString * const       _regCode_url;                            //注册验证码
UIKIT_EXTERN NSString * const       _reg_url;                                //注册
UIKIT_EXTERN NSString * const       _login_url;                              //登陆
UIKIT_EXTERN NSString * const       _loginOut_url;                           //退出登陆
UIKIT_EXTERN NSString * const       _updateDevID_url;                        //更改设备号
UIKIT_EXTERN NSString * const       _forget_url;                             //忘记密码
UIKIT_EXTERN NSString * const       _userState_url;                          //首页查询用户借款状态
UIKIT_EXTERN NSString * const       _secondApply_url;                        //二次进件
UIKIT_EXTERN NSString * const       _updateUserById_url;                     //提交用户信息
UIKIT_EXTERN NSString * const       _saveLoanApplicant_url;                  //进件
UIKIT_EXTERN NSString * const       _findLoanAuditProgress_url;              //进度审核
UIKIT_EXTERN NSString * const       _userSureRefuseLoanAction_url;           //用户拒绝与接收
UIKIT_EXTERN NSString * const       _userLoan_url;                           //提款
UIKIT_EXTERN NSString * const       _AllUserShouldAlsoAmount_url;            //查询用户还款的额(一次结清)
UIKIT_EXTERN NSString * const       _AlluserRepayment_url;                   //用户还款(一次结清)
UIKIT_EXTERN NSString * const       _WeekUserShouldAlsoAmount_url;           //查询用户周还款额(周)
UIKIT_EXTERN NSString * const       _WeekUserRepayment_url;                  //用户还款(按周)
UIKIT_EXTERN NSString * const       _updateAvatar_url;                       //上传照片
UIKIT_EXTERN NSString * const       _cardList_url;                           //银行卡列表查询
UIKIT_EXTERN NSString * const       _CHANGEPASS_URL;                         //更改密码
UIKIT_EXTERN NSString * const       _feedBack_url;                           //意见反馈
UIKIT_EXTERN NSString * const       _getMoneyHistory_url;                    //借款记录
UIKIT_EXTERN NSString * const       _getRepayHistory_url;                    //还款记录
UIKIT_EXTERN NSString * const       _schoolList_url;                         //学校列表
UIKIT_EXTERN NSString * const       _BankNumCheck_url;                       //银行卡校验
UIKIT_EXTERN NSString * const       _Certification_url;                      //手机认证信息
UIKIT_EXTERN NSString * const       _getCustomerAuth_jhtml;                  //获取手机认证信息
UIKIT_EXTERN NSString * const       _drawApply_url;                          //提款
UIKIT_EXTERN NSString * const       _getFristRepaymentDate;                  //提款获取第一个还款日
UIKIT_EXTERN NSString * const       _getMobileOpera_url;                     //获取手机运营商
UIKIT_EXTERN NSString * const       _getCustomerBase_url;                    //客户所有信息获取接口-点击我要借款
UIKIT_EXTERN NSString * const       _saveCustomerBase_url;                   //客户基本信息保存接口
UIKIT_EXTERN NSString * const       _getAllRegionList_url;                   //获取省市区全部数据接口
UIKIT_EXTERN NSString * const       _saveCustomerCarrer_jhtml;               //客户职业信息保存接口
UIKIT_EXTERN NSString * const       _getCustomerCarrer_jhtml;                //客户职业信息获取接口
UIKIT_EXTERN NSString * const       _createApplication_jhtml;                //进件接口
UIKIT_EXTERN NSString * const       _approvalAmount_jhtml;                   //审批金额查询接口
UIKIT_EXTERN NSString * const       _getProductList_jhtml;                   //产品列表获取接口
UIKIT_EXTERN NSString * const       _saveFaceId_url;                         //人脸识别结果保存
UIKIT_EXTERN NSString * const       _saveUserContacts_jhtml;                 //用户通讯录保存接口
UIKIT_EXTERN NSString * const       _updateLoginLatitude_url;                //登陆更新经纬度
UIKIT_EXTERN NSString * const       _getRegionCodeByName_jhtml;              //获取省市区编码
UIKIT_EXTERN NSString * const       _checkVersion_jhtml;                     //版本检测
UIKIT_EXTERN NSString * const       _drawApplyAgain_jhtml;                   //二次提款
UIKIT_EXTERN NSString * const       _getUserRedpacket_url;                   //红包获取
UIKIT_EXTERN NSString * const       _caseStatusUpdateApi_url;                //申请件状态更新
UIKIT_EXTERN NSString * const       _getBankList_url;                        //银行卡获取接口
UIKIT_EXTERN NSString * const       _saveInputBackInfo_url;                  //输入框埋点
UIKIT_EXTERN NSString * const       _getContractStagingInfo_url;             //合同及期供信息查询接口
UIKIT_EXTERN NSString * const       _doRepayOrSettle_url;                    //还款结清接口
UIKIT_EXTERN NSString * const       _RepayOrSettleWithPeriod_url;            //还款结清接口(新)
UIKIT_EXTERN NSString * const       _getFXDUserInfo_url;                     //P2P获取用户信息
UIKIT_EXTERN NSString * const       _drawService_url;                        //P2P客户信息录入
UIKIT_EXTERN NSString * const       _register_url;                           //P2P开户
UIKIT_EXTERN NSString * const       _bindCard_url;                           //P2P绑卡
UIKIT_EXTERN NSString * const       _getFXDCaseInfo_url;                     //发标前查询进件
UIKIT_EXTERN NSString * const       _addBidInfo_url;                         //发标
UIKIT_EXTERN NSString * const       _memberService_url;                      //P2P余额查询
UIKIT_EXTERN NSString * const       _transition_url;                         //开户返回URL
UIKIT_EXTERN NSString * const       _netSave_url;                            //P2P还款充值
UIKIT_EXTERN NSString * const       _doPay_url;                              //P2P正常还款
UIKIT_EXTERN NSString * const       _rechargeing_url;                        //P2P充值回调
UIKIT_EXTERN NSString * const       _doSettle_url;                           //P2P结清
UIKIT_EXTERN NSString * const       _getPicCode_url;                         //图形验证码获取
UIKIT_EXTERN NSString * const       _checkMobilePhoneAuth_url;               //手机认证有效性检查
UIKIT_EXTERN NSString * const       _authMobilePhone_url;                    //手机认证信息保存
UIKIT_EXTERN NSString * const       _queryAuthStatus_url;                    //用户QQ/支付宝认证状态查询
UIKIT_EXTERN NSString * const       _aboutus_url;                            //关于我们H5
UIKIT_EXTERN NSString * const       _depHistory_url;                         //发展历程H5
UIKIT_EXTERN NSString * const       _mediaReport_url;                        //媒体报道H5
UIKIT_EXTERN NSString * const       _adv_url;                                //首页广告
UIKIT_EXTERN NSString * const       _contractList_url;                       //平台合同列表
UIKIT_EXTERN NSString * const       _contractStr_url;                        //合同内容
UIKIT_EXTERN NSString * const       _querybillDetails_url;                   //P2P平台账单期供查询
UIKIT_EXTERN NSString * const       _productProtocol_url;                    //协议内容获取接口
UIKIT_EXTERN NSString * const       _queryLoanRecord_url;                    //首页借款记录
UIKIT_EXTERN NSString * const       _queryLoanStatus_url;                    //借款进度
UIKIT_EXTERN NSString * const       _h5register_url;                         //H5注册
UIKIT_EXTERN NSString * const       _loanDetial_url;                         //H5费用说明
UIKIT_EXTERN NSString * const       _detectIDCardOCR_url;                    //FaceID
UIKIT_EXTERN NSString * const       _verifyLive_url;                         //FaceID人脸对比身份核实
UIKIT_EXTERN NSString * const       _customerAuthInfo_url;                   //查询用户信息录入进度
UIKIT_EXTERN NSString * const       _JXLGetToken_url;                        //聚信力TOKEN获取
UIKIT_EXTERN NSString * const       _customerContact_url;                    //联系人信息上传
UIKIT_EXTERN NSString * const       _saveIDInfo_url;
UIKIT_EXTERN NSString * const       _getLimitProductlist_url;                //首页产品列表路径

//用户身份证图片上传
UIKIT_EXTERN NSString * const       _messagesReq_url;                        //聚信力信息采集
UIKIT_EXTERN NSString * const       _detectInfo_url;                         //活体检测信息上传
UIKIT_EXTERN NSString * const       _GetRecomfrInfo_url;                     //推荐码规则
UIKIT_EXTERN NSString * const       _fatchRate_url;                          //费率查询
UIKIT_EXTERN NSString * const       _topBanner_url;                          //Banner广告获取
UIKIT_EXTERN NSString * const       _question_url;                           //常见问题
UIKIT_EXTERN NSString * const       _getDicCode_url;                         //数据字典获取
UIKIT_EXTERN NSString * const       _mobileAuthentication_url;               //手机认证
UIKIT_EXTERN NSString * const       _selectPlatform_url;                     //审核被拒，去看看
UIKIT_EXTERN NSString * const       _findZhimaCredit_url;                     //芝麻信用授权查询
UIKIT_EXTERN NSString * const       _submitZhimaCredit_url;                    //芝麻信用授权提交
UIKIT_EXTERN NSString * const       _zhimaCreditCallBack_url;                    //芝麻信用回调地址
UIKIT_EXTERN NSString * const       _sendSms_url;                     //发送短信接口
UIKIT_EXTERN NSString * const       _bankCards_url;                     //换绑银行卡
UIKIT_EXTERN NSString * const       _huifu_url;                    //用户开户接口
UIKIT_EXTERN NSString * const       _queryCardInfo_url;                    //银行卡查询接口
UIKIT_EXTERN NSString * const       _accountHSService_url;                    //用户状态查询接口
UIKIT_EXTERN NSString * const       _paymentService_url;                    //主动还款接口
UIKIT_EXTERN NSString * const       _cash_url;                    //取现
UIKIT_EXTERN NSString * const       _toCash_url;                  //取现返回url
UIKIT_EXTERN NSString * const       _bosAcctActivate_url;                  //激活老账户
UIKIT_EXTERN NSString * const       _queryBidStatus_url;                  //标的状态查询接口
UIKIT_EXTERN NSString * const       _bosAcctActivateRet_url;                  //激活老账户返回url
UIKIT_EXTERN NSString * const       _qryUserStatus_url;                  //用户状态查询
UIKIT_EXTERN NSString * const       _getBidStatus_url;                  //用户标的状态查询

UIKIT_EXTERN NSString * const   CODE_REG;          ///注册验证码
UIKIT_EXTERN NSString * const   CODE_FINDPASS;         ///密码找回验证码
UIKIT_EXTERN NSString * const   CODE_CHANGEPASS;      ///修改密码验证码
UIKIT_EXTERN NSString * const   CODE_CHANGEDEVID;       ///设备号更改
UIKIT_EXTERN NSString * const   CODE_LOGIN;              ///登陆验证码
UIKIT_EXTERN NSString * const   CODE_BANKMOBILE;         ///银行预留手机验证码(银行卡修改)
UIKIT_EXTERN NSString * const   CODE_DRAW;              ///提款
UIKIT_EXTERN NSString * const   CODE_ADDCARD;          //新增卡


UIKIT_EXTERN NSString * const SalaryLoan;          //工薪贷平台
UIKIT_EXTERN NSString * const RapidLoan;         //急速贷平台
UIKIT_EXTERN NSString * const WhiteCollarLoan;       //白领贷平台

UIKIT_EXTERN NSString * const PLATFORM;                 //平台
UIKIT_EXTERN NSString * const Devcode;      //开发码

UIKIT_EXTERN NSString * const FaceIDAppKey; //FaceID
UIKIT_EXTERN NSString * const FaceIDAppSecret;


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

// 表名
#define userTableName   [Utility sharedUtility].userInfo.userName

//通知
UIKIT_EXTERN NSString * const  kAddMaterailNotification;


UIKIT_EXTERN NSString * const isLoginFlag;

UIKIT_EXTERN NSString * const SERVERNAME;

UIKIT_EXTERN NSString * const UserInfomation;

UIKIT_EXTERN NSString * const FirstLunch;


UIKIT_EXTERN NSString * const theMoxieApiKey;            //魔蝎key

#define MAS_SHORTHAND_GLOBALS

#endif
