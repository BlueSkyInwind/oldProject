//
//  MyBillDetailViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class MyBillDetailViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView : UITableView?
    var dataArray : NSMutableArray?
    var titleArray = ["赊销金额","服务费","违约金","逾期罚息","使用券","使用账余额","支付方式"]
    var moneyLabel : UILabel?
    var isdispalyCard : Bool? = false
    
    var userSelectIndex:Int? = 0
    var selectedCard : CardInfo?
    var detailModel : PaymentDetailAmountInfoModel?
    var discountTicketModel : DiscountTicketModel?
    var discountDetailModel : DiscountTicketDetailModel?
    var staging_id_ : String?
    var chooseIndex : Int?
    var discountNumStr : String?
    var selectRedPacketID : String?
    var useredPacketAmount : String?
    var applicationId : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的账单"
        useredPacketAmount = "0.0"
        chooseIndex = 0
        addBackItem()
        getBankCardsList()
        // Do any additional setup after loading the view.
        
        self.eductibleAmountfDiscount({[weak self] (result) in
            if result {
                if self?.detailModel != nil {
                    self?.configureView()
                    
                    self?.moneyLabel?.text = "¥" + (self?.detailModel?.repayTotal)!
                    if self?.detailModel?.couponUsageStatus == "0"{
                        self?.obtainDiscountTicket({[weak self] (result) in
                            
                            if result{
                                if (self?.discountTicketModel?.canuselist.count)! > 0{
                                    self?.tableView?.reloadData()
                                }
                            }
                            
                        })
                    }
                    self?.tableView?.reloadData()
                }
            }
        })
    }

    
    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = LINE_COLOR
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        headerView()
        if #available(iOS 11.0, *){
            tableView?.contentInsetAdjustmentBehavior = .never;
            tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }else if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = true;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
    }
    
    fileprivate func headerView(){
        
        let headerView = UIView.init(frame: CGRect(x:0,y:0,width:_k_w,height:117))
        headerView.backgroundColor = LINE_COLOR
        tableView?.tableHeaderView = headerView
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage.init(named: "bill_header_icon")
        headerView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.top).offset(12)
            make.left.equalTo(headerView.snp.left).offset(0)
            make.right.equalTo(headerView.snp.right).offset(0)
            make.bottom.equalTo(headerView.snp.bottom).offset(0)
        }
        
        let headerTitle = UILabel()
        headerTitle.text = "还款金额"
        headerTitle.textColor = TITLE_COLOR
        headerTitle.font = UIFont.systemFont(ofSize: 15)
        headerView.addSubview(headerTitle)
        headerTitle.snp.makeConstraints { (make) in
            make.top.equalTo(bgImageView.snp.top).offset(20)
            make.centerX.equalTo(bgImageView.snp.centerX)
        }
        
        moneyLabel = UILabel()
        moneyLabel?.textColor = UI_MAIN_COLOR
        moneyLabel?.font = UIFont.systemFont(ofSize: 30)
