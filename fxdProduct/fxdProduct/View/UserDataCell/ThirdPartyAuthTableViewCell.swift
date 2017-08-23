//
//  ThirdPartyAuthTableViewCell.swift
//  fxdProduct
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class ThirdPartyAuthTableViewCell: UITableViewCell {
    
    var titleLabel : UILabel?
    var statusLabel : UILabel?
    var arrowsImage : UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ThirdPartyAuthTableViewCell {
    
    fileprivate func setupUI(){
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel?.textAlignment = NSTextAlignment.left
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.center.y)
            make.width.equalTo(100)
            make.height.equalTo(21)
            make.left.equalTo(15)
        })
        
        arrowsImage = UIImageView()
        arrowsImage?.image = UIImage.init(named: "faceIcon")
        self.addSubview(arrowsImage!)
        arrowsImage?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.center.y)
            make.width.equalTo(15)
            make.height.equalTo((arrowsImage?.snp.width)!).multipliedBy(1)
            make.right.equalTo(self.snp.right).offset(-5)
        })
        
        statusLabel = UILabel()
        statusLabel?.font = UIFont.systemFont(ofSize: 15)
        statusLabel?.textAlignment = NSTextAlignment.right
        self.addSubview(statusLabel!)
        statusLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.center.y)
            make.width.equalTo(100)
            make.height.equalTo(21)
            make.right.equalTo((arrowsImage?.snp.left)!).offset(-5)
        })
    }
}


