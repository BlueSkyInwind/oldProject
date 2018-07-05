//
//  loginAndRegisterModules.swift
//  fxdProduct
//
//  Created by admin on 2018/6/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class loginAndRegisterModules: BaseViewController {

    var contentView:LoginAndRegisterSlideView?
    
    var  loginView:NewLoginView?
    var registerView:RegisterView?
    
    var loginResultModel:BaseResultModel?
    
    var oldPicId:String = ""
    var currentPicId:String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "登录"
        self.addBackItem()
        configureView()
    }
    
    override func popBack() {
        backMainVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshPicCode()
    }
    
    func configureView()  {
        
         contentView = LoginAndRegisterSlideView.init(CGRect.init(x: 0, y: CGFloat(obtainBarHeight_New(vc: self)), width: _k_w, height: _k_h - CGFloat(obtainBarHeight_New(vc: self)) ), {[weak self]  (loginView, registerView) in
            
            self?.loginView = NewLoginView.init(frame: CGRect.zero);
            loginView.addSubview((self?.loginView)!)
            self?.loginView?.snp.makeConstraints({ (make) in
                make.edges.equalTo(loginView)
            })
            
            self?.loginView?.sendVC = { (phoneNum) in
                self?.obtainUserLoginVerifyCode(phoneNum, { (isSuccess) in
                    self?.loginView?.verifyCodeView?.createTimer()
                })
            }
            
            self?.loginView?.loginBtnClick = { (button,phoneNum,password,verifyCode) in
                self?.startLogin(phoneNum, password, verifyCode)
            }
            
            self?.loginView?.forgetBtnClick = { (button) in
                self?.pushForgetVC()
            }
            
            self?.registerView = RegisterView.init(frame: CGRect.zero)
            registerView.addSubview((self?.registerView)!)
            self?.registerView?.snp.makeConstraints({ (make) in
                make.edges.equalTo(registerView)
            })
            
            self?.registerView?.obtainPicVerifuCodeClick = {
                self?.refreshPicCode()
            }
            
            self?.registerView?.sendVerifyCodeClick = { (phoneNum,picCode) in
                self?.obtainUserRegisterVerifyCode(phoneNum, picCode, { (isSuccess) in
                    if isSuccess {
                        self?.registerView?.verifyCodeView?.createTimer()
                    }
                })
            }
            
            self?.registerView?.procotolClick = { (index) in
                if index == 0{
                    self?.clickRegisterProcotol("8")
                }else{
                    self?.clickRegisterProcotol("9")
                }
            }
            
            self?.registerView?.userRegisterButtonClick = { (button,phoneNum,picCode,verifyCode,password,invatationCode) in
                self?.registerRequest(phoneNum, (self?.currentPicId)!, picCode, verifyCode, password, invatationCode)
            }
            
        }) { (isLogin) in
            if isLogin {
                self.title = "登录"
            }else{
                self.title = "注册"
            }
        }
        self.view.addSubview(contentView!)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func  refreshPicCode()  {
        self.obtainUserPicVerifyCode({ (picUrl, isSuccess) in
            if isSuccess {
                self.registerView?.picVerifyCodeView?.rightButton?.sd_setBackgroundImage(with: URL.init(string: picUrl), for: UIControlState.normal, placeholderImage: nil, options: .refreshCached, completed: nil)
            }
        })
    }
    
    func backMainVC()  {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateDevIDVC() {
        let updateIDVC = UpdateDeviceIdMoudles.init()
        updateIDVC.phoneStr = loginView?.phoneNumberView?.inputContent
        updateIDVC.passwordStr = loginView?.passwordView?.inputContent
        self.navigationController?.pushViewController(updateIDVC, animated: true)
    }

    func pushForgetVC() {
//        self.loginView?.displayVerifyCode(false)
        let forgetVC = ForgetPasswordMoudles.init()
//        forgetVC.phoneStr
        self.navigationController?.pushViewController(forgetVC, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension loginAndRegisterModules {
    
    func loginRequest(_ loginVM:LoginViewModel,_ phoneNum:String,_ password:String,_ verifyCode:String)  {
        if loginResultModel != nil {
            if loginResultModel?.errCode == "5" {
                loginVM.fatchLoginMoblieNumber(phoneNum, password: password, fingerPrint: nil, verifyCode: verifyCode)
            }else{
                loginVM.fatchLoginMoblieNumber(phoneNum, password: password, fingerPrint: nil, verifyCode: nil)
            }
        }else{
            loginVM.fatchLoginMoblieNumber(phoneNum, password: password, fingerPrint: nil, verifyCode: nil)
        }
    }

    func startLogin(_ phoneNum:String,_ password:String,_ verifyCode:String)  {
        
        let loginVM = LoginViewModel.init()
        loginVM.setBlockWithReturn({ [weak self](resultModel) in
            self?.loginResultModel = (resultModel as! BaseResultModel)
            if self?.loginResultModel?.errCode == "0" {
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: self?.loginResultModel?.friendErrMsg)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                    self?.backMainVC()
                })
            }else if self?.loginResultModel?.errCode == "4" {
                FXD_AlertViewCust.sharedHHAlertView().showFXDAlertViewTitle(nil, content: "您当前尝试在新设备上登录,确定要继续?", attributeDic: nil, textAlignment: .center, cancelTitle: "取消", sureTitle: "确定", compleBlock: { (index) in
                    if index == 1 {
                        self?.updateDevIDVC()
                    }
                })
            }else if self?.loginResultModel?.errCode == "5" {
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: self?.loginResultModel?.friendErrMsg)
                self?.loginView?.displayVerifyCode(false)
            }else {
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: self?.loginResultModel?.friendErrMsg)
            }
        }) {
            
        }
        loginRequest(loginVM, phoneNum, password, verifyCode)
    }
    
    func obtainUserLoginVerifyCode(_ phoneNumber:String,_ complication:@escaping (_ isSuccess:Bool) -> Void) {
        let smsVM = SMSViewModel.init()
        smsVM.setBlockWithReturn({ (resultModel) in
            let baseModel  = resultModel as! BaseResultModel
            if baseModel.errCode == "0"{
                complication(true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseModel.friendErrMsg)
                complication(false)
            }
        }) {
            complication(false)
        }
        smsVM.fatchRequestSMSParamPhoneNumber(phoneNumber, verifyCodeType: LOGIN_CODE)
    }
    
    //MARK: 注册
    
    func obtainUserPicVerifyCode(_ complication:@escaping (_ picUrl:String,_ isSuccess:Bool) -> Void)  {
        let smsVM = SMSViewModel.init()
        smsVM.setBlockWithReturn({[weak self] (resultModel) in
            let baseModel  = resultModel as! BaseResultModel
            if baseModel.errCode == "0"{
                let picModel = try! PicSMSModel.init(dictionary: baseModel.data as! [AnyHashable : Any]! )
                self?.oldPicId = (self?.currentPicId)!
                self?.currentPicId = picModel.id_
                var paramStr = "?id_=" + (self?.currentPicId)! + "&oldId_=" + (self?.oldPicId)!
                if  (self?.oldPicId)! == "" {
                     paramStr = "?id_=" + (self?.currentPicId)!
                }
                let resultStr = _main_new_url + picModel.pic_verify_url_ + paramStr
                complication(resultStr,true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseModel.friendErrMsg)
                complication("",false)
            }
        }) {
            complication("",false)
        }
        smsVM.postPicVerifyCode()
    }
    
    func obtainUserRegisterVerifyCode(_ phoneNumber:String,_ picCode:String,_ complication:@escaping (_ isSuccess:Bool) -> Void)  {
        let smsVM = SMSViewModel.init()
        smsVM.setBlockWithReturn({[weak self] (resultModel) in
            let baseModel  = resultModel as! BaseResultModel
            if baseModel.errCode == "0"{
                complication(true)
            }else{
                self?.refreshPicCode()
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseModel.friendErrMsg)
                complication(false)
            }
        }) {
            complication(false)
        }
        smsVM.fatchRequestRegSMSParamPhoneNumber(phoneNumber, picVerifyId: currentPicId, picVerifyCode: picCode)
    }
    
    func registerRequest(_ phoneNum:String,_ picCodeID:String,_ picCode:String,_ verifyCode:String,_ password:String,_ invitationCode:String)  {
        let regVM = RegViewModel.init()
        regVM.setBlockWithReturn({[weak self] (resultModel) in
            let baseModel  = resultModel as! BaseResultModel
            if baseModel.errCode == "0" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8, execute: {
                    self?.registerAndLogin(phoneNum,password)
                })
            }else if baseModel.errCode == "1" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8, execute: {
                    //TODO 待处理
                    self?.contentView?.loginAnimation()
                })
            }
            MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseModel.friendErrMsg)
        }) {
            
        }
        regVM.fatchRegMoblieNumber(phoneNum, password: password, verifyCode: verifyCode, invitationCode: invitationCode, picVerifyId: picCodeID, picVerifyCode: picCode)
    }
    
    func registerAndLogin(_ phoneNum:String,_ password:String)  {
        let loginVM = LoginViewModel.init()
        loginVM.setBlockWithReturn({ [weak self](resultModel) in
            self?.loginResultModel = (resultModel as! BaseResultModel)
            if self?.loginResultModel?.errCode == "0" {
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: self?.loginResultModel?.friendErrMsg)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                    self?.backMainVC()
                })
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: self?.loginResultModel?.friendErrMsg)
            }
        }) {
        }
        loginVM.fatchLoginMoblieNumber(phoneNum, password:password, fingerPrint: nil, verifyCode: nil)
    }
    
    // 注册协议  8 隐私 9
    func clickRegisterProcotol(_ procotolType:String)  {
        
        let commonVM = CommonViewModel.init()
        commonVM.setBlockWithReturn({[weak self] (resultModel) in
            let baseModel  = resultModel as! BaseResultModel
            if baseModel.errCode == "0" {
                let dic = baseModel.data as! Dictionary<String, String>
                if dic.keys.contains("productProURL") {
                    let fxdWeb = FXDWebViewController.init()
                    fxdWeb.urlStr = dic["productProURL"]
                    self?.navigationController?.pushViewController(fxdWeb, animated: true)
                }
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseModel.friendErrMsg)
            }
        }) {
        }
        commonVM.obtainProductProtocolType("user_reg", typeCode: procotolType, apply_id: nil, periods: nil, stagingType: nil)
    }
}

