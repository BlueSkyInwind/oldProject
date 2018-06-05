

 #ifdef FXD_Environment_Mode
#if FXD_Environment_Mode == 0
//h5.faxindai.com:8028
NSString * const _main_url  =   @"https://h5.faxindai.com/fxd-esb/esb/"; //生产
NSString * const _agreement_url  =   @"https://h5.faxindai.com/fxd-esb/esb/";
NSString * const _ValidESB_url = @"https://h5.faxindai.com/fxd-esb/";
NSString * const _P2P_url = @"https://fintech.chinazyjr.com/p2p/"; //生产
NSString * const _p2P_url = @"https://h5.faxindai.com/fxd-esb/p2p/";
NSString * const _H5_url    =   @"https://h5.faxindai.com/fxd-h5/page/";
NSString * const _main_new_url  =  @"https://h5.faxindai.com/apigw/client/";
NSString * const _mainTwo_new_url  =  @"http://h5.faxindai.com/coregw/client/";

#elif FXD_Environment_Mode == 1

//测试环境
//http://192.168.15.116:8055/fxd-esb    俊杰
//http://192.168.12.109:8082/fxd-esb/  罗兵本地
//http://192.168.7.140:8001/fxd-esb/esb/ 合规贷后测试地址
//http://192.168.13.173:8005/ 张强本地

//测试导流 192.168.6.134
//NSString * const _maintourism_icon_url  =   @"http://h5.test.fxds/fxd-esb/esb/";
//NSString * const _main_url  =   @"http://h5.dev.test/fxd-esb/esb/";
//NSString * const _agreement_url  =   @"http://h5.test.fxds/fxd-esb/esb/";
//NSString * const _main_new_url  =  @"http://h5.test.fxds/apigw/client/";
//NSString * const _ValidESB_url  =   @"http://h5.test.fxds/fxd-esb/";
//NSString * const _H5_url    =   @"http://h5.test.fxds/fxd-h5/page/";
//NSString * const _p2P_url = @"http://h5.test.fxds/fxd-esb/p2p/";
//NSString * const _P2P_url   =   @"http://192.168.6.85:9090/p2p/";
//NSString * const _mainTwo_new_url  =  @"http://h5.test.fxds/coregw/client/";

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
//NSString * const _main_new_url  =  @"http://h5.uat.fxds/apigw/client/";
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

//开户返回URL
NSString * const    _transition_url     =  @"https://h5.faxindai.com:8028/fxd-h5/page/case/app_transition.html";
//关于我们H5
NSString * const    _aboutus_url                =    @"more/about_us.html";
//发展历程H5
NSString * const    _depHistory_url             =    @"more/depHistory.html";
//H5注册
NSString * const    _h5register_url             =    @"register.html";
//FaceIDOCR
NSString * const    _detectIDCardOCR_url        =    @"https://api.faceid.com/faceid/v1/ocridcard";
//FaceID人脸对比身份核实
NSString * const    _verifyLive_url             =    @"https://api.megvii.com/faceid/v2/verify";

#pragma mark - 新的api

//社保
NSString * const    _shebaoupload_url    =    @"resource/mxsbtask_create";
//信用卡
NSString * const    _TheCreditCardupload_url    =    @"resource/mxmailtask_create";
//网银
NSString * const    _TheInternetbank_url    =    @"auth/ebank/ebankTaskSubmit";
//高级认证状态查询
NSString * const    _HighRankingStatus_url    =    @"user/senior/info";
//基础信息状态查询接口
NSString * const    _UserBasicInformation_url    =    @"user/info/base";
//身份证识别
NSString * const    _UserIDCardUpload_url    =    @"membership/customerAuth/saveCustomerIDInfo2";

