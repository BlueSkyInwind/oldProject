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
    case resetTradePassword_Type
    case modificationTradePassword_Type
}

class SetTransactionInfoViewController: BaseViewController,SetPayPasswordVerifyViewDelegate,SetPayPasswordViewDelegate,SetIdentitiesOfTradeViewDelegate{
    
    var exhibitionType:SetExhibitionType?
    var identitiesOfTradeView:SetIdentitiesOfTradeView?
    var payPasswordVerifyView:SetPayPasswordVerifyView?
    var payPasswordView:SetPayPasswordView?

    var firstTradePassword:String?
    var secondTradePassword:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addBackItem()
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
    
    //MARK:视图逻辑
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
        case .resetTradePassword_Type?:
            self.title = "设置交易密码"
            setCashPasswordView()
            payPasswordView?.showHeaderDisplayView()
        case .modificationTradePassword_Type?:
            self.title = "修改交易密码"
            setCashPasswordView()
            payPasswordView?.showHeaderFormerDisplayView()
            pushCashPasswordView(duration: 0)
        default:()
        }
    }
    
    /// 身份证效验界面
    func setIDCardView()  {
        identitiesOfTradeView = SetIdentitiesOfTradeView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: _k_h))
        identitiesOfTradeView?.delegate = self
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
    func pushVerificationCodeView(duration: TimeInterval)  {
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.identitiesOfTradeView?.frame = CGRect.init(x: -_k_w, y: 0, width: _k_w, height: _k_h )
            let height:CGFloat = CGFloat(obtainBarHeight_New(vc: self))
            self.payPasswordVerifyView?.frame = CGRect.init(x: 0, y: height, width: _k_w, height: _k_h - height)
        }) { (result) in
        }
    }
    
    /// 推出密码视图
    func pushCashPasswordView(duration: TimeInterval)  {
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.payPasswordVerifyView?.frame = CGRect.init(x: -_k_w, y: 0, width: _k_w, height: _k_h )
            let height:CGFloat = CGFloat(obtainBarHeight_New(vc: self))
            self.payPasswordView?.frame = CGRect.init(x: 0, y: height, width: _k_w, height: _k_h - height)
        }) { (result) in
        }
    }
    
    //MARK: SetIdentitiesOfTradeViewDelegate
    func NextBottonClick(_ code: String) {
        if !CheckUtils.accurateVerifyIDCardNumber(code) {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请输入正确的身份证号")
            return
        }
        verifyIDCardNum(code) {( isSuccess ) in
            if isSuccess {
                self.exhibitionType = .verificationCode_Type
                self.configureView()
                self.pushVerificationCodeView(duration: 0.5)
            }
        }
    }

    func userInputIDCardCode(_ code: String) {

    }
    
    //MARK: SetPayPasswordVerifyViewDelegate
    func userInputVerifyCode(_ code: String) {
        verifyTradeSMS(code) { [weak self] (isSuccess) in
            if isSuccess {
                self?.exhibitionType = .setTradePassword_Type
                self?.configureView()
                self?.pushCashPasswordView(duration: 0.5)
            }else{
                
            }
        }
    }
    
    func sendButtonClick() {
        
        

    }
    
    //MARK: SetPayPasswordViewDelegate
    func userInputCashPasswordCode(_ code: String, type: PasswordType) {
        switch type {
        case .old:
            verifyOldTradePassword(code, { [weak self] (isSuccess) in
                if isSuccess {
                    self?.payPasswordView?.showHeaderDisplayView()
                }
            })
        case .new:
            firstTradePassword = code
            payPasswordView?.showHeaderAgainDisplayView()
        case .verifyNew:
            secondTradePassword = code
            if secondTradePassword != firstTradePassword{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "密码不一致，请重新输入")
                return
            }
            
            let type = "1"
            if self.exhibitionType == .modificationTradePassword_Type {
                
            }
            
            saveNewTradePassword(firstTradePassword!, secondPasswordStr: secondTradePassword!, type: "1", { (isSuccess) in
                if isSuccess {
                    
                }else{
                    
                }
            })
        }
    }
    
    //MRAK:流程结束 跳转逻辑
    func SetPasswordProcessEndJump()  {
        for  vc in self.rt_navigationController.rt_viewControllers {
            if vc.isKind(of: CashWithdrawViewController.self) {
                self.navigationController?.popToViewController(vc, animated: true)
                return
            }
        }
        let cashWithdrawVC = CashWithdrawViewController.init()
        self.navigationController?.pushViewController(cashWithdrawVC, animated: true)
    }
    
    //MARK:网络请求
    func verifyIDCardNum(_ IDStr:String, _ result : @escaping (_ isSuccess : Bool) -> Void)  {
        let transactionVC = SetTransactionPasswordViewModel.init()
        transactionVC.setBlockWithReturn({ [weak self] (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                result(true)
            }else{
                result(false)
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            result(false)
        }
        transactionVC.verifyIdentityCardNumber(IDStr)
    }
    
    func verifyOldTradePassword(_ passwordStr:String , _ result : @escaping (_ isSuccess : Bool) -> Void)  {
        let transactionVC = SetTransactionPasswordViewModel.init()
        transactionVC.setBlockWithReturn({ [weak self] (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                result(true)
                
            }else{
                result(false)
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            result(false)
        }
        transactionVC.verifyOldTradePassword(passwordStr)
    }
    
    func saveNewTradePassword(_ firstPasswordStr:String , secondPasswordStr:String, type:String ,  _ result : @escaping (_ isSuccess : Bool) -> Void)  {
        let transactionVC = SetTransactionPasswordViewModel.init()
        transactionVC.setBlockWithReturn({ [weak self] (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                result(true)
                
            }else{
                result(false)
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            result(false)
        }
        transactionVC.saveNewTradePasswordFirst(firstPasswordStr, second: secondPasswordStr, operateType: type)
    }
    
    func verifyTradeSMS(_ verify_code_:String , _ result : @escaping (_ isSuccess : Bool) -> Void)  {
        let transactionVC = SetTransactionPasswordViewModel.init()
        transactionVC.setBlockWithReturn({ [weak self] (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                result(true)
            }else{
                result(false)
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            result(false)
        }
        transactionVC.verifyTradeSMS(verify_code_)
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
