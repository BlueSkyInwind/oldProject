//
//  SetPayPasswordVerifyView.swift
//  fxdProduct
//
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

@objc protocol SetPayPasswordVerifyViewDelegate: NSObjectProtocol {
    
    //提现按钮
    func sendButtonClick()
    
    func userInputVerifyCode(_ code:String)
    
}

class SetPayPasswordVerifyView: UIView {
    var headerDisplayView:UIView?
    var reminderLabel:UILabel?
    var phoneNumberLabel:UILabel?
    var payPasswordInputView:PayPasswordInputView?
    var footerDisplayView:UIView?
    var footerSendCodeView:UIView?
    var footerDisplayLabel:UILabel?
    var sendBtn:UIButton?
    var count : Int
    var timer:Timer?
    
    var delegate : SetPayPasswordVerifyViewDelegate?

    override init(frame: CGRect) {
        self.count = 59
        super.init(frame: frame)
        self.backgroundColor = PayPasswordBackColor_COLOR
        setUpUI()
//        setVerifyCount()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showFooterDisplayView()  {
        UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.footerDisplayView?.frame = CGRect.init(x: 0, y: 150, width: _k_w, height: 100)
            self.footerSendCodeView?.frame = CGRect.init(x: _k_w, y: 150, width: _k_w, height: 100)
            self.count = 59
        }) { (result) in
            
        }
    }
    
    func showFooterSendCodeView()  {
        UIView.animate(withDuration: 0.8, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.footerSendCodeView?.frame = CGRect.init(x: 0, y: 150, width: _k_w, height: 100)
            self.footerDisplayView?.frame = CGRect.init(x: -_k_w, y: 150, width: _k_w, height: 100)
        }) { (result) in
            
        }
    }
    
   @objc func setVerifyCount() {
        footerDisplayLabel?.attributedText = footerDisplayLabelText()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(verifyCountDisplay), userInfo: nil, repeats: true)
    }
    
    @objc func verifyCountDisplay(){
        count -= 1
        footerDisplayLabel?.attributedText = footerDisplayLabelText()
        if count == 0 {
            self.count = 59
            timer?.invalidate()
            timer = nil
            //展示重新发送验证码的界面
            showFooterSendCodeView()
        }
    }
    
    //设置秒数颜色
    func footerDisplayLabelText() -> NSAttributedString {
        let contentStr = "\(self.count)"+"秒后发送"
        let attati : NSMutableAttributedString = NSMutableAttributedString.init(string: contentStr, attributes: [:])
        attati.addAttributes([NSAttributedStringKey.foregroundColor:UI_MAIN_COLOR,NSAttributedStringKey.font:UIFont.yx_systemFont(ofSize: 14) ?? 14], range: NSMakeRange(0, contentStr.count - 4))
        return attati
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension SetPayPasswordVerifyView{
    
    func setUpUI()  {
        
        headerDisplayView = UIView()
        headerDisplayView?.backgroundColor = PayPasswordBackColor_COLOR
        self.addSubview(headerDisplayView!);
        headerDisplayView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.height.equalTo(100)
        })
        
        reminderLabel = UILabel()
        reminderLabel?.text = "我们已经发送验证码到您的手机"
        reminderLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        reminderLabel?.textColor = UIColor.black
        headerDisplayView?.addSubview(reminderLabel!)
        reminderLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((headerDisplayView?.snp.centerX)!)
            make.centerY.equalTo((headerDisplayView?.snp.centerY)!).offset(-15)
        })
        
        phoneNumberLabel = UILabel()
        phoneNumberLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        phoneNumberLabel?.textColor = UI_MAIN_COLOR
        headerDisplayView?.addSubview(phoneNumberLabel!)
        phoneNumberLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((headerDisplayView?.snp.centerX)!)
            make.centerY.equalTo((headerDisplayView?.snp.centerY)!).offset(15)
        })
        
        payPasswordInputView = PayPasswordInputView.init(frame: CGRect.init(x: 15, y: 100, width: _k_w - 30, height: 50))
        payPasswordInputView?.isEnsconce = true
        payPasswordInputView?.completeHandle = ({[weak self](inputPwd) in
            if (self?.delegate != nil) {
                self?.delegate?.userInputVerifyCode(inputPwd!)
            }
        })
        self.addSubview(payPasswordInputView!)
        
        footerDisplayView = UIView.init(frame: CGRect.init(x: 0, y: 150, width: _k_w, height: 100))
        footerDisplayView?.backgroundColor = PayPasswordBackColor_COLOR
        self.addSubview(footerDisplayView!);

        footerDisplayLabel = UILabel()
        footerDisplayLabel?.text = "59秒后发送"
        footerDisplayLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        footerDisplayLabel?.textColor = UIColor.black
        footerDisplayView?.addSubview(footerDisplayLabel!)
        footerDisplayLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((footerDisplayView?.snp.centerX)!)
            make.centerY.equalTo((footerDisplayView?.snp.centerY)!)
        })
        
        footerSendCodeView = UIView.init(frame: CGRect.init(x: _k_w, y: 150, width: _k_w, height: 100))
        footerSendCodeView?.backgroundColor = PayPasswordBackColor_COLOR
        self.addSubview(footerSendCodeView!);

        let promortLabel = UILabel()
        promortLabel.text = "收不到验证码？"
        promortLabel.textColor = UIColor.black
        promortLabel.font = UIFont.yx_systemFont(ofSize: 14)
        footerSendCodeView?.addSubview(promortLabel)
        promortLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo((footerSendCodeView?.snp.centerY)!)
            make.centerX.equalTo((footerSendCodeView?.snp.centerX)!).offset(-40)
        }
        
        sendBtn = UIButton.init(type: UIButtonType.custom)
        sendBtn?.setTitle("重新发送", for: UIControlState.normal)
        sendBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        sendBtn?.setTitleColor(UI_MAIN_COLOR, for: UIControlState.normal)
        sendBtn?.addTarget(self, action: #selector(sendBtnClick), for: UIControlEvents.touchUpInside)
        footerSendCodeView?.addSubview(sendBtn!)
        sendBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((footerSendCodeView?.snp.centerY)!)
            make.left.equalTo(promortLabel.snp.right).offset(2)
        })
    }
    
    @objc func sendBtnClick() {
        if (self.delegate != nil) {
//            showFooterDisplayView()
//            setVerifyCount()
            self.delegate?.sendButtonClick()
        }
    }

}


