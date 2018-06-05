//
//  MyOrdersCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class MyOrdersCell: UITableViewCell {

    @objc var titleLabel : UILabel?
    @objc var timeLabel : UILabel?
    @objc var moneyLabel : UILabel?
    @objc var quantityLabel : UILabel?
    
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

extension MyOrdersCell{
    fileprivate func setupUI(){
        
        titleLabel = UILabel()
        titleLabel?.textColor = TITLE_COLOR
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(titleLabel!)
        
        
    }
}
