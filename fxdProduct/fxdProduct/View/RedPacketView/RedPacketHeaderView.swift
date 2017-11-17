//
//  RedPacketHeaderView.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/17.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class RedPacketHeaderView: UIView {

    //用户名字
    @objc var moneyLabel : UILabel?
    
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

extension RedPacketHeaderView{
    fileprivate func setupUI(){
        
        let imageview = UIImageView()
        imageview.image = UIImage(named:"packet")
        self.addSubview(imageview)
        imageview.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self).offset(42)
        }
        
        let name = UILabel()
        name.text = "我的现金"
        name.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(name)
        name.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(imageview.snp.bottom).offset(15)
        }
        
        moneyLabel = UILabel()
        moneyLabel?.textColor = RedPacketMoney_COLOR
        moneyLabel?.font = UIFont.systemFont(ofSize: 25)
        self.addSubview(moneyLabel!)
        moneyLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(name.snp.bottom).offset(26)
            make.height.equalTo(35)
        })
        
        let withdrawBtn = UIButton()
        withdrawBtn.setTitle("提现", for: .normal)
        withdrawBtn.backgroundColor = UI_MAIN_COLOR
        withdrawBtn.setTitleColor(UIColor.white, for: .normal)
        withdrawBtn.layer.cornerRadius = 5.0
        withdrawBtn.addTarget(self, action: #selector(withdrawBtnClick), for: .touchUpInside)
        self.addSubview(withdrawBtn)
        withdrawBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(18)
            make.right.equalTo(self).offset(-18)
            make.height.equalTo(50)
            make.top.equalTo((moneyLabel?.snp.bottom)!).offset(42)
        }
    }
    
    @objc func withdrawBtnClick(){
        
    }
    
    override var  frame:(CGRect){
        
        didSet{
            let k_w = UIScreen.main.bounds.size.width
            let newFrame = CGRect(x:0,y:0,width:k_w,height:335)
            super.frame = newFrame
            
        }
    }
}
