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
    @objc var descLabel : UILabel?
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
        
        descLabel = UILabel()
        descLabel?.numberOfLines = 0
        descLabel?.textColor = RedPacketMoney_COLOR
        descLabel?.lineBreakMode = .byWordWrapping
        descLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(descLabel!)
        descLabel?.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(25)
            make.right.equalTo(self).offset(-25)
            make.top.equalTo(titleLabel.snp.bottom).offset(21)
            make.height.equalTo(62)
        }
        
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
        if UI_IS_IPHONEX {
            
            bottomBtn?.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self).offset(-60)
            })
        }
    }
    

    @objc func bottomBtnClick(){
        if delegate != nil {
            delegate?.bottomBtnClick()
        }
    }
}
