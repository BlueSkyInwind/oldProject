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
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        moneyLabel = UILabel()
        moneyLabel?.textColor = UI_MAIN_COLOR
        moneyLabel?.font = UIFont.systemFont(ofSize: 30)
        self.addSubview(moneyLabel!)
        moneyLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
        })
        
        dateLabel = UILabel()
        dateLabel?.textColor = RedPacketBottomBtn_COLOR
        dateLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(dateLabel!)
        dateLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((moneyLabel?.snp.bottom)!).offset(24)
            make.centerX.equalTo(self.snp.centerX)
        })
    }
}
