//
//  FXD_LoanApplicationHeaderView.swift
//  fxdProduct
//
//  Created by admin on 2017/12/21.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class FXD_LoanApplicationHeaderView: UIView {
    
    var backGroundImage:UIImageView?
    var centerImage:UIImageView?
    var amountLabel:UILabel?
    var hintWordBackImage:UIImageView?
    var hintWordLabel:UILabel?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    convenience init(frame: CGRect,amount:String) {
        self.init(frame: frame)
        self.amountLabel?.text = amount
        self.hintWordLabel?.text = String.init(format: "您当前有%@元可借额度", amount)
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

extension FXD_LoanApplicationHeaderView{
    
    func setUpUI()  {
        
        backGroundImage = UIImageView()
        backGroundImage?.image = UIImage.init(named: "header_Back_Image")
        self.addSubview(backGroundImage!)
        backGroundImage?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        
        centerImage = UIImageView()
        centerImage?.image = UIImage.init(named: "circle_center_Image")
        backGroundImage?.addSubview(centerImage!)
        centerImage?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((backGroundImage?.snp.centerX)!)
            make.centerY.equalTo((backGroundImage?.snp.centerY)!).offset(50)
        })
        
        amountLabel = UILabel()
        amountLabel?.text = "3000"
        amountLabel?.textColor = AMOUNT_COLOR
        amountLabel?.textAlignment = NSTextAlignment.center
        amountLabel?.font = UIFont.yx_systemFont(ofSize: 25)
        centerImage?.addSubview(amountLabel!)
        amountLabel?.snp.makeConstraints({ (make) in
            make.center.equalTo((centerImage?.snp.center)!)
        })
        
        hintWordBackImage = UIImageView()
        hintWordBackImage?.image = UIImage.init(named: "hintWord_Back_Image")
        backGroundImage?.addSubview(hintWordBackImage!)
        hintWordBackImage?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((backGroundImage?.snp.centerX)!)
            make.bottom.equalTo((backGroundImage?.snp.top)!).offset(-8)
        })
        
        hintWordLabel = UILabel()
        hintWordLabel?.text = "您当前有3000元可借额度"
        hintWordLabel?.textAlignment = NSTextAlignment.center
        hintWordLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        hintWordBackImage?.addSubview(hintWordLabel!)
        hintWordLabel?.snp.makeConstraints({ (make) in
            make.center.equalTo((hintWordBackImage?.snp.center)!)
        })
        
    }
}


