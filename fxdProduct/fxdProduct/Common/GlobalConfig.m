

 #ifdef FXD_Environment_Mode
#if FXD_Environment_Mode == 0

NSString * const _main_url  =   @"https://h5.faxindai.com:8028/fxd-esb/esb/"; //生产
NSString * const _agreement_url  =   @"https://h5.faxindai.com:8028/fxd-esb/esb/";
NSString * const _ValidESB_url = @"https://h5.faxindai.com:8028/fxd-esb/";
NSString * const _P2P_url = @"https://fintech.chinazyjr.com/p2p/"; //生产
NSString * const _p2P_url = @"https://h5.faxindai.com:8028/fxd-esb/p2p/";
NSString * const _H5_url    =   @"https://h5.faxindai.com:8028/fxd-h5/page/";
NSString * const _main_new_url  =  @"https://h5.faxindai.com:8028/apigw/client/";
NSString * const _mainTwo_new_url  =  @"http://h5.faxindai.com:8028/coregw/client/";

#elif FXD_Environment_Mode == 1

//测试环境
//http://192.168.14.14:9090/fxd-esb/esb/    张鹏
//http://192.168.15.116:8055/fxd-esb    俊杰
//http://192.168.12.109:8082/fxd-esb/  罗兵本地
//http://192.168.7.140:8001/fxd-esb/esb/ 合规贷后测试地址
//http://192.168.13.173:8005/ 张强本地

//测试导流 192.168.6.134
//NSString * const _main_url  =   @"http://h5.test.fxds/fxd-esb/esb/";
//NSString * const _agreement_url  =   @"http://h5.test.fxds/fxd-esb/esb/";
//NSString * const _main_new_url  =  @"http://h5.test.fxds/";
//NSString * const _ValidESB_url  =   @"http://h5.test.fxds/fxd-esb/";
//NSString * const _H5_url    =   @"http://h5.test.fxds/fxd-h5/page/";
//NSString * const _p2P_url = @"http://h5.test.fxds/fxd-esb/p2p/";
//NSString * const _P2P_url   =   @"http://192.168.6.85:9090/p2p/";

NSString * const _main_url  =   @"http://h5.dev.fxds/fxd-esb/esb/";
NSString * const _agreement_url  =   @"http://h5.dev.fxds/fxd-esb/esb/";
NSString * const _ValidESB_url  =   @"http://h5.dev.fxds/fxd-esb/";
NSString * const _main_new_url  =  @"http://h5.dev.fxds/apigw/client/";
NSString * const _mainTwo_new_url  =  @"http://h5.dev.fxds/coregw/client/";
NSString * const _H5_url    =   @"http://h5.dev.fxds/fxd-h5/page/";
NSString * const _p2P_url = @"http://h5.dev.fxds/fxd-esb/p2p/";
NSString * const _P2P_url   =   @"http://192.168.6.85:9090/p2p/";

//UAT环境
//NSString * const _main_url  =   @"http://h5.uat.fxds/fxd-esb/esb/";
//NSString * const _agreement_url  =   @"http://h5.uat.fxds/fxd-esb/esb/";
//NSString * const _main_new_url  =  @"http://h5.uat.fxds/";
//NSString * const _ValidESB_url  =   @"http://h5.uat.fxds/fxd-esb/";
//NSString * const _H5_url    =   @"http://h5.uat.fxds/fxd-h5/page/";
//NSString * const _p2P_url = @"http://h5.uat.fxds/fxd-esb/p2p/";
//NSString * const _P2P_url   =   @"http://192.168.6.85:9090/p2p/";

//http://192.168.6.134:9191/fxd-esb/
//本地
//NSString * const _main_url  =   @"http://h5.dev.fxds/fxd-esb/esb/";
//NSString * const _agreement_url  =   @"http://h5.dev.fxds/fxd-esb/esb/";
//NSString * const _main_new_url  =  @"http://h5.dev.fxds/";
//NSString * const _ValidESB_url  =   @"http://h5.dev.fxds/fxd-esb/";
//NSString * const _H5_url    =   @"http://h5.dev.fxds/fxd-h5/page/";
//NSString * const _p2P_url = @"http://h5.dev.fxds/fxd-esb/p2p/";
//NSString * const _P2P_url   =   @"http://192.168.6.85:9090/p2p/";

//芝麻信用测试地址
//NSString * const _main_url  =   @"http://180.168.159.198:19090/fxd-esb/esb/";

#else
#warning "未匹配环境"
#endif
#endif

#pragma Mark - 项目URL


