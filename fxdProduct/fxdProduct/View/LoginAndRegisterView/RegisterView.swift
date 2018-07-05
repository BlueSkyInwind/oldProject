//
//  RegisterView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

let RegisterProcotolPrompt = "请点击同意协议"

typealias UserRegisterButtonClick = (_ button:UIButton,_ phoneNum:String,_ picCode:String,_ verifyCode:String,_ password:String,_ invitationCode:String) -> Void
typealias ObtainPicVerifuCodeClick = () -> Void
typealias RegisterSendVerifyCodeClick = (_ phoneNumber:String,_ picCode:String) -> Void
typealias RegisterProcotolClick = (_ index:Int) -> Void

class RegisterView: UIView {

    var phoneNumberView:GeneralInputView?
    var picVerifyCodeView:GeneralInputView?
    var verifyCodeView:GeneralInputView?
    var passwordView:GeneralInputView?
    var inviteCodeView:GeneralInputView?
    var forgetButton:UIButton?
    var registerButton:UIButton?
    
    var userRegisterButtonClick:UserRegisterButtonClick?
    var obtainPicVerifuCodeClick:ObtainPicVerifuCodeClick?
    var sendVerifyCodeClick:RegisterSendVerifyCodeClick?
    var procotolClick:RegisterProcotolClick?
    var isAgreement:Bool = false


    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addSignal()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSignal()  {
        
        let validUserNameSignal = phoneNumberView?.inputTextField?.reactive.continuousTextValues.map({ (text) -> Bool in
            return FXD_Tool.checkMoblieNumber(text)
        })
        
        let validPicCodeSignal = picVerifyCodeView?.inputTextField?.reactive.continuousTextValues.map({ (text) -> Bool in
            return (text?.count)! > 3 ? true : false
        })
        
        let vaildSendVerifyBtnSignal = Signal.combineLatest(validUserNameSignal!,validPicCodeSignal!)
        vaildSendVerifyBtnSignal.map { (isVaildUserName,isVaildPicCode) -> Bool in
            return isVaildUserName && isVaildPicCode
            }.observeValues {[weak self] (isVaild) in
                if isVaild {
                    self?.verifyCodeView?.rightButton?.backgroundColor = UI_MAIN_COLOR
                    self?.verifyCodeView?.rightButton?.isEnabled = true
                }else{
                    self?.verifyCodeView?.rightButton?.backgroundColor = UIColor.lightGray
                    self?.verifyCodeView?.rightButton?.isEnabled = false
                }
        }
        
        let validVerifyCodeSignal = verifyCodeView?.inputTextField?.reactive.continuousTextValues.map({ (text) -> Bool in
            return (text?.count)! > 3 ? true : false
        })
        
        let validPassWordSignal = passwordView?.inputTextField?.reactive.continuousTextValues.map({ (text) -> Bool in
            return (text?.count)! > 5 ? true : false
        })
        
        let validRegisterBtnSignal = Signal.combineLatest(validUserNameSignal!,validPicCodeSignal!,validVerifyCodeSignal!,validPassWordSignal!)
        validRegisterBtnSignal.map { (isVaildUserName,isVaildPicCode,isVaildVerifyCode,isVaildPassword) -> Bool in
            return isVaildUserName && isVaildPassword && isVaildVerifyCode && isVaildPassword
            }.observeValues {[weak self] (isVaildRegister) in
                if isVaildRegister {
                    self?.registerButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_light"), for: UIControlState.normal)
                    self?.registerButton?.isEnabled  = true
                }else{
                    self?.registerButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_gray"), for: UIControlState.normal)
                    self?.registerButton?.isEnabled  = false
                }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @objc func registerButtonClick(sender:UIButton) {
        guard isAgreement else {
            MBPAlertView.sharedMBPText().showTextOnly(self, message: RegisterProcotolPrompt)
            return
        }
        
        if  userRegisterButtonClick != nil {
            userRegisterButtonClick!(sender,(self.phoneNumberView?.inputContent)!,(picVerifyCodeView?.inputContent)!,(verifyCodeView?.inputContent)!,(passwordView?.inputContent)!,(inviteCodeView?.inputContent)!)
        }
    }
}

extension RegisterView {
    
    func configureView() {
        
        phoneNumberView = GeneralInputView.init(.Phone_Number)
        phoneNumberView?.inputTextField?.placeholder = "请输入手机号码"
        phoneNumberView?.iconImageView?.image = UIImage.init(named: "1_Signin_icon_01")
        self.addSubview(phoneNumberView!)
        phoneNumberView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(_k_w * 0.65)
            if UI_IS_IPHONEX || UI_IS_IPONE6P {
                make.top.equalTo(self.snp.top).offset(60)
            }else{
                make.top.equalTo(self.snp.top).offset(40)
            }
            make.height.equalTo(34)
        })
        
        picVerifyCodeView = GeneralInputView.init(.Pic_Verify_Code)
        picVerifyCodeView?.inputTextField?.placeholder = "请先输入图形验证码"
        picVerifyCodeView?.iconImageView?.image = UIImage.init(named: "1_Signin_icon_02")
        self.addSubview(picVerifyCodeView!)
        picVerifyCodeView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo((phoneNumberView?.snp.width)!)
            make.top.equalTo((phoneNumberView?.snp.bottom)!).offset(32)
            make.height.equalTo((phoneNumberView?.snp.height)!)
        })
        picVerifyCodeView?.rightBtnClick = {[weak self] (button,type) in
            if type == .Pic_Verify_Code &&  self?.obtainPicVerifuCodeClick != nil {
                self?.obtainPicVerifuCodeClick!()
            }
        }
        
        verifyCodeView = GeneralInputView.init(.Verify_Code)
        verifyCodeView?.inputTextField?.placeholder = "请输入验证码"
        verifyCodeView?.iconImageView?.image = UIImage.init(named: "1_Signin_icon_02")
        verifyCodeView?.rightButton?.backgroundColor = UIColor.lightGray
        verifyCodeView?.rightButton?.isEnabled  = false
        self.addSubview(verifyCodeView!)
        verifyCodeView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo((phoneNumberView?.snp.width)!)
            make.top.equalTo((picVerifyCodeView?.snp.bottom)!).offset(32)
            make.height.equalTo((phoneNumberView?.snp.height)!)
        })
        verifyCodeView?.rightBtnClick = {[weak self] (button,type) in
            if type == .Verify_Code && self?.sendVerifyCodeClick != nil  {
                self?.sendVerifyCodeClick!((self?.phoneNumberView?.inputContent)!,(self?.picVerifyCodeView?.inputContent)!)
            }
        }
        
        passwordView = GeneralInputView.init(.Password)
        passwordView?.inputTextField?.placeholder = "请输入密码"
        passwordView?.iconImageView?.image = UIImage.init(named: "1_Signin_icon_03")
        self.addSubview(passwordView!)
        passwordView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo((phoneNumberView?.snp.width)!)
            make.top.equalTo((verifyCodeView?.snp.bottom)!).offset(32)
            make.height.equalTo((phoneNumberView?.snp.height)!)
        })
        
        inviteCodeView = GeneralInputView.init(.general)
        inviteCodeView?.inputTextField?.placeholder = "请输入邀请码或邀请人手机号"
        inviteCodeView?.iconImageView?.image = UIImage.init(named: "1_Signin_icon_07")
        self.addSubview(inviteCodeView!)
        inviteCodeView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo((phoneNumberView?.snp.width)!)
            make.top.equalTo((passwordView?.snp.bottom)!).offset(32)
            make.height.equalTo((phoneNumberView?.snp.height)!)
        })
        
        let agreementView = HF_AgreementView.init(CGRect.zero,content:"同意河马有钱",protocolNameArr: ["《注册协议》","《隐私保密协议》"])
        agreementView.isAgreementClick = {[weak self] (isClick) in
            self?.isAgreement = isClick
            if isClick {
                
            }else{
                
            }
        }
        agreementView.agreementClick = { [weak self] (index) in
            if self?.procotolClick != nil {
                self?.procotolClick!(index)
            }
        }
        self.addSubview(agreementView)
        agreementView.snp.makeConstraints { (make) in
            make.left.equalTo((phoneNumberView?.snp.left)!).offset(-20)
            make.top.equalTo((inviteCodeView?.snp.bottom)!).offset(32)
            make.right.equalTo((self.snp.right))
            make.height.equalTo(20)
        }
        
        registerButton = UIButton.init(type: UIButtonType.custom)
        registerButton?.setTitle("注册", for: UIControlState.normal)
        registerButton?.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        registerButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_gray"), for: UIControlState.normal)
        registerButton?.addTarget(self, action: #selector(registerButtonClick(sender:) ), for: UIControlEvents.touchUpInside)
        self.addSubview(registerButton!)
        registerButton?.snp.makeConstraints({ (make) in
            make.top.equalTo((agreementView.snp.bottom)).offset(40)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo((phoneNumberView?.snp.width)!)
            make.height.equalTo(40)
        })
    }
}