//三方信息状态查询接口
NSString * const    _UserThirdPartCertification_url    =    @"user/other/info";
//联系人信息的完成状态
NSString * const    _UserContactInfo_url    =    @"user/contact/info";
//申请进件
NSString * const    _new_CreateApplication_url    =    @"application/new/create";
//申请信息计算
NSString * const    _calculateApplicationInfo_url    =    @"application/repayAmount/calc";
//新版代申请确认页数据
NSString * const    _newApplicationViewInfo_url        =    @"application/confirmApply";
//银行卡列表信息
NSString * const    _BankCardList_url    =    @"bank/card/list";
//上传用户的registerID
NSString * const    _registerID_url    =    @"center/jiguang/register";
//用户资料测评接口
NSString * const    _UserDataCertification_url    =    @"user/measurement/info";
//得到测评结果
NSString * const    _UserDataCertificationResult_url    =    @"user/verify/status";
//退出登录删除推送id
NSString * const    _loginOutDeleteRegisterId_url    =    @"center/jiguang/delete";
//联联绑卡回调地址
NSString * const    _CapitalLoanBack_url    =    @"paidcenter/lianlian/notify";
//app 连连绑卡页面用户放弃操作接口
NSString * const    _CapitalLoanFail_url    =    @"capital/loan/fail";
//新优惠券规则
NSString * const    _New_DiscountTicket_url    =    @"operation/client/getuse";
//还款详情页金额获取
NSString * const    _repayDetailAmountInfo_url    =    @"order/calculate/show/repay/amount";
//登陆
NSString * const     _login_url        =    @"membership/login";
//注册
NSString * const     _reg_url          =   @"membership/register";
//获取验证码
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
//membership/customerAuth/saveCustomerDetectDetail
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
//新版提款
NSString * const     _newDrawApply_jhtml      =   @"coregw/draw/new/drawApply";
//推荐码规则
NSString * const    _GetRecomfrInfo_url         =    @"product/getRecomfrInfo";
//验证身份证号
NSString * const    _verifyIdentityCard_url    =    @"operation/checkIdInfo";
//验证旧交易密码
NSString * const    _verifyOldPassword_url    =    @"operation/verifyPayPassword";
//验证交易呀验证码
NSString * const    _verifyTradeSMS_url    =    @"toolbox/sms/checkSMSCodeValid";
//设置新的交易密码
NSString * const    _saveNewPassword_url    =    @"operation/savePayPassword";
//修改交易密码
NSString * const    _modificationPassword_url    =    @"operation/updatePayPassword";
//个人中心（优惠券,现金红包,账户余额）
NSString * const    _PersonalCenterWithdrawCashAPI_url    =    @"operation/withdrawCashAPI/personalCenter";
//现金红包,账户余额（点击列表操作展示提现页）
NSString * const    _LoadWithdrawCash_url    =    @"operation/withdrawCashAPI/loadWithdrawCash";
//提现
NSString * const    _WithdrawCash_url    =    @"operation/withdrawCashAPI/withdrawCash";
//导流产品埋点接口
NSString * const    _DiversionProStatics_url    =    @"market/operation/ProductClickStatics";
//校验提现条件
NSString * const    _CheckWithdrawCash_url    =    @"operation/withdrawCashAPI/checkWithdrawCash";
//现金红包收提明细
NSString * const    _WithdrawCashDetail_url    =    @"operation/withdrawCashAPI/queryDetail";
//站内信用户未读信息统计接口
NSString * const    _CountStationLetterMsg_url    =    @"operation/countStationLetterMsg";
//站内信未读已读列表
NSString * const    _ShowMsgPreview_url    =    @"operation/showMsgPreview";
//新版首页接口
NSString * const    _NewSummary_url    =    @"new/summary";
//新版代提款
NSString * const    _withDrawFunds_url        =    @"application/new/loan";
//协议内容获取接口
NSString * const    _newproductProtocol_url        =    @"product/getProductNewProtocolApi";
//协议内容获取接口
NSString * const    _newproductProtocolH5_url        =    @"product/getNewProductProH5URLApi";
//额度页面信息获取
NSString * const    _creditLimitInfo_url        =    @"user/verify/amount";
//常见问题
NSString * const    _question_url               =    @"product/getCommonProblemApi";
//用户提额
NSString * const    _increaseAmount_url               =    @"increaseQuotaApply";
//最近浏览
NSString * const    _recent_url               =    @"dc/recentView";
//首借免息
NSString *const     _sjRecord_url     =    @"sj/record.jhtml";
//经验值体系-展示等级
NSString *const     _ExperienceValue_url     =    @"operation/experienceValueGradeAPI/displayGrade";
//首页贷超接口
NSString *const     _compQuery_url     =    @"dc/compQuery";
//导流平台跳转接口
NSString *const     _getCompLink_url     =    @"dc/operation/user/getCompLink";
//钱爸爸提现申请
NSString *const     _paidcenter_url     =    @"paidcenter/qbbWithDraw";
//站内信删除、清空
NSString *const     _delMsg_url     =    @"market/operation/delMsg";
//热门推荐
NSString *const     _hotRecommend_url     =    @"dc/hotRecommend";
//会员页面信息
NSString * const    _memberShipInfo_url               =    @"user/member";
//获取我的收藏记录列表
NSString * const    _getMyCollectionList_url               =    @"jyd/getMyCollectionList";
//添加或者取消收藏记录
NSString * const    _addMyCollectionInfo_url               =    @"jyd/addMyCollectionInfo";
//会员费退费
NSString * const    _memberRefund_url               =    @"repaycenter/insurance/refund";
//会员费扣费
NSString * const    _memberRecharge_url               =    @"repaycenter/insurance/request";
//银行卡授权查询页面
NSString * const    _cardAuthQuery_url               =    @"cardAuth/query";
//银行卡授权短信发送
NSString * const    _cardAuthSmsSend_url               =    @"cardAuth/sms/send";
//银行卡授权接口
NSString * const    _cardAuthAuth_url               =    @"cardAuth/auth";