//        moneyLabel?.text = "¥1166.10"
        headerView.addSubview(moneyLabel!)
        moneyLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(headerTitle.snp.bottom).offset(20)
            make.centerX.equalTo(headerView.snp.centerX)
        })
        
    }
    
    func eductibleAmountfDiscount(_ result : @escaping (_ isSuccess : Bool) -> Void){
        let paymentViewModel = PaymentViewModel()
        paymentViewModel.setBlockWithReturn({[weak self] (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                
                self?.detailModel = try! PaymentDetailAmountInfoModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                result(true)
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
                result(false)
            }
            
        }) {
            
            result(false)
        }
        paymentViewModel.obtaineductibleAmountfDiscount(discountDetailModel?.base_id, stagingIds: staging_id_)
    }
    
    
    /**
     获取抵扣券，折扣券数据
     @param finish 结果回调
     */

    func obtainDiscountTicket(_ result : @escaping (_ isSuccess : Bool) -> Void){
        
        let applicationVM = ApplicationViewModel()
        applicationVM.setBlockWithReturn({[weak self] (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                
                self?.discountTicketModel = try! DiscountTicketModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                result(true)
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
                result(false)
            }
        }) {
            result(false)
        }
        applicationVM.new_obtainUserDiscountTicketListDisplayType("3", product_id: nil, pageNum: nil, pageSize: nil)
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
                        self.selectedCard = cardInfo
                        self.tableView?.reloadData()
                        break
                    }
                }
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
        }
        bankInfoVM.obtainUserBankCardListPlatformType("")
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footView = UIView()
        footView.backgroundColor = UIColor.clear
        
        let confirmBtn = UIButton()
        confirmBtn.setTitle("确定", for: .normal)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.setBackgroundImage(UIImage.init(named: "btn_seleted_icon"), for: .normal)
        confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        confirmBtn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        footView.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.top.equalTo(footView.snp.top).offset(40)
            make.height.equalTo(40)
            make.width.equalTo(240)
            make.centerX.equalTo(footView.snp.centerX)
        }
        return footView
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (titleArray.count)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:MyBillCell! = tableView.dequeueReusableCell(withIdentifier:"MyBillCell") as? MyBillCell
        if cell == nil {
            cell = MyBillCell.init(style: .default, reuseIdentifier: "MyBillCell")
        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        cell.isSelected = false
        cell.leftLabel?.text = titleArray[indexPath.row]
        
        cell.arrowImage?.isHidden = true
        if indexPath.row == 4 || indexPath.row == 6 {
            cell.arrowImage?.isHidden = false
        }
        
        switch indexPath.row {
        case 0:
            cell.rightLabel?.text = "¥" + (self.detailModel?.debtPrincipal)!
        case 1:
            cell.rightLabel?.text = "¥" + (self.detailModel?.debtServiceFee)!
        case 2:
            cell.rightLabel?.text = "¥" + (self.detailModel?.debtDamages)!
        case 3:
            cell.rightLabel?.text = "¥" + (self.detailModel?.debtPenaltyInterest)!
        case 4:
            
            cell.rightLabel?.text = "无可用券"
            if self.discountTicketModel?.canuselist != nil{
                
                cell.rightLabel?.text = "有可用券"
            }
            
        case 5:
            cell.rightLabel?.text = "¥" + (self.detailModel?.overpaidAmount)!
        case 6:
            
            if selectedCard != nil {
                
                let index = selectedCard?.cardNo.index((selectedCard?.cardNo.endIndex)!, offsetBy: -4)
                let numStr = selectedCard?.cardNo[index!...]
                cell.rightLabel?.text = (selectedCard?.bankName)!+"(尾号"+numStr!+")"
            }
        default:
            break
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 4:
            showChooseAmountView()
        case 6:
            pushUserBankListVC()
        default:
            break
        }
    }

    func showChooseAmountView(){
        let discountCouponVC = DiscountCouponListVCModules()
        discountCouponVC.dataListArr = (discountTicketModel?.canuselist! as NSArray?)
        discountCouponVC.currentIndex = "\(chooseIndex)" as NSString
        discountCouponVC.displayType = "3"
        discountCouponVC.view.frame = CGRect.init(x: 0, y: 0, width: _k_w, height: _k_h * 0.6)
        discountCouponVC.chooseDiscountTicket = ({[weak self] (index,discountTicketDetailModel,str ) in
            self?.chooseIndex = index;
            self?.discountDetailModel = discountTicketDetailModel;
            if index != 0 {
                
                self?.eductibleAmountfDiscount({[weak self] (result) in
                    
                    if result{
    
                        self?.selectRedPacketID = discountTicketDetailModel.base_id
                        self?.useredPacketAmount = self?.detailModel?.redPacketRepayAmount
                        if discountTicketDetailModel.voucher_type == "1"{
                            self?.discountNumStr = "抵扣" + (self?.detailModel?.redPacketRepayAmount)! + "元"
                        }else if discountTicketDetailModel.voucher_type == "3"{
                            self?.discountNumStr = "折扣" + (self?.detailModel?.redPacketRepayAmount)! + "元"
                        }
                        self?.tableView?.reloadData()
                    }
                })

            }else{
            
                self?.selectRedPacketID = nil
                self?.useredPacketAmount = "0.0"
                self?.discountNumStr = "有可用券"
            }
            self?.tableView?.reloadData()
        })
        
        self.presentSemiViewController(discountCouponVC, withOptions: [KNSemiModalOptionKeys.pushParentBack.takeUnretainedValue() : false,KNSemiModalOptionKeys.parentAlpha.takeUnretainedValue() : 0.8], completion: nil, dismiss: {
        })
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
        
        bankInfoVM.obtainUserBankCardListPlatformType("16")
        
    }
    
    @objc fileprivate func confirmBtnClick(){
        
        getInfo()

    }
    
    func fxdRepay(){
        
        let paymentDetailModel = PaymentDetailModel()
        
        if Float(useredPacketAmount!) != 0{
            
            paymentDetailModel.staging_ids_ = staging_id_
            paymentDetailModel.account_card_id_ = selectedCard?.cardId
            paymentDetailModel.total_amount_ = NSNumber(value: NSString(string: (detailModel?.overpaidAmount)!).floatValue)//溢缴金
            paymentDetailModel.repay_amount_ = NSNumber(value: NSString(string: (detailModel?.repayTotal)!).floatValue)//应还金额
            paymentDetailModel.repay_total_ = NSNumber(value: NSString(string: (detailModel?.payAmount)!).floatValue)//实际金额
            paymentDetailModel.save_amount_ = NSNumber(value: NSString(string: (detailModel?.debtServiceFee)!).floatValue)//前端全选时节省的未还服务费
            paymentDetailModel.socket = ""//还款标示
            paymentDetailModel.request_type_ = "0"//请求类型
            paymentDetailModel.redpacket_id_ = selectRedPacketID
            paymentDetailModel.redpacket_cash_ = NSNumber(value: NSString(string: useredPacketAmount!).floatValue)
        
        }else{
            paymentDetailModel.staging_ids_ = staging_id_
            paymentDetailModel.account_card_id_ = selectedCard?.cardId
            paymentDetailModel.total_amount_ = NSNumber(value: NSString(string: (detailModel?.overpaidAmount)!).floatValue)//溢缴金
            paymentDetailModel.repay_amount_ = NSNumber(value: NSString(string: (detailModel?.repayTotal)!).floatValue)//应还金额
            paymentDetailModel.repay_total_ = NSNumber(value: NSString(string: (detailModel?.payAmount)!).floatValue)//实际金额
            paymentDetailModel.save_amount_ = NSNumber(value: NSString(string: (detailModel?.debtServiceFee)!).floatValue)//前端全选时节省的未还服务费
            paymentDetailModel.socket = ""//还款标示
            paymentDetailModel.request_type_ = "0"//请求类型
            
        }
        
        
        let paymentViewModel = PaymentViewModel()
        paymentViewModel.setBlockWithReturn({ (returnValue) in
            
            let baseResultModel = returnValue as! BaseResultModel
            if baseResultModel.errCode == "0"{

                let controller = RepaymentResultViewController()
                controller.state = .intermediate
                self.navigationController?.pushViewController(controller, animated: true)
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResultModel.friendErrMsg)
            }
            
        }) {
            
        }
        paymentViewModel.fxDpaymentDetail(paymentDetailModel)
        
    }
    
    //MARK: 银行卡授权查询页面
    func getInfo(){
        let bankCardAuthorizationVM = BankCardAuthorizationViewModel()
        bankCardAuthorizationVM.setBlockWithReturn({[weak self] (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {

                let model = try! BankCardAuthorizationModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                if model.authList.count > 0{

                    let controller = FXD_WithholdAuthViewController()
                    controller.bankName = self?.selectedCard?.bankName
                    controller.cardNum = self?.selectedCard?.cardNo
                    controller.telNum = self?.selectedCard?.bankPhone
                    controller.bankCode = self?.selectedCard?.cardShortName
                    controller.bankShortName = self?.selectedCard?.cardShortName
                    controller.requestType = ""
                    controller.applicationId = FXD_Utility.shared().userInfo.applicationId
                    controller.type = .repay
                    self?.navigationController?.pushViewController(controller, animated: true)

                }else{

                    self?.fxdRepay()
                }

            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {

        }
        
        bankCardAuthorizationVM.cardAuthQueryBankShortName(selectedCard?.cardShortName, cardNo: selectedCard?.cardNo,type:"2")

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
