//
//  MineMiddleView.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/17.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class MineMiddleView: UIView {

    var couponNumLabel : UILabel?
    var redPacketNumLabel : UILabel?
    var redPacketImageView : UIImageView?
    var couponImageView : UIImageView?
    
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

extension MineMiddleView{
    fileprivate func setupUI(){
        
        let redPacketImageV = UIImageView()
        redPacketImageV.image = UIImage(named:"")
        self.addSubview(redPacketImageV)
        redPacketImageV.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(42)
            make.top.equalTo(self).offset(19)
        }
        
        redPacketImageView = UIImageView()
        redPacketImageView?.image = UIImage(named:"")
        self.addSubview(redPacketImageView!)
        redPacketImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(69)
            make.top.equalTo(self).offset(15)
        })
        
        redPacketNumLabel = UILabel()
        redPacketNumLabel?.font = UIFont.systemFont(ofSize: 15)
        redPacketNumLabel?.textColor = UIColor.white
        redPacketImageView?.addSubview(redPacketNumLabel!)
        redPacketNumLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((redPacketImageView?.snp.centerX)!)
            make.centerY.equalTo((redPacketImageView?.snp.centerY)!)
        })
        
        
        
        let redPacketLabel = UILabel()
        redPacketLabel.text = "现金红包"
        redPacketLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(redPacketLabel)
        redPacketLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(34)
            make.top.equalTo(redPacketImageV.snp.bottom).offset(10)
            make.height.equalTo(14)
        }
        
    }
}