//申请件状态更新
NSString * const     _caseStatusUpdateApi_url   =   @"increase/caseStatusUpdateApi.jhtml";

//银行卡获取接口
NSString * const     _getBankList_url           =   @"getDictCode/getDictCodeList.jhtml";

//发标前查询进件
NSString * const    _getFXDCaseInfo_url         =   @"p2p/hg/getFXDCaseInfo.jhtml";

//开户返回URL
NSString * const    _transition_url     =  @"https://h5.faxindai.com:8028/fxd-h5/page/case/app_transition.html";

//关于我们H5
NSString * const    _aboutus_url                =    @"more/about_us.html";

//发展历程H5
NSString * const    _depHistory_url             =    @"more/depHistory.html";

//协议内容获取接口
NSString * const    _productProtocol_url        =    @"ProductProtocol/getProductProtocol.jhtml";

//H5注册
NSString * const    _h5register_url             =    @"register.html";

//FaceIDOCR
NSString * const    _detectIDCardOCR_url        =    @"https://api.faceid.com/faceid/v1/ocridcard";

//FaceID人脸对比身份核实
NSString * const    _verifyLive_url             =    @"https://api.megvii.com/faceid/v2/verify";

//常见问题
NSString * const    _question_url               =    @"more/question.html";

//手机认证
NSString * const    _mobileAuthentication_url    =    @"case/case_main_phone.html";

//审核被拒，去看看
NSString * const    _selectPlatform_url    =    @"case/select_platform.html";

//芝麻信用授权查询
NSString * const    _findZhimaCredit_url    =    @"zmxy/findZhimaCreditAuthStatus.jhtml";


#pragma mark - 新的api

//社保
NSString * const    _shebaoupload_url    =    @"resource/mxsbtask_create";

//信用卡
NSString * const    _TheCreditCardupload_url    =    @"resource/mxmailtask_create";

//高级认证状态查询
NSString * const    _HighRankingStatus_url    =    @"resource/fundtask";

//基础信息状态查询接口
NSString * const    _UserBasicInformation_url    =    @"user/info/base";

//三方信息状态查询接口
NSString * const    _UserThirdPartCertification_url    =    @"user/other/info";

//三方信息状态查询接口
NSString * const    _AuthenticationCenterBasicInformation_url    =    @"user/base/complete/info";

//联系人信息的完成状态
NSString * const    _UserContactInfo_url    =    @"user/contact/info";

//首页状态查询
NSString * const    _HomeState_url    =    @"summary";

//申请进件
NSString * const    _createApplication_url    =    @"application/create";

//申请确认页数据
NSString * const    _ApplicationViewInfo_url    =    @"application/confirm";

//提款页数据
NSString * const    _UserDrawingInfo_url    =    @"application/loan";

//获取当前期的续期信息
NSString * const    _repayment_url    =    @"repayment/staging/continue/info";

//银行卡列表信息
NSString * const    _BankCardList_url    =    @"bank/card/list";

//放款中 还款中 展期中 状态实时获取
NSString * const    _ApplicationStatus_url    =    @"application/status";

//工薪贷根据周期获取费用
NSString * const    _SalaryProductFee_url    =    @"fee/calc";

//提交续期请求
NSString * const    _Staging_url    =    @"staging/continue/add";

//待还款界面信息获取
NSString * const    _Repay_url    =    @"ready/to/repay";

//获取续期规则
NSString * const    _StagingRule_url    =    @"continue/rule/detail";

//上传用户的registerID
NSString * const    _registerID_url    =    @"center/jiguang/register";

//用户资料测评接口
NSString * const    _UserDataCertification_url    =    @"user/measurement/info";

//用户资料测评接口
NSString * const    _Trilateral_url    =    @"repay/third/pay";

//得到测评结果
NSString * const    _UserDataCertificationResult_url    =    @"user/verify/status";

//退出登录删除推送id
NSString * const    _loginOutDeleteRegisterId_url    =    @"center/jiguang/delete";

//资金平台列表
NSString * const    _CapitalList_url    =    @"capital/list";

//资金平台放款接口
NSString * const    _CapitalLoan_url    =    @"capital/loan";

//联联绑卡回调地址
NSString * const    _CapitalLoanBack_url    =    @"paidcenter/lianlian/notify";

//联联绑卡返回回调地址
NSString * const    _ShanLinBack_url    =    @"main.html#shanlinBack";

//app 连连绑卡页面用户放弃操作接口
NSString * const    _CapitalLoanFail_url    =    @"capital/loan/fail";

//优惠券接口
NSString * const    _DiscountTicketList_url    =    @"market/getuserBase";

