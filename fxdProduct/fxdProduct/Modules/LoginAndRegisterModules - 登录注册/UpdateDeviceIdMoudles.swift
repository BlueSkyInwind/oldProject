//
//  UpdateDeviceIdMoudles.swift
//  fxdProduct
//
//  Created by admin on 2018/7/3.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class UpdateDeviceIdMoudles: BaseViewController {

    var phoneStr:String?
    var passwordStr:String?
    
    var updateDeviceView:UpdateDeviceIdView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "重新验证"
        self.addBackItem()
        configureView()
    }
    
    func configureView()  {
        
        updateDeviceView = UpdateDeviceIdView.init(frame: CGRect.zero)
        self.view.addSubview(updateDeviceView!)
        updateDeviceView?.snp.makeConstraints({ (make) in
            make.top.equalTo(obtainBarHeight_New(vc: self))
            make.bottom.left.right.equalTo(self.view)
        })
        
        updateDeviceView?.updateDeviceSendVerifyCodeClick  = {[weak self] (phonenumber) in
            self?.obtainUserUpdateDeviceIDVerifyCode(phonenumber, { (isSuccess) in
                if isSuccess {
                    self?.updateDeviceView?.verifyCodeView?.createTimer()
                }
            })
        }
        
        updateDeviceView?.userUpdateButtonClick = {[weak self] (button,phoneNum,verifyCode) in
            self?.updateDeviceID(phoneNum, verifyCode, { (isSuccess) in
                
            })
        }
    }
    
    func backMainVC()  {
        self.dismiss(animated: true) {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.btb.selectedIndex = 0
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
extension UpdateDeviceIdMoudles {
    
    func obtainUserUpdateDeviceIDVerifyCode(_ phoneNumber:String,_ complication:@escaping (_ isSuccess:Bool) -> Void) {
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
        smsVM.fatchRequestSMSParamPhoneNumber(phoneNumber, verifyCodeType: CHANGEDEVID_CODE)
    }
    
    func updateDeviceID(_ phoneNum:String,_ verifyCode:String,_ complication:@escaping (_ isSuccess:Bool) -> Void)  {
        
        let loginVM = LoginViewModel.init()
        loginVM.setBlockWithReturn({[weak self] (resultModel) in
            let baseModel  = resultModel as! BaseResultModel
            if baseModel.errCode == "0"{
                self?.updateDeviceID(phoneNum, (self?.passwordStr)!, { (isSuccess) in
                })
                complication(true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseModel.friendErrMsg)
                complication(false)
            }
        }) {
            complication(false)
        }
        loginVM.updateDeviceID(phoneNum, verify_code: verifyCode)
    }
    
    func updateIDAndLogin(_ phoneNum:String,_ password:String)  {
        let loginVM = LoginViewModel.init()
        loginVM.setBlockWithReturn({ [weak self](resultModel) in
            let baseModel  = resultModel as! BaseResultModel
            if baseModel.errCode == "0" {
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseModel.friendErrMsg)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                   self?.backMainVC()
                })
            }else if baseModel.errCode == "5" {
                self?.navigationController?.popViewController(animated: true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseModel.friendErrMsg)
            }
        }) {
        }
        loginVM.fatchLoginMoblieNumber(phoneNum, password: password, fingerPrint: nil, verifyCode: nil)
    }
}


