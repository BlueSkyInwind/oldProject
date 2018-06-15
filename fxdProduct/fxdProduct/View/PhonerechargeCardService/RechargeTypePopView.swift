//
//  RechargeTypePopView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

typealias CloseButtonClick = () -> Void
class RechargeTypePopView: UIView,NibLoadProtocol  {
    
    
    var closeButtonClick:CloseButtonClick?
    
    override func awakeFromNib() {
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
    }
    
    @IBAction func closeBtnClick(_ sender: Any) {
        
        if closeButtonClick != nil {
            closeButtonClick!()
        }
    }
    
    @IBAction func moblieNumberTap(_ sender: Any) {
        FXD_Tool.makePhoneCall("10086")
    }
    
    @IBAction func unicomNumberTap(_ sender: Any) {
        FXD_Tool.makePhoneCall("10011")
    }
    
    @IBAction func telecomNumberTap(_ sender: Any) {
        FXD_Tool.makePhoneCall("11888")
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
