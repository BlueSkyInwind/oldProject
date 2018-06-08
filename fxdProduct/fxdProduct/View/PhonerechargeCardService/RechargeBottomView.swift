//
//  RechargeBottomView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

typealias RechargeButtonClick = () -> Void
typealias RechargeTransferButtonClick = () -> Void
class RechargeBottomView: UIView {
    
    var rechargeBtn:UIButton?
    var rechargeTransferBtn:UIButton?
    
    var rechargeClick:RechargeButtonClick?
    var rechargeTransferClick:RechargeTransferButtonClick?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    @objc func rechargeBtnClick() {
        if rechargeClick != nil {
            rechargeClick!()
        }
    }
    
    @objc func rechargeTransferBtnClick() {
        if rechargeTransferClick != nil {
            rechargeTransferClick!()
        }
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

extension RechargeBottomView {
    
    func setUpUI()  {
        rechargeBtn = UIButton.init(type: UIButtonType.custom)
        rechargeBtn?.setBackgroundImage(UIImage.init(named: "recharge_button_card"), for: UIControlState.normal)
        rechargeBtn?.setTitleColor(UIColor.black, for: UIControlState.normal)
        rechargeBtn?.setTitle("手机充值", for: UIControlState.normal)
        rechargeBtn?.changeTitleTopInsets(4)
        rechargeBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        rechargeBtn?.addTarget(self, action: #selector(rechargeBtnClick), for: UIControlEvents.touchUpInside)
        self.addSubview(rechargeBtn!)
        rechargeBtn?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX).offset(-90)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        rechargeTransferBtn = UIButton.init(type: UIButtonType.custom)
        rechargeTransferBtn?.setBackgroundImage(UIImage.init(named: "recharge_button_card"), for: UIControlState.normal)
        rechargeTransferBtn?.setTitle("充值卡转让", for: UIControlState.normal)
        rechargeTransferBtn?.changeTitleTopInsets(4)
        rechargeTransferBtn?.setTitleColor(UIColor.black, for: UIControlState.normal)
        rechargeTransferBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        rechargeTransferBtn?.addTarget(self, action: #selector(rechargeTransferBtnClick), for: UIControlEvents.touchUpInside)
        self.addSubview(rechargeTransferBtn!)
        rechargeTransferBtn?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX).offset(90)
            make.centerY.equalTo(self.snp.centerY)
        })
    }
}

