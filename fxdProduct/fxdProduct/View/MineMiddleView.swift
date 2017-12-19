//
//  MineMiddleView.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/17.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

@objc protocol MineMiddleViewDelegate: NSObjectProtocol {
    
    //现金红包
    func redPacketViewTap()
    //优惠券
    func couponViewTap()
    //账户余额
    func accountViewTap()
    
}

class MineMiddleView: UIView {

    @objc var couponNumLabel : UILabel?
    @objc var couponImageView : UIImageView?
    @objc weak var delegate: MineMiddleViewDelegate?
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
        
        let redPacketView = MiddleView(imageName: "redPacket", title: "现金红包")
        redPacketView.isUserInteractionEnabled = true
        redPacketView.tag = 101
        let redPacketTap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(gesture:)))
        redPacketView.addGestureRecognizer(redPacketTap)
        
        self.addSubview(redPacketView)
        redPacketView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30)
            make.top.equalTo(self).offset(20)
            make.width.equalTo(60)
            make.height.equalTo(66)
        
        }
        
        let couponView = MiddleView(imageName: "coupon", title: "优惠券")
        couponView.isUserInteractionEnabled = true
        couponView.tag = 102
        
        let couponTap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(gesture:)))
        couponView.addGestureRecognizer(couponTap)
        self.addSubview(couponView)
        couponView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(60)
            make.height.equalTo(66)
            
        }
        couponImageView = UIImageView()
        couponImageView?.image = UIImage(named:"dots")
        couponImageView?.isHidden = true
        couponView.addSubview(couponImageView!)
        couponImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(couponView.snp.right).offset(-22)
            make.top.equalTo(couponView.snp.top).offset(-5)
        })
        
        couponNumLabel = UILabel()
        couponNumLabel?.font = UIFont.systemFont(ofSize: 15)
        couponNumLabel?.textColor = UIColor.white
        couponNumLabel?.isHidden = true
        couponImageView?.addSubview(couponNumLabel!)
        couponNumLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((couponImageView?.snp.centerX)!)
            make.centerY.equalTo((couponImageView?.snp.centerY)!)
            
        })
        
        let accountView = MiddleView(imageName: "account", title: "账户余额")
        accountView.isUserInteractionEnabled = true
        accountView.tag = 103
        let accountTap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(gesture:)))
        accountView.addGestureRecognizer(accountTap)
        self.addSubview(accountView)
        accountView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-30)
            make.top.equalTo(self).offset(20)
            make.width.equalTo(60)
            make.height.equalTo(66)
            
        }

    }
    
    @objc func handleTapGesture(gesture: UIPanGestureRecognizer) {
        
        let tag = gesture.view?.tag
        switch tag {
        case 101?:
            if delegate != nil {
                
                delegate?.redPacketViewTap()
            }
            print("点击了现金红包")
        case 102?:
            if delegate != nil {
                
                delegate?.couponViewTap()
            }
            print("点击了优惠券")
        case 103?:
            if delegate != nil {
                
                delegate?.accountViewTap()
            }
            print("点击账户余额")
        default:
            break
        }
    }

    
    fileprivate func MiddleView(imageName: String, title: String)->UIView{
        
        let bgView = UIView()
        
        let couponImageV = UIImageView()
        couponImageV.image = UIImage(named:imageName)
        bgView.addSubview(couponImageV)
        couponImageV.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgView.snp.centerX)
            make.top.equalTo(bgView.snp.top).offset(0)
        }
        
        let couponLabel = UILabel()
        couponLabel.text = title
        couponLabel.font = UIFont.systemFont(ofSize: 15)
        bgView.addSubview(couponLabel)
        couponLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgView.snp.centerX)
            make.top.equalTo(couponImageV.snp.bottom).offset(10)
            make.height.equalTo(14)
        }
        
        return bgView
        
    }
    override var  frame:(CGRect){
        
        didSet{
            let k_w = UIScreen.main.bounds.size.width
            let newFrame = CGRect(x:0,y:180,width:k_w,height:108)
            super.frame = newFrame
            
        }
    }
}
