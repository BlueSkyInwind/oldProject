//
//  thirdPartyAuthViewController.swift
//  fxdProduct
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class thirdPartyAuthViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var phoneAuthChannel : String?
    var resultCode : String?
    var isZmxyAuth : String?
    var verifyStatus : String?
    var isMobileAuth : String?
    var isPhoneAuthType : Bool?

    var tableView : UITableView?
    var thirdPartyAuthCell :ThirdPartyAuthTableViewCell?
    let dataArr : Array<String> = ["人脸识别","手机认证","芝麻信用"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "三方认证"
        addBackItem()
        setupUI()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThirdPartCertification()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if resultCode == "0" && indexPath.row == 0 {
            return 0
        }
        return 44
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        thirdPartyAuthCell = tableView.dequeueReusableCell(withIdentifier:  "ThirdPartyAuthTableViewCell", for: indexPath) as? ThirdPartyAuthTableViewCell
        switch indexPath.row {
        case 0:
            thirdPartyAuthCell?.titleLabel?.text = dataArr[indexPath.row]
            if verifyStatus == "1" {
                thirdPartyAuthCell?.statusLabel?.text = "已完成"
            }else{
                thirdPartyAuthCell?.statusLabel?.text = "未完成"
            }
            break
        case 1:
            thirdPartyAuthCell?.titleLabel?.text = dataArr[indexPath.row]
            if isMobileAuth == "1" {
                thirdPartyAuthCell?.statusLabel?.text = "已完成"
            }else{
                thirdPartyAuthCell?.statusLabel?.text = "未完成"
            }
            break
        case 2:
            thirdPartyAuthCell?.titleLabel?.text = dataArr[indexPath.row]
            if isZmxyAuth == "2" {
                thirdPartyAuthCell?.statusLabel?.text = "已完成"
            }else if isZmxyAuth == "1" {
                thirdPartyAuthCell?.statusLabel?.text = "认证中"
            }else if isZmxyAuth == "3" {
                thirdPartyAuthCell?.statusLabel?.text = "未完成"
            }
            break
        default:
            break
        }
        
        if thirdPartyAuthCell?.statusLabel?.text == "已完成" {
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
            let faceIdentiCreditVC  = FaceIdentiViewController.init()
            faceIdentiCreditVC.verifyStatus = verifyStatus
            self.navigationController?.pushViewController(faceIdentiCreditVC, animated: true)
            faceIdentiCreditVC.identifyResultStatus = { [weak self] (status) -> () in
                self?.verifyStatus  = status
                self?.tableView?.reloadData()
            }
            break
        case 1:
            /*
            guard mobilePhoneOperatorChannels() else {
                return
            }
            */
            let certificationVC = CertificationViewController.init()
            certificationVC.phoneAuthChannel = phoneAuthChannel
            certificationVC.isMobileAuth = isMobileAuth
            certificationVC.whetherPhoneAuth = isPhoneAuthType!
            self.navigationController?.pushViewController(certificationVC, animated: true)
            break
        case 2:
            if isZmxyAuth == "2" {
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "您已完成认证")
                return;
            }
            
            if isZmxyAuth == "1" {
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "您正在认证中，请勿重复认证!")
                return
            }
            
            let sesameCreditVC  = SesameCreditViewController.init()
            self.navigationController?.pushViewController(sesameCreditVC, animated: true)
            break
        default:
            break
        }
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
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请先进行人脸识别")
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
        userDataVM.setBlockWithReturn({ (result) in
           let baseResult = try! BaseResultModel.init(dictionary: result as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                 let userThirdPartCertificationModel = try! UserThirdPartCertificationModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                self.verifyStatus = userThirdPartCertificationModel.faceIdentity;
                self.isMobileAuth = userThirdPartCertificationModel.telephone;
                self.isZmxyAuth = userThirdPartCertificationModel.zmIdentity;
                self.tableView?.reloadData()
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        userDataVM.obtainthirdPartCertificationStatus()
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





