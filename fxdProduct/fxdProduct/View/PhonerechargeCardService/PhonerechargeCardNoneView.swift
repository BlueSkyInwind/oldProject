//
//  NoneView.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/7.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class PhonerechargeCardNoneView: UIView {

    @objc var noneDesc : UILabel?
    
    @objc var noneImageView : UIImageView?
    
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

extension PhonerechargeCardNoneView{
    fileprivate func setupUI(){
        
        noneImageView = UIImageView()
        noneImageView?.image = UIImage.init(named: "none_icon")
        self.addSubview(noneImageView!)
        noneImageView?.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(90)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        noneDesc = UILabel()
        noneDesc?.textColor = RedPacketBottomBtn_COLOR
        noneDesc?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(noneDesc!)
        noneDesc?.snp.makeConstraints({ (make) in
            make.top.equalTo((noneImageView?.snp.bottom)!).offset(40)
            make.centerX.equalTo(self.snp.centerX)
        })
    }
}
