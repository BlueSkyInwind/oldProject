//
//  OrderVerifyCodeView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/6.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit


typealias VerifyInputResult = (_ verifyCode:String) -> Void
typealias ResendVerifyCodeClick = () -> Void

class OrderVerifyCodeView: UIView {

    
    var headerDisplayView:UIView?
    var tittleLabel:UILabel?
    var closeBtn:UIButton?
    var timerBtn:UIButton?
    var displayLabel:UILabel?
    var payPasswordInputView:PayPasswordInputView?
    var timer:Timer?
    var VC: UIViewController?
    var timeNum = 60

    var inputResult:VerifyInputResult?
    var resendVerifyCodeClick:ResendVerifyCodeClick?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = PayPasswordBackColor_COLOR
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK:展示输入密码视图
    static var  orderVerifyCodeView:OrderVerifyCodeView?
    class func showOrderVerifyCodeView(_ vc:UIViewController , displayStr:String ,result:@escaping VerifyInputResult,verifyCodeClick:@escaping ResendVerifyCodeClick)  {
        var heightProportion:CGFloat = 0.6
        if UI_IS_IPONE6P || UI_IS_IPHONEX {
            heightProportion = 0.6
        }
        if orderVerifyCodeView != nil {
            return
        }
        orderVerifyCodeView = OrderVerifyCodeView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: _k_h * heightProportion))
        orderVerifyCodeView?.VC = vc
        orderVerifyCodeView?.displayLabel?.text = displayStr
        orderVerifyCodeView?.createVerifyTimer()
        orderVerifyCodeView?.inputResult = result
        orderVerifyCodeView?.resendVerifyCodeClick = verifyCodeClick
        orderVerifyCodeView?.VC?.presentSemiView(orderVerifyCodeView, withOptions: [KNSemiModalOptionKeys.pushParentBack.takeUnretainedValue() : false,KNSemiModalOptionKeys.parentAlpha.takeUnretainedValue() : 0.8,KNSemiModalOptionKeys.animationDuration.takeUnretainedValue():0.2,KNSemiModalOptionKeys.disableCancel.takeUnretainedValue():true])
    }
    
    class func dismissImportPayPasswordView()  {
        if orderVerifyCodeView?.timer != nil {
            orderVerifyCodeView?.timer?.invalidate()
            orderVerifyCodeView?.timer = nil
        }
        orderVerifyCodeView?.payPasswordInputView?.endEditing(true)
        orderVerifyCodeView?.VC?.dismissSemiModalView()
        orderVerifyCodeView = nil
    }
    
    class func cleanUpPayPasswordView()  {
        orderVerifyCodeView?.payPasswordInputView?.cleanUpTheData()
    }
    
    @objc func closeBtnClick() {
        OrderVerifyCodeView.dismissImportPayPasswordView()
    }
    
    func createVerifyTimer()  {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(verifyCodeKeepTime), userInfo: nil, repeats: true)
    }
    
    @objc func verifyCodeKeepTime()  {
        timeNum -= 1
        self.timerBtn?.setTitle("\(timeNum)s", for: UIControlState.normal)
        self.timerBtn?.isUserInteractionEnabled = false
        if timeNum == 0 {
            timeNum = 60
            self.timerBtn?.setTitle("重新获取", for: UIControlState.normal)
            self.timerBtn?.isUserInteractionEnabled = true
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc func timerBtnClick() {
        if resendVerifyCodeClick != nil {
            resendVerifyCodeClick!()
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
extension OrderVerifyCodeView {
    
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
            make.left.equalTo((headerDisplayView?.snp.left)!).offset(15)
            make.width.height.equalTo((headerDisplayView?.snp.height)!)
        })
        
        timerBtn =  UIButton.init(type: UIButtonType.custom)
        timerBtn?.setTitleColor("D4AB44".uiColor(), for: UIControlState.normal)
        timerBtn?.addTarget(self, action: #selector(timerBtnClick), for: UIControlEvents.touchUpInside)
        headerDisplayView?.addSubview(timerBtn!)
        timerBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((headerDisplayView?.snp.centerY)!)
            make.right.equalTo((headerDisplayView?.snp.right)!).offset(-15)
        })

        let sepView = UIView()
        sepView.backgroundColor = UIColor.init(red: 0.82, green: 0.82, blue: 0.82, alpha: 1)
        headerDisplayView?.addSubview(sepView)
        sepView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        
        displayLabel = UILabel()
        displayLabel?.font = UIFont.yx_systemFont(ofSize: 15)
        displayLabel?.textColor = "808080".uiColor()
        displayLabel?.textAlignment = NSTextAlignment.center
        self.addSubview(displayLabel!)
        displayLabel?.snp.makeConstraints { (make) in
            make.top.equalTo((headerDisplayView?.snp.bottom)!).offset(25)
            make.centerX.equalTo((self.snp.centerX))
        }
        
        payPasswordInputView = PayPasswordInputView.initFrame(CGRect.init(x: 15, y: 100, width: 240, height: 50), inputTypw: .BoxTypeInput) as! PayPasswordInputView
        payPasswordInputView?.center = CGPoint.init(x: self.center.x, y: 125)
        payPasswordInputView?.isEnsconce = true
        payPasswordInputView?.completeHandle = ({[weak self] (inputPwd) in
            if self?.inputResult != nil {
                self?.inputResult!(inputPwd!)
            }
        })
        self.addSubview(payPasswordInputView!)
    }
        
}



