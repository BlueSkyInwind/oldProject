//
//  QuotaCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/4.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class QuotaCell: UITableViewCell {

    @objc var titleLabel : UILabel?
    @objc var quotaBtn : UIButton?
    
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

extension QuotaCell{
    fileprivate func setupUI(){
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        titleLabel?.textColor = UI_MAIN_COLOR
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(20)
            make.centerX.equalTo(self.snp.centerX)
        })
        
        quotaBtn = UIButton()
        quotaBtn?.setTitleColor(UI_MAIN_COLOR, for: .normal)
        quotaBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 20)
        self.addSubview(quotaBtn!)
        quotaBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(30)
        })
    }
}
