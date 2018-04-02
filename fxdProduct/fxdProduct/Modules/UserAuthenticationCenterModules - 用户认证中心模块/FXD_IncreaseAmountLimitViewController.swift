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
    
    var highRandingM:HighRandingModel?

    var isTestFlag:Bool = false
    var isCompleteFlag:Bool = false
    
    var amount:String? {
        didSet{
            headerView?.amountStr = amount
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.MXTask()
        obtainHighRanking()
        obtainViewConInfo()
        addBackItem()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    func MXTask()  {
        FXD_MXVerifyManager.sharedInteraction().configMoxieSDKViewcontroller(self) { (result) in
            let  dic = result! as NSDictionary
            let code = dic["code"] as! NSString
            let taskType = dic["taskType"] as! NSString
            let taskId = dic["taskId"] as! NSString
            let loginDone = dic["loginDone"] as! NSNumber
            
            if (code == "2" && loginDone.boolValue == true) ||  code == "1" {
                if taskType == "email" {
                    self.TheCreditCardInfoupload(taskId as String)
                }
                if taskType == "security" {
                    self.TheSocialSecurityupload(taskId as String)
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
        tableView?.isScrollEnabled = true
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
        headerView = FXD_displayAmountCommonHeaderView.init(frame: rect, amount: "")
        headerView?.titleLabel?.text = "提额"
        headerView?.hintWordLabel?.text = IncreaseAmountLimitMarkeords
        headerView?.goBackBtn?.isHidden = false
        headerView?.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
        tableView?.tableHeaderView = headerView
    
    }
    
    @objc func appraisalBottonClick(){
        
        if isTestFlag {
            userRequestImproveAmount({ (isSuccess) in
                if isSuccess {
                    self.tabBarController?.selectedIndex = 0;
                }
            })
        }else{
            guard isCompleteFlag else {
                let userDataVC = UserDataAuthenticationListVCModules.init(nibName: "UserDataAuthenticationListVCModules", bundle: nil)
                self.navigationController?.pushViewController(userDataVC, animated: true)
                return
            }
        }
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
        switch indexPath.row {
        case 0:
            cell.statusLabel.text = highRandingM == nil ? "未完成" : highRandingM?.creditMailDesc
            cell.titleLabel.text = "信用卡认证";
            if creditCardStatus == "3" {
                cell.statusLabel.textColor = UI_MAIN_COLOR
            }

            break
        case 1:
            cell.statusLabel.text = highRandingM == nil ? "未完成" : highRandingM?.socialDesc
            cell.titleLabel.text = "社保认证";
            if socialSecurityStatus == "3" {
                cell.statusLabel.textColor = UI_MAIN_COLOR
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
        label.textColor = UIColor.init(red: 175/255, green: 177/255, blue: 179/255, alpha: 1)
        label.text = "快速提额任务"
        label.font = UIFont.yx_systemFont(ofSize: 13)
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
        appraisalBtn?.addTarget(self, action: #selector(appraisalBottonClick), for: .touchUpInside)
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
                let highRandM = try! HighRandingModel.init(dictionary:baseResult.data as! [AnyHashable : Any])
                self.creditCardStatus = highRandM.creditMail
                self.socialSecurityStatus = highRandM.social
                self.highRandingM = highRandM

                self.tableView?.reloadData()
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
        }
        userDataVM.obtainhighRankingStatus()
    }
    
    func obtainViewConInfo()  {
        let userDataVM = UserDataViewModel.init()
        userDataVM.setBlockWithReturn({ (resultObject) in
            let baseResult = resultObject as? BaseResultModel
            if baseResult?.errCode == "0"{
                let customerMeasureAmountInfo = try! CustomerMeasureAmountInfo.init(dictionary: baseResult?.data as! [AnyHashable : Any])
                self.amount = customerMeasureAmountInfo.amount
                self.isTestFlag = (customerMeasureAmountInfo.testFlag as NSString).boolValue
                self.isCompleteFlag =  (customerMeasureAmountInfo.completeFlag as NSString).boolValue
                if !self.isTestFlag {
//                    MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
                }
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult?.friendErrMsg)
            }
        }) {
        }
        userDataVM.obtainUserCreditLimit()
    }
    
    func userRequestImproveAmount(_ isFinish:@escaping (_ success:Bool) -> Void)  {
        let userDataVM = UserDataViewModel.init()
        userDataVM.setBlockWithReturn({ (returnValue) in
//            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            let baseResult = returnValue  as! BaseResultModel
            if baseResult.errCode == "0"{
                isFinish(true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
                isFinish(false)
            }
        }, withFaileBlock: {
            isFinish(false)
        })
//        userDataVM.userDataCertification(EliteLoan)
        userDataVM.user(toImproveAmount: EliteLoan)
    }
}


