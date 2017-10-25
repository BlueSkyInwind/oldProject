//
//  HomeChoosePopView.swift
//  fxdProduct
//
//  Created by admin on 2017/10/25.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

typealias CancelClick = () -> Void
typealias SureClick = () -> Void

class HomeChoosePopView: UIView {
    
   @objc var  backImageView :UIImageView?
   @objc var  displayLabel :UILabel?
   @objc var  cancelButton :UIButton?
   @objc var  sureButton :UIButton?
   @objc var  cancelClick :CancelClick?
   @objc var  sureClick :SureClick?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
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
extension HomeChoosePopView{
    
   fileprivate func setupUI() {
        
    self.backImageView = UIImageView()
    self.backImageView?.image = UIImage.init(named: "homePop_BackImage")
    self.backImageView?.isUserInteractionEnabled = true
    self.addSubview(backImageView!)
    backImageView?.snp.makeConstraints { (make) in
        make.centerX.equalTo(self.snp.centerX)
        make.centerY.equalTo(self.snp.centerY)
        make.left.equalTo(self).offset(25)
        make.right.equalTo(self).offset(-25)
        make.height.equalTo((backImageView?.snp.width)!).multipliedBy(0.95)
    }
    
        cancelButton = UIButton()
        cancelButton?.setTitleColor(UIColor.white, for: .normal)
        cancelButton?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        cancelButton?.setBackgroundImage(UIImage(named:"homePop_cancelImage"), for: .normal)
        cancelButton?.layer.cornerRadius = 5
        cancelButton?.clipsToBounds = true
        cancelButton?.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        backImageView?.addSubview(cancelButton!)
        cancelButton?.snp.makeConstraints { (make) in
            make.bottom.equalTo((backImageView?.snp.bottom)!).offset(-40)
            make.left.equalTo((backImageView?.snp.left)!).offset(24)
        }
        
        sureButton = UIButton()
        sureButton?.setTitleColor(UIColor.black, for: .normal)
        sureButton?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        sureButton?.setBackgroundImage(UIImage(named:"homePop_sureImage"), for: .normal)
        sureButton?.layer.cornerRadius = 5
        sureButton?.clipsToBounds = true
        sureButton?.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        backImageView?.addSubview(sureButton!)
        sureButton?.snp.makeConstraints { (make) in
            make.bottom.equalTo((backImageView?.snp.bottom)!).offset(-40)
            make.right.equalTo((backImageView?.snp.left)!).offset(-24)
        }
        
        displayLabel = UILabel()
        displayLabel?.font = UIFont.systemFont(ofSize: 14)
        displayLabel?.numberOfLines = 0;
        displayLabel?.textColor = UIColor.black
        backImageView?.addSubview(displayLabel!)
        displayLabel?.snp.makeConstraints { (make) in
            make.bottom.equalTo((cancelButton?.snp.top)!).offset(-30)
            make.left.equalTo((backImageView?.snp.left)!).offset(24)
            make.right.equalTo((backImageView?.snp.right)!).offset(-24)
            make.height.equalTo(40)
        }
    }
    
    @objc func cancelBtnClick()  {
        if cancelClick != nil {
            self.cancelClick!()
        }
    }
    
    @objc func sureBtnClick()  {
        if sureClick != nil {
            self.sureClick!()
        }
    }
    
}





