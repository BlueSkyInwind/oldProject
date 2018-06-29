//
//  NewLoginView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class NewLoginView: UIView {

    var phoneNumberView:GeneralInputView?
    var passwordView:GeneralInputView?
    var loginButton:UIButton?
    var forgetButton:UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func loginButtonClick(sender:UIButton) {
        
    }
    
    @objc func forgetButtonClick(sender:UIButton) {
        
        
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
        self.addSubview(phoneNumberView!)
        phoneNumberView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(_k_w * 0.65)
            make.top.equalTo(self.snp.top).offset(60)
            make.height.equalTo(40)
        })
        
        passwordView = GeneralInputView.init(.Password)
        passwordView?.inputTextField?.placeholder = "请输入密码"
        self.addSubview(passwordView!)
        passwordView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo((phoneNumberView?.snp.width)!)
            make.top.equalTo((phoneNumberView?.snp.bottom)!).offset(40)
            make.height.equalTo((phoneNumberView?.snp.height)!)
        })
        
        loginButton = UIButton.init(type: UIButtonType.custom)
        loginButton?.setTitle("登录", for: UIControlState.normal)
        loginButton?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 17)
        loginButton?.setBackgroundImage(UIImage.init(named: "login_Btn_Icon_gray"), for: UIControlState.normal)
        loginButton?.addTarget(self, action: #selector(loginButtonClick(sender:) ), for: UIControlEvents.touchUpInside)
        self.addSubview(loginButton!)
        loginButton?.snp.makeConstraints({ (make) in
            make.top.equalTo((passwordView?.snp.top)!).offset(85)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo((phoneNumberView?.snp.width)!)
            make.height.equalTo(40)
        })
        
        forgetButton = UIButton.init(type: UIButtonType.custom)
        forgetButton?.setTitle("忘记密码", for: UIControlState.normal)
        forgetButton?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 13)
        forgetButton?.backgroundColor = UIColor.white
        forgetButton?.addTarget(self, action: #selector(forgetButtonClick(sender:) ), for: UIControlEvents.touchUpInside)
        self.addSubview(forgetButton!)
        forgetButton?.snp.makeConstraints({ (make) in
            make.top.equalTo((loginButton?.snp.top)!).offset(34)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(60)
            make.height.equalTo(15)
        })
    }
}


