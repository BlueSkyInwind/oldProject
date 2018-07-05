//
//  ForgetPasswordMoudles.swift
//  fxdProduct
//
//  Created by admin on 2018/7/3.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class ForgetPasswordMoudles: BaseViewController {
    
    var phoneStr:String?

    var forgetPasswordView:ForgetPasswordView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "忘记密码"
        self.addBackItem()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().shouldResignOnTouchOutside = false
        IQKeyboardManager.shared().isEnabled = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().isEnabled = true
    }
    
    func configureView()  {
        forgetPasswordView = ForgetPasswordView.init(frame: CGRect.zero)
        self.view.addSubview(forgetPasswordView!)
        forgetPasswordView?.snp.makeConstraints({ (make) in
            make.top.equalTo(obtainBarHeight_New(vc: self))
            make.bottom.left.right.equalTo(self.view)
        })
        
        forgetPasswordView?.forgetPasswordSendVerifyCodeClick  = {[weak self] (phonenumber) in
            self?.obtainUserForgetPasswordVerifyCode(phonenumber, { (isSuccess) in
                if isSuccess {
                    self?.forgetPasswordView?.verifyCodeView?.createTimer()
                }
            })
        }
        
        forgetPasswordView?.userfindPasswordButtonClick = {[weak self] (button,phoneNum,password,verifyCode) in
            self?.userFindPasswordRequest(phoneNum, password, verifyCode, { (isSuccess) in
                if isSuccess {
                    self?.navigationController?.popViewController(animated: true)
                }
            })
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

extension ForgetPasswordMoudles {
    
    func obtainUserForgetPasswordVerifyCode(_ phoneNumber:String,_ complication:@escaping (_ isSuccess:Bool) -> Void) {
        let smsVM = SMSViewModel.init()
        smsVM.setBlockWithReturn({ (resultModel) in
            let baseModel  = resultModel as! BaseResultModel
            if baseModel.errCode == "0"{
                complication(true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseModel.friendErrMsg)
                complication(false)
            }
        }) {
            complication(false)
        }
        smsVM.fatchRequestSMSParamPhoneNumber(phoneNumber, verifyCodeType: FINDPASS_CODE)
    }
    
    func userFindPasswordRequest(_ phoneNumber:String,_ password:String,_ verifyCode:String,_ complication:@escaping (_ isSuccess:Bool) -> Void)  {
        
        let findVM = FindPassViewModel.init()
        findVM.setBlockWithReturn({ (resultModel) in
            let baseModel  = resultModel as! BaseResultModel
            if baseModel.errCode == "0"{
                complication(true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseModel.friendErrMsg)
                complication(false)
            }
        }) {
            complication(false)
        }
        findVM.fatchFindPassPhone(phoneNumber, password: password, verify_code: verifyCode)
    }
    
}
