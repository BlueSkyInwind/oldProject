//
//  SetPayPasswordView.swift
//  fxdProduct
//
//  Created by admin on 2017/11/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

/// 输入的密码类型
///
/// - old: 旧密码
/// - new: 新密码
/// - verifyNew: 再次输入新密码
@objc enum PasswordType:Int {
    case old
    case new
    case verifyNew
}

/// 输入结果代理
@objc protocol SetPayPasswordViewDelegate: NSObjectProtocol {

    func userInputCashPasswordCode(_ code:String,type:PasswordType)
    
}

class SetPayPasswordView: UIView {
    
    var headerDisplayView:UIView?
    var headerAgainDisplayView:UIView?
    var headerFormerDisplayView:UIView?
    
    var userFormerAccountNumberLabel:UILabel?
    var userAccountNumberLabel:UILabel?
    var reminderLabel:UILabel?
    var reminderAgainLabel:UILabel?
    var payPasswordInputView:PayPasswordInputView?
    
    var delegate : SetPayPasswordViewDelegate?
    
    var type:PasswordType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = PayPasswordBackColor_COLOR
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   @objc func showHeaderFormerDisplayView()  {
        type = .old
        self.headerFormerDisplayView?.frame = CGRect.init(x: 0, y: 0, width: _k_w, height: 100)
        self.headerDisplayView?.frame = CGRect.init(x: _k_w, y: 0, width: _k_w, height: 100)
        self.headerAgainDisplayView?.frame = CGRect.init(x: _k_w, y: 0, width: _k_w, height: 100)
    }
    
    func showHeaderDisplayView()  {
        UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.type = .new
            self.payPasswordInputView?.cleanUpTheData()
            self.headerFormerDisplayView?.frame = CGRect.init(x: -_k_w, y: 0, width: _k_w, height: 100)
            self.headerDisplayView?.frame = CGRect.init(x: 0, y: 0, width: _k_w, height: 100)
            self.headerAgainDisplayView?.frame = CGRect.init(x: _k_w, y: 0, width: _k_w, height: 100)
        }) { (result) in
            
        }
    }
    
    func showHeaderAgainDisplayView()  {
        UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.type = .verifyNew
            self.payPasswordInputView?.cleanUpTheData()
            self.headerAgainDisplayView?.frame = CGRect.init(x: 0, y: 0, width: _k_w, height: 100)
            self.headerDisplayView?.frame = CGRect.init(x: -_k_w, y: 0, width: _k_w, height: 100)
        }) { (result) in
            
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
extension SetPayPasswordView {
    
    func setUpUI()  {
        
        headerFormerDisplayView = UIView.init(frame: CGRect.init(x: -_k_w, y: 0, width: _k_w, height: 100))
        headerFormerDisplayView?.backgroundColor = PayPasswordBackColor_COLOR
        self.addSubview(headerFormerDisplayView!);
        
        userFormerAccountNumberLabel = UILabel()
        userFormerAccountNumberLabel?.text = "输入原交易密码，完成身份验证"
        userFormerAccountNumberLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        userFormerAccountNumberLabel?.textColor = UIColor.black
        headerFormerDisplayView?.addSubview(userFormerAccountNumberLabel!)
        userFormerAccountNumberLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((headerFormerDisplayView?.snp.centerX)!)
            make.centerY.equalTo((headerFormerDisplayView?.snp.centerY)!)
        })
        
        headerDisplayView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 100))
        headerDisplayView?.backgroundColor = PayPasswordBackColor_COLOR
        self.addSubview(headerDisplayView!);
        
        userAccountNumberLabel = UILabel()
        userAccountNumberLabel?.text = "请为账号186******4859"
        userAccountNumberLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        userAccountNumberLabel?.textColor = UIColor.black
        headerDisplayView?.addSubview(userAccountNumberLabel!)
        userAccountNumberLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((headerDisplayView?.snp.centerX)!)
            make.centerY.equalTo((headerDisplayView?.snp.centerY)!).offset(-15)
        })
        
        reminderLabel = UILabel()
        reminderLabel?.text = "设置6位数字交易密码"
        reminderLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        reminderLabel?.textColor = UI_MAIN_COLOR
        headerDisplayView?.addSubview(reminderLabel!)
        reminderLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((headerDisplayView?.snp.centerX)!)
            make.centerY.equalTo((headerDisplayView?.snp.centerY)!).offset(15)
        })
        
        headerAgainDisplayView = UIView.init(frame: CGRect.init(x: _k_w, y: 0, width: _k_w, height: 100))
        headerAgainDisplayView?.backgroundColor = PayPasswordBackColor_COLOR
        self.addSubview(headerAgainDisplayView!);
        
        reminderAgainLabel = UILabel()
        reminderAgainLabel?.text = "再次输入密码"
        reminderAgainLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        reminderAgainLabel?.textColor = UI_MAIN_COLOR
        headerAgainDisplayView?.addSubview(reminderAgainLabel!)
        reminderAgainLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((headerAgainDisplayView?.snp.centerX)!)
            make.centerY.equalTo((headerAgainDisplayView?.snp.centerY)!)
        })
        
        payPasswordInputView = PayPasswordInputView.init(frame: CGRect.init(x: 15, y: 100, width: _k_w - 30, height: 50))
        payPasswordInputView?.isEnsconce = false
        payPasswordInputView?.completeHandle = ({[weak self] (inputPwd) in
            if self?.delegate != nil {
                self?.delegate?.userInputCashPasswordCode(inputPwd!, type: (self?.type)!)
            }
        })
        self.addSubview(payPasswordInputView!)
    }
}


