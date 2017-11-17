//
//  RapidLoanApplicationcConfirmation.swift
//  fxdProduct
//
//  Created by sxp on 2017/9/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

@objc protocol RapidLoanApplicationcConfirmationDelegate: NSObjectProtocol {
    
    func commitBtn()

    func capitalSourceBtn()
    
    func showChooseAmountView()
    
    func showDirectionsForUse()

}

class RapidLoanApplicationcConfirmation: UIView,DiscountCouponsViewDelegate{
    
    //标题
    var titleLabel : UILabel?
    //额度
    var qutoaLabel : UILabel?
    //期限
    var termLabel : UILabel?
    //标题图片
    var titleImageView : UIImageView?
    //资金方名字
    var capitalSourceLabel : UILabel?
    
    var headerView : UIView?
    var bottomView : UIView?
    //选择资金方视图
    var capitalSourceView : UIView?
    //提额券视图
    var discountCouponsV:DiscountCouponsView?
    
    weak var delegate: RapidLoanApplicationcConfirmationDelegate?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor =  APPLICATION_backgroundColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addDiscountCoupons(discountTicketDetailM:DiscountTicketDetailModel)  {
        
        var discountCouponsTop = 115
        if UI_IS_IPONE6P {
            discountCouponsTop = 164
        }else if UI_IS_IPONE6 {
            discountCouponsTop = 140
        }else if UI_IS_IPHONEX {
            discountCouponsTop = 164
        }
        
        discountCouponsV = DiscountCouponsView();
        discountCouponsV?.backgroundColor = APPLICATION_backgroundColor
        discountCouponsV?.delegate = self
        discountCouponsV?.amountLabel?.text = "+￥" + "\(discountTicketDetailM.total_amount ?? "")"
        self.addSubview(discountCouponsV!)
        discountCouponsV?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.top.equalTo((headerView?.snp.bottom)!).offset(0)
            make.height.equalTo(discountCouponsTop)
        })
        
        bottomView?.snp.remakeConstraints({ (make) in
            make.top.equalTo((discountCouponsV?.snp.bottom)!).offset(0)
            make.left.equalTo((self.snp.left)).offset(0)
            make.right.equalTo((self.snp.right)).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(-70)
        })
        
        titleImageView?.snp.updateConstraints({ (make) in
            make.top.equalTo((headerView?.snp.top)!).offset(20)
        })
        headerView?.snp.updateConstraints({ (make) in
            make.height.equalTo(210)
        })
    }
    
    func pushChooseAmountView()  {
        if delegate != nil {
            delegate?.showChooseAmountView()
        }
    }
    func pushDirectionsForUse() {
        if delegate != nil {
            delegate?.showDirectionsForUse()
        }
    }
    
}

extension RapidLoanApplicationcConfirmation{
    
