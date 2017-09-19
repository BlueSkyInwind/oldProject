//
//  HomeRefuseCell.swift
//  fxdProduct
//
//  Created by sxp on 2017/9/19.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class RefuseCell: UITableViewCell {

    var leftLabel : UILabel?
    
    var rightLabel : UILabel?
    
    var lineView : UIView?
    
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
    
    func setupUI(){
    
        leftLabel = UILabel()
        leftLabel?.font = UIFont.systemFont(ofSize: 15)
        leftLabel?.textColor = UIColor.black
        self.addSubview(leftLabel!)
        leftLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(25)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(20)
        })
        
        let arrowImage = UIImageView()
        arrowImage.image = UIImage(named:"icon_arrowRight")
        self.addSubview(arrowImage)
        arrowImage.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self.snp.centerY)
            
        }
        
        
        rightLabel = UILabel()
        rightLabel?.font = UIFont.systemFont(ofSize: 12)
        rightLabel?.textColor = UI_MAIN_COLOR
        self.addSubview(rightLabel!)
        rightLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(arrowImage.snp.left).offset(-15)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(20)
        })
        
        lineView = UIView()
        lineView?.backgroundColor = LINE_COLOR
        self.addSubview(lineView!)
        lineView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(0.5)
            make.bottom.equalTo(self).offset(-0.5)
        })
    }
}
