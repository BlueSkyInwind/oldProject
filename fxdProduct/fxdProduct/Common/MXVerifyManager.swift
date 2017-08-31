//
//  MXVerifyManager.swift
//  fxdProduct
//
//  Created by admin on 2017/8/25.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

typealias MXVerifyResult = (_ result: [AnyHashable : Any]) -> Void
class MXVerifyManager: NSObject,MoxieSDKDelegate {
    
    static let shareInstance = MXVerifyManager()
 
    var mxVerifyResult : MXVerifyResult?

    //初始化SDK
    func configMoxieSDK( Viewcontroller:UIViewController,  mxResult : @escaping MXVerifyResult){
        //初始化SDK
        MoxieSDK.shared().apiKey = theMoxieApiKey
        MoxieSDK.shared().userId = Utility.shared().userInfo.juid
        MoxieSDK.shared().fromController = Viewcontroller
        MoxieSDK.shared().delegate = self
        configureUI()
        mxVerifyResult = { (result) -> () in
            mxResult(result)
        }
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
        MoxieSDK.shared().taskType = "security"
        MoxieSDK.shared().startFunction()
    }
    //信用卡
    func creditCard() -> Void {
        MoxieSDK.shared().taskType = "email"
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
        let loginDone = resultDictionary["loginDone"] as! Bool

        print("code:\(resultDictionary["code"]),taskType:\(resultDictionary["taskType"]),taskId:\(resultDictionary["taskId"]),message:\(resultDictionary["message"]),account:\(resultDictionary["account"]),loginDone:\(resultDictionary["loginDone"])")

        mxVerifyResult!(resultDictionary)
        if code == "2" && loginDone == false{
            print("任务正在登录中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
        }
            //【采集中】假如code是2且loginDone为true，已经登录成功，正在采集中
        else if code == "2" && loginDone == true{
            print("任务已经登录成功，正在采集中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
        }
            //【采集成功】假如code是1则采集成功（不代表回调成功）
        else if code == "1"{
            print("任务采集成功，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
            mxVerifyResult!(resultDictionary)
        }
        //【未登录】假如code是-1则用户未登录
        else if code == "-1" {
            print("用户未登录");
        }
            //【任务失败】该任务按失败处理，可能的code为0，-2，-3，-4
            //0 其他失败原因
            //-2平台方不可用（如中国移动维护等）
            //-3魔蝎数据服务异常
            //-4用户输入出错（密码、验证码等输错后退出）
        else{
            print("任务失败");
        }
    }
}
