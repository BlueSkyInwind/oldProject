//
//  SDCycleScrollCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/4/3.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class SDCycleScrollCell: UITableViewCell {

    @objc var sdCycleScrollview : SDCycleScrollView?
    
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
        
        setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SDCycleScrollCell{
    
    fileprivate func setUpUI(){
        
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage.init(named: "sdcy_bg_icon")
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        let leftImageView = UIImageView()
        leftImageView.image = UIImage.init(named: "icon_cycleICON")
        self.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self).offset(22)
        }
        
        sdCycleScrollview = SDCycleScrollView()
        sdCycleScrollview?.isUserInteractionEnabled = false
        sdCycleScrollview?.onlyDisplayText = true
        sdCycleScrollview?.titleLabelBackgroundColor = UIColor.white
        sdCycleScrollview?.titleLabelTextColor = RedPacket_COLOR
        sdCycleScrollview?.scrollDirection = .vertical
        sdCycleScrollview?.titleLabelTextFont = UIFont.yx_systemFont(ofSize: 12)
        self.addSubview(sdCycleScrollview!)
        sdCycleScrollview?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(leftImageView.snp.right).offset(14)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(20)
        })
    }
}
