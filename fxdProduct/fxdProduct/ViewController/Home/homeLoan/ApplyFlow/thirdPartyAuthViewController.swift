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
                thirdPartyAuthCell?.statusLabel?.text = "未完成"
            }else{
                thirdPartyAuthCell?.statusLabel?.text = "已完成"
            }
            break
        case 1:
            thirdPartyAuthCell?.titleLabel?.text = dataArr[indexPath.row]
            if isMobileAuth != "0" {
                thirdPartyAuthCell?.statusLabel?.text = "已完成"
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
            self.navigationController?.pushViewController(faceIdentiCreditVC, animated: true)
            break
        case 1:
            let certificationVC = CertificationViewController.init()
            self.navigationController?.pushViewController(certificationVC, animated: true)
            break
        case 2:
            if isZmxyAuth == "2" {
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "您已完成认证")
                return;
            }
            
            if isZmxyAuth == "1" {
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "您正在认证中，请勿重复认证!")
                return;
            }
            
            let sesameCreditVC  = SesameCreditViewController.init()
            self.navigationController?.pushViewController(sesameCreditVC, animated: true)
            break
        default:
            break
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





