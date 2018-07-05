//
//  UpdateDeviceIdView.swift
//  fxdProduct
//
//  Created by admin on 2018/7/3.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result


typealias UserUpdateButtonClick = (_ button:UIButton,_ phoneNum:String,_ verifyCode:String) -> Void
typealias UpdateDeviceSendVerifyCodeClick = (_ phoneNumber:String) -> Void

class UpdateDeviceIdView: UIView {
    
    var phoneNumberView:GeneralInputView?
    var verifyCodeView:GeneralInputView?
    var updateButton:UIButton?
    fileprivate var bottomIcon:UIImageView?
    
    var userUpdateButtonClick:UserUpdateButtonClick?
    var updateDeviceSendVerifyCodeClick:UpdateDeviceSendVerifyCodeClick?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addSignal()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSignal()  {
    
        let validVerifyCodeSignal = verifyCodeView?.inputTextField?.reactive.continuousTextValues.map({ (text) -> Bool in
            (text?.count)! > 3  ? true : false
        })
        
        let validUserNameSignal = phoneNumberView?.inputTextField?.reactive.continuousTextValues.map({ (text) -> Bool in
            return FXD_Tool.checkMoblieNumber(text)
        })
        
        let (signalA, observerA) = Signal<Bool, NoError>.pipe()
        let validVerifyBtnSignal = Signal.combineLatest(validUserNameSignal!,signalA)
        validVerifyBtnSignal.map { (isVaildUserName,isVaild) -> Bool in
            return isVaildUserName && isVaild
            }.observeValues {[weak self] (isVaild) in
                if isVaild {
                    self?.verifyCodeView?.rightButton?.backgroundColor = UI_MAIN_COLOR
                    self?.verifyCodeView?.rightButton?.isEnabled = true
                }else{
                    self?.verifyCodeView?.rightButton?.backgroundColor = UIColor.lightGray
                    self?.verifyCodeView?.rightButton?.isEnabled = false
                }
        }
        
        let validForgetBtnSignal = Signal.combineLatest(validUserNameSignal!,validVerifyCodeSignal!)
        validForgetBtnSignal.map { (isVaildUserName,isVaildVerifyCode) -> Bool in
            return isVaildUserName && isVaildVerifyCode
            }.observeValues {[weak self] (isVaildLogin) in
                if isVaildLogin {
                    self?.updateButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_light"), for: UIControlState.normal)
                }else{
                    self?.updateButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_gray"), for: UIControlState.normal)
                }
        }
        
        observerA.send(value: true)
        observerA.sendCompleted()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @objc func updateButtonClick(sender:UIButton)  {
        
        guard FXD_Tool.checkMoblieNumber(phoneNumberView?.inputContent) else {
            MBPAlertView.sharedMBPText().showTextOnly(self, message: phoneNumberPrompt)
            return
        }
        
        guard verifyCodeView?.inputContent != "" else {
            MBPAlertView.sharedMBPText().showTextOnly(self, message: VerifyCodePrompt)
            return
        }
        
        if  userUpdateButtonClick != nil {
            userUpdateButtonClick!(sender,(phoneNumberView?.inputContent)!,(verifyCodeView?.inputContent)!)
        }
    }
}

extension UpdateDeviceIdView {
    
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
            if type == .Verify_Code && self?.updateDeviceSendVerifyCodeClick != nil  {
                self?.updateDeviceSendVerifyCodeClick!((self?.phoneNumberView?.inputContent)!)
            }
        }
        
        let displayLabel = UILabel()
        displayLabel.textColor = UI_MAIN_COLOR
        displayLabel.text = "提示:设备号发生改变,为了您的账号安全请重新验证!"
        displayLabel.font = UIFont.systemFont(ofSize: 12)
        displayLabel.textAlignment = .center
        self.addSubview(displayLabel)
        displayLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo((self.snp.width))
            make.top.equalTo((verifyCodeView?.snp.bottom)!).offset(20)
            make.height.equalTo((phoneNumberView?.snp.height)!)
        }
        
        
        updateButton = UIButton.init(type: UIButtonType.custom)
        updateButton?.setTitle("确认更改", for: UIControlState.normal)
        updateButton?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 17)
        updateButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_gray"), for: UIControlState.normal)
        updateButton?.addTarget(self, action: #selector(updateButtonClick(sender:)), for: UIControlEvents.touchUpInside)
        self.addSubview(updateButton!)
        updateButton?.snp.makeConstraints({ (make) in
            make.top.equalTo((verifyCodeView?.snp.bottom)!).offset(65)
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


