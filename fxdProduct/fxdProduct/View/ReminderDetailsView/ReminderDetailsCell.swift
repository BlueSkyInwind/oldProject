//
//  ReminderDetailsCell.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/20.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class ReminderDetailsCell: UITableViewCell {

    @objc var titleLabel : UILabel?
    @objc var timeLabel : UILabel?
    @objc var moneyLabel : UILabel?
    
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

extension ReminderDetailsCell{
    fileprivate func setupUI(){
        
        titleLabel = UILabel()
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.yx_systemFont(ofSize: 15)
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(22)
            make.top.equalTo(self).offset(18)
        })
        
        timeLabel = UILabel()
        timeLabel?.textColor = TIME_COLOR
        timeLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        self.addSubview(timeLabel!)
        timeLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(22)
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(10)
        })
        
        moneyLabel = UILabel()
        moneyLabel?.textColor = UI_MAIN_COLOR
        moneyLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        self.addSubview(moneyLabel!)
        moneyLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-16)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        let lineView = UIView()
        lineView.backgroundColor = LINE_COLOR
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-0.5)
            make.height.equalTo(0.5)
        }
        
    }
}