//选择模式列表
NSString * const    _ChoosePattern_url    =    @"ios/expay";

//优惠券规则
NSString * const    _DiscountTicketRule_url    =    @"protocol/couponInstructions.html";

//新优惠券规则
NSString * const    _New_DiscountTicket_url    =    @"operation/client/getuse";

//新优惠券规则
NSString * const    _DeductibleAmountOfDiscountTicket_url    =    @"order/voucher/money/single";

//登陆
NSString * const     _login_url        =    @"membership/login";

//注册
NSString * const     _reg_url          =   @"membership/register";

//获取验证码    common/sendSMS.jhtml
NSString * const     _getCode_url                   =   @"toolbox/sms/sendSMS";

//更改设备号
NSString * const     _updateDevID_url            =   @"membership/updateLoginEquipment";

//图形验证码
NSString * const    _getPicCode_url             =    @"membership/getPicCodeApi";

//注册验证码
NSString * const    _regCode_url                    =   @"toolbox/sms/sendSMSH5Api";

//忘记密码
NSString * const     _forget_url                    =   @"membership/findPasswordBack";

//更换密码
NSString * const     _changePassword_url                    =   @"membership/updatePassword";

//退出登陆
NSString * const     _loginOut_url                  =   @"membership/logout";

//客户所有信息获取接口
NSString * const     _getCustomerBase_url           =   @"membership/customer/getCustomerBase";

//客户职业信息获取接口
NSString * const     _getCustomerCarrer_jhtml       =   @"membership/customer/getCustomerCarrer";

//用户身份证图片上传
NSString * const    _saveIDInfo_url             =    @"membership/customerAuth/saveCustomerIDInfo";

//客户基本信息保存接口
NSString * const     _saveCustomerBase_url          =   @"membership/customerAuth/saveCustomerBaseInfo";

//数据字典获取
NSString * const    _getDicCode_url             =    @"dict/getDictCodeList";

//获取省市区编码
NSString * const     _getRegionCodeByName_jhtml     =  @"region/getRegionCodeByName";

//获取省市区全部数据接口
NSString * const     _getAllRegionList_url          =    @"region/getAllRegionByOrderList";

//客户职业信息保存接口
NSString * const     _saveCustomerCarrer_jhtml      =   @"membership/customer/saveCustomerCarrer";

//联系人信息上传
NSString * const    _customerContact_url        =    @"membership/customerAuth/saveCustomerContactInfo";

//用户通讯录保存接口
NSString * const     _saveUserContacts_jhtml        =   @"membership/saveUserContacts";

//活体检测信息上传
NSString * const    _detectInfo_url             =    @"membership/saveCustomerDetectInfo";

//芝麻信用授权提交
NSString * const    _submitZhimaCredit_url    =    @"customerSesameCreditAuth";

//获取手机运营商天创
NSString * const     _getTianChuangCertification_url          =   @"saveCustomerAuthTcMobile";

//芝麻信用回调地址
NSString * const    _zhimaCreditCallBack_url    =    @"zhimaCreditCallBackApi";

//获取手机运营商
NSString * const     _getMobileOpera_url            =   @"getCarrierNameByMobile";

//手机认证信息保存
NSString * const    _authMobilePhone_url            =   @"user/common/authMobilePhone";

//合同及期供信息查询
NSString * const     _getContractStagingInfo_url   =   @"order/contractStaging/getContractStagingInfo";

//还款接口(新)
NSString * const    _RepayOrSettleWithPeriod_url = @"order/doRepayOrSettleWithPeriod";

//意见反馈
NSString * const     _feedBack_url                  =   @"user/common/saveFeedBack";

//获取银行卡类型接口
NSString * const     _getSupportBankList_url           =   @"card/getSupportBankListApi";

//银行卡校验
NSString * const     _BankNumCheck_url              =   @"membership/saveAccountBankCard";

//版本检测
NSString * const     _checkVersion_jhtml        =   @"user/common/checkVersion";

//借款记录
NSString * const     _getMoneyHistory_url           =   @"order/user/loanList";

//登陆更新经纬度
NSString * const     _updateLoginLatitude_url       =   @"user/common/updateLastLongitudeAndLatitude";

//二次提款
NSString * const     _drawApplyAgain_jhtml      =   @"coregw/draw/drawApply";

//推荐码规则
NSString * const    _GetRecomfrInfo_url         =    @"product/getRecomfrInfo";


//验证身份证号
NSString * const    _verifyIdentityCard_url    =    @"apigw/client/operation/checkIdInfo";

