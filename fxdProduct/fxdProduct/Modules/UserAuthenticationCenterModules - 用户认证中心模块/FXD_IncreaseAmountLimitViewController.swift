//
//  FXD_IncreaseAmountLimitViewController.swift
//  fxdProduct
//
//  Created by admin on 2017/12/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class FXD_IncreaseAmountLimitViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView?
    var headerView:FXD_displayAmountCommonHeaderView?
    var appraisalBtn:UIButton?
    
    var creditCardStatus:String? = ""
    var socialSecurityStatus:String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.MXTask()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    func MXTask()  {
        FXD_MXVerifyManager.sharedInteraction().configMoxieSDKViewcontroller(self) { (result) in
            let  dic = result! as! [String:String]
            let code = dic["code"]
            let taskType = dic["taskType"]
            let taskId = dic["taskId"]
            let loginDone = dic["loginDone"]
            
            if (code == "2" && Bool(loginDone!) == true) ||  code == "1" {
                if taskType == "email" {
                    self.TheCreditCardInfoupload(taskId!)
                }
                if taskType == "security" {
                    self.TheSocialSecurityupload(taskId!)
                }
            }
        }
    }
    
    func configureView()  {
        
        self.view.backgroundColor = LOAN_APPLICATION_COLOR
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        self.tableView?.backgroundColor = LOAN_APPLICATION_COLOR
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        tableView?.register(UINib.init(nibName: "HighRankingAuthTableViewCell", bundle: nil), forCellReuseIdentifier: "HighRankingAuthTableViewCell")
        
        if #available(iOS 11.0, *){
            tableView?.contentInsetAdjustmentBehavior = .never;
            tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }else if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = false;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        
        var rect =  CGRect.init(x: 0, y: 0, width: _k_w, height: 205)
        if UI_IS_IPONE6P || UI_IS_IPHONEX{
            rect =  CGRect.init(x: 0, y: 0, width: _k_w, height: 256)
        }
        headerView = FXD_displayAmountCommonHeaderView.init(frame: rect, amount: "3000")
        headerView?.titleLabel?.text = "提额"
        headerView?.hintWordLabel?.text = IncreaseAmountLimitMarkeords
        headerView?.goBackBtn?.isHidden = true
        tableView?.tableHeaderView = headerView
    
    }
    @objc func appraisalBottonClick(){
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UI_IS_IPONE6P || UI_IS_IPHONEX{
            return 45 / 0.8
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighRankingAuthTableViewCell", for: indexPath) as! HighRankingAuthTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle  = .none
        cell.statusLabel.text = "未完成"
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "信用卡认证";
            if creditCardStatus == "1" {
                cell.statusLabel.textColor = UI_MAIN_COLOR
                cell.statusLabel.text = "已完成"
            }
            
            if creditCardStatus == "2" {
                cell.statusLabel.text = "认证中"
            }
            
            break
        case 1:
            cell.titleLabel.text = "社保认证";
            if socialSecurityStatus == "1" {
                cell.statusLabel.textColor = UI_MAIN_COLOR
                cell.statusLabel.text = "已完成"
            }
            if socialSecurityStatus == "2" {
                cell.statusLabel.text = "认证中"
            }
            break
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if creditCardStatus == "2" || creditCardStatus == "3"{
                break
            }
              FXD_MXVerifyManager.sharedInteraction().mailImportClick()
            break
        case 1:
            if socialSecurityStatus == "2" || socialSecurityStatus == "3"{
                break
            }
             FXD_MXVerifyManager.sharedInteraction().securityImportClick()
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 42))
        let label = UILabel()
        label.textColor = UI_MAIN_COLOR
        label.text = "快速提额任务"
        label.font = UIFont.yx_systemFont(ofSize: 14)
        headerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalTo(headerView.snp.center)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 150))
        footerView.backgroundColor = LOAN_APPLICATION_COLOR
        appraisalBtn = UIButton.init(type: UIButtonType.custom)
        appraisalBtn?.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
        appraisalBtn?.setTitle("测评提额", for: UIControlState.normal)
        appraisalBtn?.addTarget(self, action: #selector(appraisalBottonClick), for: UIControlEvents.touchUpInside)
        footerView.addSubview(appraisalBtn!)
        appraisalBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo(footerView.snp.top).offset(40)
            make.left.equalTo(footerView.snp.left).offset(25)
            make.right.equalTo(footerView.snp.right).offset(-25)
        })
        return footerView
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

extension FXD_IncreaseAmountLimitViewController {
    
    func TheCreditCardInfoupload(_ taskid:String) {
        let userDataVM = UserDataViewModel.init()
        userDataVM.setBlockWithReturn({ (resultObject) in
            let baseResult = try! BaseResultModel.init(dictionary: resultObject as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                self.obtainHighRanking()
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        userDataVM.theCreditCardInfoUpload(taskid)
    }
    
    func TheSocialSecurityupload(_ taskid:String) {
        let userDataVM = UserDataViewModel.init()
        userDataVM.setBlockWithReturn({ (resultObject) in
            let baseResult = try! BaseResultModel.init(dictionary: resultObject as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                self.obtainHighRanking()
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
        }
        userDataVM.socialSecurityInfoUpload(taskid)
    }

    func obtainHighRanking()  {
        let userDataVM = UserDataViewModel.init()
        userDataVM.setBlockWithReturn({ (resultObject) in
            let baseResult = try! BaseResultModel.init(dictionary: resultObject as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                let array = baseResult.data as! NSArray
                for dic in array {
                    let highRandM = try! HighRandingModel.init(dictionary: dic as! [AnyHashable : Any])
                    if highRandM.tasktypeid == "1" {
                        self.creditCardStatus = highRandM.resultid
                    }
                    if highRandM.tasktypeid == "2" {
                        self.socialSecurityStatus = highRandM.resultid
                    }
                }
                self.tableView?.reloadData()
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
        }
        userDataVM.obtainhighRankingStatus()
    }
}




