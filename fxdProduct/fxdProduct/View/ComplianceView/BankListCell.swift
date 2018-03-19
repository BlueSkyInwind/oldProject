//
//  BankListCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/7.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class HGBankListCell: UITableViewCell {

    var bankImageView : UIImageView?
    var bankNameLabel : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HGBankListCell{
    fileprivate func setUpUI(){
        
        bankImageView = UIImageView()
        self.addSubview(bankImageView!)
        bankImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(20)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(35)
            make.width.equalTo(35)
        })
        
        bankNameLabel = UILabel()
        bankNameLabel?.font = UIFont.yx_systemFont(ofSize: 15)
        bankNameLabel?.textColor = UIColor.black
        self.addSubview(bankNameLabel!)
        bankNameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((bankImageView?.snp.right)!).offset(10)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        let lineView = UIView()
        lineView.backgroundColor = TIME_COLOR
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo((bankNameLabel?.snp.left)!).offset(0)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
            make.right.equalTo(self).offset(0)
        }
    }
}
