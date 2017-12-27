//
//  HomeOverdueFeesRulesPopView.swift
//  fxdProduct
//
//  Created by sxp on 2017/12/27.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class HomeOverdueFeesRulesPopView: UIView {

    var bgView : UIView?
    
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

extension HomeOverdueFeesRulesPopView{
    
    fileprivate func setupUI(){
        
//        bgView = UIView()
//        bgView?.backgroundColor = UIColor.black
//        bgView?.alpha = 0.4
//        self.addSubview(bgView!)
//        bgView?.snp.makeConstraints({ (make) in
//
//        })
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 5.0
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        let topImageView = UIImageView()
        topImageView.image = UIImage(named:"")
        bgView.addSubview(topImageView)
        topImageView.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.top).offset(0)
            make.left.equalTo(bgView.snp.left).offset(0)
            
        }
        
    
    }
}
