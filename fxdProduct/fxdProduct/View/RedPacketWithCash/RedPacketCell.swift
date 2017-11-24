//
//  RedPacketCell.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/20.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

@objc protocol RedPacketCellDelegate: NSObjectProtocol {
    
    //关于现金红包
    func bottomBtnClick()
    
}

class RedPacketCell: UITableViewCell {

    @objc var bottomBtn : UIButton?
    @objc weak var delegate: RedPacketCellDelegate?
    
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

extension RedPacketCell{
    fileprivate func setupUI(){
        
        let titleLabel = UILabel()
        titleLabel.text = "提现说明"
        titleLabel.textColor = UI_MAIN_COLOR
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(39)
        }
        
        let label1 = UILabel()
        label1.numberOfLines = 0
        label1.text = "1、逾期状态无法提现。 2、累计满X元可提现。 3、提现申请成功后，3个工作日内到账。"
        label1.textColor = RedPacketMoney_COLOR
        label1.lineBreakMode = .byWordWrapping
        label1.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(label1)
        label1.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(25)
            make.right.equalTo(self).offset(-25)
            make.top.equalTo(titleLabel.snp.bottom).offset(21)
            make.height.equalTo(62)
        }
        
//        let label2 = UILabel()
//        label2.text = "2、累计满X元可提现。"
//        label2.textColor = RedPacketMoney_COLOR
//        label2.font = UIFont.systemFont(ofSize: 14)
//        self.addSubview(label2)
//        label2.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(25)
//            make.top.equalTo(label1).offset(25)
//        }
//
//        let label3 = UILabel()
//        label3.text = "3、提现申请成功后，3个工作日内到账。"
//        label3.textColor = RedPacketMoney_COLOR
//        label3.font = UIFont.systemFont(ofSize: 14)
//        self.addSubview(label3)
//        label3.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(25)
//            make.top.equalTo(label2).offset(25)
//        }
        
        bottomBtn = UIButton()
        bottomBtn?.setTitleColor(RedPacketBottomBtn_COLOR, for: .normal)
        bottomBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        bottomBtn?.addTarget(self, action: #selector(bottomBtnClick), for: .touchUpInside)
        self.addSubview(bottomBtn!)
        bottomBtn?.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self).offset(-20)
        }
    
        if UI_IS_IPONE5 {
            bottomBtn?.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self).offset(-10)
            })
        }
    }
    

    @objc func bottomBtnClick(){
        if delegate != nil {
            delegate?.bottomBtnClick()
        }
    }
}
