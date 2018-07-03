//
//  SortCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class SortCell: UITableViewCell {

    @objc var leftNameLabel : UILabel?
    @objc var rightImageView : UIImageView?
    @objc var lineView : UIView?
    
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

extension SortCell{
    fileprivate func setupUI(){
        
        leftNameLabel = UILabel()
        leftNameLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        leftNameLabel?.textColor = QUTOA_COLOR
        self.addSubview(leftNameLabel!)
        leftNameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(22)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        rightImageView = UIImageView()
        rightImageView?.image = UIImage.init(named: "sort_right_icon")
        self.addSubview(rightImageView!)
        rightImageView?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-22)
            make.centerY.equalTo(self.snp.centerY)
        })
        
//        lineView = UIView()
//        lineView?.backgroundColor = UIColor.black
//        self.addSubview(lineView!)
//        lineView?.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(22)
////            make.width.equalTo(_k_w - 44)
//            make.right.equalTo(self).offset(-22)
//            make.bottom.equalTo(self).offset(-1)
//            make.height.equalTo(1)
//        }
    }
}
