


//NSString * const _main_url  =   @"http://192.168.6.130:9191/fxd-esb/esb/";
//NSString * const _main_url  =   @"http://192.168.14.18:9191/fxd-esb/esb/";

//NSString * const _ValidESB_url = @"http://192.168.6.85:9090/fxd-esb/";
//NSString * const _ValidESB_url = @"http://192.168.6.130:9191/fxd-esb/";
//NSString * const _ValidESB_url = @"http://192.168.14.18:9191/fxd-esb/";

//NSString * const _H5_url    =   @"http://192.168.6.130:9090/fxd-h5/page/";
//NSString * const _H5_url    =   @"https://192.168.6.130:8892/fxd-h5/page/";

//NSString * const _P2P_url   =   @"http://192.168.6.85:8080/p2p/";
//NSString * const _P2P_url   =   @"http://192.168.9.254:10010/p2p/";
//NSString * const _P2P_url   =   @"http://192.168.15.163:10010/p2p/";



#ifdef FXD_Environment_Mode
#if FXD_Environment_Mode == 0
NSString * const _main_url  =   @"https://h5.faxindai.com:8028/fxd-esb/esb/"; //生产
NSString * const _ValidESB_url = @"https://h5.faxindai.com:8028/fxd-esb/";

NSString * const _P2P_url = @"https://fintech.chinazyjr.com/p2p/"; //生产
NSString * const _H5_url    =   @"https://h5.faxindai.com:8028/fxd-h5/page/";


#elif FXD_Environment_Mode == 1
NSString * const _main_url  =   @"http://192.168.6.130:9191/fxd-esb/esb/";
//饶明祥本地地址
//NSString * const _main_url  =   @"http://192.168.9.2:8080/esb/";
//新整合的地址
//NSString * const _main_url  =   @"http://192.168.7.253:8081/fxd-esb/esb/";
NSString * const _ValidESB_url = @"http://192.168.6.130:9191/fxd-esb/";
//准生产地址
//NSString * const _main_url  =   @"http://192.168.6.240:9090/fxd-esb/esb/";
//NSString * const _ValidESB_url = @"http://192.168.6.240:9090/fxd-esb/";
NSString * const _H5_url    =   @"http://192.168.6.130/fxd-h5/page/";
NSString * const _P2P_url   =   @"http://192.168.6.85:8080/p2p/";

//本地测试芝麻信用
//NSString * const _ZMXY_url   =   @"http://192.168.14.14:9191/fxd-esb/esb/";
//本地测试芝麻信用步数
//NSString * const _SETP_url   =   @"http://192.168.10.100:9191/fxd-esb/esb/";
//芝麻信用回调地址
NSString * const _ZhimaBack_url   =   @"http://180.168.159.198:19090/fxd-esb/esb/";

#else
#warning "未匹配环境"
#endif
#endif



//获取验证码
NSString * const     _getCode_url                   =   @"common/sendSMS.jhtml";

//注册验证码
NSString * const    _regCode_url                    =   @"common/sendSMSH5.jhtml";

//注册
NSString * const     _reg_url                       =   @"register/register.jhtml";

//登陆
NSString * const     _login_url                     =   @"login/login.jhtml";

//退出登陆
NSString * const     _loginOut_url                  =   @"logout/logout.jhtml";

//更改设备号
NSString * const     _updateDevID_url               =   @"updateLoginEquipment/updateLoginEquipment.jhtml";

//忘记密码
NSString * const     _forget_url                    =   @"findPasswordBack/findPasswordBack.jhtml";

//首页查询用户借款状态
NSString * const     _userState_url                 =   @"caseInfo/getApplyStatus.jhtml";

//二次进件
NSString * const     _secondApply_url               =   @"caseInfo/secondApply.jhtml";

//提交用户信息
NSString * const     _updateUserById_url            =   @"userWs/updateUserById";

//进件
NSString * const     _saveLoanApplicant_url         =   @"appLoanAppLicant/saveLoanApplicant";

//进度审核
NSString * const     _findLoanAuditProgress_url     =   @"appLoanAppLicant/findAuditProgressByUid";

