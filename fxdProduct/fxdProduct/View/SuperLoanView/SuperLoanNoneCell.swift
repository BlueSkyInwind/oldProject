//
//  SuperLoanNoneCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/4/10.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class SuperLoanNoneCell: UITableViewCell {

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

extension SuperLoanNoneCell{
    fileprivate func setupUI(){
        
        let bgView = UIView()
        bgView.backgroundColor = LINE_COLOR
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        let contentView = UIView()
        contentView.backgroundColor = UIColor.clear
        bgView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgView.snp.centerX)
            make.top.equalTo(bgView.snp.top).offset(40)
//            make.centerY.equalTo(bgView.snp.centerY)
            make.height.equalTo(127)
            make.width.equalTo(86)
        }
        
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "none_icon")
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(0)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        let contentLabel = UILabel()
        contentLabel.text = "该模块暂无平台"
        contentLabel.textColor = RedPacketBottomBtn_COLOR
        contentLabel.font = UIFont.yx_systemFont(ofSize: 12)
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(24)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
}
