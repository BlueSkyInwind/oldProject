//
//  BankCardCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/6.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class BankCardCell: UITableViewCell {

    var cardImageView : UIImageView?
    var cardNameLabel : UILabel?
    var cardSpeciesLabel : UILabel?
    var cardNumLabel : UILabel?
    var phoneLabel : UILabel?
    var codeTextField : UITextField?
    
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
        
        setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BankCardCell {
    fileprivate func setUpUI(){
        
        cardImageView = UIImageView()
        self.addSubview(cardImageView!)
        cardImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(19)
            make.top.equalTo(self).offset(11)
            make.height.equalTo(50)
            make.width.equalTo(50)
        })
        
        cardNameLabel = UILabel()
        cardNameLabel?.font = UIFont.yx_systemFont(ofSize: 15)
        cardNameLabel?.textColor = TERM_COLOR
        self.addSubview(cardNameLabel!)
        cardNameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((cardImageView?.snp.right)!).offset(25)
            make.top.equalTo(self).offset(18)
        })
        
        cardSpeciesLabel = UILabel()
        cardSpeciesLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        cardSpeciesLabel?.textColor = QUTOA_COLOR
        self.addSubview(cardSpeciesLabel!)
        cardSpeciesLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((cardNameLabel?.snp.left)!).offset(0)
            make.top.equalTo((cardNameLabel?.snp.bottom)!).offset(10)
        })
        
        let lineImageView = UIImageView()
        lineImageView.image = UIImage.init(named: "line_icon")
        self.addSubview(lineImageView)
        lineImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-34)
            make.height.equalTo(1)
        }
        
        cardNumLabel = UILabel()
        cardNumLabel?.font = UIFont.yx_systemFont(ofSize: 17)
        cardNumLabel?.textColor = TERM_COLOR
        cardNumLabel?.textAlignment = .right
        self.addSubview(cardNumLabel!)
        cardNumLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-16)
            make.top.equalTo(lineImageView.snp.bottom).offset(10)
        })
        
    }
}
