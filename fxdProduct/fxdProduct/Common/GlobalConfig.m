



 #ifdef FXD_Environment_Mode
#if FXD_Environment_Mode == 0

NSString * const _main_url  =   @"https://h5.faxindai.com:8028/fxd-esb/esb/"; //生产
NSString * const _agreement_url  =   @"https://h5.faxindai.com:8028/fxd-esb/esb/";
NSString * const _ValidESB_url = @"https://h5.faxindai.com:8028/fxd-esb/";
NSString * const _P2P_url = @"https://fintech.chinazyjr.com/p2p/"; //生产
NSString * const _p2P_url = @"https://h5.faxindai.com:8028/fxd-esb/p2p/";
NSString * const _H5_url    =   @"https://h5.faxindai.com:8028/fxd-h5/page/";
NSString * const _main_new_url  =  @"https://h5.faxindai.com:8028/";

#elif FXD_Environment_Mode == 1

//测试环境
//http://192.168.14.14:9090/fxd-esb/esb/    张鹏
//http://192.168.15.116:8055/fxd-esb    俊杰
//http://192.168.12.109:8082/fxd-esb/  罗兵本地
//http://192.168.7.140:8001/fxd-esb/esb/ 合规贷后测试地址
//http://192.168.13.173:8005/ 张强本地

//测试导流 192.168.6.134
NSString * const _main_url  =   @"http://192.168.6.134/fxd-esb/esb/";
NSString * const _agreement_url  =   @"http://192.168.6.134/fxd-esb/esb/";
//NSString * const _main_new_url  =  @"http://service-apigateway.test.fxds:8005/";
NSString * const _main_new_url  =  @"http://service-apigateway.dev.fxds:8005/";
NSString * const _ValidESB_url  =   @"http://192.168.6.134/fxd-esb/";
NSString * const _H5_url    =   @"http://h5.test.fxds/fxd-h5/page/";
NSString * const _p2P_url = @"http://192.168.6.134/fxd-esb/p2p/";
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
//张强本地
//NSString * const _main_url  =   @"http://192.168.13.173:8005/fxd-esb/esb/";
//NSString * const _ValidESB_url  =   @"http://192.168.13.173:8005/fxd-esb/";
//NSString * const _main_new_url  =  @"http://192.168.13.173:8005/";
//NSString * const _H5_url    =   @"http://192.168.13.173:8005/fxd-h5/page/";
//NSString * const _p2P_url = @"http://192.168.13.173:8005/fxd-esb/p2p/";
//NSString * const _P2P_url   =   @"http://192.168.13.173:8005/p2p/";

//彭冲本地
//NSString * const _main_url  =   @"http://192.168.9.243:8080/fxd-esb/esb/";
//NSString * const _ValidESB_url  =   @"http://192.168.9.243:8080/fxd-esb/";
//NSString * const _H5_url    =   @"http://192.168.6.133/fxd-h5/page/";
//NSString * const _p2P_url = @"http://192.168.9.243:8080/fxd-esb/p2p/";
//NSString * const _P2P_url   =   @"http://192.168.6.85:9090/p2p/";

//张宇本地
//NSString * const _main_url  =   @"http://192.168.12.166:9191/fxd-esb/esb/";
//NSString * const _ValidESB_url  =   @"http://192.168.12.166:9191/fxd-esb/";
//NSString * const _H5_url    =   @"http://192.168.12.166:9191/fxd-h5/page/";
//NSString * const _p2P_url = @"http://192.168.12.166:9191/fxd-esb/p2p/";
//NSString * const _P2P_url   =   @"http://192.168.6.85:9090/p2p/";

//芝麻信用测试地址
//NSString * const _main_url  =   @"http://180.168.159.198:19090/fxd-esb/esb/";

#else
#warning "未匹配环境"
#endif
#endif

#pragma Mark - 项目URL
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

//更换密码
NSString * const     _changePassword_url                    =   @"updatePassword/updatePassword.jhtml";

////首页查询用户借款状态
NSString * const     _userState_url                 =   @"caseInfo/getApplyStatus.jhtml";

//首页查询用户借款状态
//NSString * const     _userState_url                 =   @"caseInfo/getApplyStatusTemp.jhtml";

//二次进件
NSString * const     _secondApply_url               =   @"caseInfo/secondApply.jhtml";

//二次进件
//NSString * const     _secondApply_url               =   @"caseInfo/secondApplyTemp.jhtml";

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
//NSString * const     _Certification_url             =   @"customer/saveCustomerAuthTcMobile.jhtml";

//获取手机运营商天创
NSString * const     _getTianChuangCertification_url          =   @"customer/saveCustomerAuthTcMobile.jhtml";

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
NSString * const     _getUserRedpacket_url      =   @"userWs/getUserAvailabelRedpacketAndCouponsList.jhtml";

//申请件状态更新
NSString * const     _caseStatusUpdateApi_url   =   @"increase/caseStatusUpdateApi.jhtml";

//银行卡获取接口
NSString * const     _getBankList_url           =   @"getDictCode/getDictCodeList.jhtml";

//获取银行卡类型接口
NSString * const     _getSupportBankList_url           =   @"getAccountCardList/getSupportBankListApi.jhtml";

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

