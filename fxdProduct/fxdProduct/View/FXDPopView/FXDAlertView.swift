//
//  FXDAlertView.swift
//  fxdProduct
//
//  Created by admin on 2017/12/20.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

let header_Height:CGFloat = 35
let bottom_Height:CGFloat = 45
let Alert_width:CGFloat = 250

typealias ClickButtonIndex = (_ currentIndex:Int) -> Void
class FXDAlertView: UIView {
    
    @objc var  titleLabel:UILabel?
    @objc var  contentLabel:UILabel?
    @objc var  cancelBtn:UIButton?
    @objc var  sureBtn:UIButton?
    
    var lineOne:UIView?
    var lineTwo:UIView?
    var lineThree:UIView?
    
    var bottomView:UIView?
    var backGroundView:UIView?
    @objc var clickButtonIndex:ClickButtonIndex?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        setUpUI()
    }
    
    @objc convenience init(_ titleStr:String, content:String , cancelTitle:String, sureTitle:String) {
        self.init(frame: UIScreen.main.bounds)
        self.titleLabel?.text = titleStr
        self.contentLabel?.text = content

        if cancelTitle == "" ||  sureTitle == "" {
            updateViewLayout()
            self.sureBtn?.setTitle(sureTitle, for: UIControlState.normal)
        }else{
            self.cancelBtn?.setTitle(cancelTitle, for: UIControlState.normal)
            self.sureBtn?.setTitle(sureTitle, for: UIControlState.normal)
        }
        
        if titleStr == "" {
            updateNoTitleViewLayout()
        }
    }
    
    ///MARK: 富文本  通用全局弹窗初始化
    @objc convenience init(_ titleStr:String, content:String ,attributes:[NSAttributedStringKey : Any], cancelTitle:String,  sureTitle:String) {
        let  contentAttri = NSMutableAttributedString.init(string: content, attributes:attributes)
        self.init(titleStr, contentAttri: contentAttri, cancelTitle: cancelTitle, sureTitle: sureTitle)
        adaptHeightContent(contentAttri)
    }
    
    @objc convenience init(_ titleStr:String, contentAttri:NSAttributedString, cancelTitle:String,  sureTitle:String) {
        self.init(frame: UIScreen.main.bounds)
        self.titleLabel?.text = titleStr
        self.contentLabel?.attributedText = contentAttri
        
        if cancelTitle == "" ||  sureTitle == "" {
            updateViewLayout()
            self.sureBtn?.setTitle(sureTitle, for: UIControlState.normal)
        }else{
            self.cancelBtn?.setTitle(cancelTitle, for: UIControlState.normal)
            self.sureBtn?.setTitle(sureTitle, for: UIControlState.normal)
        }
        
        if titleStr == "" {
            updateNoTitleViewLayout()
        }
    }
    
    ///根据提示框内容自适应高度
    func adaptHeightContent(_ contentAttri:NSAttributedString) {
        let height = contentAttri.boundingRect(with:CGSize.init(width: Alert_width - 30, height: UIScreen.main.bounds.size.height), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.RawValue(UInt8(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue) | UInt8(NSStringDrawingOptions.usesFontLeading.rawValue))), context: nil).height
        var backHeight = height + header_Height + bottom_Height + 20
        backHeight  = backHeight < 150.0 ? 150.0 : backHeight
        backGroundView?.snp.updateConstraints({ (make) in
            make.height.equalTo(backHeight)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 弹窗动画
    @objc  func show()  {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIApplication.shared.keyWindow?.bringSubview(toFront: self)
        self.backGroundView?.transform = CGAffineTransform(scaleX: 1.21, y: 1.21);
        self.backGroundView?.alpha = 0
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.backGroundView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
            self.backGroundView?.alpha = 1
        }, completion: nil)
    }
    
    @objc  func dismiss()  {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.backGroundView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
            self.backGroundView?.alpha = 0
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    @objc func cancelBtnClick(){
        if clickButtonIndex != nil {
            clickButtonIndex!(0)
        }
    }
    
    @objc func  sureBtnClick(){
        if clickButtonIndex != nil {
            clickButtonIndex!(1)
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

extension FXDAlertView {
    
    func setUpUI() {
        
        backGroundView = UIView()
        backGroundView?.backgroundColor = UIColor.white
        backGroundView?.layer.cornerRadius = 8
        backGroundView?.clipsToBounds = true
        self.addSubview(backGroundView!)
        backGroundView?.snp.makeConstraints({ (make) in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(260)
            make.height.equalTo(205)
        })
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.yx_systemFont(ofSize: 15)
        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.textColor = UIColor.init(red: 77/255.0, green: 77/255.0, blue: 77/255.0, alpha: 1)
        backGroundView?.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((backGroundView?.snp.centerX)!)
            make.top.equalTo((backGroundView?.snp.top)!).offset(15);
            make.height.equalTo(header_Height - 5)
            make.left.right.equalTo(0)
        })
        
        lineOne = UIView()
        lineOne?.backgroundColor = UIColor.init(red: 202/255.0, green: 202/255.0, blue: 202/255.0, alpha: 1)
        backGroundView?.addSubview(lineOne!)
        lineOne?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((backGroundView?.snp.centerX)!)
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(5);
            make.height.equalTo(1)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        })
        
        bottomView = UIView()
        backGroundView?.addSubview(bottomView!)
        bottomView?.snp.makeConstraints({ (make) in
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(bottom_Height)
        })
        
        lineTwo = UIView()
        lineTwo?.backgroundColor = UIColor.init(red: 202/255.0, green: 202/255.0, blue: 202/255.0, alpha: 1)
        bottomView?.addSubview(lineTwo!)
        lineTwo?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((bottomView?.snp.centerX)!)
            make.top.equalTo((bottomView?.snp.top)!).offset(0);
            make.height.equalTo(1)
            make.left.equalTo((bottomView?.snp.left)!).offset(30)
            make.right.equalTo((bottomView?.snp.right)!).offset(-30)
        })
        
        lineThree = UIView()
        lineThree?.backgroundColor = UIColor.init(red: 202/255.0, green: 202/255.0, blue: 202/255.0, alpha: 1)
        bottomView?.addSubview(lineThree!)
        lineThree?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((bottomView?.snp.centerX)!)
            make.top.equalTo((bottomView?.snp.top)!).offset(8);
            make.bottom.equalTo((bottomView?.snp.bottom)!).offset(-8);
            make.width.equalTo(1)
        })
        
        cancelBtn = UIButton.init(type: UIButtonType.custom)
        cancelBtn?.setTitle("取消", for: UIControlState.normal)
        cancelBtn?.setTitleColor(UI_MAIN_COLOR, for: UIControlState.normal)
        cancelBtn?.addTarget(self, action: #selector(cancelBtnClick), for: UIControlEvents.touchUpInside)
        bottomView?.addSubview(cancelBtn!)
        cancelBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((bottomView?.snp.left)!).offset(0)
            make.right.equalTo((lineThree?.snp.left)!).offset(0)
            make.top.equalTo((bottomView?.snp.top)!).offset(0);
            make.bottom.equalTo((bottomView?.snp.bottom)!).offset(0);
        })
        
        sureBtn = UIButton.init(type: UIButtonType.custom)
        sureBtn?.setTitle("确定", for: UIControlState.normal)
        sureBtn?.setTitleColor(UI_MAIN_COLOR, for: UIControlState.normal)
        sureBtn?.addTarget(self, action: #selector(sureBtnClick), for: UIControlEvents.touchUpInside)
        bottomView?.addSubview(sureBtn!)
        sureBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((lineThree?.snp.right)!).offset(0)
            make.right.equalTo((bottomView?.snp.right)!).offset(0)
            make.top.equalTo((bottomView?.snp.top)!).offset(0);
            make.bottom.equalTo((bottomView?.snp.bottom)!).offset(0);
        })
        
        contentLabel = UILabel()
        contentLabel?.font = UIFont.yx_boldSystemFont(ofSize: 14)
        contentLabel?.textColor = UIColor.init(red: 127/255.0, green: 127/255.0, blue: 127/255.0, alpha: 1)
        contentLabel?.textAlignment  = NSTextAlignment.center
        contentLabel?.numberOfLines = 0
        backGroundView?.addSubview(contentLabel!)
        contentLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((lineOne?.snp.bottom)!).offset(10)
            make.bottom.equalTo((bottomView?.snp.top)!).offset(-10)
            make.left.equalTo((backGroundView?.snp.left)!).offset(15)
            make.right.equalTo((backGroundView?.snp.right)!).offset(-15)
        })
        
        if UI_IS_IPONE6P || UI_IS_IPHONEX {
            backGroundView?.snp.updateConstraints({ (make) in
                make.width.equalTo(290)
                make.height.equalTo(220)
            })
        }
    }
    
    func updateViewLayout() {
        lineThree?.removeFromSuperview()
        cancelBtn?.removeFromSuperview()
        sureBtn?.snp.remakeConstraints({ (make) in
            make.left.equalTo((bottomView?.snp.left)!).offset(0)
            make.right.equalTo((bottomView?.snp.right)!).offset(0)
            make.top.equalTo((bottomView?.snp.top)!).offset(0);
            make.bottom.equalTo((bottomView?.snp.bottom)!).offset(0);
        })
    }
    
    func updateNoTitleViewLayout() {
        lineOne?.removeFromSuperview()
        titleLabel?.removeFromSuperview()
        contentLabel?.snp.remakeConstraints({ (make) in
            make.top.equalTo((backGroundView?.snp.top)!).offset(10)
            make.bottom.equalTo((bottomView?.snp.top)!).offset(-10)
            make.left.equalTo((backGroundView?.snp.left)!).offset(15)
            make.right.equalTo((backGroundView?.snp.right)!).offset(-15)
        })
    }
    
    func homePageOverdueViewLayout()  {
        
        
    }
}





