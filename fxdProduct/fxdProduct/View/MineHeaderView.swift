//
//  MineHeaderView.swift
//  fxdProduct
//
//  Created by sxp on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

@objc protocol MineHeaderViewDelegate: NSObjectProtocol {
    
    func bottomBtnClick()
}
class MineHeaderView: UIView {

    //进件状态名称
    @objc var titleLabel : UILabel?
    //还款金额
    @objc var moneyLabel : UILabel?
    //还款日期
    @objc var dateLabel : UILabel?
    //距离还款时间
    @objc var timeBtn : UIButton?
    //底部按钮
    @objc var bottomBtn : UIButton?
    @objc var type : String?{
        didSet(newValue){
            
            setViewType(type: type!)
        }
    }
    
    @objc weak var delegate: MineHeaderViewDelegate?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MineHeaderView{
    fileprivate func setViewType(type : String){
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        let type = Int(type)
        switch type {
        case 2:
            repayUI()
        case 3:
            repaymentConfirmationUI()
        case 1:
            normalUI()
        default:
            normalUI()
        }
    }
}
extension MineHeaderView{
    
    fileprivate func repayUI(){
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage.init(named: "mine_bg_icon")
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        titleLabel = UILabel()
        titleLabel?.text = "待还款"
        titleLabel?.textColor = UIColor.white
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(35)
            make.centerX.equalTo(self.snp.centerX)
        })
        
        if UI_IS_IPHONEX {
            titleLabel?.snp.remakeConstraints({ (make) in
                make.top.equalTo(self).offset(45)
                make.centerX.equalTo(self.snp.centerX)
            })
        }
        moneyLabel = UILabel()
        moneyLabel?.textColor = MINE_MONEY_COLOR
        moneyLabel?.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(moneyLabel!)
        moneyLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(10)
            make.centerX.equalTo(self.snp.centerX)
        })
        
        let timeView = UIView()
        timeView.backgroundColor = UIColor.clear
        self.addSubview(timeView)
        timeView.snp.makeConstraints { (make) in
            make.top.equalTo((moneyLabel?.snp.bottom)!).offset(10)
            make.width.equalTo(210)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(20)
        }
        
        dateLabel = UILabel()
        dateLabel?.textColor = UIColor.white
        dateLabel?.font = UIFont.systemFont(ofSize: 12)
        timeView.addSubview(dateLabel!)
        dateLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(timeView.snp.left).offset(5)
            make.centerY.equalTo(timeView.snp.centerY)
        })
        
        timeBtn = UIButton()
        timeBtn?.setBackgroundImage(UIImage.init(named: "timeBtn_icon"), for: .normal)
        timeBtn?.isHidden = true
        timeBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        timeBtn?.setTitleColor(UIColor.init(red: 93/255.0, green: 141/255.0, blue: 250/255.0, alpha: 1.0), for: .normal)
        timeView.addSubview(timeBtn!)
        timeBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((dateLabel?.snp.right)!).offset(14)
            make.centerY.equalTo(timeView.snp.centerY)
            make.width.equalTo(70)
        })
        
        bottomBtn = UIButton()
        bottomBtn?.titleLabel?.textAlignment = .center
        bottomBtn?.setTitleColor(UIColor.black, for: .normal)
        bottomBtn?.isHidden = true
        bottomBtn?.setBackgroundImage(UIImage.init(named: "bottomBtn_icon"), for: .normal)
        bottomBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        bottomBtn?.setTitle("立即还款", for: .normal)
        bottomBtn?.addTarget(self, action: #selector(bottomBtnClick), for: .touchUpInside)
        self.addSubview(bottomBtn!)
        bottomBtn?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self).offset(-14)
            make.centerX.equalTo(self.snp.centerX)
        })
        
        let bottomLabel = UILabel()
        bottomLabel.text = "立即还款"
        bottomLabel.textColor = UIColor.black
        bottomLabel.font = UIFont.systemFont(ofSize: 14)
        bottomBtn?.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo((bottomBtn?.snp.top)!).offset(5)
            make.centerX.equalTo((bottomBtn?.snp.centerX)!)
        }
        
        
    }
    
    fileprivate func repaymentConfirmationUI(){
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage.init(named: "mine_bg_icon")
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        let titleImageView = UIImageView()
        titleImageView.image = UIImage.init(named: "repay_icon")
        self.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(51)
            make.centerX.equalTo(self.snp.centerX)
        }
        
       let nameLabel = UILabel()
        nameLabel.text = "还款确认中"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleImageView.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    fileprivate func normalUI(){
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage.init(named: "mine_bg_icon")
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        let nameLabel = UILabel()
        nameLabel.text = "多款贷款产品任您选"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(70)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        bottomBtn = UIButton()
//        bottomBtn?.setTitle("查看", for: .normal)
        bottomBtn?.setTitleColor(UIColor.black, for: .normal)
        bottomBtn?.setBackgroundImage(UIImage.init(named: "bottomBtn_icon"), for: .normal)
        bottomBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        bottomBtn?.addTarget(self, action: #selector(bottomBtnClick), for: .touchUpInside)
        self.addSubview(bottomBtn!)
        bottomBtn?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self).offset(-25)
            make.centerX.equalTo(self.snp.centerX)
        })
        
        let bottomLabel = UILabel()
        bottomLabel.text = "查看"
        bottomLabel.textColor = UIColor.black
        bottomLabel.font = UIFont.systemFont(ofSize: 14)
        bottomBtn?.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo((bottomBtn?.snp.top)!).offset(5)
            make.centerX.equalTo((bottomBtn?.snp.centerX)!)
        }
    }
    
    
    @objc fileprivate func bottomBtnClick(){
        
        if delegate != nil {
            delegate?.bottomBtnClick()
        }
    }
}
