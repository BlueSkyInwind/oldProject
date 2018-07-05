//
//  HomeHotCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/15.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class HomeHotCell: UICollectionViewCell {

    @objc var nameImageView : UIImageView?
    @objc var nameLabel : UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeHotCell{
    fileprivate func setupUI(){
        
        nameImageView = UIImageView()
        nameImageView?.layer.cornerRadius = 5.0
        self.addSubview(nameImageView!)
        nameImageView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(45)
            make.height.equalTo(45)
        })
        
        nameLabel = UILabel()
        nameLabel?.textColor = UIColor.init(red: 132/255.0, green: 132/255.0, blue: 132/255.0, alpha: 1.0)
        nameLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((nameImageView?.snp.bottom)!).offset(5)
            make.centerX.equalTo(self.snp.centerX)
        })
    
    }
}
