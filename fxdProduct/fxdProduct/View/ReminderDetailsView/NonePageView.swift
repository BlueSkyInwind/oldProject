//
//  NoneView.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/24.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class NonePageView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
//        DefaultUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension NonePageView{
    
     func ReminderUI(){
        
        let imageView = UIImageView()
        imageView.image = UIImage(named:"5_shenhe_icon_03")
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self).offset(164)
        }
        
        let content = UILabel()
        content.text = "当前无记录"
        content.textColor = UI_MAIN_COLOR
        content.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(content)
        content.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(60)
        }
    }
    
    func DefaultUI(){
        
        let imageView = UIImageView()
        imageView.image = UIImage(named:"my-logo")
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self).offset(164)
        }
        
        let content = UILabel()
        content.text = "当前无记录"
        content.textColor = UIColor.init(red: 180/255.0, green: 180/255.0, blue: 181/255.0, alpha: 1.0)
        content.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(content)
        content.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(60)
        }
    }
    
    override var  frame:(CGRect){
        didSet{
            
            super.frame = CGRect(x:0,y:0,width:_k_w,height:_k_h)
            
        }
    }
}
