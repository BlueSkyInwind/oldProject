//
//  MyBillCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class MyBillCell: UITableViewCell {

    @objc var leftLabel : UILabel?
    @objc var rightLabel : UILabel?
    @objc var arrowImage : UIImageView?
    
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

extension MyBillCell{
    fileprivate func setupUI(){
        
        leftLabel = UILabel()
        leftLabel?.textColor = RedPacket_COLOR
        leftLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(leftLabel!)
        leftLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(20)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        rightLabel = UILabel()
        rightLabel?.textColor = UI_MAIN_COLOR
        rightLabel?.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(rightLabel!)
        rightLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-40)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        arrowImage = UIImageView()
        arrowImage?.image = UIImage.init(named: "my_arrow_icon")
        self.addSubview(arrowImage!)
        arrowImage?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        let lineView = UIView()
        lineView.backgroundColor = LINE_COLOR
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        }
    }
}
