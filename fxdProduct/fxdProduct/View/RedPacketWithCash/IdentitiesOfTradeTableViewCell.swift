//
//  IdentitiesOfTradeTableViewCell.swift
//  fxdProduct
//
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class IdentitiesOfTradeTableViewCell: UITableViewCell,UITextFieldDelegate{
    
    var titleLabel : UILabel?
    var contentTextfield : UITextField?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension IdentitiesOfTradeTableViewCell{
    func setUpUI() {
        
        titleLabel = UILabel()
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        titleLabel?.text = "请输入身份证号"
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(15)
        })
        
        contentTextfield = UITextField()
        contentTextfield?.textColor = UI_MAIN_COLOR
        contentTextfield?.font = UIFont.yx_systemFont(ofSize: 14)
        contentTextfield?.delegate = self
        contentTextfield?.keyboardType = UIKeyboardType.asciiCapable
        self.addSubview(contentTextfield!)
        contentTextfield?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-15)
            make.left.equalTo((titleLabel?.snp.right)!).offset(5)
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if CheckUtils.checkUserIdCard(textField.text) {
            textField.endEditing(true)
        }else{
            textField.endEditing(false)
        }
    }

    
}


