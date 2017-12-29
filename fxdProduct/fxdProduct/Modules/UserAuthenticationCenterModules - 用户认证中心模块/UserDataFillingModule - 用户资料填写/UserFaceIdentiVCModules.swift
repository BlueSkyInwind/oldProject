//
//  UserFaceIdentiVCModules.swift
//  fxdProduct
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit
import MGLivenessDetection

typealias IdentifyResultStatus = (_ status : String) ->Void
class UserFaceIdentiVCModules: BaseViewController,LiveDeteDelgate{
    
   @objc var verifyStatus : String?

   @objc var iconImage : UIImageView?
   @objc var titleLabel : UILabel?
   @objc var explainLabel : UILabel?
   @objc var promptLabel : UILabel?
   @objc var statusBtn : UIButton?
   @objc var identifyResultStatus : IdentifyResultStatus?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "人脸识别"
        addBackItem()
        setupUI()
        changeStatus()
    }
    
    func changeStatus() -> Void {
        if verifyStatus == "1" {
            statusBtn?.isEnabled = true
            statusBtn?.backgroundColor = UI_MAIN_COLOR
            statusBtn?.setTitle("进入检测", for: UIControlState.normal)
        }else {
            statusBtn?.isEnabled = false
            statusBtn?.backgroundColor = UIColor.init(red: 139/255, green: 140/255, blue: 143/255, alpha: 1)
            statusBtn?.setTitle("已认证", for: UIControlState.normal)
        }
    }
    
    @objc func statusBtnClick() -> Void {
        startFaceDetection()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startFaceDetection() -> Void {
        MGLicenseManager.license { (License) in
            if License {
                let mGLiveVC = MGLiveViewController.init(defauleSetting: ())
                mGLiveVC?.delagate  = self
                let baseVC = BaseNavigationViewController.init(rootViewController: mGLiveVC!)
                self.present(baseVC, animated: true, completion: nil)
            }
        }
    }
    
    //MARK:  LiveDeteDelgate 事件
    func liveDateSuccess(_ faceIDData: FaceIDData!) {
        verifyLive(faceIDData: faceIDData)
    }
    func liveDateFaile(_ errorType: MGLivenessDetectionFailedType) {
        showErrorString(errorType: errorType)
    }

    func showErrorString(errorType: MGLivenessDetectionFailedType) -> Void {
        switch (errorType) {
        case DETECTION_FAILED_TYPE_ACTIONBLEND:
            FXD_Tool.showMessage("请按照提示完成动作", vc: self)
            break;
        case DETECTION_FAILED_TYPE_NOTVIDEO:
            FXD_Tool.showMessage("活体检测未成功", vc: self)
            break;
        case DETECTION_FAILED_TYPE_TIMEOUT:
            FXD_Tool.showMessage("请在规定时间内完成动作", vc: self)
            break;
        default:
            FXD_Tool.showMessage("请按照提示完成动作", vc: self)
            break;
        }
    }
    
    //MARK: 网络请求
    func verifyLive( faceIDData : FaceIDData) -> Void {
       let userDataVM =  UserDataViewModel.init()
        userDataVM.setBlockWithReturn({[weak self] (object) in
            let baseResult = object as? BaseResultModel
            if baseResult?.errCode == "0"{
                let dic = baseResult?.data as! NSDictionary
                let statusMsg = dic["verify_msg_"] as! String
                let status = dic["verify_status_"]
                self?.verifyStatus = String.init(format: "%@", status as! CVarArg)
                self?.changeStatus()
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: statusMsg)
                if ((self?.identifyResultStatus) != nil) {
                    self?.identifyResultStatus!((self?.verifyStatus)!)
                }
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message:baseResult?.friendErrMsg)
            }
        }) {
        }
        userDataVM.uploadLiveIdentiInfo(faceIDData)
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

extension UserFaceIdentiVCModules {
    
   fileprivate func setupUI() -> Void {
        
    iconImage = UIImageView()
    iconImage?.image = UIImage.init(named: "faceIcon")
    self.view.addSubview(iconImage!)
    iconImage?.snp.makeConstraints({ (make) in
        make.centerX.equalTo(self.view.center.x)
        make.width.equalTo(90)
        make.height.equalTo((iconImage?.snp.width)!).multipliedBy(1)
        make.top.equalTo(self.view.snp.top).offset(100)
    })
    
    titleLabel = UILabel()
    titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    titleLabel?.text = "人脸识别"
    titleLabel?.textAlignment = NSTextAlignment.center
    self.view.addSubview(titleLabel!)
    titleLabel?.snp.makeConstraints({ (make) in
        make.centerX.equalTo(self.view.center.x)
        make.width.equalTo(200)
        make.height.equalTo(35)
        make.top.equalTo((iconImage?.snp.bottom)!).offset(20)
    })
    
    explainLabel = UILabel()
    explainLabel?.font = UIFont.systemFont(ofSize: 15)
    if UI_IS_IPONE5{
        explainLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    explainLabel?.text = "举起手机，正对屏幕，人脸完全置于虚线内跟随提示完成“摇头”“抬头”“眨眼”“张嘴”等动作"
    explainLabel?.numberOfLines = 0
    explainLabel?.textColor = UIColor.init(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
    explainLabel?.textAlignment = NSTextAlignment.center
    self.view.addSubview(explainLabel!)
    explainLabel?.snp.makeConstraints({ (make) in
        make.right.equalTo(self.view.snp.right).offset(-20)
        make.left.equalTo(self.view.snp.left).offset(20)
        make.top.equalTo((titleLabel?.snp.bottom)!).offset(60)
        make.height.equalTo(40)
    })
    
    promptLabel = UILabel()
    promptLabel?.font = UIFont.systemFont(ofSize: 15)
    promptLabel?.text = "温馨提示：动作幅度不要过快哦"
    promptLabel?.textColor = UIColor.init(red: 63/255, green: 169/255, blue: 245/255, alpha: 1)
    promptLabel?.textAlignment = NSTextAlignment.center
    self.view.addSubview(promptLabel!)
    promptLabel?.snp.makeConstraints({ (make) in
        make.centerX.equalTo(self.view.center.x)
        make.right.equalTo(self.view.snp.right).offset(-20)
        make.left.equalTo(self.view.snp.left).offset(20)
        make.top.equalTo((explainLabel?.snp.bottom)!).offset(60)
    })
    
    statusBtn = UIButton.init(type: UIButtonType.custom)
    statusBtn?.setTitle("进入检测", for: UIControlState.normal)
    statusBtn?.backgroundColor = UI_MAIN_COLOR
    FXD_Tool.setCorner(statusBtn, borderColor: UIColor.clear)
    statusBtn?.setTitleColor(UIColor.white, for: UIControlState.normal)
    statusBtn?.addTarget(self, action: #selector(statusBtnClick), for: UIControlEvents.touchUpInside)
    self.view.addSubview(statusBtn!)
    statusBtn?.snp.makeConstraints({ (make) in
        make.top.equalTo(promptLabel!.snp.bottom).offset(20)
        make.left.equalTo(self.view.snp.left).offset(20)
        make.right.equalTo(self.view.snp.right).offset(-20)
        make.height.equalTo(50)
    })
    
    }
}





