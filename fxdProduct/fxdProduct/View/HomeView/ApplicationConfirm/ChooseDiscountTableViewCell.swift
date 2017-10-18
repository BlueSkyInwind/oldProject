//
//  ChooseDiscountTableViewCell.swift
//  fxdProduct
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class ChooseDiscountTableViewCell: UITableViewCell {

    @objc var titleLabel : UILabel?
    @objc var chooseBtn : UIButton?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setUpUI()
    }


    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension ChooseDiscountTableViewCell{
    
    func setUpUI()  -> Void{
        chooseBtn = UIButton.init(type: UIButtonType.custom)
        chooseBtn?.setBackgroundImage(UIImage.init(named: "unChoose_Icon"), for: UIControlState.normal)
        self.addSubview(chooseBtn!)
        chooseBtn?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(19)
            make.right.equalTo(-20)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        titleLabel?.textColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo((chooseBtn?.snp.left)!).offset(-15)
            make.left.equalTo(15)
            make.height.equalTo(30)
        })
    }

}





