//
//  RechargeCardTableViewCell.swift
//  fxdProduct
//
//  Created by admin on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class RechargeCardTableViewCell: UITableViewCell {

//    var backImage:UIImage {
//        didSet{
//            
//            
//            
//        }
//    }
    var backImageView:UIImageView?
    var titileLabel:UILabel?
    var amountLabel:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
        
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
extension RechargeCardTableViewCell {
    
    func setUpUI()  {
        
        backImageView = UIImageView()
        backImageView?.isUserInteractionEnabled = true;
        backImageView?.contentMode = .center
        self.addSubview(backImageView!)
        backImageView?.snp.makeConstraints({ (make) in
            make.center.equalTo(self.snp.center)
        })
        
        titileLabel = UILabel()
        titileLabel?.font = UIFont.yx_systemFont(ofSize: 17)
        titileLabel?.textColor = UIColor.white
        backImageView?.addSubview(titileLabel!)
        titileLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((backImageView?.snp.left)!).offset(15)
            make.top.equalTo((backImageView?.snp.top)!).offset(30)
        })
        
        titileLabel = UILabel()
        titileLabel?.font = UIFont.yx_systemFont(ofSize: 17)
        titileLabel?.textColor = UIColor.white
        backImageView?.addSubview(titileLabel!)
        titileLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((backImageView?.snp.left)!).offset(15)
            make.centerY.equalTo((backImageView?.snp.centerY)!).offset(-30)
        })
        
        amountLabel = UILabel()
        amountLabel?.font = UIFont.yx_systemFont(ofSize: 30)
        amountLabel?.textColor = UIColor.white
        backImageView?.addSubview(amountLabel!)
        amountLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((backImageView?.snp.left)!).offset(15)
            make.centerY.equalTo((backImageView?.snp.centerY)!).offset(15)
        })
    }
    

    
    
}




