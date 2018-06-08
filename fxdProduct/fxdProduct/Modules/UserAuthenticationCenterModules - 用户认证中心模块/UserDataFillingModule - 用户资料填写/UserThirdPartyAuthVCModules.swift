//
//  thirdPartyAuthViewController.swift
//  fxdProduct
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class UserThirdPartyAuthVCModules: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var phoneAuthChannel : String?
    var resultCode : String?
    var isZmxyAuth : String?
    var verifyStatus : String?
    var isMobileAuth : String?
    var isPhoneAuthType : Bool?
    
    var tableView : UITableView?
    var thirdPartyAuthCell :ThirdPartyAuthTableViewCell?
//    let dataArr : Array<String> = ["视频认证","手机认证","芝麻信用","工资流水"]
    let dataArr : Array<String> = ["视频认证","手机认证","工资流水"]

    var userThirdPartCM:UserThirdPartCertificationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "三方认证"
        userThirdPartCM = UserThirdPartCertificationModel.init()
        isZmxyAuth = "3"
        isMobileAuth = "0"
        verifyStatus = "0"
        addBackItem()
        setupUI()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThirdPartCertification()
        self.MXTask()
    }
    
    func setupUI() -> Void {
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView?.delegate = self;
        tableView?.dataSource = self;
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        tableView?.register(ThirdPartyAuthTableViewCell.self, forCellReuseIdentifier: "ThirdPartyAuthTableViewCell")
    }
    
    ///魔蝎三方认证
    func MXTask()  {
        FXD_MXVerifyManager.sharedInteraction().configMoxieSDKViewcontroller(self) { (result) in
            print(result ?? "")
            let  dic = result! as NSDictionary
            let code = dic["code"] as! NSString
            let taskType = dic["taskType"] as! NSString
            let taskId = dic["taskId"] as! NSString
            let loginDone = dic["loginDone"] as! NSNumber
            
            if code == "2" && loginDone.boolValue == true {
                self.TheInternetBankupload(taskid: taskId as String)
            }else if code == "1" {
                self.TheInternetBankupload(taskid: taskId as String)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if resultCode == "0" && indexPath.row == 0 {
            return 0
        }
        return 44
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        thirdPartyAuthCell = tableView.dequeueReusableCell(withIdentifier:  "ThirdPartyAuthTableViewCell", for: indexPath) as? ThirdPartyAuthTableViewCell
        switch indexPath.row {
        case 0:
            thirdPartyAuthCell?.titleLabel?.text = dataArr[indexPath.row]
            thirdPartyAuthCell?.statusLabel?.text = userThirdPartCM?.faceIdentityDesc == nil ? "未完成":userThirdPartCM?.faceIdentityDesc

            break
        case 1:
            thirdPartyAuthCell?.titleLabel?.text = dataArr[indexPath.row]
            thirdPartyAuthCell?.statusLabel?.text = userThirdPartCM?.telephoneDesc == nil ? "未完成":userThirdPartCM?.telephoneDesc

            break
//        case 2:
//            thirdPartyAuthCell?.titleLabel?.text = dataArr[indexPath.row]
//            thirdPartyAuthCell?.statusLabel?.text = userThirdPartCM?.zmIdentityDesc == nil ? "未完成":userThirdPartCM?.zmIdentityDesc
//            break
        case 2:
            thirdPartyAuthCell?.titleLabel?.text = dataArr[indexPath.row]
            thirdPartyAuthCell?.statusLabel?.text = userThirdPartCM?.salaryDesc == nil ? "未完成":userThirdPartCM?.salaryDesc

            break
            
        default:
            break
        }
        
        if thirdPartyAuthCell?.statusLabel?.text == "已认证" {
            thirdPartyAuthCell?.statusLabel?.textColor = UIColor.init(red: 42/255, green: 155/255, blue: 234/255, alpha: 1)
        }else{
            thirdPartyAuthCell?.statusLabel?.textColor = UIColor.init(red: 159/255, green: 160/255, blue: 162/255, alpha: 1)
        }
        return thirdPartyAuthCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row{
        case 0:
            if userThirdPartCM?.faceIdentity == "2" || userThirdPartCM?.faceIdentity == "3"{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: userThirdPartCM?.faceIdentityDesc)
                return;
            }
             startFaceDetection()
            break
        case 1:

            if userThirdPartCM?.telephone == "2" || userThirdPartCM?.telephone == "3"{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: userThirdPartCM?.telephoneDesc)
                return;
            }
            let certificationVC = UserMobileAuthenticationVCModules.init()
            certificationVC.phoneAuthChannel = "TC"
            certificationVC.isMobileAuth = isMobileAuth
            self.navigationController?.pushViewController(certificationVC, animated: true)
            break
        case 2:
            if userThirdPartCM?.salaryEdit == "0" {
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: userThirdPartCM?.salaryDesc)
                return;
            }
             FXD_MXVerifyManager.sharedInteraction().internetbank()
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 150))
        footerView.backgroundColor = LOAN_APPLICATION_COLOR
        return footerView
    }
    
    func mobilePhoneOperatorChannels() -> Bool {
        var result = true
        if resultCode == "1" {
            //模拟的运营商认证
            isPhoneAuthType = false
        }else{
            liveDiscernAndmibileAuthJudge(result: { (isPass) in
                result = isPass
            })
        }
        return result
    }
    
    func liveDiscernAndmibileAuthJudge(result:(_ isPass:Bool) -> Void) -> Void {
        
        if verifyStatus == "2" ||  verifyStatus == "3" {
            //三方运营商认证
            isPhoneAuthType = true
            result(true)
        }else if verifyStatus == "1"{
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请先进行视频认证")
            result(false)
        }else{
            //模拟的运营商认证
            isPhoneAuthType = false
            result(true)
        }
    }
    
    //MARK: 三方认证状态
    func ThirdPartCertification() -> Void{
        let  userDataVM =  UserDataViewModel()
        userDataVM.setBlockWithReturn({[weak self] (result) in
           let baseResult = try! BaseResultModel.init(dictionary: result as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                 let userThirdPartCertificationModel = try! UserThirdPartCertificationModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                self?.userThirdPartCM = userThirdPartCertificationModel

                self?.tableView?.reloadData()
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
        }
        userDataVM.obtainthirdPartCertificationStatus()
    }
    
    func TheInternetBankupload(taskid : String)  {
        let  userDataVM = UserDataViewModel.init()
        userDataVM.setBlockWithReturn({[weak self] (result) in
            let baseResult = try! BaseResultModel.init(dictionary: result as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                self?.ThirdPartCertification()
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        userDataVM.theInternetbankUpload(taskid)
    }
    
    func startFaceDetection() -> Void {
        obtainVideoVerifyInfo { (isSuccess, content,time) in
            guard !isSuccess else {
                let videoVerifyVC = VideoVerifyViewController.init()
                videoVerifyVC.displaystr = content
                videoVerifyVC.RecordsTimeMax = Int(time)!
                self.present(videoVerifyVC, animated: true, completion: nil)
                return
            }
        }
    }
    /// 获取视频信息
    func obtainVideoVerifyInfo(finish:@escaping (_ isSuccess:Bool,_ content:String,_ time:String) -> Void)  {
        let  userDataVM = UserDataViewModel.init()
        userDataVM.setBlockWithReturn({[weak self] (result) in
            let baseResult = result as? BaseResultModel
            if baseResult?.errCode == "0" {
                let dic = baseResult?.data as! Dictionary<String,Any>
                if let contentStr = dic["content"], let time = dic["time"] {
                    finish(true,contentStr as! String,time as! String)
                }
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message:baseResult?.friendErrMsg)
                finish(false,"","")
            }
        }) {
            finish(false,"","")
        }
        userDataVM.obtainVideoVerifyContent()
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





