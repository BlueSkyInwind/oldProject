//
//  CurrentInformationHeadView.swift
//  fxdProduct
//
//  Created by sxp on 2017/8/31.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class CurrentInformationHeadView: UIView {

    var titleLabel: UILabel?
    var moneyDescLabel: UILabel?
    var moneyLabel: UILabel?
    
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

extension CurrentInformationHeadView{

    fileprivate func setupUI(){
    
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named:""), for: .normal)
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(30)
            make.left.equalTo(self).offset(20)
        }
        
        titleLabel = UILabel()
        titleLabel?.textColor = UIColor.white
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        titleLabel?.textAlignment = .center
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(30)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(20)
        })
        
        moneyDescLabel = UILabel()
        moneyDescLabel?.textColor = UIColor.white
        moneyDescLabel?.font = UIFont.systemFont(ofSize: 15)
        moneyDescLabel?.textAlignment = .center
        self.addSubview(moneyDescLabel!)
        moneyDescLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(40)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(20)
        })
        
        moneyLabel = UILabel()
        moneyLabel?.textColor = UIColor.white
        moneyLabel?.font = UIFont.systemFont(ofSize: 20)
        moneyLabel?.textAlignment = .center
        self.addSubview(moneyLabel!)
        moneyLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((moneyDescLabel?.snp.bottom)!).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(30)
        })
    }
}

extension CurrentInformationHeadView{

    func back(){
    
    }
}
