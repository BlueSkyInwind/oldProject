//
//  FXD_displayAmountCommonHeaderView.swift
//  fxdProduct
//
//  Created by admin on 2017/12/21.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

typealias GOBackACtion = () -> Void
class FXD_displayAmountCommonHeaderView: UIView {
    
    var backGroundImage:UIImageView?
    var centerImage:UIImageView?
    var amountLabel:UILabel?
    var amountTitleLabel:UILabel?
    var hintWordBackImage:UIImageView?
    var hintWordLabel:UILabel?
    var periodLabel:UILabel?
    var periodAmountLabel:UILabel?

    var goBackBtn:UIButton?
    var titleLabel:UILabel?
    var goBack:GOBackACtion?
    
    var amountStr:String?{
        didSet{
            self.amountLabel?.text = amountStr
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    convenience init(frame: CGRect,amount:String) {
        self.init(frame: frame)
        self.amountStr = amount
        self.amountLabel?.text = amount
        self.hintWordLabel?.text = String.init(format: "您当前有%@元可借额度", amount)
    }
    
    convenience init(frame: CGRect,amount:String,periodNum:String,periodAmount:String) {
        self.init(frame: frame)
        self.amountLabel?.text = "¥" + amount
        self.periodLabel?.text = periodNum
        self.periodAmountLabel?.text = periodAmount
        resetUI()
        self.amountTitleLabel?.text = "到账金额"
    }
    
    convenience init(frame: CGRect,amount:String,amountTitle:String,centerImage:String) {
        self.init(frame: frame)
        self.amountLabel?.text = amount
        self.centerImage?.image = UIImage.init(named: centerImage)
        if amountTitle != "" {
            resetUI()
            self.amountTitleLabel?.text = amountTitle
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func goBackAction()  {
        if goBack != nil {
            goBack!()
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

extension FXD_displayAmountCommonHeaderView{
    
    func setUpUI()  {
        
        backGroundImage = UIImageView()
        backGroundImage?.image = UIImage.init(named: "header_Back_Image")
        backGroundImage?.isUserInteractionEnabled = true
        self.addSubview(backGroundImage!)
        backGroundImage?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })

        titleLabel = UILabel()
        titleLabel?.textColor = UIColor.white
        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.font = UIFont.yx_systemFont(ofSize: 17)
        backGroundImage?.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((backGroundImage?.snp.centerX)!)
            make.centerY.equalTo((backGroundImage?.snp.top)!).offset(44)
        })
        
        goBackBtn = UIButton.init(type: UIButtonType.custom)
//     goBackBtn?.setBackgroundImage(UIImage.init(named: "return_white"), for: UIControlState.normal)
        goBackBtn?.setImage(UIImage.init(named: "return_white"), for: UIControlState.normal)
        goBackBtn?.addTarget(self, action: #selector(goBackAction), for: UIControlEvents.touchUpInside)
        backGroundImage?.addSubview(goBackBtn!)
        goBackBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((backGroundImage?.snp.left)!).offset(15)
            make.width.height.equalTo(23)
            make.centerY.equalTo((backGroundImage?.snp.top)!).offset(44)
        })
        
        centerImage = UIImageView()
        centerImage?.image = UIImage.init(named: "circle_center_Image")
        backGroundImage?.addSubview(centerImage!)
        centerImage?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((backGroundImage?.snp.centerX)!)
            make.centerY.equalTo((backGroundImage?.snp.centerY)!).offset(10)
        })
        
        amountLabel = UILabel()
        amountLabel?.text = "¥3000"
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
            make.bottom.equalTo((backGroundImage?.snp.bottom)!).offset(-8)
            make.left.equalTo((backGroundImage?.snp.left)!).offset(20)
            make.right.equalTo((backGroundImage?.snp.right)!).offset(-20)
        })
        
        hintWordLabel = UILabel()
        hintWordLabel?.textAlignment = NSTextAlignment.center
        hintWordLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        hintWordBackImage?.addSubview(hintWordLabel!)
        hintWordLabel?.snp.makeConstraints({ (make) in
            make.center.equalTo((hintWordBackImage?.snp.center)!)
        })
        
        periodLabel = UILabel()
        periodLabel?.textAlignment = NSTextAlignment.left
        periodLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        hintWordBackImage?.addSubview(periodLabel!)
        periodLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((hintWordBackImage?.snp.left)!).offset(10)
            make.centerY.equalTo((hintWordBackImage?.snp.centerY)!)
        })
        
        periodAmountLabel = UILabel()
        periodAmountLabel?.textAlignment = NSTextAlignment.right
        periodAmountLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        hintWordBackImage?.addSubview(periodAmountLabel!)
        periodAmountLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo((hintWordBackImage?.snp.right)!).offset(-10)
            make.centerY.equalTo((hintWordBackImage?.snp.centerY)!)
        })
    }
    
    func resetUI()  {
        
        amountTitleLabel = UILabel()
        amountTitleLabel?.textColor = UIColor.black
        amountTitleLabel?.textAlignment = NSTextAlignment.center
        amountTitleLabel?.font = UIFont.yx_boldSystemFont(ofSize: 13)
        centerImage?.addSubview(amountTitleLabel!)
        amountTitleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((centerImage?.snp.centerX)!)
            make.centerY.equalTo((centerImage?.snp.centerY)!).offset(-15)
        })
        
        amountLabel?.snp.remakeConstraints({ (make) in
            make.centerX.equalTo((centerImage?.snp.centerX)!)
            make.centerY.equalTo((centerImage?.snp.centerY)!).offset(10)
        })
        
        if UI_IS_IPONE6P {
            centerImage?.snp.remakeConstraints({ (make) in
                make.centerX.equalTo((backGroundImage?.snp.centerX)!)
                make.centerY.equalTo((backGroundImage?.snp.centerY)!).offset(10)
                make.width.height.equalTo(110)
            })
        }
    }
}


