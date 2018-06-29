//
//  RegisterView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class RegisterView: UIView {

    var phoneNumberView:GeneralInputView?
    var picVerifyCodeView:GeneralInputView?
    var verifyCodeView:GeneralInputView?
    var passwordView:GeneralInputView?
    var inviteCodeView:GeneralInputView?
    
    var registerButton:UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension RegisterView {
    
    func configureView() {
        
        
        
        
        
    }
}

