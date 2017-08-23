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
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(100)
            make.height.equalTo(21)
            make.left.equalTo(15)
        })
        
        arrowsImageBtn = UIButton.init(type: UIButtonType.custom)
        arrowsImageBtn?.setBackgroundImage(UIImage.init(named: "icon_arrowRight"), for: UIControlState.normal)
        arrowsImageBtn?.addTarget(self, action: #selector(arrowImageBtnClick), for: UIControlEvents.touchUpInside)
        self.addSubview(arrowsImageBtn!)
        arrowsImageBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(15)
            make.height.equalTo((arrowsImageBtn?.snp.width)!).multipliedBy(1)
            make.right.equalTo(self.snp.right).offset(-10)
        })
        
        contentTextField = UITextField()
        contentTextField?.font = UIFont.systemFont(ofSize: 14)
        contentTextField?.textColor = UI_MAIN_COLOR
        self.addSubview(contentTextField!)
        contentTextField?.snp.makeConstraints({ (make) in
            make.left.equalTo((titleLabel?.snp.right)!)
            make.right.equalTo((arrowsImageBtn?.snp.left)!)
            make.top.equalTo(self.snp.top).offset(5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        })
    }
}









