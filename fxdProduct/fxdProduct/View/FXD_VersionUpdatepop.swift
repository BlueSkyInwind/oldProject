//
//  FXD_VersionUpdatepop.swift
//  fxdProduct
//
//  Created by admin on 2017/11/7.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

typealias CloseClick = (_ index : Int) -> Void
typealias UpdateClick = (_ index : Int) -> Void

class FXD_VersionUpdatepop: UIView {
    
    @objc var  backImageView :UIImageView?
    @objc var  titleLabel :UILabel?
    @objc var  displayLabel :UILabel?
    @objc var  closeButton :UIButton?
    @objc var  updateButton :UIButton?
    @objc var  closeClick :CloseClick?
    @objc var  updateClick :UpdateClick?
    
    @objc convenience init(content : String , isFroce:Bool){
        
        self.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: _k_h))
        
        setContentStyle(str: content)
        
        self.closeButton?.isHidden = isFroce
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc  func show()  {
        UIApplication.shared.keyWindow?.addSubview(self)
        self.backImageView?.transform = CGAffineTransform(scaleX: 1.21, y: 1.21);
        self.backImageView?.alpha = 0
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.backImageView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
            self.backImageView?.alpha = 1
        }, completion: nil)
    }
    
    @objc  func dismiss()  {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.backImageView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
            self.backImageView?.alpha = 0
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
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

extension FXD_VersionUpdatepop{
    
    func setUpUI() {
        
        self.backImageView = UIImageView()
        self.backImageView?.image = UIImage.init(named: "update_backgroundImage")
        self.backImageView?.isUserInteractionEnabled = true
        self.addSubview(backImageView!)
        backImageView?.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self).offset(25)
            make.right.equalTo(self).offset(-25)
            make.height.equalTo((backImageView?.snp.width)!).multipliedBy(1.36)
        }
        
        titleLabel = UILabel()
        titleLabel?.text = "发现新版本"
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel?.textColor = UI_MAIN_COLOR
        self.backImageView?.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((self.backImageView?.snp.centerX)!)
            make.top.equalTo((self.backImageView?.snp.top)!).offset(160);
            make.height.equalTo(30)
        })
        
        updateButton = UIButton.init(type: UIButtonType.custom)
        updateButton?.setTitle("立即更新", for: UIControlState.normal)
        updateButton?.setBackgroundImage(UIImage.init(named: "update_Icon"), for: UIControlState.normal)
        updateButton?.addTarget(self, action: #selector(appVersionUpdate), for: UIControlEvents.touchUpInside)
        self.backImageView?.addSubview(updateButton!)
        updateButton?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.backImageView?.snp.left)!).offset(30);
            make.right.equalTo((self.backImageView?.snp.right)!).offset(-30);
            make.height.equalTo(45);
            make.bottom.equalTo((self.backImageView?.snp.bottom)!).offset(-45);
        })
        
        displayLabel  = UILabel()
        displayLabel?.numberOfLines = 0
        displayLabel?.font = UIFont.systemFont(ofSize: 14)
        displayLabel?.textColor = UIColor.init(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        self.backImageView?.addSubview(displayLabel!);
        displayLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(19)
            make.left.equalTo((self.backImageView?.snp.left)!).offset(20)
            make.right.equalTo((self.backImageView?.snp.right)!).offset(-20)
//            make.bottom.equalTo((updateButton?.snp.top)!).offset(-20)
        })
        
        closeButton = UIButton.init(type: UIButtonType.custom)
        closeButton?.setBackgroundImage(UIImage.init(named: "update_CloseBtn_Icon"), for: UIControlState.normal)
        closeButton?.addTarget(self, action: #selector(closeAppVersionUpdate), for: UIControlEvents.touchUpInside)
        self.addSubview(closeButton!)
        closeButton?.snp.makeConstraints({ (make) in
            make.right.equalTo((self.snp.right)).offset(-17);
            make.height.width.equalTo(34);
            make.bottom.equalTo((self.backImageView?.snp.top)!).offset(-5);
        })
        
        if UI_IS_IPONE5 {
            titleLabel?.snp.updateConstraints({ (make) in
                make.top.equalTo((self.backImageView?.snp.top)!).offset(130);
            })
            displayLabel?.snp.updateConstraints({ (make) in
                make.top.equalTo((titleLabel?.snp.bottom)!).offset(2)
            })
            updateButton?.snp.updateConstraints({ (make) in
                make.bottom.equalTo((self.backImageView?.snp.bottom)!).offset(-25);
                make.height.equalTo(35);
            })
        }
        
        if UI_IS_IPONE6P {
            titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
            displayLabel?.font = UIFont.systemFont(ofSize: 16)
        }
        
    }
    
    /// 设置内容格式
    ///
    /// - Parameter str: 内容
    func setContentStyle(str:String)  {
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = 15
        if UI_IS_IPONE5 {
            paragraphStyle.lineSpacing = 10
        }
        let attarStr = NSMutableAttributedString.init(string: str, attributes: [NSAttributedStringKey.paragraphStyle : paragraphStyle])
        displayLabel?.attributedText=attarStr
        displayLabel?.sizeToFit()
    }
    
    @objc func appVersionUpdate(){
        if updateClick != nil {
            self.updateClick!(1)
        }
    }
    @objc func closeAppVersionUpdate(){
        if updateClick != nil {
            self.updateClick!(0)
        }
    }
}


