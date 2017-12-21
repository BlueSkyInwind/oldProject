//
//  FXD_LoanApplicationCellTableViewCell.swift
//  fxdProduct
//
//  Created by admin on 2017/12/21.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class FXD_LoanApplicationCellTableViewCell: UITableViewCell {
    
    var titleLabel:UILabel?
    var contentLabel:UILabel?
    var iconImageView:UIImageView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
extension FXD_LoanApplicationCellTableViewCell {
    
    func setUpUI()  {
        titleLabel = UILabel()
        titleLabel?.textColor = UIColor.init(red: 77/255.0, green: 77/255.0, blue: 77/255.0, alpha: 1)
        titleLabel?.textAlignment = NSTextAlignment.left
        titleLabel?.font = UIFont.yx_systemFont(ofSize: 15)
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        iconImageView = UIImageView()
        iconImageView?.image = UIImage.init(named: "cell_Icon_Image")
        self.addSubview(iconImageView!)
        iconImageView?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.snp.right).offset(-15)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        contentLabel = UILabel()
        contentLabel?.textColor = UIColor.init(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
        contentLabel?.textAlignment = NSTextAlignment.right
        contentLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        self.addSubview(contentLabel!)
        contentLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((titleLabel?.snp.left)!).offset(5)
            make.right.equalTo((iconImageView?.snp.left)!).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(self.snp.height)
        })
        
    }
    
}



