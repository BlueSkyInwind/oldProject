//
//  ForgetPasswordView.swift
//  fxdProduct
//
//  Created by admin on 2018/7/3.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

typealias UserfindPasswordButtonClick = (_ button:UIButton,_ phoneNum:String,_ password:String,_ verifyCode:String) -> Void
typealias ForgetPasswordSendVerifyCodeClick = (_ phoneNumber:String) -> Void
class ForgetPasswordView: UIView {
    
    var phoneNumberView:GeneralInputView?
    var verifyCodeView:GeneralInputView?
    var passwordView:GeneralInputView?
    var forgetButton:UIButton?
    fileprivate var bottomIcon:UIImageView?
    
    var userfindPasswordButtonClick:UserfindPasswordButtonClick?
    var forgetPasswordSendVerifyCodeClick:ForgetPasswordSendVerifyCodeClick?
    
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
            
        validUserNameSignal?.map({ (isLightVC) -> Bool in
            return isLightVC
        }).observeValues({ [weak self] (isVaild) in
            if isVaild {
                self?.verifyCodeView?.rightButton?.backgroundColor = UI_MAIN_COLOR
                self?.verifyCodeView?.rightButton?.isEnabled = true
            }else{
                self?.verifyCodeView?.rightButton?.backgroundColor = UIColor.lightGray
                self?.verifyCodeView?.rightButton?.isEnabled = false
            }
        })
        
        let validPassWordSignal = passwordView?.inputTextField?.reactive.continuousTextValues.map({ (text) -> Bool in
            return (text?.count)! > 5 ? true : false
        })
        
        let validVerifyCodeSignal = verifyCodeView?.inputTextField?.reactive.continuousTextValues.map({ (text) -> Bool in
            (text?.count)! > 3  ? true : false
        })
        
        let validForgetBtnSignal = Signal.combineLatest(validUserNameSignal!,validPassWordSignal!,validVerifyCodeSignal!)
        validForgetBtnSignal.map { (isVaildUserName,isVaildPassword,isVaildVerifyCode) -> Bool in
            return isVaildUserName && isVaildPassword && isVaildVerifyCode
            }.observeValues {[weak self] (isVaildLogin) in
                if isVaildLogin {
                    self?.forgetButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_light"), for: UIControlState.normal)
                }else{
                    self?.forgetButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_gray"), for: UIControlState.normal)
                }
        }
    }
    
    @objc func forgetButtonClick(sender:UIButton) {
        guard FXD_Tool.checkMoblieNumber(phoneNumberView?.inputContent) else {
            MBPAlertView.sharedMBPText().showTextOnly(self, message: phoneNumberPrompt)
            return
        }
        
        guard verifyCodeView?.inputContent != "" else {
            MBPAlertView.sharedMBPText().showTextOnly(self, message: VerifyCodePrompt)
            return
        }
        
        guard passwordView?.inputContent != "" else {
            MBPAlertView.sharedMBPText().showTextOnly(self, message: passwordPrompt)
            return
        }
        if userfindPasswordButtonClick != nil {
            userfindPasswordButtonClick!(sender,(phoneNumberView?.inputContent)!,(passwordView?.inputContent)!,(verifyCodeView?.inputTextField?.text)!)
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

extension ForgetPasswordView {
    
    func configureView()  {
        
        phoneNumberView = GeneralInputView.init(.Phone_Number)
        phoneNumberView?.inputTextField?.placeholder = "请输入手机号码"
        phoneNumberView?.inputTextField?.keyboardType = .numberPad
        phoneNumberView?.iconImageView?.image = UIImage.init(named: "1_Signin_icon_01")
        self.addSubview(phoneNumberView!)
        phoneNumberView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(_k_w * 0.65)
            make.top.equalTo(self.snp.top).offset(100)
            make.height.equalTo(30)
        })
        
        verifyCodeView = GeneralInputView.init(.Verify_Code)
        verifyCodeView?.inputTextField?.placeholder = "请输入验证码"
        verifyCodeView?.iconImageView?.image = UIImage.init(named: "1_Signin_icon_02")
        self.addSubview(verifyCodeView!)
        verifyCodeView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo((phoneNumberView?.snp.width)!)
            make.top.equalTo((phoneNumberView?.snp.bottom)!).offset(40)
            make.height.equalTo((phoneNumberView?.snp.height)!)
        })
        verifyCodeView?.rightBtnClick = {[weak self] (button,type) in
            if type == .Verify_Code && self?.forgetPasswordSendVerifyCodeClick != nil  {
                self?.forgetPasswordSendVerifyCodeClick!((self?.phoneNumberView?.inputContent)!)
            }
        }
        
        passwordView = GeneralInputView.init(.Password)
        passwordView?.inputTextField?.placeholder = "请输入密码"
        passwordView?.iconImageView?.image = UIImage.init(named: "1_Signin_icon_03")
        self.addSubview(passwordView!)
        passwordView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo((phoneNumberView?.snp.width)!)
            make.top.equalTo((verifyCodeView?.snp.bottom)!).offset(40)
            make.height.equalTo((phoneNumberView?.snp.height)!)
        })
        
        forgetButton = UIButton.init(type: UIButtonType.custom)
        forgetButton?.setTitle("确认找回", for: UIControlState.normal)
        forgetButton?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 17)
        forgetButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_gray"), for: UIControlState.normal)
        forgetButton?.addTarget(self, action: #selector(forgetButtonClick(sender:)), for: UIControlEvents.touchUpInside)
        self.addSubview(forgetButton!)
        forgetButton?.snp.makeConstraints({ (make) in
            make.top.equalTo((passwordView?.snp.bottom)!).offset(65)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo((phoneNumberView?.snp.width)!)
            make.height.equalTo(40)
        })
        
        bottomIcon = UIImageView()
        bottomIcon?.image = UIImage.init(named: "LR_bottom_Icon")
        self.addSubview(bottomIcon!)
        bottomIcon?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(BOTTOM_HEIGHT)
        })
    }
}


