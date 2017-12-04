//
//  ImportPayPasswordView.swift
//  fxdProduct
//
//  Created by admin on 2017/11/23.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

/// 输入结果代理
@objc protocol ImportPayPasswordViewDelegate: NSObjectProtocol {
    
    func userInputCashPasswordCode(_ code:String)
    
    func userForgetPasswordClick()
    
}
class ImportPayPasswordView: UIView {
    
    var headerDisplayView:UIView?
    var tittleLabel:UILabel?
    var closeBtn:UIButton?
    var amountDisplayLabel:UILabel?
    var payPasswordInputView:PayPasswordInputView?
    var forgetPasswordBtn:UIButton?
    var VC: UIViewController?
    var delegate: ImportPayPasswordViewDelegate?
    
    //MARK:提现金额展示
    var amountDisplayStr:String?{
        didSet{
            let contentStr = "提现金额：￥" + "\(amountDisplayStr ?? "")"
            let attati : NSMutableAttributedString = NSMutableAttributedString.init(string: contentStr, attributes: [:])
            attati.addAttributes([NSAttributedStringKey.foregroundColor:UI_MAIN_COLOR,NSAttributedStringKey.font:UIFont.yx_systemFont(ofSize: 25) ?? 25], range: NSMakeRange(6, contentStr.count - 6))
            amountDisplayLabel?.attributedText = attati
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = PayPasswordBackColor_COLOR
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:展示输入密码视图
   static var  payPasswordView:ImportPayPasswordView?
   class func showImportPayPasswordView(_ vc:UIViewController , amountStr:String)  {
    var heightProportion:CGFloat = 0.75
    if UI_IS_IPONE6P || UI_IS_IPHONEX {
        heightProportion = 0.6
    }
    if payPasswordView != nil {
        return
    }
    payPasswordView = ImportPayPasswordView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: _k_h * heightProportion))
    payPasswordView?.VC = vc
    payPasswordView?.delegate = (vc as! ImportPayPasswordViewDelegate)
    payPasswordView?.amountDisplayStr = amountStr
    payPasswordView?.VC?.presentSemiView(payPasswordView, withOptions: [KNSemiModalOptionKeys.pushParentBack.takeUnretainedValue() : false,KNSemiModalOptionKeys.parentAlpha.takeUnretainedValue() : 0.8,KNSemiModalOptionKeys.animationDuration.takeUnretainedValue():0.2])
    }
    
   class func dismissImportPayPasswordView()  {
        payPasswordView?.payPasswordInputView?.endEditing(true)
        payPasswordView?.VC?.dismissSemiModalView()
        payPasswordView = nil
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension ImportPayPasswordView {
    func setUpUI()  {
        headerDisplayView = UIView()
        headerDisplayView?.backgroundColor = PayPasswordBackColor_COLOR
        self.addSubview(headerDisplayView!)
        headerDisplayView?.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(44)
        })
        
        tittleLabel = UILabel()
        tittleLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        tittleLabel?.textColor = UIColor.black
        tittleLabel?.text = "请输入交易密码"
        tittleLabel?.textAlignment = NSTextAlignment.center
        headerDisplayView?.addSubview(tittleLabel!)
        tittleLabel?.snp.makeConstraints({ (make) in
            make.center.equalTo((headerDisplayView?.snp.center)!)
        })
        
        closeBtn =  UIButton.init(type: UIButtonType.custom)
        closeBtn?.setImage(UIImage.init(named: "close_paypassword_Icon"), for: UIControlState.normal)
        closeBtn?.addTarget(self, action: #selector(closeBtnClick), for: UIControlEvents.touchUpInside)
        headerDisplayView?.addSubview(closeBtn!)
        closeBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((headerDisplayView?.snp.centerY)!)
            make.left.equalTo((headerDisplayView?.snp.left)!).offset(5)
            make.width.height.equalTo((headerDisplayView?.snp.height)!)
        })
        
        let sepView = UIView()
        sepView.backgroundColor = UIColor.init(red: 0.82, green: 0.82, blue: 0.82, alpha: 1)
        headerDisplayView?.addSubview(sepView)
        sepView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        
        amountDisplayLabel = UILabel()
        amountDisplayLabel?.font = UIFont.yx_systemFont(ofSize: 15)
        amountDisplayLabel?.backgroundColor = PayPasswordBackColor_COLOR
        amountDisplayLabel?.textAlignment = NSTextAlignment.center
        self.addSubview(amountDisplayLabel!)
        amountDisplayLabel?.snp.makeConstraints { (make) in
            make.top.equalTo((headerDisplayView?.snp.bottom)!).offset(20)
            make.centerX.equalTo((self.snp.centerX))
        }
        
        payPasswordInputView = PayPasswordInputView.init(frame: CGRect.init(x: 15, y: 100, width: _k_w - 30, height: 50))
        payPasswordInputView?.isEnsconce = false
        payPasswordInputView?.completeHandle = ({[weak self] (inputPwd) in
            if self?.delegate != nil {
                self?.delegate?.userInputCashPasswordCode(inputPwd!)
            }
        })
        self.addSubview(payPasswordInputView!)
        
        forgetPasswordBtn = UIButton.init(type: UIButtonType.custom)
        forgetPasswordBtn?.setTitle("忘记密码？", for: UIControlState.normal)
        forgetPasswordBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        forgetPasswordBtn?.setTitleColor(UI_MAIN_COLOR, for: UIControlState.normal)
        forgetPasswordBtn?.addTarget(self, action: #selector(forgetPasswordBtnClick), for: UIControlEvents.touchUpInside)
        self.addSubview(forgetPasswordBtn!)
        forgetPasswordBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((payPasswordInputView?.snp.bottom)!).offset(10)
            make.right.equalTo(-15)
        })
    }
    
   @objc func closeBtnClick()  {
        ImportPayPasswordView.dismissImportPayPasswordView()
    }
    
    @objc func forgetPasswordBtnClick()  {
        if self.delegate  != nil {
            self.delegate?.userForgetPasswordClick()
        }
    }

}



