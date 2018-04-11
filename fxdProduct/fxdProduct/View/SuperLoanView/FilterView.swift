//
//  FilterView.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit


@objc protocol FilterViewDelegate: NSObjectProtocol {
    
    //点击确认按钮
    func sureBtnClick(_ minLoanMoney: String, maxLoanMoney: String, minLoanPeriod: String ,maxLoanPeriod:String)->Void
}

class FilterView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @objc var minLoanMoney : UITextField?
    @objc var maxLoanMoney : UITextField?
    @objc var minLoanPeriod : UITextField?
    @objc var maxLoanPeriod : UITextField?
    @objc weak var delegate: FilterViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterView{
    
    fileprivate func setupUI(){
        
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(180)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.black
        bgView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.left).offset(0)
            make.top.equalTo(bgView.snp.top).offset(0)
            make.right.equalTo(bgView.snp.right).offset(0)
            make.height.equalTo(1)
        }
        
        let loanMoneyLine = UIView()
        loanMoneyLine.backgroundColor = UI_MAIN_COLOR
        bgView.addSubview(loanMoneyLine)
        loanMoneyLine.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.left).offset(24)
            make.top.equalTo(bgView.snp.top).offset(32)
            make.height.equalTo(10)
            make.width.equalTo(2)
        }
        
        let loanMoneyName = UILabel()
        loanMoneyName.text = "借款金额"
        loanMoneyName.textColor = TITLE_COLOR
        loanMoneyName.font = UIFont.yx_systemFont(ofSize: 12)
        bgView.addSubview(loanMoneyName)
        loanMoneyName.snp.makeConstraints { (make) in
            make.left.equalTo(loanMoneyLine.snp.right).offset(6)
            make.top.equalTo(loanMoneyLine.snp.top).offset(-5)
        }
        
        minLoanMoney = UITextField()
        minLoanMoney?.placeholder = "最小金额"
        minLoanMoney?.font = UIFont.yx_systemFont(ofSize: 11)
        minLoanMoney?.keyboardType = .numberPad
        bgView.addSubview(minLoanMoney!)
        minLoanMoney?.snp.makeConstraints { (make) in
            make.left.equalTo(loanMoneyName.snp.right).offset(44)
            make.top.equalTo(bgView.snp.top).offset(25)
            make.width.equalTo(60)
        }
        
        let minMoneyLine = UIView()
        minMoneyLine.backgroundColor = QUTOA_COLOR
        bgView.addSubview(minMoneyLine)
        minMoneyLine.snp.makeConstraints { (make) in
            make.left.equalTo((minLoanMoney?.snp.left)!).offset(0)
            make.top.equalTo((minLoanMoney?.snp.bottom)!).offset(0)
            make.height.equalTo(1)
            make.width.equalTo(60)
        }
        
        let symbol = UILabel()
        symbol.text = "~"
        symbol.textColor = QUTOA_COLOR
        symbol.font = UIFont.yx_systemFont(ofSize: 12)
        bgView.addSubview(symbol)
        symbol.snp.makeConstraints { (make) in
            make.left.equalTo((minLoanMoney?.snp.right)!).offset(15)
            make.top.equalTo(bgView.snp.top).offset(25)
        }
        
        maxLoanMoney = UITextField()
        maxLoanMoney?.placeholder = "最大金额"
        maxLoanMoney?.font = UIFont.yx_systemFont(ofSize: 11)
        maxLoanMoney?.keyboardType = .numberPad
        bgView.addSubview(maxLoanMoney!)
        maxLoanMoney?.snp.makeConstraints { (make) in
            make.left.equalTo(symbol.snp.right).offset(15)
            make.top.equalTo(bgView.snp.top).offset(25)
            make.width.equalTo(60)
        }
        
        let maxMoneyLine = UIView()
        maxMoneyLine.backgroundColor = QUTOA_COLOR
        bgView.addSubview(maxMoneyLine)
        maxMoneyLine.snp.makeConstraints { (make) in
            make.left.equalTo((maxLoanMoney?.snp.left)!).offset(0)
            make.top.equalTo((maxLoanMoney?.snp.bottom)!).offset(0)
            make.height.equalTo(1)
            make.width.equalTo(60)
        }
        
        let unit = UILabel()
        unit.text = "元"
        unit.textColor = QUTOA_COLOR
        unit.font = UIFont.yx_systemFont(ofSize: 11)
        bgView.addSubview(unit)
        unit.snp.makeConstraints { (make) in
            make.left.equalTo(maxMoneyLine.snp.right).offset(5)
            make.top.equalTo(bgView.snp.top).offset(28)
        }
        
        let line = UIView()
        line.backgroundColor = UIColor.black
        bgView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.left).offset(15)
            make.top.equalTo(unit.snp.bottom).offset(28)
            make.right.equalTo(bgView.snp.right).offset(-25)
            make.height.equalTo(1)
        }
        
        let loanPeriodLine = UIView()
        loanPeriodLine.backgroundColor = UI_MAIN_COLOR
        bgView.addSubview(loanPeriodLine)
        loanPeriodLine.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.left).offset(24)
            make.top.equalTo(line.snp.bottom).offset(33)
            make.height.equalTo(10)
            make.width.equalTo(2)
        }
        
        let loanPeriodName = UILabel()
        loanPeriodName.text = "借款周期"
        loanPeriodName.textColor = TITLE_COLOR
        loanPeriodName.font = UIFont.yx_systemFont(ofSize: 12)
        bgView.addSubview(loanPeriodName)
        loanPeriodName.snp.makeConstraints { (make) in
            make.left.equalTo(loanPeriodLine.snp.right).offset(6)
            make.top.equalTo(loanPeriodLine.snp.top).offset(-5)
        }
        
        minLoanPeriod = UITextField()
        minLoanPeriod?.placeholder = "最短周期"
        minLoanPeriod?.font = UIFont.yx_systemFont(ofSize: 11)
        minLoanPeriod?.keyboardType = .numberPad
        bgView.addSubview(minLoanPeriod!)
        minLoanPeriod?.snp.makeConstraints { (make) in
            make.left.equalTo(loanPeriodName.snp.right).offset(44)
            make.top.equalTo(loanPeriodName.snp.top).offset(-5)
            make.width.equalTo(60)
        }
        
        let minPeriodLine = UIView()
        minPeriodLine.backgroundColor = QUTOA_COLOR
        bgView.addSubview(minPeriodLine)
        minPeriodLine.snp.makeConstraints { (make) in
            make.left.equalTo((minLoanPeriod?.snp.left)!).offset(0)
            make.top.equalTo((minLoanPeriod?.snp.bottom)!).offset(0)
            make.height.equalTo(1)
            make.width.equalTo(60)
        }
        
        let symbol1 = UILabel()
        symbol1.text = "~"
        symbol1.textColor = QUTOA_COLOR
        symbol1.font = UIFont.yx_systemFont(ofSize: 12)
        bgView.addSubview(symbol1)
        symbol1.snp.makeConstraints { (make) in
            make.left.equalTo((minLoanPeriod?.snp.right)!).offset(15)
            make.top.equalTo(line.snp.bottom).offset(30)
        }
        
        maxLoanPeriod = UITextField()
        maxLoanPeriod?.placeholder = "最长周期"
        maxLoanPeriod?.font = UIFont.yx_systemFont(ofSize: 11)
        maxLoanPeriod?.keyboardType = .numberPad
        bgView.addSubview(maxLoanPeriod!)
        maxLoanPeriod?.snp.makeConstraints { (make) in
            make.left.equalTo(symbol1.snp.right).offset(15)
            make.top.equalTo((minLoanPeriod?.snp.top)!).offset(0)
            make.width.equalTo(60)
        }
        
        let maxPeriodLine = UIView()
        maxPeriodLine.backgroundColor = QUTOA_COLOR
        bgView.addSubview(maxPeriodLine)
        maxPeriodLine.snp.makeConstraints { (make) in
            make.left.equalTo((maxLoanPeriod?.snp.left)!).offset(0)
            make.top.equalTo((maxLoanPeriod?.snp.bottom)!).offset(0)
            make.height.equalTo(1)
            make.width.equalTo(60)
        }
        
        let unit1 = UILabel()
        unit1.text = "天"
        unit1.textColor = QUTOA_COLOR
        unit1.font = UIFont.yx_systemFont(ofSize: 11)
        bgView.addSubview(unit1)
        unit1.snp.makeConstraints { (make) in
            make.left.equalTo(maxPeriodLine.snp.right).offset(5)
            make.top.equalTo(line.snp.bottom).offset(30)
        }
        
        let bottomView = UIView()
        bgView.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.left).offset(0)
            make.right.equalTo(bgView.snp.right).offset(0)
            make.top.equalTo(bgView.snp.bottom).offset(-32)
            make.height.equalTo(32)
        }
        
        let resetBtn = UIButton()
        resetBtn.setTitle("重置", for: .normal)
        resetBtn.setTitleColor(TITLE_COLOR, for: .normal)
        resetBtn.backgroundColor = UIColor.init(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1)
        resetBtn.titleLabel?.font = UIFont.yx_systemFont(ofSize: 13)
        resetBtn.addTarget(self, action: #selector(resetBtnClick), for: .touchUpInside)
        bottomView.addSubview(resetBtn)
        resetBtn.snp.makeConstraints { (make) in
            make.left.equalTo(bottomView.snp.left).offset(0)
            make.top.equalTo(bottomView.snp.top).offset(0)
            make.bottom.equalTo(bottomView.snp.bottom).offset(0)
            make.width.equalTo(_k_w / 2)
        }
        
        let sureBtn = UIButton()
        sureBtn.setTitleColor(UIColor.white, for: .normal)
        sureBtn.setTitle("确认", for: .normal)
        sureBtn.backgroundColor = UI_MAIN_COLOR
        sureBtn.titleLabel?.font = UIFont.yx_systemFont(ofSize: 13)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        bottomView.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { (make) in
            make.right.equalTo(bottomView.snp.right).offset(0)
            make.top.equalTo(bottomView.snp.top).offset(0)
            make.bottom.equalTo(bottomView.snp.bottom).offset(0)
            make.width.equalTo(_k_w / 2)
        }
    }
    
    override var  frame:(CGRect){
        
        didSet{
            
            let newFrame = CGRect(x:0,y:360,width:_k_w,height:_k_h - 360)
            super.frame = newFrame
            
        }
    }
}

extension FilterView{
    
    @objc fileprivate func resetBtnClick(){
        
        minLoanMoney?.text = ""
        maxLoanMoney?.text = ""
        minLoanPeriod?.text = ""
        maxLoanPeriod?.text = ""
    }
    
    @objc fileprivate func sureBtnClick(){
        
        if delegate != nil {
            delegate?.sureBtnClick((minLoanMoney?.text)!, maxLoanMoney: (maxLoanMoney?.text)!, minLoanPeriod: (minLoanPeriod?.text)!, maxLoanPeriod: (maxLoanPeriod?.text)!)
        }
    }
}
