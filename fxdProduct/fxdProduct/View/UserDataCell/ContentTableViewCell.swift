//
//  ContentTableViewCell.swift
//  fxdProduct
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    var titleLabel : UILabel?
    var contentTextField : UITextField?
    var arrowsImageBtn : UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func arrowImageBtnClick() -> Void {
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ContentTableViewCell {
    
    fileprivate func setupUI (){
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel?.textAlignment = NSTextAlignment.left
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.center.y)
            make.width.equalTo(100)
            make.height.equalTo(21)
            make.left.equalTo(15)
        })
        
        arrowsImageBtn = UIButton.init(type: UIButtonType.custom)
        arrowsImageBtn?.addTarget(self, action: #selector(arrowImageBtnClick), for: UIControlEvents.touchUpInside)
        self.addSubview(arrowsImageBtn!)
        arrowsImageBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.center.y)
            make.width.equalTo(15)
            make.height.equalTo((arrowsImageBtn?.snp.width)!).multipliedBy(1)
            make.right.equalTo(self.snp.right).offset(-5)
        })
        
        contentTextField = UITextField()
        contentTextField?.font = UIFont.systemFont(ofSize: 14)
        contentTextField?.textColor = UI_MAIN_COLOR
        self.addSubview(contentTextField!)
        contentTextField?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.center.y)
            make.left.equalTo((titleLabel?.snp.right)!)
            make.right.equalTo((titleLabel?.snp.left)!)
            make.height.equalTo(21)
        })
    }
}









