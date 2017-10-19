//
//  DiscountCouponsView.swift
//  fxdProduct
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

@objc protocol DiscountCouponsViewDelegate: NSObjectProtocol {
    
    func pushDirectionsForUse()
    
    func pushChooseAmountView()
    
}

class DiscountCouponsView: UIView {

    var backImageView:UIImageView?
    var arrowIcon:UIButton?
    var titleLabel:UILabel?
   @objc var amountLabel:UILabel?
    var directionsForUseBtn:UIButton?
    @objc var delegate : DiscountCouponsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setUpUI()
    }
    
//    convenience init(vc:UIViewController){
//        self = self.init(frame: CGRect.zero);
//        self.backgroundColor
//        vc.view.addSubview(self)
//        self.snp.makeConstraints { (make) in
//
//        }
//    }
    
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

extension DiscountCouponsView{
    
    func setUpUI() -> Void {
    
        backImageView = UIImageView.init(image: UIImage.init(named: "applicationCoupons_BackIcon"))
        backImageView?.isUserInteractionEnabled = true
        self.addSubview(backImageView!);
        backImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
        })
        
        let headerView = UIView()
        var tap = UITapGestureRecognizer.init(target: self, action: #selector(pushChooseAmount))
        headerView.addGestureRecognizer(tap)
        self.backImageView?.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.left.equalTo(120)
            make.right.top.equalTo(0)
            make.height.equalTo(self.snp.height).multipliedBy(0.65)
        }
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        titleLabel?.textColor = UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        titleLabel?.text = "使用提额券"
        backImageView?.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(headerView.snp.centerY)
            make.width.equalTo(120)
            make.height.equalTo(30)
        })
        
        arrowIcon = UIButton.init(type: UIButtonType.custom)
        arrowIcon?.setBackgroundImage(UIImage.init(named: "icon_arrowRight"), for: UIControlState.normal)
        headerView.addSubview(arrowIcon!)
        arrowIcon?.snp.makeConstraints({ (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(headerView.snp.centerY)
            make.width.equalTo(18)
            make.height.equalTo(20)
        })
        
        amountLabel = UILabel()
        amountLabel?.font = UIFont.systemFont(ofSize: 25)
        amountLabel?.textColor = UIColor.init(red: 0.93, green: 0.11, blue: 0.14, alpha: 1)
        amountLabel?.text = "+￥200"
        amountLabel?.textAlignment = NSTextAlignment.right
        headerView.addSubview(amountLabel!)
        amountLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo((arrowIcon?.snp.left)!).offset(-10)
            make.centerY.equalTo(headerView.snp.centerY)
            make.width.equalTo(120)
            make.height.equalTo(40)
        })
        
        directionsForUseBtn = UIButton.init(type: UIButtonType.custom)
        directionsForUseBtn?.setTitle("使用说明", for: UIControlState.normal)
        directionsForUseBtn?.setTitleColor(UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1), for: UIControlState.normal)
        directionsForUseBtn?.addTarget(self, action: #selector(directionsForUseClick), for: UIControlEvents.touchUpInside)
        directionsForUseBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.backImageView?.addSubview(directionsForUseBtn!)
        directionsForUseBtn?.snp.makeConstraints({ (make) in
            make.width.equalTo(120)
            make.top.equalTo(headerView.snp.bottom).offset(0)
            make.bottom.equalTo(0)
            make.centerX.equalTo((self.backImageView?.snp.centerX)!)
        })
        
        if UI_IS_IPONE6P {
            titleLabel?.font = UIFont.systemFont(ofSize: 22)
            amountLabel?.font = UIFont.systemFont(ofSize: 30)
            directionsForUseBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        }
    }
    
    @objc func directionsForUseClick() {
        if delegate != nil{
            delegate?.pushDirectionsForUse()
        }
    }
    @objc func pushChooseAmount() {
        if delegate != nil{
            delegate?.pushChooseAmountView()
        }
    }
}