    fileprivate func setupUI(){
        
        headerView = UIView()
        headerView?.backgroundColor = UIColor.white
        self.addSubview(headerView!)
        headerView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(0)
            make.left.right.equalTo(self).offset(0)
            make.height.equalTo(230)
        })
        
        titleImageView = UIImageView()
        headerView?.addSubview(titleImageView!)
        titleImageView?.snp.makeConstraints({ (make) in
            make.top.equalTo((headerView?.snp.top)!).offset(32)
            make.centerX.equalTo((headerView?.snp.centerX)!)
        })
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.systemFont(ofSize: 22)
        titleLabel?.textColor = TITLE_COLOR
        headerView?.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((titleImageView?.snp.bottom)!).offset(10)
            make.centerX.equalTo((headerView?.snp.centerX)!)
            make.height.equalTo(22)
        })
        
        qutoaLabel = UILabel()
        qutoaLabel?.font = UIFont.systemFont(ofSize: 14)
        qutoaLabel?.textColor = QUTOA_COLOR
        headerView?.addSubview(qutoaLabel!)
        qutoaLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(25)
            make.centerX.equalTo((headerView?.snp.centerX)!)
            make.height.equalTo(20)
        })
        
        termLabel = UILabel()
        termLabel?.font = UIFont.systemFont(ofSize: 14)
        termLabel?.textColor = QUTOA_COLOR
        headerView?.addSubview(termLabel!)
        termLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((qutoaLabel?.snp.bottom)!).offset(5)
            make.left.equalTo((qutoaLabel?.snp.left)!).offset(0)
            make.height.equalTo(20)
        })
        
        bottomView = UIView()
        bottomView?.backgroundColor = UIColor.white
        self.addSubview(bottomView!)
        bottomView?.snp.makeConstraints({ (make) in
            make.top.equalTo((headerView?.snp.bottom)!).offset(0)
            make.left.equalTo((self.snp.left)).offset(0)
            make.right.equalTo((self.snp.right)).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(-80)
        })
        
        //选择资金方视图
        capitalSourceView = UIView()
        capitalSourceView?.layer.cornerRadius = 5.0
        capitalSourceView?.layer.masksToBounds = true
        capitalSourceView?.layer.borderWidth = 1
        capitalSourceView?.layer.borderColor = UI_MAIN_COLOR.cgColor
        bottomView?.addSubview(capitalSourceView!)
        capitalSourceView?.snp.makeConstraints { (make) in
            make.top.equalTo((bottomView?.snp.top)!).offset(10)
            make.left.equalTo((bottomView?.snp.left)!).offset(20)
            make.right.equalTo((bottomView?.snp.right)!).offset(-20)
            make.height.equalTo(50)
        }
        
        //选择资金方按钮
        let capitalSourceBtn = UIButton()
        capitalSourceBtn.setBackgroundImage(UIImage(named:"icon_xiajiatou"), for: .normal)
        capitalSourceBtn.addTarget(self, action: #selector(capitalSourceBtnClick), for: .touchUpInside)
        capitalSourceView?.addSubview(capitalSourceBtn)
        capitalSourceBtn.snp.makeConstraints { (make) in
            make.top.equalTo((capitalSourceView?.snp.top)!).offset(0)
            make.right.equalTo((capitalSourceView?.snp.right)!).offset(0)
            make.height.equalTo(50)
            make.width.equalTo(53)
        }
        
        capitalSourceLabel = UILabel()
        capitalSourceLabel?.font = UIFont.systemFont(ofSize: 16)
        capitalSourceLabel?.textColor = TITLE_COLOR
        capitalSourceView?.addSubview(capitalSourceLabel!)
        capitalSourceLabel?.snp.makeConstraints { (make) in
            make.left.equalTo((capitalSourceView?.snp.left)!).offset(20)
            make.right.equalTo(capitalSourceBtn.snp.left).offset(0)
            make.top.equalTo((capitalSourceView?.snp.top)!).offset(0)
            make.height.equalTo(50)
        }
        
        let tipLabel = UILabel()
        tipLabel.font = UIFont.systemFont(ofSize: 12)
        tipLabel.textColor = QUTOA_COLOR
        tipLabel.text = "温馨提示:账单日自动扣款,可能由资金来源方操作。"
        bottomView?.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo((capitalSourceView?.snp.bottom)!).offset(5)
            make.left.equalTo((bottomView?.snp.left)!).offset(20)
            make.right.equalTo((bottomView?.snp.right)!).offset(0)
            make.height.equalTo(20)
        }
        
        let bottomBtn = UIButton()
        bottomBtn.setTitle("确认申请", for: .normal)
        bottomBtn.setTitleColor(UIColor.white, for: .normal)
        bottomBtn.backgroundColor = UI_MAIN_COLOR
        bottomBtn.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        bottomBtn.layer.cornerRadius = 5.0
        bottomBtn.addTarget(self, action: #selector(bottomBtnClick), for: .touchUpInside)
        self.addSubview(bottomBtn)
        bottomBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-20)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(50)
        }
        
    }
}

//MARK 点击事件
extension RapidLoanApplicationcConfirmation{
    
    //MARK 选择资金来源
    @objc fileprivate func capitalSourceBtnClick(){
        
        if delegate != nil {
            
            delegate?.capitalSourceBtn()
        }
        print("选择资金来源")
        
    }
    
    //MARK 点击确认申请
    @objc fileprivate func bottomBtnClick(){
        
        if delegate != nil {
            
            delegate?.commitBtn()

        }
        print("点击确认申请")
    }
    
    override var  frame:(CGRect){
        
        didSet{
            
            let newFrame = CGRect(x:0,y:64,width:_k_w,height:_k_h-64)
            super.frame = newFrame
            
        }
    }
}

