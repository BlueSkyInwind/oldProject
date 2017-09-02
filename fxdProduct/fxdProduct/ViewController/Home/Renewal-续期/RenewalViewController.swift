//
//  RenewalViewController.swift
//  fxdProduct
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class RenewalViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    var leftTitleArr = ["逾期费用","使用溢缴金","应付金额","支付方式"]
    let cellId = "CellId"
    var headerView: CurrentInformationHeadView? = nil
    var contentArr : [String] = [String]()
    var supportBankListArr : [AnyObject] = [AnyObject]()
    var cardInfo : CardInfo?
    var defaultBankIndex: NSInteger?
    var userSelectIndex : NSInteger?
    
    let renewalTableView: UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        
        
//        tableView.backgroundColor = APPColor.shareInstance.homeTableViewColor
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "续期费用"
        
        addBackItem()
        defaultBankIndex = -1
        userSelectIndex = defaultBankIndex
        
        headerView = CurrentInformationHeadView()
        headerView?.moneyDescLabel?.text = "续期费用(元)"
        headerView?.backgroundColor = UI_MAIN_COLOR
        renewalTableView.tableHeaderView = headerView
        
        let footerView = FooterBtnView()
        footerView.frame = CGRect(x:0,y:0,width:_k_w,height:60)
        footerView.footerBtn?.setTitle("确认", for: .normal)
        footerView.footerBtnClosure = {
        
            print("确认按钮点击")
        }
        renewalTableView.tableFooterView = footerView
        
        
        renewalTableView.delegate = self
        renewalTableView.dataSource = self
        self.view.addSubview(renewalTableView)
        renewalTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UI_MAIN_COLOR
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.backgroundImage(for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
       getData()

       fatchBankList()
//       getGatheringInformation_jhtml()
        
        
//        headerView.backClosure = {
//        
//            self.navigationController?.popViewController(animated: true)
//        }

    }
    
    
    func getData(){
    
        let repayMentViewModel = RepayMentViewModel()
        
        repayMentViewModel.setBlockWithReturn({ (returnValue) in
            
             let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                
                let renewalModel = try! RenewalModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                
                self.headerView?.moneyLabel?.text = renewalModel.extensionFee!
                self.contentArr.append(renewalModel.overdueAmount!)
                self.contentArr.append(renewalModel.balanceFee!)
                self.contentArr.append(renewalModel.shallPayFee!)
                
                self.renewalTableView.reloadData()
            }else{
            
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
            
            
        }) { 
            
        }
        repayMentViewModel.getCurrentRenewal(withStagingId: "34c563ab9f934a7396b4d8569622f56b")

    }
    func addBackItem(){
    
        let btn = UIButton.init(type: .system)
        let img = UIImage(named:"return_white")?.withRenderingMode(.alwaysOriginal)
        btn.setImage(img, for: .normal)
        btn.frame = CGRect(x:0,y:0,width:45,height:44)
        btn.addTarget(self, action: #selector(backToPrevious), for: .touchUpInside)
        let item = UIBarButtonItem.init(customView: btn)
        let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spaceItem.width = -15
        self.navigationItem.leftBarButtonItems = [spaceItem,item]
        
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        self.navigationController!.popViewController(animated: true)
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
                    let numStr = cardInfo?.cardNo.substring(from: index!)
                    cell.rightLabel?.text = (cardInfo?.bankName)!+" 尾号 "+"("+numStr!+")"
                }
                
                return cell
            }
            
            cell.rightLabel?.text = contentArr[indexPath.row]+"元"
            return cell
        }
        
        cell.cellType = CurrentInfoCellType(cellType: .Renewal)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 3{
            
            let userBankCardListVC = UserBankCardListViewController()
            userBankCardListVC.userSelectedBankCard({ (cardInfo, currentIndex) in
                
                self.cardInfo = cardInfo
                self.renewalTableView.reloadData()
            })

            self.navigationController?.pushViewController(userBankCardListVC, animated: false)
           
        }
    }

    

//    func getGatheringInformation_jhtml() -> Void {
//        
//        let checkBankViewModel = CheckBankViewModel()
//        checkBankViewModel.setBlockWithReturn({ (returnValue) in
//            
//             let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
//            if baseResult.flag == "0000"{
//            
//                let array = baseResult.result!
//                
//                for index in 0..<(array as! NSArray).count{
//                
//                    let bankList = try! SupportBankList.init(dictionary: (array as! NSArray)[index] as! [AnyHashable : Any])
//                    self.supportBankListArr.append(bankList)
//                }
//                self.fatchCardInfo(supportBankListArr: self.supportBankListArr as NSArray)
//            }else{
//            
//                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.msg)
//            }
//        }) { 
//            
//        }
//        
//        checkBankViewModel.getSupportBankListInfo("2")
//    }
//    
//    
//    func fatchCardInfo(supportBankListArr : NSArray){
//    
//        let userDataVM = UserDataViewModel()
//        userDataVM.setBlockWithReturn({ (returnValue) in
//
//            let  userCardsModel = (UserCardResult.yy_model(with: returnValue as! [AnyHashable : Any]))!
//            if userCardsModel.flag! == "0000"{
//            
//                self.cardInfo = CardInfo()
//                if userCardsModel.result.count>0{
//                
//                    for _ in 0..<userCardsModel.result.count{
//                    
//                        let cardResult = userCardsModel.result[0]
//                        if cardResult.card_type_ == "2"{
//                        
//                            self.defaultBankIndex = 0
//                            
//                            for banlist in self.supportBankListArr{
//                                if cardResult.card_bank_ == banlist.bank_code_{
//                                    
//                                    self.cardInfo?.tailNumber = cardResult.card_no_
//                                    self.cardInfo?.bankName = banlist.bank_name_
//                                    self.cardInfo?.cardIdentifier = cardResult.id_
//                                    self.cardInfo?.phoneNum = cardResult.bank_reserve_phone_
//                                    self.renewalTableView.reloadData()
//                                    break
//                                }
//                                
//                            }
//                            
//                        }
//                    }
//                }
//            }else{
//            
//                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: userCardsModel.msg!)
//            }
//        }) { 
//            
//        }
//        userDataVM.obtainGatheringInformation()
//        return
//    }


    func fatchBankList(){
    
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
//        repayMentViewModel.getBankCardList()

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
