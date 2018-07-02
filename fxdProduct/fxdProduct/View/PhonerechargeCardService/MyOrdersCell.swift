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
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage.init(named: "order_bg_icon")
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        titleLabel = UILabel()
        titleLabel?.textColor = MESSAGE_TITLE_COLOR
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(22)
            make.top.equalTo(self).offset(19)
        })
        
        timeLabel = UILabel()
        timeLabel?.textColor = RedPacketBottomBtn_COLOR
        timeLabel?.font = UIFont.systemFont(ofSize: 11)
        self.addSubview(timeLabel!)
        timeLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(22)
            make.bottom.equalTo(self).offset(-20)
        })
        
        moneyLabel = UILabel()
        moneyLabel?.textColor = MESSAGE_TITLE_COLOR
        moneyLabel?.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(moneyLabel!)
        moneyLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-58)
            make.top.equalTo(self).offset(25)
        })
        
        quantityLabel = UILabel()
        quantityLabel?.textColor = RedPacketBottomBtn_COLOR
        quantityLabel?.font = UIFont.systemFont(ofSize: 11)
        self.addSubview(quantityLabel!)
        quantityLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-58)
            make.bottom.equalTo(self).offset(-26)
        })
        
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage.init(named: "arrow_icon")
        self.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-30)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}
