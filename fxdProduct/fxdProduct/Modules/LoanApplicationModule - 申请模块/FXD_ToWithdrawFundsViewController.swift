//
//  FXD_ToWithdrawFundsViewController.swift
//  fxdProduct
//
//  Created by admin on 2017/12/25.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class FXD_ToWithdrawFundsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,WithdrawFundsFooterViewDelegate {
    
    var headerView:FXD_displayAmountCommonHeaderView?
    var tableView:UITableView?
    var withdrawFundsFooterView:FXD_ToWithdrawFundsFooterView?
    var drawingsInfoModel:DrawingsInfoModel?
    
    var drawAmount:String? = ""
    var period:String? = ""
    var periodAmount:String? = ""
    var displayContent:[String]? = [""]
    var displayTitle:String? = ""
    var applicationId:String? = ""
    var stagingType:String? = ""
    var isKeepProtocol : Bool? = false
    var isdispalyCard : Bool? = false

    var userSelectIndex:Int? = 0
    var selectedCard:CardInfo?
    var protocolArray : NSMutableArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = LOAN_APPLICATION_COLOR
        protocolArray = NSMutableArray.init()
        
        self.obtainWithDrawFundsInfo {[weak self] (isSuccess) in
            
            self?.configureView()
            
            if isSuccess{
                
                self?.getHgLoanProtoolList { [weak self] (isSuccess) in
                    
                    self?.configureView()
                }
            }
            
            if self?.drawingsInfoModel?.platformType == "2" {
                self?.isdispalyCard = true
                self?.changeBankCard()
            }
//            self?.getHgLoanProtoolList()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        if self.drawingsInfoModel?.platformType == "2" {
            self.obtainWithDrawFundsInfo {[weak self] (isSuccess) in
                
                if self?.drawingsInfoModel?.platformType == "2" {
                    self?.isdispalyCard = true
                    self?.changeBankCard()
                }
                
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    func configureView()  {
        
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        self.tableView?.backgroundColor = LOAN_APPLICATION_COLOR
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.bounces = false
        tableView?.isScrollEnabled = false
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        tableView?.register(UINib.init(nibName: "FXD_ToWithDrawFundsTableViewCell", bundle: nil), forCellReuseIdentifier: "FXD_ToWithDrawFundsTableViewCell")
        
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
            rect =  CGRect.init(x: 0, y: 0, width: _k_w, height: 250)
        }
        headerView = FXD_displayAmountCommonHeaderView.init(frame: rect, amount: drawAmount!, periodNum: String.init(format: "借款期数：%@期", period!), periodAmount: String.init(format: "每期还款：%@元", periodAmount!))
        headerView?.titleLabel?.text = "待提款"
        tableView?.tableHeaderView = headerView
        headerView?.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
        
//        withdrawFundsFooterView = FXD_ToWithdrawFundsFooterView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: _k_h - 205 - 60), htmlContentArr: displayContent!, protocolNames: ["《借款协议》","《技术服务协议》","\n《风险管理与数据服务》"],titleStr:displayTitle!)
        
        let protocolNameArray :[HgLoanProtoolListModel] = NSMutableArray.init(array: protocolArray!) as! [HgLoanProtoolListModel]
        withdrawFundsFooterView = FXD_ToWithdrawFundsFooterView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: _k_h - 205 - 60), htmlContentArr: displayContent!, protocolNames: protocolNameArray,titleStr:displayTitle!)
        withdrawFundsFooterView?.delegate = self
        tableView?.tableFooterView = withdrawFundsFooterView
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UI_IS_IPONE6P || UI_IS_IPHONEX{
            return 45 / 0.8
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FXD_ToWithDrawFundsTableViewCell", for: indexPath) as! FXD_ToWithDrawFundsTableViewCell
        cell.selectionStyle  = .none
    
        cell.titleLabel.text = "请选择绑卡";
        if  selectedCard != nil {
            cell.contentLabel.text = String.init(format: "%@ 尾号(%@)", (selectedCard?.bankName)!,((selectedCard?.cardNo! as NSString?)?.formatTailNumber())!)
        }

        return cell
    }
    
    func changeBankCard(){
        
        fatchCardInfo {[weak self] (isSuccess,isBankCard) in
            guard  isSuccess else {
                return
            }
            self?.tableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.drawingsInfoModel?.platformType == "2" {
            let controller = BankCardViewController()
            controller.cardInfo = self.selectedCard
            self.navigationController?.pushViewController(controller, animated: true)
        }else{
            
            fatchCardInfo {[weak self] (isSuccess,isBankCard) in
                guard  isSuccess else {
                    return
                }
                
                if !isBankCard {
                    self?.pushAddBanckCard()
                }else{
                    self?.pushUserBankListVC()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 42))
        return headerView
    }
    

    //MARK:WithdrawFundsFooterViewDelegate
    func keepProtocolClick(_ isKeep: Bool) {
        isKeepProtocol = isKeep
    }
    
    func protocolNameClick(_ index: Int) {
        
        let model = protocolArray![0] as! HgLoanProtoolListModel
        var inverBorrowId = ""
        if model.protocolName == "借款协议" {
            inverBorrowId = model.inverBorrowId
        }
        var periods = self.period
        if  self.drawingsInfoModel?.productId == EliteLoan {
            periods = ""
        }
        
        
        
//        HgLoanProtoolListModel *model = _protocolArray[0];
//        NSString *inverBorrowId = @"";
//        if ([protocoalName containsString:@"借款协议"]) {
//            inverBorrowId = model.inverBorrowId;
//        }
//        NSString *periods = _homeProductList.periods;
//        if ([_homeProductList.productId isEqualToString:EliteLoan]) {
//            periods = @"";
//        }
        switch index {
        case 0:
            
            getProductNewProtocol(inverBorrowId: inverBorrowId, periods: periods!, productType: "", protocolType: "2", stagingType: (self.drawingsInfoModel?.stagingType)!)
//            [self getProductNewProtocolInverBorrowId:inverBorrowId periods:periods productType:@"" protocolType:@"2" stagingType:_homeProductList.stagingType];
//            obtainProductProtocol(self.applicationId!, periods: self.period!, productId: EliteLoan, protocolType: "2", complication: {[weak self] (isSuccess, content) in
//                if isSuccess {
//                    self?.pushDetailWebView(content: content)
//                }
//            })
           break
        case 1:
            obtainProductProtocol(self.applicationId!, periods: self.period!, productId: EliteLoan, protocolType: "6", complication: {[weak self] (isSuccess, content) in
                if isSuccess {
                    self?.pushDetailWebView(content: content)
                }
            })
            break
        case 2:
            obtainProductProtocol(self.applicationId!, periods: self.period!, productId: EliteLoan, protocolType: "7", complication: {[weak self] (isSuccess, content) in
                if isSuccess {
                    self?.pushDetailWebView(content: content)
                }
            })
            break
        default:
            break
        }
    }
    
    func pushDetailWebView(content:String)  {
        let fxdWeb = FXDWebViewController.init()
        fxdWeb.urlStr = content
        self.navigationController?.pushViewController(fxdWeb, animated: true)
    }
    
    //MARK: 提款按钮
    func WithdrawFundsClick() {
        if !isdispalyCard! {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请添加收款方式")
            return
        }
        
        if !isKeepProtocol! {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请勾选借款协议")
            return
        }
        
        if self.drawingsInfoModel?.platformType == "2" {
            complianceJump()
        }else{
            
            requestWithDraw((self.selectedCard?.cardId)!) { (isSuccess) in
                if isSuccess {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    func complianceJump(){
        
        let userStatusTag = Int((self.drawingsInfoModel?.userStatus)!)
        switch userStatusTag {
        case 3?:
            print("已开户")
        case 4?:
        
            HG_Manager.sharedHG().hgUserActiveJumpP2pCtrlCapitalPlatform("2", retUrl: _transition_url, vc: self)
        
            print("待激活")
        default:
            break
        }
    }
    
    func pushUserBankListVC()  {
        let userBankCardListVC = UserBankCardListVCModule.init()
        userBankCardListVC.currentIndex = userSelectIndex!
        userBankCardListVC.payPatternSelectBlock = {[weak self] (cardInfo,currentIndex) in
            self?.isdispalyCard = true
            self?.selectedCard = cardInfo
             self?.userSelectIndex = currentIndex
            if cardInfo == nil {
                self?.fatchCardInfo({ (isSuccess, isBankCard) in
                })
            }
            self?.tableView?.reloadData()
        }
        self.navigationController?.pushViewController(userBankCardListVC, animated: true)
    }
    
    func pushAddBanckCard()  {
        let editCard = EditCardsController.init(nibName: "EditCardsController", bundle: nil)
        editCard.typeFlag = "0";
        editCard.addCarSuccess = {
            self.isdispalyCard = true
            self.fatchCardInfo({ (isSuccess, isBankCard) in
            })
        }
        let addCarNC = BaseNavigationViewController.init(rootViewController: editCard)
        self.present(addCarNC, animated: true, completion: nil)
    }
    
    func protocolListClick(_ sender: UIButton) {
        
        let tag = sender.tag
        let model = protocolArray![0] as! HgLoanProtoolListModel
        var inverBorrowId = ""
        if (sender.titleLabel?.text?.contains("借款协议"))! {
            inverBorrowId = model.inverBorrowId
        }
        var periods = ""
        if (sender.titleLabel?.text?.contains("借款协议"))! {
            periods = ""
        }
        switch tag {
        case 1:
            
            getProductNewProtocol(inverBorrowId: inverBorrowId, periods: periods, productType: "", protocolType: "", stagingType: "")
            
            break
            
        default:
            break
        }
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

extension FXD_ToWithdrawFundsViewController {
    
    /// 获取发薪贷银行卡信息
    func fatchCardInfo(_ success:@escaping ((_ isSuccess:Bool,_ isBankCard:Bool) -> Void))  {
        let bankInfoVM = BankInfoViewModel.init()
        bankInfoVM.setBlockWithReturn({[weak self] (resultObject) in
            let baseResult = try! BaseResultModel.init(dictionary: resultObject as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                let cardArr = baseResult.data as! NSArray
                if cardArr.count <= 0{
                    success(true,false)
                    return
                }
                guard (self?.isdispalyCard!)! else {
                    success(true,true)
                    return
                }
                //获取默认卡  或者选择的卡 （第一张卡）
                for  dic in cardArr{
                    let cardInfo = try! CardInfo.init(dictionary: dic as! [AnyHashable : Any])
                    if cardInfo.cardType == "2" {
                        self?.selectedCard = cardInfo
                        break
                    }
                }
                self?.tableView?.reloadData()
                success(true,true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
                success(false,false)
            }
        }) {
            success(false,false)
        }
        
        bankInfoVM.obtainUserBankCardListPlatformType(self.drawingsInfoModel?.platformType)
        
    }
    
    /// 协议列表信息
    func getHgLoanProtoolList(_ complication:@escaping ((_ isSuccess:Bool) -> Void))  {
        
        let complianceVM = ComplianceViewModel()
        complianceVM.setBlockWithReturn({ (returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                self.protocolArray?.removeAllObjects()
                let array = baseResult.data as! NSArray
                
                for  dic in array{
                    let model = try! HgLoanProtoolListModel.init(dictionary: dic as! [AnyHashable : Any])
                    self.protocolArray?.add(model)
                }
                complication(true)
                self.tableView?.reloadData()
                
            }else{
                complication(false)
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            complication(false)
        }
        complianceVM.hgLoanProtoolListApplicationId(self.applicationId)
        
    }
    
    //获取协议内容并跳转
    fileprivate func getProductNewProtocol(inverBorrowId :String ,periods:String ,productType:String ,protocolType:String,stagingType:String){
        
        let complianceVM = ComplianceViewModel()
        complianceVM.setBlockWithReturn({ [weak self](returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
                let protocolContent = (baseResult.data as! [String:String])["protocolContent"]
                let navTitle = (baseResult.data as! [String:String])["title"]
                let webController = DetailViewController()
                webController.content = protocolContent;
                webController.navTitle = navTitle;
                self?.navigationController?.pushViewController(webController, animated: true)
                
            }else{
                
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        
        complianceVM.hgGetProductNewProtocolApplicationId(self.applicationId, inverBorrowId: inverBorrowId, periods: periods, productId: self.drawingsInfoModel?.productId, productType: productType, protocolType: protocolType, stagingType: stagingType)
    }
    /// 提款信息
    func obtainWithDrawFundsInfo(_ complication:@escaping ((_ isSuccess:Bool) -> Void))  {
        let checkVM = CheckViewModel.init()
        checkVM.setBlockWithReturn({ (resultObject) in
            let baseRM = resultObject as? BaseResultModel
            if baseRM?.errCode == "0" {
                let drawingsInfoM = try! DrawingsInfoModel.init(dictionary: baseRM?.data as! [AnyHashable : Any])
                self.drawingsInfoModel = drawingsInfoM
                self.drawAmount = drawingsInfoM.actualAmount
                self.period = drawingsInfoM.period
                self.periodAmount = drawingsInfoM.repaymentAmount
                self.displayContent = drawingsInfoM.text as? [String]
                self.displayTitle = drawingsInfoM.title
                self.applicationId = drawingsInfoM.applicationId
            
                complication(true)
                self.tableView?.reloadData()
            }else{
                complication(false)
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseRM?.friendErrMsg)
            }
        }) {
            complication(false)
        }
        checkVM.withDrawFundsInfoApply()
    }
    
    func  requestWithDraw(_ cardId:String,_ complication:@escaping ((_ isSuccess:Bool) -> Void)) {
        
        let checkVM = CheckViewModel.init()
        checkVM.setBlockWithReturn({ (result) in
            let baseRM = result as? BaseResultModel
            if baseRM?.errCode == "0" {
                complication(true)
            }else{
                complication(false)
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseRM?.friendErrMsg)
            }
        }) {
            complication(false)
        }
        checkVM.new(withDrawalsApplyCard_id:cardId)
    }
    
    func obtainProductProtocol(_ applyId:String,periods:String,productId:String,protocolType:String, complication:@escaping ((_ isSuccess:Bool,_ content:String) -> Void))  {
        
        let commonVM = CommonViewModel.init()
        commonVM.setBlockWithReturn({ (result) in
            let baseRM = result as? BaseResultModel
            if baseRM?.errCode == "0" {
                var content =  (baseRM?.data as! [String:String])["productProURL"]
                complication(true,(content == nil ? "" : content!))
            }else{
                complication(false,"")
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseRM?.friendErrMsg)
            }
        }) {
            complication(false,"")
        }
        commonVM.obtainProductProtocolType(productId, typeCode: protocolType, apply_id: applyId, periods: periods, stagingType: self.drawingsInfoModel?.stagingType)
    }
}


