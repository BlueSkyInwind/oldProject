//
//  NewLoginView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result


let phoneNumberPrompt = "请输入有效的手机号码"
let passwordPrompt = "请输入密码"
let VerifyCodePrompt = "请输入验证码"

typealias UserLoginButtonClick = (_ button:UIButton,_ phoneNum:String,_ password:String,_ verifyCode:String) -> Void
typealias UserForgetButtonClick = (_ button:UIButton) -> Void
typealias SendVerifyCodeClick = (_ phoneNumber:String) -> Void

class NewLoginView: UIView {

    var phoneNumberView:GeneralInputView?
    var passwordView:GeneralInputView?
    var verifyCodeView:GeneralInputView?
    var loginButton:UIButton?
    var forgetButton:UIButton?
    
    var loginBtnClick:UserLoginButtonClick?
    var forgetBtnClick:UserForgetButtonClick?
    var sendVC:SendVerifyCodeClick?
    
    var validUserNameSignal:Signal<Bool, NoError>?
    var validPassWordSignal:Signal<Bool, NoError>?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addSignal()
    }
    
    func addSignal()  {
        
         validUserNameSignal = phoneNumberView?.inputTextField?.reactive.continuousTextValues.map({ (text) -> Bool in
            return FXD_Tool.checkMoblieNumber(text)
        })
        
        validPassWordSignal = passwordView?.inputTextField?.reactive.continuousTextValues.map({ (text) -> Bool in
            return (text?.count)! > 5 ? true : false
        })
        
        displayVerifyCode(true)
    }
    
    func displayVerifyCode(_ hidden:Bool)  {
        verifyCodeView?.isHidden = hidden
        if hidden == false {
            
            let validVerifyCodeSignal = verifyCodeView?.inputTextField?.reactive.continuousTextValues.map({ (text) -> Bool in
                (text?.count)! > 3  ? true : false
            })
            
            let validloginBtnSignal = Signal.combineLatest(validUserNameSignal!,validPassWordSignal!,validVerifyCodeSignal!)
            validloginBtnSignal.map { (isVaildUserName,isVaildPassword,isVaildVerifyCode) -> Bool in
                return isVaildUserName && isVaildPassword && isVaildVerifyCode
                }.observeValues {[weak self] (isVaildLogin) in
                    if isVaildLogin {
                        self?.loginButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_light"), for: UIControlState.normal)
                    }else{
                        self?.loginButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_gray"), for: UIControlState.normal)
                    }
            }
        }else{
            let validloginBtnSignal = Signal.combineLatest(validUserNameSignal!,validPassWordSignal!)
            validloginBtnSignal.map { (isVaildUserName,isVaildPassword) -> Bool in
                return isVaildUserName && isVaildPassword
                }.observeValues {[weak self] (isVaildLogin) in
                    if isVaildLogin {
                        self?.loginButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_light"), for: UIControlState.normal)
                    }else{
                        self?.loginButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_gray"), for: UIControlState.normal)
                    }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func loginButtonClick(sender:UIButton) {
        guard FXD_Tool.checkMoblieNumber(phoneNumberView?.inputContent) else {
            MBPAlertView.sharedMBPText().showTextOnly(self, message: phoneNumberPrompt)
            return
        }
        
        guard passwordView?.inputContent != nil else {
            MBPAlertView.sharedMBPText().showTextOnly(self, message: passwordPrompt)
            return
        }
        
        if loginBtnClick != nil{
            loginBtnClick!(sender,(phoneNumberView?.inputContent)!,(passwordView?.inputContent)!,(verifyCodeView?.inputContent)!)
        }
    }
    
    @objc func forgetButtonClick(sender:UIButton) {
        if forgetBtnClick != nil{
            forgetBtnClick!(sender)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

extension NewLoginView {
    
    func configureView()  {
        
        phoneNumberView = GeneralInputView.init(.Phone_Number)
        phoneNumberView?.inputTextField?.placeholder = "请输入手机号码"
        phoneNumberView?.inputTextField?.keyboardType = .numberPad
        phoneNumberView?.iconImageView?.image = UIImage.init(named: "1_Signin_icon_01")
        self.addSubview(phoneNumberView!)
        phoneNumberView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(_k_w * 0.65)
            make.top.equalTo(self.snp.top).offset(60)
            make.height.equalTo(30)
        })
        
        passwordView = GeneralInputView.init(.Password)
        passwordView?.inputTextField?.placeholder = "请输入密码"
        passwordView?.iconImageView?.image = UIImage.init(named: "1_Signin_icon_03")
        self.addSubview(passwordView!)
        passwordView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo((phoneNumberView?.snp.width)!)
            make.top.equalTo((phoneNumberView?.snp.bottom)!).offset(40)
            make.height.equalTo((phoneNumberView?.snp.height)!)
        })
        
        verifyCodeView = GeneralInputView.init(.Verify_Code)
        verifyCodeView?.inputTextField?.placeholder = "请输入验证码"
        verifyCodeView?.iconImageView?.image = UIImage.init(named: "1_Signin_icon_02")
        verifyCodeView?.isHidden = true
        self.addSubview(verifyCodeView!)
        verifyCodeView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo((phoneNumberView?.snp.width)!)
            make.top.equalTo((passwordView?.snp.bottom)!).offset(40)
            make.height.equalTo((phoneNumberView?.snp.height)!)
        })
        verifyCodeView?.rightBtnClick = {[weak self] (button,type) in
            if type == .Verify_Code && self?.sendVC != nil  {
                self?.sendVC!((self?.phoneNumberView?.inputContent)!)
            }
        }
        
        loginButton = UIButton.init(type: UIButtonType.custom)
        loginButton?.setTitle("登录", for: UIControlState.normal)
        loginButton?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 17)
        loginButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_gray"), for: UIControlState.normal)
        loginButton?.addTarget(self, action: #selector(loginButtonClick(sender:) ), for: UIControlEvents.touchUpInside)
        self.addSubview(loginButton!)
        loginButton?.snp.makeConstraints({ (make) in
            make.top.equalTo((passwordView?.snp.bottom)!).offset(90)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo((phoneNumberView?.snp.width)!)
            make.height.equalTo(40)
        })
        
        forgetButton = UIButton.init(type: UIButtonType.custom)
        forgetButton?.setTitle("忘记密码?", for: UIControlState.normal)
        forgetButton?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        forgetButton?.setTitleColor("B3B3B3".uiColor(), for: UIControlState.normal)
        forgetButton?.backgroundColor = UIColor.white
        forgetButton?.addTarget(self, action: #selector(forgetButtonClick(sender:) ), for: UIControlEvents.touchUpInside)
        self.addSubview(forgetButton!)
        forgetButton?.snp.makeConstraints({ (make) in
            make.top.equalTo((loginButton?.snp.bottom)!).offset(34)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(20)
        })
    }
}