//验证旧交易密码
NSString * const    _verifyOldPassword_url    =    @"apigw/client/operation/verifyPayPassword";

//验证交易呀验证码
NSString * const    _verifyTradeSMS_url    =    @"apigw/client/toolbox/sms/checkSMSCodeValid";

//设置新的交易密码
NSString * const    _saveNewPassword_url    =    @"apigw/client/operation/savePayPassword";

//修改交易密码
NSString * const    _modificationPassword_url    =    @"apigw/client/operation/updatePayPassword";

//个人中心（优惠券,现金红包,账户余额）
NSString * const    _PersonalCenterWithdrawCashAPI_url    =    @"apigw/client/operation/withdrawCashAPI/personalCenter";

//现金红包,账户余额（点击列表操作展示提现页）
NSString * const    _LoadWithdrawCash_url    =    @"apigw/client/operation/withdrawCashAPI/loadWithdrawCash";

//提现
NSString * const    _WithdrawCash_url    =    @"apigw/client/operation/withdrawCashAPI/withdrawCash";

//导流产品埋点接口
NSString * const    _DiversionProStatics_url    =    @"apigw/client/market/operation/ProductClickStatics";

//校验提现条件
NSString * const    _CheckWithdrawCash_url    =    @"apigw/client/operation/withdrawCashAPI/checkWithdrawCash";

//现金红包收提明细
NSString * const    _WithdrawCashDetail_url    =    @"apigw/client/operation/withdrawCashAPI/queryDetail";

//站内信用户未读信息统计接口
NSString * const    _CountStationLetterMsg_url    =    @"apigw/client/operation/countStationLetterMsg";

//站内信未读已读列表
NSString * const    _ShowMsgPreview_url    =    @"apigw/client/operation/showMsgPreview";

#pragma mark - 合规接口

//用户开户接口
NSString * const    _huifu_url    =    @"http/huifush/toRegister.jhtml";

//激活老账户
NSString * const    _bosAcctActivate_url    =    @"http/huifush/toBosAcctActivate.jhtml";

//P2P平台账单期供查询 （还款账单）
NSString * const    _querybillDetails_url       =    @"http/do.jhtml?router=prematurityService.querybillDetails";

//主动还款接口 （自动划扣）
NSString * const    _paymentService_url    =    @"http/do.jhtml?router=activrePaymentService.activrePayment";

//平台合同列表
//NSString * const    _contractList_url           =    @"http/do.jhtml?router=contractService.contractList";
NSString * const    _contractList_url           =    @"hg/contractList.jhtml";

//合同内容
//NSString * const    _contractStr_url            =    @"http/do.jhtml?router=contractService.contractStr";
NSString * const    _contractStr_url            =    @"hg/contractStr.jhtml";

//发送短信接口
//NSString * const    _sendSms_url    =    @"h ttp/do.jhtml?router=sendSmsSHService.send";
NSString * const    _sendSms_url    =    @"hg/sendSms.jhtml";

//换绑银行卡
//NSString * const    _bankCards_url    =    @"http/do.jhtml?router=bankCardsSHService.quickChangeBindingCard";
NSString * const    _bankCards_url    =    @"hg/quickChangeBindingCard.jhtml";

//银行卡查询接口
//NSString * const    _queryCardInfo_url    =    @"http/do.jhtml?router=bankCardsSHService.queryCardInfo";
NSString * const    _queryCardInfo_url    =    @"hg/queryCardInfo.jhtml";

//合规银行卡列表信息
NSString * const    _queryCardListInfo_url    =    @"bankCardsSHService.queryCardInfo.jhtml";

//用户状态查询接口
NSString * const    _accountHSService_url    =    @"http/do.jhtml?router=accountHSService.qryUserStatus";

//取现
NSString * const    _cash_url    =    @"http/huifush/toCash.jhtml";

//标的状态查询接口
NSString * const    _queryBidStatus_url    =    @"http/do.jhtml?router= BidsService.queryBidStatus";

//激活老账户返回url
NSString * const    _bosAcctActivateRet_url    =    @"https://h5.faxindai.com:8028/fxd-h5/page/case/app_toBosAcctActivate.html";

//用户状态查询   *
NSString * const    _qryUserStatus_url    =    @"hg/qryUserStatus.jhtml";

//用户标的状态查询
NSString * const    _getBidStatus_url    =    @"hg/getBidStatus";

