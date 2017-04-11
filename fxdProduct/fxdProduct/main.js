console.log('run success');
require('MBPAlertView,Tool');
defineClass('RepaymentViewController',{
            sureBtn: function(sender) {
            if (dataListAll3[0].length() < 1) {
            MBPAlertView.sharedMBPTextView().showTextOnly_message(self.view(), "请选择银行卡");
            } else if (_bankCodeNUm.length() < 1 || _bankCodeNUm == null) {
            MBPAlertView.sharedMBPTextView().showTextOnly_message(self.view(), "请重新选择银行卡类型");
            } else if (dataListAll3[1].length() < 16) {
            MBPAlertView.sharedMBPTextView().showTextOnly_message(self.view(), "请填写正确的卡号");
            } else if (!Tool.isMobileNumber(dataListAll3[2])) {
            MBPAlertView.sharedMBPTextView().showTextOnly_message(self.view(), "请填写正确的手机号");
            } else if (dataListAll3[3].length() != 6) {
            MBPAlertView.sharedMBPTextView().showTextOnly_message(self.view(), "请填写正确的验证码");
            } else if (!_btnStatus) {
            MBPAlertView.sharedMBPTextView().showTextOnly_message(self.view(), "请同意授权书");
            } else {
            self.PostSubmitUrl();}
            },
            });
//require('GeTuiSdk');
//defineClass('AppDelegate', {
//            startSdkWith_appKey_appSecret: function(appID, appKey, appSecret) {
//            console.log(appSecret);
//            var kAppSecret = "rPvgHctJ9m7odkglAm1Xx5";
//            console.log(kAppSecret);
//            //[1-1]:通过 AppId、 appKey 、appSecret 启动SDK
//            GeTuiSdk.startSdkWithAppId_appKey_appSecret_delegate_error(appID, appKey, kAppSecret, self, null);
//            
//            //[1-2]:设置是否后台运行开关
//            GeTuiSdk.runBackgroundEnable(YES);
//            //[1-3]:设置电子围栏功能，开启LBS定位服务 和 是否允许SDK 弹出用户定位请求
//            GeTuiSdk.lbsLocationEnable_andUserVerify(YES, YES);
//            
//            },
//            })
//
//console.log('run second')
//require('DataWriteAndRead,Utility,GetCustomerBaseViewModel');
//defineClass('HomeViewController', {
//            getUserInfoData: function() {
//            var data = DataWriteAndRead.readDataWithkey("UserInfomation");
//            if (data) {
//            console.log(data);
//            var userInfo = data;
//            Utility.sharedUtility().userInfo().setUserIDNumber(userInfo.result().idCode());
//            console.log(Utility.sharedUtility().userInfo().userIDNumber());
//            } else {
//            if (Utility.sharedUtility().loginFlage()) {
//            var customBaseViewModel = GetCustomerBaseViewModel.alloc().init();
//            var slf = self;
//            customBaseViewModel.setBlockWithReturnBlock_WithFaileBlock(block('id', function(returnValue) {
//                                                                             slf.setValue_forKey(returnValue, "_customerBase")
//                                                                             //                                                                             _customerBase = returnValue;
//                                                                             console.log(slf.valueForKey("_customerBase").flag());
//                                                                             if (slf.valueForKey("_customerBase").flag().isEqualToString("0000")) {
//                                                                             DataWriteAndRead.writeDataWithkey_value("UserInfomation", slf.valueForKey("_customerBase"));
//                                                                             //                DLog("%d",[DataWriteAndRead writeDataWithkey:UserInfomation value:_customerBase]);
//                                                                             }
//                                                                             }), block(function() {
//                                                                                       
//                                                                                       }));
//            customBaseViewModel.fatchCustomBaseInfo(null);
//            }
//            }
//            },
//            });
