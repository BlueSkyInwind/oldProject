//
//  MineCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class MineCell: UITableViewCell {

    @objc var titleImageView : UIImageView?
    @objc var titleLabel : UILabel?
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

extension MineCell{
    fileprivate func setupUI(){
        
        titleImageView = UIImageView()
        self.addSubview(titleImageView!)
        titleImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(20)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        titleLabel = UILabel()
        titleLabel?.textColor = RedPacket_COLOR
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((titleImageView?.snp.right)!).offset(30)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage.init(named: "my_arrow_icon")
        self.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        lineView = UIView()
        lineView?.backgroundColor = LINE_COLOR
        self.addSubview(lineView!)
        lineView?.snp.makeConstraints({ (make) in
            make.left.equalTo((titleLabel?.snp.left)!).offset(0)
            make.right.equalTo(arrowImageView.snp.left).offset(-25)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        })
    
    }
}
