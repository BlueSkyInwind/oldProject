//
//  LoadFailureView.swift
//  fxdProduct
//
//  Created by admin on 2017/9/7.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

@objc protocol LoadFailureDelegate: NSObjectProtocol{
    func LoadFailureLoadRefreshButtonClick()
}

class LoadFailureView: UIView {

   @objc var iconImageView : UIImageView?
   @objc var reminderLabel : UILabel?
   @objc var refreshBtn : UIButton?
   @objc var delegate : LoadFailureDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func refreshBtnClick(){
        if self.delegate != nil {
            self.delegate?.LoadFailureLoadRefreshButtonClick()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

extension LoadFailureView {
    
    fileprivate func setUpUI(){
        
        
        reminderLabel = UILabel.init()
        reminderLabel?.text = "加载失败，点击刷新重试！"
        reminderLabel?.textColor = UIColor.init(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
        reminderLabel?.font = UIFont.systemFont(ofSize: 16)
        reminderLabel?.textAlignment = NSTextAlignment.center
        self.addSubview(reminderLabel!)
        reminderLabel?.snp.makeConstraints({ (make) in
            make.centerX .equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-5)
            make.height.equalTo(25)
            make.width.equalTo(200)
        })
    
        iconImageView = UIImageView.init()
        iconImageView?.image = UIImage.init(named: "none_icon")
        self.addSubview(iconImageView!)
        iconImageView?.snp.makeConstraints({ (make) in
            make.bottom.equalTo((reminderLabel?.snp.top)!).offset(-5)
            make.centerX.equalTo(self.snp.centerX)
        })
        
        refreshBtn = UIButton()
        refreshBtn?.setTitle("点击刷新", for: .normal)
        refreshBtn?.setTitleColor(UI_MAIN_COLOR, for: .normal)
        refreshBtn?.addTarget(self, action: #selector(refreshBtnClick), for: .touchUpInside)
        FXD_Tool.setCorner(refreshBtn, borderColor: UI_MAIN_COLOR)
        self.addSubview(refreshBtn!)
        refreshBtn?.snp.makeConstraints { (make) in
            make.top.equalTo((reminderLabel?.snp.bottom)!).offset(35)
            make.width.equalTo(130)
            make.height.equalTo(40)
            make.centerX.equalTo(self.snp.centerX)
        }
        

        
    }
}



