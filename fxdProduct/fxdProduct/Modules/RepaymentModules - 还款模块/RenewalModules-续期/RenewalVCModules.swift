//
//  RenewalViewController.swift
//  fxdProduct
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class RenewalVCModules: BaseViewController ,UITableViewDataSource,UITableViewDelegate{

    //tab左边的文字内容
    var leftTitleArr = ["逾期费用","使用溢缴金","应付金额","支付方式"]
    let cellId = "CellId"
    var headerView: CurrentInformationHeadView? = nil
    //tab右边的内容
    var contentArr : [String] = [String]()
    var cardInfo : CardInfo?
    //当前期的分期id
   @objc var stagingId : String?
    var currentindex : Int?
    var patternName : String?

    let renewalTableView: UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "续期费用"
        currentindex = 0
        addBackItem()
        //头部视图
        headerView = CurrentInformationHeadView()
        headerView?.moneyDescLabel?.text = "续期费用(元)"
        headerView?.backgroundColor = UI_MAIN_COLOR
        renewalTableView.tableHeaderView = headerView
        
        //底部确认按钮视图
        let footerView = FooterBtnView()
        footerView.frame = CGRect(x:0,y:0,width:_k_w,height:50)
        footerView.footerBtn?.setTitle("确认", for: .normal)
        footerView.footerBtnClosure = {
            self.submitRenewalRequest()
//         print("确认按钮点击")
        }
        renewalTableView.tableFooterView = footerView
        
        renewalTableView.delegate = self
        renewalTableView.dataSource = self
        self.view.addSubview(renewalTableView)
        renewalTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        getRenewalInformation()
        getBankCardsList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 19)]

    }
    
    //MARK:获取当前期的续期信息
    func getRenewalInformation(){
    
        let repayMentViewModel = RepayMentViewModel()
        
        repayMentViewModel.setBlockWithReturn({ (returnValue) in
            
             let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                
                let renewalModel = try? RenewalModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                
                let str=NSString(string:(renewalModel?.extensionFee!)!)
                let number = NSNumber.init(value: str.floatValue)
                self.headerView?.moneyLabel?.fn_setNumber(number, format: "%.0f")
                
                self.contentArr.append((renewalModel?.overdueAmount!)!)
                self.contentArr.append((renewalModel?.balanceFee!)!)
                self.contentArr.append((renewalModel?.shallPayFee!)!)
                self.renewalTableView.reloadData()
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        repayMentViewModel.getCurrentRenewal(withStagingId: stagingId)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leftTitleArr.count+1
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:CurrentInformationCell! = tableView.dequeueReusableCell(withIdentifier:cellId) as? CurrentInformationCell
        if cell == nil {
            cell = CurrentInformationCell.init(style: .default, reuseIdentifier: cellId)
        }
        cell.selectionStyle = .none
        if contentArr.count<2{
            return cell
        }
        if indexPath.row<leftTitleArr.count{
        
            cell.cellType = CurrentInfoCellType(cellType: .Default)
            cell.leftLabel?.text = leftTitleArr[indexPath.row]
            
            if indexPath.row == 3{
                    if cardInfo != nil{
                        let index = cardInfo?.cardNo.index((cardInfo?.cardNo.endIndex)!, offsetBy: -4)
//                        let numStr = cardInfo?.cardNo.substring(from: index!)
                        let numStr = cardInfo?.cardNo.suffix(from: index!)
                        
                        cell.rightLabel?.text = (cardInfo?.bankName)!+" 尾号 "+"("+numStr!+")"
                    }
                return cell
            }
            cell.rightLabel?.textColor = UIColor.black
            if indexPath.row == 1 || indexPath.row == 2 {
            
                cell.rightLabel?.textColor = UI_MAIN_COLOR
            }
            cell.rightLabel?.text = contentArr[indexPath.row]+"元"
            return cell
        }
        
        cell.cellType = CurrentInfoCellType(cellType: .Renewal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 3{
            let userBankCardListVC = UserBankCardListVCModule()
            userBankCardListVC.currentIndex = currentindex!
            userBankCardListVC.userSelectedBankCard({ [weak self] (cardInfo, currentIndex) in
                self?.cardInfo = cardInfo
                self?.currentindex = currentIndex
                self?.renewalTableView.reloadData()
            })
            self.navigationController?.pushViewController(userBankCardListVC, animated: true)
        }
        if indexPath.row == 4{
            obtainRenewalRules()
        }
    }
 
    //MARK:获取用户的银行卡列表
    func getBankCardsList(){
    
        let bankInfoVM = BankInfoViewModel()
        bankInfoVM.setBlockWithReturn({ (returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                for dic in baseResult.data as! NSArray{
                
                    let cardInfo = try! CardInfo.init(dictionary: dic as! [AnyHashable : Any])
                    if cardInfo.cardType == "2"{
                        self.cardInfo = cardInfo
                        self.renewalTableView.reloadData()
                        break
                    }
                }
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        bankInfoVM.obtainUserBankCardList()
    }
    
    //MARK:提交续期请求
    func submitRenewalRequest(){
        
        let bankInfoVM = BankInfoViewModel()
        bankInfoVM.setBlockWithReturn({ (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
            
                let idVC = self.rt_navigationController?.rt_viewControllers[1] as! LoanMoneyViewController
                idVC.applicationStatus = .Staging
                _ = self.navigationController?.popToViewController(idVC, animated: true)

            }else{
                print("================",baseResult.errMsg)
                 MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) { 
            
        }
        bankInfoVM.obtainUserCommitStaging(stagingId, cardId: self.cardInfo?.cardId)
    }
    
    //MARK:获取续期规则
    func obtainRenewalRules(){
    
        let bankInfoVM = BankInfoViewModel()
        bankInfoVM.setBlockWithReturn({ (returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                
                let model = try! P2PContactContentModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                let detailVC = DetailViewController()
                detailVC.content = model.rule;
                detailVC.navTitle = "续期规则";
                self.navigationController?.pushViewController(detailVC, animated: true)

            }else{
                print("================",baseResult.errMsg)
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) { 
            
        }
        bankInfoVM.obtainUserStagingRule()
    }
    //d19296c082164be1af7f4a8e7279b04b
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
