//
//  SupermarketCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/5/25.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc protocol SupermarketCellDelegate: NSObjectProtocol {
    
    //收藏
    func collectionBtn(_ sender: UIButton)
}

class SupermarketCell: UICollectionViewCell {
    
    @objc var leftImageView : UIImageView?
    @objc var titleLabel : UILabel?
    @objc var collectionBtn : UIButton?
    @objc weak var delegate: SupermarketCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        
        leftImageView = UIImageView()
        self.addSubview(leftImageView!)
        leftImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(27)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(50)
            make.height.equalTo(50)
        })
    
        titleLabel = UILabel()
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((leftImageView?.snp.right)!).offset(25)
            make.top.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-10)
        })
        
        collectionBtn = UIButton()
        collectionBtn?.addTarget(self, action: #selector(collectionBtnClick(_:)), for: .touchUpInside)
        self.addSubview(collectionBtn!)
        collectionBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((leftImageView?.snp.right)!).offset(31)
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(9)
        })
    }
    
    @objc fileprivate func collectionBtnClick(_ sender : UIButton){
        
        if delegate != nil{
            delegate?.collectionBtn(sender)
        }
    }
}
