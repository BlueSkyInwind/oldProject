//
//  BankCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/7/2.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class BankCell: UITableViewCell {

    @objc var type : String?{
        didSet(newValue){
            
            setCellType(type: type!)
        }
    }
    
    @objc var bankImageView : UIImageView?
    @objc var bankNameLabel : UILabel?
    @objc var bankNumLabel : UILabel?
    
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
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension BankCell{
    
    fileprivate func setCellType(type : String){
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        let type = Int(type)
        switch type! {
        case 1:
            defaultUI()
        case 2:
            addBankCell()
        default:
            break
        }
    }
    fileprivate func defaultUI(){
        let bgImageView = UIImageView()
        bgImageView.image = UIImage.init(named: "bank_bg_icon")
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(17)
            make.right.equalTo(self).offset(-17)
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        let bankBgImageView = UIImageView()
        bankBgImageView.image = UIImage.init(named: "bank_white_icon")
        bgImageView.addSubview(bankBgImageView)
        bankBgImageView.snp.makeConstraints { (make) in
            
            make.left.equalTo(bgImageView.snp.left).offset(7)
            make.top.equalTo(bgImageView.snp.top).offset(10)
//            make.width.equalTo(42)
//            make.height.equalTo(42)
        }
        bankImageView = UIImageView()
        bankImageView?.layer.cornerRadius = 21
        bankBgImageView.addSubview(bankImageView!)
        bankImageView?.snp.makeConstraints({ (make) in
//            make.left.equalTo(bgImageView.snp.left).offset(7)
//            make.top.equalTo(bgImageView.snp.top).offset(10)
            make.centerX.equalTo(bankBgImageView.snp.centerX)
            make.centerY.equalTo(bankBgImageView.snp.centerY)
            make.width.equalTo(28)
            make.height.equalTo(28)
        })
        
        bankNameLabel = UILabel()
        bankNameLabel?.textColor = UIColor.white
        bankNameLabel?.font = UIFont.systemFont(ofSize: 13)
        bgImageView.addSubview(bankNameLabel!)
        bankNameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((bankImageView?.snp.right)!).offset(17)
            make.top.equalTo(bgImageView.snp.top).offset(20)
        })
        
        bankNumLabel = UILabel()
        bankNumLabel?.textColor = UIColor.white
        bankNumLabel?.font = UIFont.systemFont(ofSize: 18)
        bgImageView.addSubview(bankNumLabel!)
        bankNumLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((bankNameLabel?.snp.left)!).offset(0)
            make.bottom.equalTo(bgImageView.snp.bottom).offset(-16)
        })
    }
    
    fileprivate func addBankCell(){
        
        let addImageView = UIImageView()
        addImageView.image = UIImage.init(named: "bank_add_icon")
        self.addSubview(addImageView)
        addImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(17)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        let titleLabel = UILabel()
        titleLabel.textColor = MINE_BANK_COLOR
        titleLabel.text = "添加银行卡"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(addImageView.snp.right).offset(12)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage.init(named: "bank_arrow_icon")
        self.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-14)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}