//取现返回URL
NSString * const    _toCash_url     =  @"https://h5.faxindai.com:8028/fxd-h5/page/case/app_cash.html";

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

//协议内容获取接口
NSString * const    _productProtocol_url        =    @"ProductProtocol/getProductProtocol.jhtml";

//首页借款记录
NSString * const    _queryLoanRecord_url        =    @"caseInfo/queryLoanRecordApi.jhtml";

//借款进度
NSString * const    _queryLoanStatus_url        =    @"caseInfo/queryLoanStatus.jhtml";

//H5注册
NSString * const    _h5register_url             =    @"register.html";

//H5费用说明
//NSString * const    _loanDetial_url             =    @"protocol/loanDetial.html";
NSString * const    _loanDetial_url             =    @"protocol/protocol.html";
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


#pragma mark - 新的api

//社保
NSString * const    _shebaoupload_url    =    @"apigw/client/resource/mxsbtask_create";

//信用卡
NSString * const    _TheCreditCardupload_url    =    @"apigw/client/resource/mxmailtask_create";

//高级认证状态查询
NSString * const    _HighRankingStatus_url    =    @"apigw/client/resource/fundtask";

//基础信息状态查询接口
NSString * const    _UserBasicInformation_url    =    @"apigw/client/user/info/base";

//三方信息状态查询接口
NSString * const    _UserThirdPartCertification_url    =    @"apigw/client/user/other/info";

//三方信息状态查询接口
NSString * const    _AuthenticationCenterBasicInformation_url    =    @"apigw/client/user/base/complete/info";

//联系人信息的完成状态
NSString * const    _UserContactInfo_url    =    @"apigw/client/user/contact/info";

//首页状态查询
NSString * const    _HomeState_url    =    @"apigw/client/summary";

//申请进件
NSString * const    _createApplication_url    =    @"apigw/client/application/create";

//申请确认页数据
NSString * const    _ApplicationViewInfo_url    =    @"apigw/client/application/confirm";

//提款页数据
NSString * const    _UserDrawingInfo_url    =    @"apigw/client/application/loan";

//获取当前期的续期信息
NSString * const    _repayment_url    =    @"apigw/client/repayment/staging/continue/info";

//银行卡列表信息
NSString * const    _BankCardList_url    =    @"apigw/client/bank/card/list";

//放款中 还款中 展期中 状态实时获取
NSString * const    _ApplicationStatus_url    =    @"apigw/client/application/status";

//工薪贷根据周期获取费用
NSString * const    _SalaryProductFee_url    =    @"apigw/client/fee/calc";

//提交续期请求
NSString * const    _Staging_url    =    @"apigw/client/staging/continue/add";

//待还款界面信息获取
NSString * const    _Repay_url    =    @"apigw/client/ready/to/repay";

//获取续期规则
NSString * const    _StagingRule_url    =    @"apigw/client/continue/rule/detail";

//上传用户的registerID
NSString * const    _registerID_url    =    @"apigw/client/center/jiguang/register";

//用户资料测评接口
NSString * const    _UserDataCertification_url    =    @"apigw/client/user/measurement/info";

//用户资料测评接口
NSString * const    _Trilateral_url    =    @"apigw/client/repay/third/pay";

//得到测评结果
NSString * const    _UserDataCertificationResult_url    =    @"apigw/client/user/verify/status";

//退出登录删除推送id
NSString * const    _loginOutDeleteRegisterId_url    =    @"apigw/client/center/jiguang/delete";

//资金平台列表
NSString * const    _CapitalList_url    =    @"apigw/client/capital/list";

//资金平台放款接口
NSString * const    _CapitalLoan_url    =    @"apigw/client/capital/loan";

//联联绑卡回调地址
NSString * const    _CapitalLoanBack_url    =    @"main.html";

//联联绑卡返回回调地址
NSString * const    _ShanLinBack_url    =    @"main.html#shanlinBack";

//app 连连绑卡页面用户放弃操作接口
NSString * const    _CapitalLoanFail_url    =    @"apigw/client/capital/loan/fail";

//优惠券接口
NSString * const    _DiscountTicketList_url    =    @"apigw/client/market/getuserBase";

//选择模式列表
NSString * const    _ChoosePattern_url    =    @"apigw/client/ios/expay";

//优惠券规则
NSString * const    _DiscountTicketRule_url    =    @"protocol/couponInstructions.html";

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
NSString *const     _getDrawLottery_url     =    @"apigw/client/market/getDrawLottery";



#pragma mark - 对外导流接口

//量子互助
NSString * const    _liangzihuzhu_url    =    @"http://www.liangzihuzhu.com.cn/xwh5/pages/plan/quotaRecharge.html?id=222767";

#pragma Mark - 验证码类型

NSString * const  CODE_REG           =    @"MSG_REG_"; ///注册验证码
NSString * const  CODE_FINDPASS      =    @"MSG_FIND_PASSWORD_"; ///密码找回验证码
NSString * const  CODE_CHANGEPASS    =    @"MSG_UPDATE_PASSWORD_"; ///修改密码验证码
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




