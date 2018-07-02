//
//  LoginAndRegisterSlideView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

let HEADER_HEIGHT = 40
let HEADER_TOP = 35
let BOTTOM_HEIGHT = 58

typealias LoginAndRegisterBottomView = (_ loginView:UIView,_ registerView:UIView) -> Void
typealias LoginAndRegisterStatus = (_ isLogin:Bool) -> Void
class LoginAndRegisterSlideView: UIView {
    
    var loginButton:UIButton?
    var registerButton:UIButton?
    var bottomView:UIView?
    
    fileprivate var loginView:UIView?
    fileprivate var registerView:UIView?
    fileprivate var bottomIcon:UIImageView?
    fileprivate var statusView:UIView?
    fileprivate var lrBottomView : LoginAndRegisterBottomView?
    fileprivate var loginAndRegisterStatus:LoginAndRegisterStatus?

    convenience init(_ frame: CGRect,_ bottonView:@escaping LoginAndRegisterBottomView,_ status:@escaping LoginAndRegisterStatus){
        self.init(frame: frame)
        self.lrBottomView = bottonView
        self.loginAndRegisterStatus = status
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func loginButtonClick(sender:UIButton) {
        let button  = sender
        if button.isSelected == false {
            self.registerButton?.isSelected = false
            UIView.animate(withDuration: 0.2, delay: 0.1, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.bottomView?.frame = CGRect.init(x: 0, y: 0, width: 65, height: 2)
                self.loginView?.frame = CGRect.init(x: 0, y: CGFloat(HEADER_TOP + HEADER_HEIGHT), width: _k_w, height: self.bounds.size.height - CGFloat(HEADER_TOP + HEADER_HEIGHT  + BOTTOM_HEIGHT))
                self.registerView?.frame = CGRect.init(x: _k_w, y: CGFloat(HEADER_TOP + HEADER_HEIGHT), width: _k_w, height: self.bounds.size.height - CGFloat(HEADER_TOP + HEADER_HEIGHT  + BOTTOM_HEIGHT))
            }) { (status) in
                
            }
            button.isSelected = !button.isSelected
            if loginAndRegisterStatus != nil {
                loginAndRegisterStatus!(true)
            }
        }
    }
    
    @objc func registerButtonClick(sender:UIButton) {
        let button  = sender
        if button.isSelected == false {
            self.loginButton?.isSelected = false
            UIView.animate(withDuration: 0.2, delay: 0.1, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.bottomView?.frame = CGRect.init(x: (self.statusView?.bounds.size.width)! - 65, y: 0, width: 65, height: 2)
                self.loginView?.frame = CGRect.init(x: -_k_w, y: CGFloat(HEADER_TOP + HEADER_HEIGHT), width: _k_w, height: self.bounds.size.height - CGFloat(HEADER_TOP + HEADER_HEIGHT  + BOTTOM_HEIGHT))
                self.registerView?.frame = CGRect.init(x: 0, y: CGFloat(HEADER_TOP + HEADER_HEIGHT), width: _k_w, height: self.bounds.size.height - CGFloat(HEADER_TOP + HEADER_HEIGHT  + BOTTOM_HEIGHT))
            }) { (status) in
                
            }
            button.isSelected = !button.isSelected
            if loginAndRegisterStatus != nil {
                loginAndRegisterStatus!(false)
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

}

extension LoginAndRegisterSlideView {
    
    func configureView()  {
        
        let headView = UIView()
        self.addSubview(headView)
        headView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(HEADER_TOP)
            make.height.equalTo(HEADER_HEIGHT)
            make.width.equalTo(self.snp.width)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        loginButton = UIButton.init(type: UIButtonType.custom)
        loginButton?.setTitle("登录", for: UIControlState.normal)
        loginButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        loginButton?.setTitleColor(UI_MAIN_COLOR, for: UIControlState.selected)
        loginButton?.setTitleColor("999999".uiColor(), for: UIControlState.normal)
        loginButton?.isSelected = true
        loginButton?.addTarget(self, action: #selector(loginButtonClick(sender:) ), for: UIControlEvents.touchUpInside)
        headView.addSubview(loginButton!)
        loginButton?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(headView.snp.centerX).offset(-50)
            make.top.equalTo(headView.snp.top)
            make.bottom.equalTo(headView.snp.bottom).offset(-2)
            make.width.equalTo(65)
        })
        
        registerButton = UIButton.init(type: UIButtonType.custom)
        registerButton?.setTitle("注册", for: UIControlState.normal)
        registerButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        registerButton?.setTitleColor("999999".uiColor(), for: UIControlState.normal)
        registerButton?.setTitleColor(UI_MAIN_COLOR, for: UIControlState.selected)
        registerButton?.addTarget(self, action: #selector(registerButtonClick(sender:) ), for: UIControlEvents.touchUpInside)
        headView.addSubview(registerButton!)
        registerButton?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(headView.snp.centerX).offset(50)
            make.top.equalTo(headView.snp.top)
            make.bottom.equalTo(headView.snp.bottom).offset(-2)
            make.width.equalTo(65)
        })
        
        statusView = UIView()
        headView.addSubview(statusView!)
        statusView?.snp.makeConstraints { (make) in
            make.left.equalTo((loginButton?.snp.left)!)
            make.right.equalTo((registerButton?.snp.right)!)
            make.top.equalTo((loginButton?.snp.bottom)!)
            make.bottom.equalTo(headView.snp.bottom)
        }
        
        bottomView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 65, height: 2))
        bottomView?.backgroundColor = UI_MAIN_COLOR
        statusView?.addSubview(bottomView!)

        bottomIcon = UIImageView()
        bottomIcon?.image = UIImage.init(named: "LR_bottom_Icon")
        self.addSubview(bottomIcon!)
        bottomIcon?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(BOTTOM_HEIGHT)
        })
        
        loginView = UIView.init(frame: CGRect.init(x: 0, y: CGFloat(HEADER_TOP + HEADER_HEIGHT), width: _k_w, height: self.bounds.size.height - CGFloat(HEADER_TOP + HEADER_HEIGHT  + BOTTOM_HEIGHT)))
        self.addSubview(loginView!)
        
        registerView = UIView.init(frame: CGRect.init(x: _k_w, y: CGFloat(HEADER_TOP + HEADER_HEIGHT), width: _k_w, height: self.bounds.size.height - CGFloat(HEADER_TOP + HEADER_HEIGHT  + BOTTOM_HEIGHT)))
        self.addSubview(registerView!)
        if  lrBottomView != nil{
            lrBottomView!(loginView!,registerView!)
        }
        if loginAndRegisterStatus != nil {
            loginAndRegisterStatus!(true)
        }
    }
}



