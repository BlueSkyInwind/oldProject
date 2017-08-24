//
//  AuthenticationCenterHeaderView.swift
//  fxdProduct
//
//  Created by sxp on 2017/8/24.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class AuthenticationCenterHeaderView: UIView {

    var titleLabel : UILabel?
    var descLabel : UILabel?
    
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

extension AuthenticationCenterHeaderView{

    fileprivate func setupUI(){
    
        titleLabel = UILabel()
        titleLabel?.textColor = UI_MAIN_COLOR
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(32)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(20)
        })
        
        descLabel = UILabel()
        descLabel?.textColor = AuthenticationHeader_COLOR
        descLabel?.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(descLabel!)
        descLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((titleLabel?.snp.right)!).offset(20)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(20)
        })
    }
    
    override var  frame:(CGRect){
        
        didSet{
            let k_w = UIScreen.main.bounds.size.width
            let newFrame = CGRect(x:0,y:0,width:k_w,height:39)
            super.frame = newFrame
            
        }
    }
}
