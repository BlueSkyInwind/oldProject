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
    @objc var descLabel : UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
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
        nameLabel?.textColor = UIColor.black
        nameLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((nameImageView?.snp.bottom)!).offset(5)
            make.centerX.equalTo(self.snp.centerX)
        })
        
        descLabel = UILabel()
        descLabel?.textColor = QUTOA_COLOR
        descLabel?.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(descLabel!)
        descLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((nameLabel?.snp.bottom)!).offset(5)
            make.centerX.equalTo(self.snp.centerX)
        })
    }
}
