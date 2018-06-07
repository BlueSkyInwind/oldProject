//
//  HeaderInstructionsView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/6.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class HeaderInstructionsView: UIView {

    var IconImageView:UIImageView?
    var instructionsLabel:UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension HeaderInstructionsView {
    
    func setUpUI()  {
        IconImageView = UIImageView()
        IconImageView?.image = UIImage.init(named: "topCellIcon")
        self.addSubview(IconImageView!)
        IconImageView?.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        instructionsLabel = UILabel()
        instructionsLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        instructionsLabel?.textColor = UIColor.red
        self.addSubview(instructionsLabel!)
        instructionsLabel?.snp.makeConstraints { (make) in
            make.left.equalTo((IconImageView?.snp.right)!).offset(11)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}
