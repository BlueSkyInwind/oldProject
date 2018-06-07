//
//  PhoneRechargePopView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit


typealias RechargePopClickEvent = () -> Void
class PhoneRechargePopView: UIView,UIGestureRecognizerDelegate {
    
    @objc var  titleLabel:UILabel?
    @objc var  contentLabel:UILabel?
    @objc var  sureBtn:UIButton?
    @objc var hotlinePopView:RechargeTypePopView?
    var backGroundView:UIView?
    
    @objc var popClick:RechargePopClickEvent?

    @objc convenience init(_ titleStr:String, contentAttri:NSAttributedString, sureTitle:String) {
        self.init(frame: UIScreen.main.bounds)
        self.titleLabel?.text = titleStr
        self.contentLabel?.attributedText = contentAttri
        self.sureBtn?.setTitle(sureTitle, for: UIControlState.normal)
        adaptHeightContent(contentAttri)
    }
    
    @objc convenience init() {
        self.init(frame: UIScreen.main.bounds)
        self.backGroundView?.removeFromSuperview()
        self.hotlinePopView?.isHidden = false
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(backgroundTap(tap:)))
        tap.delegate = self as UIGestureRecognizerDelegate
        self.addGestureRecognizer(tap)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.hotlinePopView!))!{
            return false
        }
        return true
    }
    
    ///根据提示框内容自适应高度
    func adaptHeightContent(_ contentAttri:NSAttributedString) {
        let height = contentAttri.boundingRect(with:CGSize.init(width: Alert_width - 30, height: UIScreen.main.bounds.size.height), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.RawValue(UInt8(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue) | UInt8(NSStringDrawingOptions.usesFontLeading.rawValue))), context: nil).height
        var backHeight = height + 20 + 40 + 40
        backHeight  = backHeight < 180.0 ? 180.0 : backHeight
        backGroundView?.snp.updateConstraints({ (make) in
            make.height.equalTo(backHeight)
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sureBtnClick() {
        
        if popClick  != nil {
            popClick!()
        }
    }
    
    @objc func backgroundTap(tap:UITapGestureRecognizer) {
        if popClick  != nil {
            popClick!()
        }
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
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension PhoneRechargePopView {
    
    func setUpUI()  {
        
        hotlinePopView = RechargeTypePopView.loadNib("RechargeTypePopView")
        hotlinePopView?.isHidden = true
        self.addSubview(hotlinePopView!)
        hotlinePopView?.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(298)
            make.height.equalTo((hotlinePopView?.snp.width)!).multipliedBy(0.97)
        }
        
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
        titleLabel?.font = UIFont.yx_systemFont(ofSize: 17)
        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.textColor = UI_MAIN_COLOR
        backGroundView?.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((backGroundView?.snp.centerX)!)
            make.top.equalTo((backGroundView?.snp.top)!).offset(15);
            make.height.equalTo(header_Height - 5)
            make.left.right.equalTo(0)
        })
        
        sureBtn = UIButton.init(type: UIButtonType.custom)
        sureBtn?.setTitle("确定", for: UIControlState.normal)
        sureBtn?.setTitleColor(UIColor.white, for: UIControlState.normal)
        sureBtn?.backgroundColor = UI_MAIN_COLOR
        sureBtn?.layer.cornerRadius = 5
        sureBtn?.clipsToBounds = true
        sureBtn?.addTarget(self, action: #selector(sureBtnClick), for: UIControlEvents.touchUpInside)
        backGroundView?.addSubview(sureBtn!)
        sureBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((backGroundView?.snp.left)!).offset(20)
            make.right.equalTo((backGroundView?.snp.right)!).offset(-20)
            make.height.equalTo(40);
            make.bottom.equalTo((backGroundView?.snp.bottom)!).offset(-20);
        })
        
        contentLabel = UILabel()
        contentLabel?.font = UIFont.yx_boldSystemFont(ofSize: 15)
        contentLabel?.textColor = "4D4D4D".uiColor()
        contentLabel?.textAlignment  = NSTextAlignment.left
        contentLabel?.lineBreakMode = NSLineBreakMode.byCharWrapping
        contentLabel?.numberOfLines = 0
        backGroundView?.addSubview(contentLabel!)
        contentLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(5)
            make.bottom.equalTo((sureBtn?.snp.top)!).offset(-8)
            make.left.equalTo((backGroundView?.snp.left)!).offset(20)
            make.right.equalTo((backGroundView?.snp.right)!).offset(-20)
        })
    }
}



