//
//  MXVerifyManager.swift
//  fxdProduct
//
//  Created by admin on 2017/8/25.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

typealias MXVerifyResult = (_ result:NSDictionary) -> Void
class MXVerifyManager: NSObject,MoxieSDKDelegate {
    
    static let shareInstance = MXVerifyManager()
 
    var mxVerifyResult : MXVerifyResult?

    //初始化SDK
    func configMoxieSDK( Viewcontroller:UIViewController, mxVerifyResult : MXVerifyResult){
        //初始化SDK
        MoxieSDK.shared().apiKey = theMoxieApiKey
        MoxieSDK.shared().userId = Utility.shared().userInfo.juid
        MoxieSDK.shared().fromController = Viewcontroller
        MoxieSDK.shared().delegate = self
        configureUI()
        //参数自定义
        /******** 参数自定义详情见OC版本 ******/
    }
    //网银
    func Internetbank() -> Void {
        MoxieSDK.shared().taskType = "bank"
        MoxieSDK.shared().startFunction()
    }
    //社保
    func socialSecurity() -> Void {
        MoxieSDK.shared().taskType = "email"
        MoxieSDK.shared().startFunction()
    }
    //信用卡
    func creditCard() -> Void {
        MoxieSDK.shared().taskType = "security"
        MoxieSDK.shared().startFunction()
    }
    
    func configureUI() {
        MoxieSDK.shared().navigationController.navigationBar.isTranslucent = true
        MoxieSDK.shared().backImageName = "return"
        MoxieSDK.shared().navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        MoxieSDK.shared().navigationController.navigationBar.tintColor = UIColor.white
        MoxieSDK.shared().navigationController.navigationBar.setBackgroundImage(UIImage.init(named: "navigation"), for: UIBarMetrics.default)
    }
    
    func receiveMoxieSDKResult(_ resultDictionary: [AnyHashable : Any]!) {
        let code = resultDictionary["code"] as! String
        print("code:\(resultDictionary["code"]),taskType:\(resultDictionary["taskType"]),taskId:\(resultDictionary["taskId"]),message:\(resultDictionary["message"]),account:\(resultDictionary["account"]),loginDone:\(resultDictionary["loginDone"])")
        if code == "2"{
            
        }
            
    }
    

}