//用户拒绝与接收
NSString * const     _userSureRefuseLoanAction_url  =   @"appLoanAppLicant/userSureRefuseLoanAction";

//提款
NSString * const     _userLoan_url                  =   @"appLoanAppLicant/userLoan";

//查询用户还款的额(一次结清)
NSString * const     _AllUserShouldAlsoAmount_url   =   @"repay/getSettleRepayAmount.jhtml";

//用户还款(一次结清)
NSString * const     _AlluserRepayment_url          =    @"repay/settleRepay.jhtml";

//查询用户周还款额(周)
NSString * const     _WeekUserShouldAlsoAmount_url  =   @"repay/getCommonRepayAmount.jhtml";

//用户还款(按周)
NSString * const     _WeekUserRepayment_url         =   @"repay/commonRepay.jhtml";

//上传照片
NSString * const     _updateAvatar_url              =   @"customer/saveAuthIdentify.jhtml";

//银行卡列表查询
NSString * const     _cardList_url                  =   @"getAccountCardList/getAccountCardList.jhtml";

//更改密码
NSString * const     _CHANGEPASS_URL                =   @"userWs/updatePassword";

//意见反馈
NSString * const     _feedBack_url                  =   @"common/saveFeedBack.jhtml";

//借款记录
NSString * const     _getMoneyHistory_url           =   @"account/loanList.jhtml";

//还款记录
NSString * const     _getRepayHistory_url           =   @"account/repayList.jhtml";

//学校列表
NSString * const     _schoolList_url                =   @"schoolWs/getSchoolByName";

//银行卡校验
NSString * const     _BankNumCheck_url              =   @"saveAccountBankCard/saveAccountBankCard.jhtml";

//手机认证信息
NSString * const     _Certification_url             =   @"customer/saveCustomerAuthMobile.jhtml";

//获取手机认证信息
NSString * const     _getCustomerAuth_jhtml         =   @"customer/getCustomerAuth.jhtml";

//手机认证有效性检查
NSString * const    _checkMobilePhoneAuth_url       =   @"customer/checkMobilePhoneAuth.jhtml";

//手机认证信息保存
NSString * const    _authMobilePhone_url            =   @"customer/authMobilePhone.jhtml";

//提款
NSString * const     _drawApply_url                 =   @"draw/drawApply.jhtml";

//提款获取第一个还款日
NSString * const     _getFristRepaymentDate         =   @"appLoanAppLicant/getFristRepaymentDate";

//获取手机运营商
NSString * const     _getMobileOpera_url            =   @"getCarrierNameByMobile/getCarrierNameByMobile.jhtml";

//客户所有信息获取接口
NSString * const     _getCustomerBase_url           =   @"customer/getCustomerBase.jhtml";

//客户基本信息保存接口
NSString * const     _saveCustomerBase_url          =   @"customerAuth/saveCustomerBaseInfo.jhtml";

//获取省市区全部数据接口
NSString * const     _getAllRegionList_url          =    @"getRegionList/getAllRegionByOrderList.jhtml";

//客户职业信息保存接口
NSString * const     _saveCustomerCarrer_jhtml      =   @"customer/saveCustomerCarrer.jhtml";

//客户职业信息获取接口
NSString * const     _getCustomerCarrer_jhtml       =   @"customer/getCustomerCarrer.jhtml";
//进件接口
NSString * const     _createApplication_jhtml       =   @"applicant/createApplication.jhtml";

//审批金额查询接口
NSString * const     _approvalAmount_jhtml          =   @"caseInfo/approvalAmount.jhtml";

//产品列表获取接口
NSString * const     _getProductList_jhtml          =   @"getProductList/getProductList.jhtml";

//人脸识别结果保存
NSString * const     _saveFaceId_url    =   @"faceid/saveFaceId.jhtml";

//用户通讯录保存接口
NSString * const     _saveUserContacts_jhtml        =   @"userContact/saveUserContacts.jhtml";

