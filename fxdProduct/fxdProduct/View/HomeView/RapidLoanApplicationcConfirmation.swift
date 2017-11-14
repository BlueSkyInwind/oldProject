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
    
}

class RapidLoanApplicationcConfirmation: UIView{
    
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
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RapidLoanApplicationcConfirmation{
    
    fileprivate func setupUI(){
        
        titleImageView = UIImageView()
        self.addSubview(titleImageView!)
        titleImageView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(32)
            make.centerX.equalTo(self.snp.centerX)
        })
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.systemFont(ofSize: 22)
        titleLabel?.textColor = TITLE_COLOR
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((titleImageView?.snp.bottom)!).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(22)
        })
        
        qutoaLabel = UILabel()
        qutoaLabel?.font = UIFont.systemFont(ofSize: 14)
        qutoaLabel?.textColor = QUTOA_COLOR
        self.addSubview(qutoaLabel!)
        qutoaLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(25)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(20)
        })
        
        termLabel = UILabel()
        termLabel?.font = UIFont.systemFont(ofSize: 14)
        termLabel?.textColor = QUTOA_COLOR
        self.addSubview(termLabel!)
        termLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((qutoaLabel?.snp.bottom)!).offset(15)
            make.left.equalTo((qutoaLabel?.snp.left)!).offset(0)
            make.height.equalTo(20)
        })
        
        //选择资金方视图
        let capitalSourceView = UIView()
        capitalSourceView.layer.cornerRadius = 5.0
        capitalSourceView.layer.masksToBounds = true
        capitalSourceView.layer.borderWidth = 1
        capitalSourceView.layer.borderColor = UI_MAIN_COLOR.cgColor
        self.addSubview(capitalSourceView)
        capitalSourceView.snp.makeConstraints { (make) in
            make.top.equalTo((termLabel?.snp.bottom)!).offset(60)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(50)
        }
        
        //选择资金方按钮
        let capitalSourceBtn = UIButton()
        capitalSourceBtn.setBackgroundImage(UIImage(named:"icon_xiajiatou"), for: .normal)
        capitalSourceBtn.addTarget(self, action: #selector(capitalSourceBtnClick), for: .touchUpInside)
        capitalSourceView.addSubview(capitalSourceBtn)
        capitalSourceBtn.snp.makeConstraints { (make) in
            make.top.equalTo(capitalSourceView.snp.top).offset(0)
            make.right.equalTo(capitalSourceView.snp.right).offset(0)
            make.height.equalTo(50)
            make.width.equalTo(53)
        }
        
        capitalSourceLabel = UILabel()
        capitalSourceLabel?.font = UIFont.systemFont(ofSize: 16)
        capitalSourceLabel?.textColor = TITLE_COLOR
        capitalSourceView.addSubview(capitalSourceLabel!)
        capitalSourceLabel?.snp.makeConstraints { (make) in
            make.left.equalTo(capitalSourceView.snp.left).offset(20)
            make.right.equalTo(capitalSourceBtn.snp.left).offset(0)
            make.top.equalTo(capitalSourceView.snp.top).offset(0)
            make.height.equalTo(50)
        }
        
        let tipLabel = UILabel()
        tipLabel.font = UIFont.systemFont(ofSize: 12)
        tipLabel.textColor = QUTOA_COLOR
        tipLabel.text = "温馨提示:账单日自动扣款,可能由资金来源方操作。"
        self.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(capitalSourceView.snp.bottom).offset(23)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(0)
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
            make.bottom.equalTo(self).offset(-57)
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

