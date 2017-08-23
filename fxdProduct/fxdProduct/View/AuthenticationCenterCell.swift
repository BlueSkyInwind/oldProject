//
//  AuthenticationCenterCell.swift
//  fxdProduct
//
//  Created by sxp on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class AuthenticationCenterCell: UICollectionViewCell {
    
    var image: UIImageView?
    var nameLabel: UILabel?
    var completeImage : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthenticationCenterCell{

    fileprivate func setupUI(){
    
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        image = UIImageView()
        bgView.addSubview(image!)
        image?.snp.makeConstraints({ (make) in
            make.top.equalTo(bgView.snp.top).offset(5)
            make.centerX.equalTo(bgView.snp.centerX)
        })
        
        nameLabel = UILabel()
        nameLabel?.textColor = UIColor.black
        nameLabel?.font = UIFont.systemFont(ofSize: 15)
        bgView.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((image?.snp.bottom)!).offset(5)
            make.centerX.equalTo(bgView.snp.centerX)
            make.height.equalTo(20)
        })
        
        completeImage = UIImageView()
        completeImage?.image = UIImage(named:"")
        bgView.addSubview(completeImage!)
        completeImage?.snp.makeConstraints({ (make) in
            make.top.equalTo(bgView.snp.top).offset(10)
            make.right.equalTo(bgView.snp.right).offset(-10)
        })
    }
}
