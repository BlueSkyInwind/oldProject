//
//  MyBillAmountCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class MyBillAmountCell: UITableViewCell {

    
    @objc var moneyLabel : UILabel?
    @objc var dateLabel : UILabel?
    
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
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MyBillAmountCell{
    fileprivate func setupUI(){
        
        let titleLabel = UILabel()
        titleLabel.text = "待还金额"
        titleLabel.textColor = TITLE_COLOR
        
    }
}