//登陆更新经纬度
NSString * const     _updateLoginLatitude_url       =   @"updateLastLongitudeAndLatitude/updateLastLongitudeAndLatitude.jhtml";

//获取省市区编码
NSString * const     _getRegionCodeByName_jhtml     =  @"getRegionList/getRegionCodeByName.jhtml";

//版本检测
NSString * const     _checkVersion_jhtml        =   @"appcommon/checkVersion.jhtml";

//二次提款
NSString * const     _drawApplyAgain_jhtml      =   @"draw/drawApplyAgain.jhtml";

//红包获取
NSString * const     _getUserRedpacket_url      =   @"userWs/getUserAvailabelRedpacketList.jhtml";

//申请件状态更新
NSString * const     _caseStatusUpdateApi_url   =   @"increase/caseStatusUpdateApi.jhtml";

//银行卡获取接口
NSString * const     _getBankList_url           =   @"getDictCode/getDictCodeList.jhtml";

//输入框埋点
NSString * const     _saveInputBackInfo_url     =   @"userWs/saveInputBackInfo.jhtml";

//合同及期供信息查询
NSString * const     _getContractStagingInfo_url   =   @"contractStaging/getContractStagingInfo.jhtml";

//还款结清接口
NSString * const     _doRepayOrSettle_url       =   @"repayorsettle/doRepayOrSettle.jhtml";

//还款接口(新)
NSString * const    _RepayOrSettleWithPeriod_url = @"repayorsettle/doRepayOrSettleWithPeriod.jhtml";

//P2P获取用户基本信息
NSString * const    _getFXDUserInfo_url          =  @"p2p/hg/getFXDUserInfo.jhtml";

//P2P客户基本信息录入
NSString * const    _drawService_url            =   @"http/do.jhtml?router=drawService.take";

//P2P开户接口
NSString * const    _register_url               =   @"http/huifu/toRegister.jhtml";

//P2P绑卡
NSString * const    _bindCard_url               =   @"http/huifu/toBindCard.jhtml";

//发标前查询进件
NSString * const    _getFXDCaseInfo_url         =   @"p2p/hg/getFXDCaseInfo.jhtml";

//P2P发标
NSString * const    _addBidInfo_url             =   @"http/do.jhtml?router=addBidInfoService.addBidInfo";

//P2P还款余额查询
NSString * const    _memberService_url          =   @"http/do.jhtml?router=memberService.accountInfo";

//P2P还款充值
NSString * const    _netSave_url                =   @"http/huifu/toNetSave.jhtml";

//开户返回URL
NSString * const    _transition_url     =  @"https://h5.faxindai.com:8028/fxd-h5/page/case/app_transition.html";

//充值返回URL
NSString * const    _rechargeing_url    =   @"https://h5.faxindai.com:8028/fxd-h5/page/mine/rechargeing.html";

//P2P正常还款
NSString * const    _doPay_url                  =    @"http/do.jhtml?router=paySettleService.doPay";

//P2P结清
NSString * const    _doSettle_url               =    @"http/do.jhtml?router=paySettleService.doSettle";

//图形验证码
NSString * const    _getPicCode_url             =    @"register/getPicCodeApi.jhtml";

//用户QQ/支付宝认证状态查询
NSString * const    _queryAuthStatus_url        =    @"caseInfo/queryAuthStatus.jhtml";

//关于我们H5
NSString * const    _aboutus_url                =    @"more/about_us.html";

//发展历程H5
NSString * const    _depHistory_url             =    @"more/depHistory.html";

//媒体报道H5
NSString * const    _mediaReport_url            =    @"more/mediaReport.html";

//首页广告
NSString * const    _adv_url                    =    @"event/pop_up.jhtml";

//平台合同列表
NSString * const    _contractList_url           =    @"http/do.jhtml?router=contractService.contractList";

//合同内容
NSString * const    _contractStr_url            =    @"http/do.jhtml?router=contractService.contractStr";

//P2P平台账单期供查询
NSString * const    _querybillDetails_url       =    @"http/do.jhtml?router=prematurityService.querybillDetails";

