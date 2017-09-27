//
//  FooterBtnView.swift
//  fxdProduct
//
//  Created by sxp on 2017/9/1.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

typealias FooterBtn = ()->Void

class FooterBtnView: UIView {

    
    var footerBtnClosure : FooterBtn?
    
    var footerBtn: UIButton?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FooterBtnView{

    fileprivate func setupUI(){
    
        footerBtn = UIButton()
        footerBtn?.backgroundColor = UI_MAIN_COLOR
        footerBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        footerBtn?.setTitleColor(UIColor.white, for: .normal)
        footerBtn?.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        footerBtn?.layer.cornerRadius = 5.0
        
        self.addSubview(footerBtn!)
        footerBtn?.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
            
        }
    }
}

extension FooterBtnView {

    @objc func btnClick() -> Void {
        
        if self.footerBtnClosure != nil {
            
            self.footerBtnClosure!()
        }
    }
}
