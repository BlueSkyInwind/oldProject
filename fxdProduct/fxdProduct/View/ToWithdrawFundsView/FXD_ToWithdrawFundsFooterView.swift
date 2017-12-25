//
//  FXD_ToWithdrawFundsFooterView.swift
//  fxdProduct
//
//  Created by admin on 2017/12/25.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit
import WebKit

class FXD_ToWithdrawFundsFooterView: UIView{
    
    var webView:WKWebView?
    var protocolBackView:UIView?
    var applyForBtn:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = LOAN_APPLICATION_COLOR
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func applyForBottonClick(){
        
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
extension FXD_ToWithdrawFundsFooterView {
    
    func setUpUI()  {
        
        applyForBtn = UIButton.init(type: UIButtonType.custom)
        applyForBtn?.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
        applyForBtn?.setTitle("确认申请", for: UIControlState.normal)
        applyForBtn?.addTarget(self, action: #selector(applyForBottonClick), for: UIControlEvents.touchUpInside)
        self.addSubview(applyForBtn!)
        applyForBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(25)
            make.right.equalTo(self.snp.right).offset(-25)
            make.bottom.equalTo(self.snp.bottom).offset(-70)
        })
        
        protocolBackView = UIView.init()
        self.addSubview(protocolBackView!)
        protocolBackView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(25)
            make.right.equalTo(self.snp.right).offset(-25)
            make.bottom.equalTo((applyForBtn?.snp.top)!).offset(-10)
            make.height.equalTo(27)
        })
        
        webView  = WKWebView.init()
        webView?.isUserInteractionEnabled  = false
        self.addSubview(webView!)
        webView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.left).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
        })
        
    }

}