//协议内容获取接口
NSString * const    _productProtocol_url        =    @"ProductProtocol/getProductProtocol.jhtml";

//首页借款记录
NSString * const    _queryLoanRecord_url        =    @"caseInfo/queryLoanRecordApi.jhtml";

//借款进度
NSString * const    _queryLoanStatus_url        =    @"caseInfo/queryLoanStatus.jhtml";

//H5注册
NSString * const    _h5register_url             =    @"register.html";

//H5费用说明
NSString * const    _loanDetial_url             =    @"protocol/loanDetial.html";

//FaceIDOCR
NSString * const    _detectIDCardOCR_url        =    @"https://api.faceid.com/faceid/v1/ocridcard";

//FaceID人脸对比身份核实
NSString * const    _verifyLive_url             =    @"https://api.megvii.com/faceid/v2/verify";

//查询用户信息录入进度
NSString * const    _customerAuthInfo_url       =    @"customerAuth/getCustomerAuthInfoSchedule.jhtml";

//联系人信息上传
NSString * const    _customerContact_url        =    @"customerAuth/saveCustomerContactInfo.jhtml";

//用户身份证图片上传
NSString * const    _saveIDInfo_url             =    @"customerAuth/saveCustomerIDInfo.jhtml";

//聚信力TOKEN获取
NSString * const    _JXLGetToken_url            =    @"https://www.juxinli.com/orgApi/rest/v2/applications/chinazyjr";

//聚信力信息采集
NSString * const    _messagesReq_url            =    @"https://www.juxinli.com/orgApi/rest/v2/messages/collect/req";

//活体检测信息上传
NSString * const    _detectInfo_url             =    @"customerAuth/saveCustomerDetectInfo.jhtml";

//推荐码规则
NSString * const    _GetRecomfrInfo_url         =    @"ProductProtocol/GetRecomfrInfoApi.jhtml";

//费率查询
NSString * const    _fatchRate_url              =    @"product/getProductInfo.jhtml";

//Banner广告获取
NSString * const    _topBanner_url              =    @"event/topBanner.jhtml";

//常见问题
NSString * const    _question_url               =    @"more/question.html";

//数据字典获取
NSString * const    _getDicCode_url             =    @"getDictCode/getDictCodeList.jhtml";

//手机认证
NSString * const    _mobileAuthentication_url    =    @"case/case_main_phone.html";

//审核被拒，去看看
NSString * const    _selectPlatform_url    =    @"case/select_platform.html";

//首页产品列表路径
NSString * const    _getLimitProductlist_url    =    @"product/getLimitProductlistApi.jhtml";

//芝麻信用授权查询
NSString * const    _findZhimaCredit_url    =    @"zmxy/findZhimaCreditAuthStatus.jhtml";

//芝麻信用授权提交
NSString * const    _submitZhimaCredit_url    =    @"zmxy/submitZhimaCreditAuth.jhtml";

//芝麻信用回调地址
NSString * const    _zhimaCreditCallBack_url    =    @"zmxy/zhimaCreditCallBackApi.jhtml";


NSString * const  CODE_REG           =    @"MSG_REG_"; ///注册验证码
NSString * const  CODE_FINDPASS      =    @"MSG_FIND_PASSWORD_"; ///密码找回验证码
NSString * const  CODE_CHANGEPASS    =    @"MSG_UPDATE_PASSWORD_"; ///修改密码验证码
NSString * const  CODE_CHANGEDEVID   =    @"MSG_CHANGE_DEVICE_"; ///设备号更改
NSString * const  CODE_LOGIN         =    @"MSG_LOGIN_";   ///登陆验证码
NSString * const  CODE_BANKMOBILE    =    @"MSG_CHANGE_DEBIT_"; ///银行预留手机验证码(银行卡修改)
NSString * const  CODE_DRAW          =    @"MSG_DRAW_"; ///提款
NSString * const  CODE_ADDCARD       =    @"MSG_BANKCARD_AUDIT_"; //新增卡


NSString * const PLATFORM = @"1";                   //平台


NSString * const Devcode = @"5LIK5RW35LIT6LW";     //开发码

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




