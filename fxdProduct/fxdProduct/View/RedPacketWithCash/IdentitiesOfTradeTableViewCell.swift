//
//  IdentitiesOfTradeTableViewCell.swift
//  fxdProduct
//
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

typealias ValiddDCardNum = (_ idNum : String) -> Void
class IdentitiesOfTradeTableViewCell: UITableViewCell,UITextFieldDelegate{
    
    var titleLabel : UILabel?
    var contentTextfield : UITextField?
    var validdDCardNum : ValiddDCardNum?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        contentTextfield?.textAlignment = NSTextAlignment.right
        contentTextfield?.keyboardType = UIKeyboardType.asciiCapable
        contentTextfield?.addTarget(self, action: #selector(textFieldChanged(textField:)), for: UIControlEvents.editingChanged)
        self.addSubview(contentTextfield!)
        contentTextfield?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-15)
            make.left.equalTo((titleLabel?.snp.right)!).offset(5)
        })
    }
    
    @objc func textFieldChanged(textField:UITextField)  {
            if (self.validdDCardNum != nil) {
                self.validdDCardNum!(textField.text!)
            }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            textField.endEditing(true)
            if (self.validdDCardNum != nil) {
                self.validdDCardNum!(textField.text!)
            }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let cs = NSCharacterSet.init(charactersIn: IDCardNum).inverted
        let filtered = (string.components(separatedBy: cs) as NSArray ).componentsJoined(by: "")
        let resultStr:String = "\(textField.text ?? "")" + "\(string)"
        if resultStr.count > 18 {
            return false
        }else{
            if filtered != string{
                return false
            }
        }
        return true
    }
}