#pragma mark - 合规接口

//获取合规开户信息
NSString * const    _account_url    =    @"membership/hg/account/info";

//对接合规平台，换绑卡发送短信验证码
NSString * const    _sendSmsCode_url    =    @"paidcenter/hg/sendSmsCode";

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
NSString * const    _sendSms_url    =    @"paidcenter/hg/sendSmsCodeApi";
//提交合规换绑银行卡信息
NSString * const    _change_BankCards_url    =    @"membership/hg/change/bank/card";
//合规获取老用户激活跳转页面参数
NSString * const    _hgUser_Active_url    =    @"paidcenter/user/active";
//合规用户状态查询
NSString * const    _queryUserStatus_url    =    @"membership/paid/queryUserStatus";
//合规的件 调用此接口 用于获取借款协议列表
NSString * const    _hgLoanProtoolList_url    =    @"product/getHgLoanProtoolListApi";



#pragma mark - 对外导流接口

//量子互助  http://www.liangzihuzhu.com.cn/xwh5/pages/plan/quotaRecharge.html?id=222767
NSString * const    _liangzihuzhu_url    =    @"apigw/client/quonline/link";

#pragma mark - 视频认证接口

//获取认证视频信息
NSString * const    _VideoVerify_url    =    @"membership/customerAuth/getUserRegisterVideoVerifyText";

//上传视频
NSString * const    _uploadVideoVideo_url    =    @"membership/customerAuth/userRegisterVideoVerify";


#pragma Mark - 验证码类型

NSString * const  CODE_REG           =    @"MSG_REG_"; ///注册验证码
NSString * const  CODE_FINDPASS      =    @"MSG_FIND_PASSWORD_"; ///密码找回验证码
NSString * const  CODE_TRADEPASSWORD    =    @"MSG_SET_PAYPASSWORD"; ///设置交易密码
NSString * const  CODE_CHANGEDEVID   =    @"MSG_CHANGE_DEVICE_"; ///设备号更改
NSString * const  CODE_LOGIN         =    @"MSG_LOGIN_";   ///登陆验证码
NSString * const  CODE_DRAW          =    @"MSG_DRAW_"; ///提款
NSString * const  CODE_ADDCARD       =    @"MSG_BANKCARD_AUDIT_"; //新增卡

#pragma Mark - 产品类型

NSString * const SalaryLoan = @"P001002";                   //工薪贷平台
NSString * const RapidLoan = @"P001004";                   //急速贷平台
NSString * const WhiteCollarLoan = @"P001005";           //白领贷平台
NSString * const DeriveRapidLoan = @"P001006";           //急速贷衍生（30天）平台
NSString * const EliteLoan = @"P001007";           //精英贷

#pragma Mark - 项目配置信息

NSString * const PLATFORM = @"1";                   //平台
NSString * const CHANNEL = @"1";                   //平台

NSString * const SERVICE_PLATFORM = @"0";                   //服务
NSString * const CODE_SERVICE_PLATFORM = @"16";                   //服务
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

//提示语
NSString * const IDOCRMarkeords = @"务必确认系统识别的以上身份信息无误，否则无法借款成功";
NSString * const obtainUserContactMarkeords = @"当前信息填写，需要获取您的通讯录授权。您需要在设置中打开“通讯录”权限开关";
NSString * const IncreaseAmountLimitMarkeords = @"良好的借还款记录，有助于快速提额";





