//
//  MyBillAmountCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class MyBillAmountCell: UITableViewCell {

    //待还金额
    @objc var moneyLabel : UILabel?
    //还款日期
    @objc var dateLabel : UILabel?
    //逾期View
    @objc var overdueView : UIView?
    //逾期天数
    @objc var overdueDateLabel : UILabel?
    
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
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
        })
        
        dateLabel = UILabel()
        dateLabel?.textColor = RedPacketBottomBtn_COLOR
        dateLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(dateLabel!)
        dateLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((moneyLabel?.snp.bottom)!).offset(5)
            make.centerX.equalTo(self.snp.centerX)
        })
        
        overdueView = UIView()
        overdueView?.isHidden = true
        overdueView?.backgroundColor = UIColor.clear
        self.addSubview(overdueView!)
        overdueView?.snp.makeConstraints({ (make) in
            make.top.equalTo((dateLabel?.snp.bottom)!).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.centerX.equalTo(self.snp.centerX)
        })
        let tipImageView = UIImageView()
        tipImageView.image = UIImage.init(named: "tip_icon")
        overdueView?.addSubview(tipImageView)
        tipImageView.snp.makeConstraints { (make) in
            make.left.equalTo((overdueView?.snp.left)!).offset(0)
            make.centerY.equalTo((overdueView?.snp.centerY)!)
        }
        
        overdueDateLabel = UILabel()
        overdueDateLabel?.textColor = OVERDUEDATE_COLOR
        overdueDateLabel?.font = UIFont.systemFont(ofSize: 15)
        overdueView?.addSubview(overdueDateLabel!)
        overdueDateLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo((overdueView?.snp.right)!).offset(0)
            make.centerY.equalTo((overdueView?.snp.centerY)!)
        })
    }
}
