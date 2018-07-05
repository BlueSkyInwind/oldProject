//
//  SupermarketTabCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class SupermarketTabCell: UITableViewCell {
    
    //最左边图片
    @objc var leftImageView : UIImageView?
    //名称
    @objc var nameLabel : UILabel?
    //下载量
    @objc var downloadsLabel : UILabel?
    //额度
    @objc var quotaLabel : UILabel?
    //期限
    @objc var termLabel : UILabel?
    //产品描述
    @objc var descLabel : UILabel?
    
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

extension SupermarketTabCell{
    
    fileprivate func setupUI(){
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
        }
        
        let leftView = UIView()
        leftView.backgroundColor = UIColor.clear
        bgView.addSubview(leftView)
        leftView.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.left).offset(0)
            make.top.equalTo(bgView.snp.top).offset(0)
            make.bottom.equalTo(bgView.snp.bottom).offset(0)
            make.width.equalTo(120)
        }
        
        leftImageView = UIImageView()
        leftView.addSubview(leftImageView!)
        leftImageView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(leftView.snp.centerX)
            make.top.equalTo(leftView.snp.top).offset(16)
            make.width.equalTo(38)
            make.height.equalTo(38)
        })
        
        nameLabel = UILabel()
        nameLabel?.textColor = TIP_TITLE_COLOR
        nameLabel?.font = UIFont.systemFont(ofSize: 14)
        nameLabel?.textAlignment = .center
        leftView.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((leftImageView?.snp.bottom)!).offset(10)
            make.centerX.equalTo(leftView.snp.centerX)
            make.width.equalTo(120)
        })
        
        downloadsLabel = UILabel()
        downloadsLabel?.textColor = DWONLOAD_COLOR
        downloadsLabel?.font = UIFont.systemFont(ofSize: 10)
        downloadsLabel?.textAlignment = .center
        leftView.addSubview(downloadsLabel!)
        downloadsLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((nameLabel?.snp.bottom)!).offset(6)
            make.centerX.equalTo(leftView.snp.centerX)
            make.width.equalTo(120)
        })
        
        let lineView = UIView()
        lineView.backgroundColor = LINE_COLOR
        bgView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(leftView.snp.right).offset(5)
            make.height.equalTo(80)
            make.width.equalTo(1)
            make.centerY.equalTo(bgView.snp.centerY)
        }
        
        let quota = UILabel()
        quota.text = "最高额度"
        quota.textColor = SUPERMARK_QUOTA_COLOR
        quota.font = UIFont.systemFont(ofSize: 13)
        bgView.addSubview(quota)
        quota.snp.makeConstraints { (make) in
            make.left.equalTo(lineView.snp.right).offset(30)
            make.top.equalTo(bgView.snp.top).offset(19)
            make.height.equalTo(20)
        }
        
        quotaLabel = UILabel()
        quotaLabel?.textColor = SUPERMARK_QUOTA_COLOR
        quotaLabel?.font = UIFont.systemFont(ofSize: 19)
        bgView.addSubview(quotaLabel!)
        quotaLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(quota.snp.left).offset(0)
            make.top.equalTo(quota.snp.bottom).offset(5)
        })
        
        let term = UILabel()
        term.text = "期限"
        term.textColor = DWONLOAD_COLOR
        term.font = UIFont.systemFont(ofSize: 13)
        bgView.addSubview(term)
        term.snp.makeConstraints { (make) in
            make.right.equalTo(bgView.snp.right).offset(-70)
            make.top.equalTo(quota.snp.top).offset(0)
            make.height.equalTo(20)
        }
        
        termLabel = UILabel()
        termLabel?.textColor = SUPERMARK_TERM_COLOR
        termLabel?.font = UIFont.systemFont(ofSize: 15)
        bgView.addSubview(termLabel!)
        termLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(term.snp.left).offset(0)
            make.top.equalTo(term.snp.bottom).offset(5)
        })
        
        descLabel = UILabel()
        descLabel?.textColor = DWONLOAD_COLOR
        descLabel?.font = UIFont.systemFont(ofSize: 13)
        bgView.addSubview(descLabel!)
        descLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(quota.snp.left).offset(0)
            make.bottom.equalTo(bgView.snp.bottom).offset(-16)
            make.right.equalTo(bgView.snp.right).offset(0)
        })
    }
}

