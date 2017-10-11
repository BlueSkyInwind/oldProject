//
//  AuthenticationCenterCell.swift
//  fxdProduct
//
//  Created by sxp on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class AuthenticationCenterCell: UICollectionViewCell {
    
  @objc  var image: UIImageView?
  @objc  var nameLabel: UILabel?
    
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
        self.contentView.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        image = UIImageView()
        bgView.addSubview(image!)
        image?.snp.makeConstraints({ (make) in
            make.top.equalTo(bgView.snp.top).offset(15)
            make.centerX.equalTo(bgView.snp.centerX)
        })
        
        if UI_IS_IPONE5{
            image?.snp.updateConstraints({ (make) in
                make.top.equalTo(bgView.snp.top).offset(5)
            })
        }
        
        nameLabel = UILabel()
        nameLabel?.textColor = UIColor.black
        nameLabel?.font = UIFont.systemFont(ofSize: 14)
        bgView.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((image?.snp.bottom)!).offset(5)
            make.centerX.equalTo(bgView.snp.centerX)
            make.height.equalTo(20)
        })
    
        let leftLineView = UIView()
        leftLineView.backgroundColor = LINE_COLOR
        bgView.addSubview(leftLineView)
        leftLineView.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.top).offset(0)
            make.right.equalTo(bgView.snp.right).offset(-1)
            make.bottom.equalTo(bgView.snp.bottom).offset(-1)
            make.width.equalTo(1)
        }
        if UI_IS_IPONE5{
        
            leftLineView.isHidden = true
        }
        let bottomLineView = UIView()
        bottomLineView.backgroundColor = LINE_COLOR
        bgView.addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.left).offset(0)
            make.right.equalTo(bgView.snp.right).offset(1)
            make.bottom.equalTo(bgView.snp.bottom).offset(0)
            make.height.equalTo(1)
        }
    }
}
