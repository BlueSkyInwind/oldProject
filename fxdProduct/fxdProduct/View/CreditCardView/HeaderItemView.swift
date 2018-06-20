//
//  HeaderItemView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/20.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

typealias ItemClick = (_ button:UIButton,_ isOpen:Bool) -> Void
class HeaderItemView: UIView {

    var  titleBtn:UIButton?
    var  iconView:UIImageView?
    var itemClick:ItemClick?
    
    var isOpen:Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func titleBtnClick(sender:UIButton) {
        if itemClick != nil {
            isOpen != isOpen
            itemClick!(sender,isOpen)
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

extension HeaderItemView {
    
    func configureView()  {
        
        titleBtn = UIButton.init(type: UIButtonType.custom)
        titleBtn?.setTitleColor("4D4D4D".uiColor(), for: UIControlState.normal)
        titleBtn?.setTitle("手机充值", for: UIControlState.normal)
        titleBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 13)
        titleBtn?.addTarget(self, action: #selector(titleBtnClick(sender:)), for: UIControlEvents.touchUpInside)
        self.addSubview(titleBtn!)
        titleBtn?.snp.makeConstraints({ (make) in
            make.center.equalTo(self.snp.center)
        })
        
        iconView = UIImageView()
        iconView?.image = UIImage.init(named: "up_arrow_Icon")
        self.addSubview(iconView!)
        iconView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(10)
        })
    }
    
    
    
}


