//
//  WithdrawHeaderView.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class WithdrawHeaderView: UIView {

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

extension WithdrawHeaderView{
    fileprivate func setupUI(){
        
        let headerImage = UIImageView()
        headerImage.image = UIImage(named:"duigou")
        self.addSubview(headerImage)
        headerImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self).offset(31)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "提现申请已提交"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.yx_systemFont(ofSize: 16)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(headerImage.snp.bottom).offset(18)
        }
        
    }
    
    override var  frame:(CGRect){
        didSet{
            let k_w = UIScreen.main.bounds.size.width
            var newFrame = CGRect(x:0,y:0,width:k_w,height:194)
            if UI_IS_IPONE5 {
                newFrame = CGRect(x:0,y:0,width:k_w,height:194)
            }
            super.frame = newFrame
        }
    }
}
