//
//  SetTransactionInfoViewController.swift
//  fxdProduct
//
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit
import IQKeyboardManager
/// 页面展示类型
///
/// - IDCardNumber_Type: 身份证效验
/// - verificationCode_Type: 验证码效验
/// - setTradePassword_Type: 交易密码效验
/// - modificationTradePassword_Type: 修改交易密码
@objc enum SetExhibitionType : Int {
    case IDCardNumber_Type
    case verificationCode_Type
    case setTradePassword_Type
    case modificationTradePassword_Type
}

class SetTransactionInfoViewController: BaseViewController,SetPayPasswordVerifyViewDelegate,SetPayPasswordViewDelegate{
    
    var exhibitionType:SetExhibitionType?
    var identitiesOfTradeView:SetIdentitiesOfTradeView?
    var payPasswordVerifyView:SetPayPasswordVerifyView?
    var payPasswordView:SetPayPasswordView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addBackItemRoot()
        self.view.backgroundColor = UIColor.white
        configureView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().shouldResignOnTouchOutside = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
    }
    
    func configureView() -> Void {
        switch exhibitionType {
        case .IDCardNumber_Type?:
            self.title = "设置交易身份"
            setIDCardView()
        case .verificationCode_Type?:
            self.title = "设置交易密码"
            setVerificationCodeView()
        case .setTradePassword_Type?:
            self.title = "设置交易密码"
            setCashPasswordView()
            payPasswordView?.showHeaderDisplayView()
        case .modificationTradePassword_Type?:
            self.title = "修改交易密码"
            setCashPasswordView()
            payPasswordView?.showHeaderFormerDisplayView()
        default:()
        }
    }
    
    /// 身份证效验界面
    func setIDCardView()  {
        identitiesOfTradeView = SetIdentitiesOfTradeView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: _k_h))
        identitiesOfTradeView?.nextClick = ({ [weak self]() in
            //下一个按钮点击
            self?.exhibitionType = .verificationCode_Type
            self?.configureView()
            self?.pushVerificationCodeView()
        })
        self.view.addSubview(identitiesOfTradeView!)
    }
    
    func setVerificationCodeView()  {
        let height:CGFloat = CGFloat(obtainBarHeight_New(vc: self))
        payPasswordVerifyView = SetPayPasswordVerifyView.init(frame: CGRect.init(x: _k_w, y: height, width: _k_w, height: _k_h - height))
        payPasswordVerifyView?.delegate = self
        self.view.addSubview(payPasswordVerifyView!)
    }
    
    func setCashPasswordView()  {
        let height:CGFloat = CGFloat(obtainBarHeight_New(vc: self))
        payPasswordView = SetPayPasswordView.init(frame: CGRect.init(x: _k_w, y: height, width: _k_w, height: _k_h - height))
        payPasswordView?.delegate = self
        self.view.addSubview(payPasswordView!)
    }
    
    /// 推出验证码视图
    func pushVerificationCodeView()  {
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.identitiesOfTradeView?.frame = CGRect.init(x: -_k_w, y: 0, width: _k_w, height: _k_h )
            let height:CGFloat = CGFloat(obtainBarHeight_New(vc: self))
            self.payPasswordVerifyView?.frame = CGRect.init(x: 0, y: height, width: _k_w, height: _k_h - height)
        }) { (result) in
        }
    }
    
    /// 推出密码视图
    func pushCashPasswordView()  {
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.payPasswordVerifyView?.frame = CGRect.init(x: -_k_w, y: 0, width: _k_w, height: _k_h )
            let height:CGFloat = CGFloat(obtainBarHeight_New(vc: self))
            self.payPasswordView?.frame = CGRect.init(x: 0, y: height, width: _k_w, height: _k_h - height)
        }) { (result) in
        }
    }
    
    //MARK: SetPayPasswordVerifyViewDelegate
    func userInputVerifyCode(_ code: String) {
        self.exhibitionType = .setTradePassword_Type
        self.configureView()
        pushCashPasswordView()
    }
    
    func sendButtonClick() {

    }
    
    //MARK: SetPayPasswordViewDelegate
    func userInputCashPasswordCode(_ code: String, type: PasswordType) {
        switch type {
        case .old:
            payPasswordView?.showHeaderDisplayView()
        case .new:
            payPasswordView?.showHeaderAgainDisplayView()
        case .verifyNew:
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "确认成功")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
