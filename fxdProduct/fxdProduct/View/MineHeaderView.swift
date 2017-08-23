//
//  MineHeaderView.swift
//  fxdProduct
//
//  Created by sxp on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class MineHeaderView: UIView {

    var nameLabel : UILabel?
    var accountLabel : UILabel?
    
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

extension MineHeaderView{

    fileprivate func setupUI(){
    
        let leftImage = UIImageView()
        leftImage.image = UIImage(named:"3_lc_icon_15")
        self.addSubview(leftImage)
        leftImage.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-20)
        }
        
        let headLabel = UILabel()
        headLabel.text = "我的"
        headLabel.textColor = UIColor.white
        headLabel.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(headLabel)
        headLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(35)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(20)
        }
        
        nameLabel = UILabel()
        nameLabel?.textColor = UIColor.white
        nameLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(80)
            make.left.equalTo(leftImage.snp.right).offset(30)
            make.height.equalTo(15)
        })
        
        accountLabel = UILabel()
        accountLabel?.textColor = UIColor.white
        accountLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(accountLabel!)
        accountLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((nameLabel?.snp.bottom)!).offset(10)
            make.left.equalTo(leftImage.snp.right).offset(30)
            make.height.equalTo(15)
        })
        
    }
    
    override var  frame:(CGRect){
        
        didSet{
            let k_w = UIScreen.main.bounds.size.width
            let newFrame = CGRect(x:0,y:0,width:k_w,height:150)
            super.frame = newFrame
            
        }
    }
    
}