//提款申请件记录 *
NSString * const    _saveLoanCase_url    =    @"hg/saveLoanCase.jhtml";
//首借免息
NSString *const     _sjRecord_url     =    @"sj/record.jhtml";
//老客周末活动判断是否弹框刮奖
NSString *const     _getDrawLottery_url     =    @"market/getDrawLottery";
//协议
NSString *const     _ProductProtocol_url     =    @"product/getProductProtocolApi";


#pragma mark - 对外导流接口

//量子互助  http://www.liangzihuzhu.com.cn/xwh5/pages/plan/quotaRecharge.html?id=222767
NSString * const    _liangzihuzhu_url    =    @"apigw/client/quonline/link";

#pragma Mark - 验证码类型

NSString * const  CODE_REG           =    @"MSG_REG_"; ///注册验证码
NSString * const  CODE_FINDPASS      =    @"MSG_FIND_PASSWORD_"; ///密码找回验证码
NSString * const  CODE_CHANGEPASS    =    @"MSG_UPDATE_PASSWORD_"; ///修改密码验证码
NSString * const  CODE_TRADEPASSWORD    =    @"MSG_SET_PAYPASSWORD"; ///设置交易密码
NSString * const  CODE_CHANGEDEVID   =    @"MSG_CHANGE_DEVICE_"; ///设备号更改
NSString * const  CODE_LOGIN         =    @"MSG_LOGIN_";   ///登陆验证码
NSString * const  CODE_BANKMOBILE    =    @"MSG_CHANGE_DEBIT_"; ///银行预留手机验证码(银行卡修改)
NSString * const  CODE_DRAW          =    @"MSG_DRAW_"; ///提款
NSString * const  CODE_ADDCARD       =    @"MSG_BANKCARD_AUDIT_"; //新增卡

#pragma Mark - 产品类型

NSString * const SalaryLoan = @"P001002";                   //工薪贷平台
NSString * const RapidLoan = @"P001004";                   //急速贷平台
NSString * const WhiteCollarLoan = @"P001005";           //白领贷平台
NSString * const DeriveRapidLoan = @"P001006";           //急速贷衍生（30天）平台

#pragma Mark - 项目配置信息

NSString * const PLATFORM = @"1";                   //平台
NSString * const CHANNEL = @"1";                   //平台

NSString * const SERVICE_PLATFORM = @"0";                   //服务
NSString * const Devcode = @"5LIK5RW35LIT6LW";     //开发码
//bJO03627qY52JEu4
NSString * const Fxd_pw = @"6d82763bdd2ddcbea6da1ee6a9c636e68dae259127ba1e24";

/**
 *  @author dd
 *
 *  推送正式环境
 */
NSString * const GeTuiAppId       =    @"DQXNTKpVWO9lRYDmmCJJ6A";
NSString * const GeTuiAppKey      =    @"4STTy2mX088AfJATn90x35";
NSString * const GeTuiAppSecret    =   @"rPvgHctJ9m7odkglAm1Xx5";

/*测试环境*/
// NSString * const GeTuiAppId       =    @"TfEBqkOvmwAwAu2BjA9bz5";
// NSString * const GeTuiAppKey      =    @"FnvN7OWMwk91k3z3iqCT33";
// NSString * const GeTuiAppSecret    =   @"QPJUggTYMo6RfMM70s54V3";


NSString * const FaceIDAppKey   = @"nTKWn6a5PUVZ0Lsf2AU8mThnL2esjfJl";
NSString * const FaceIDAppSecret = @"pAnTrgzEZnrjo6kUciE9AkNa8Je2FwCu";


//NSString * const UmengKey      =   @"56497dd267e58ea0470009aa";
NSString * const UmengKey      =   @"58d9b5a299f0c72cc5001347";


NSString * const kUserID       =   @"userName";
NSString * const kUserPass     =   @"userPass";

//juid
NSString * const Fxd_JUID     =    @"juid";
//token
NSString * const Fxd_Token     =   @"token";

//登陆标识
NSString * const kLoginFlag    =   @"loginFlag";

//邀请码
NSString * const kInvitationCode = @"invitation_code";

NSString * const kTopView     =    @"TopView";

//用户
NSString * const UserName    =    @"userName";

NSString * const  kAddMaterailNotification  =   @"zbctongzhi";

NSString * const isLoginFlag  =   @"loginState";

NSString * const SERVERNAME   =   @"com.hfsj.fxd";

NSString * const UserInfomation = @"UserInfomation";

NSString * const FirstLunch = @"FirstLunch";

NSString * const theMoxieApiKey = @"54adcefe02314a44b82dca9b470c4bad";  //生产
//NSString * const theMoxieApiKey = @"8190142167af4b30b898827623d57b4d";




