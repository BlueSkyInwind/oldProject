//
//  FaceIdentiViewController.swift
//  fxdProduct
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit
import MGLivenessDetection
class FaceIdentiViewController: BaseViewController,LiveDeteDelgate{

    var iconImage : UIImageView?
    var titleLabel : UILabel?
    var explainLabel : UILabel?
    var promptLabel : UILabel?
    var statusBtn : UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "人脸识别"
        addBackItem()
        setupUI()
    }
    
    func statusBtnClick() -> Void {
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
        
    }
    func liveDateFaile(_ errorType: MGLivenessDetectionFailedType) {
        showErrorString(errorType: errorType)
    }

    func showErrorString(errorType: MGLivenessDetectionFailedType) -> Void {
        switch (errorType) {
        case DETECTION_FAILED_TYPE_ACTIONBLEND:
            Tool.showMessage("请按照提示完成动作", vc: self)
            break;
        case DETECTION_FAILED_TYPE_NOTVIDEO:
            Tool.showMessage("活体检测未成功", vc: self)
            break;
        case DETECTION_FAILED_TYPE_TIMEOUT:
            Tool.showMessage("请在规定时间内完成动作", vc: self)
            break;
        default:
            Tool.showMessage("请按照提示完成动作", vc: self)
            break;
        }
    }
    
    //MARK: 网络请求
    func verifyLive( faceIDData : FaceIDData) -> Void {
       let userDataVM =  UserDataViewModel.init()
        userDataVM.setBlockWithReturn({ (object) in
            
            
            
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

extension FaceIdentiViewController {
    
   fileprivate func setupUI() -> Void {
        
    iconImage = UIImageView()
    iconImage?.image = UIImage.init(named: "faceIcon")
    self.view.addSubview(iconImage!)
    iconImage?.snp.makeConstraints({ (make) in
        make.centerX.equalTo(self.view.center.x)
        make.width.equalTo(60)
        make.height.equalTo((iconImage?.snp.width)!).multipliedBy(1)
        make.top.equalTo(self.view.snp.top).offset(100)
    })
    
    titleLabel = UILabel()
    titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    titleLabel?.text = "人脸识别"
    titleLabel?.textAlignment = NSTextAlignment.center
    self.view.addSubview(titleLabel!)
    titleLabel?.snp.makeConstraints({ (make) in
        make.centerX.equalTo(self.view.center.x)
        make.width.equalTo(120)
        make.height.equalTo(21)
        make.top.equalTo((iconImage?.snp.bottom)!).offset(5)
    })
    
    explainLabel = UILabel()
    explainLabel?.font = UIFont.systemFont(ofSize: 15)
    explainLabel?.text = "举起手机，正对屏幕，人脸完全置于虚线内跟随提示完成“摇头”“抬头”“眨眼”“张嘴”等动作"
    explainLabel?.numberOfLines = 0
    explainLabel?.textAlignment = NSTextAlignment.center
    self.view.addSubview(explainLabel!)
    explainLabel?.snp.makeConstraints({ (make) in
        make.right.equalTo(self.view.snp.right).offset(-15)
        make.left.equalTo(self.view.snp.left).offset(15)
        make.top.equalTo((titleLabel?.snp.bottom)!).offset(10)
        make.height.equalTo(40)
    })
    
    promptLabel = UILabel()
    promptLabel?.font = UIFont.systemFont(ofSize: 15)
    promptLabel?.text = "温馨提示：动作幅度不要过快哦"
    promptLabel?.textAlignment = NSTextAlignment.center
    self.view.addSubview(promptLabel!)
    promptLabel?.snp.makeConstraints({ (make) in
        make.centerX.equalTo(self.view.center.x)
        make.right.equalTo(self.view.snp.right).offset(-15)
        make.left.equalTo(self.view.snp.left).offset(15)
        make.top.equalTo((explainLabel?.snp.bottom)!).offset(15)
    })
    
    statusBtn = UIButton.init(type: UIButtonType.custom)
    statusBtn?.setTitle("进入检测", for: UIControlState.normal)
    statusBtn?.backgroundColor = UIColor.red
    Tool.setCorner(statusBtn, borderColor: UIColor.red)
    statusBtn?.setTitleColor(UIColor.white, for: UIControlState.normal)
    statusBtn?.addTarget(self, action: #selector(statusBtnClick), for: UIControlEvents.touchUpInside)
    self.view.addSubview(statusBtn!)
    statusBtn?.snp.makeConstraints({ (make) in
        make.top.equalTo(promptLabel!.snp.bottom).offset(20)
        make.left.equalTo(self.view.snp.left).offset(15)
        make.right.equalTo(self.view.snp.right).offset(-15)
        make.height.equalTo(40)
    })
    
    
    
    
    }
}





