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
    var staging_id_ : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的账单"
        addBackItem()
        configureView()
        headerView()
        getBankCardsList()
        // Do any additional setup after loading the view.
        
        self.eductibleAmountfDiscount({[weak self] (result) in
            if result {
                if self?.detailModel != nil {
                    if self?.detailModel?.couponUsageStatus == "0"{
                        self?.obtainDiscountTicket({[weak self] (result) in
                            if (self?.discountTicketModel?.canuselist.count)! > 0{
                                self?.tableView?.reloadData()
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
        if #available(iOS 11.0, *){
            tableView?.contentInsetAdjustmentBehavior = .never;
            tableView?.contentInset = UIEdgeInsetsMake(CGFloat(obtainBarHeight_New(vc: self)), 0, 0, 0)
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
        moneyLabel?.text = "¥1166.10"
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
        paymentViewModel.obtaineductibleAmountfDiscount(nil, stagingIds: staging_id_)
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
        confirmBtn.setTitle("确认", for: .normal)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.setBackgroundImage(UIImage.init(named: "applayBtnImage"), for: .normal)
        confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        confirmBtn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        footView.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.left.equalTo(footView.snp.left).offset(20)
            make.right.equalTo(footView.snp.right).offset(-20)
            make.top.equalTo(footView.snp.top).offset(40)
            make.height.equalTo(45)
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
            cell.rightLabel?.text = "¥150.00"
        case 1:
            cell.rightLabel?.text = "¥16.10"
        case 2:
            cell.rightLabel?.text = "¥10.10"
        case 3:
            cell.rightLabel?.text = self.detailModel?.debtOverdueTotal
        case 4:
            cell.rightLabel?.text = "请选择"
        case 5:
            cell.rightLabel?.text = "¥0"
        case 6:
            
            if selectedCard != nil {
                
                let index = selectedCard?.cardNo.index((selectedCard?.cardNo.endIndex)!, offsetBy: -4)
                let numStr = selectedCard?.cardNo[index!...]
                cell.rightLabel?.text = (selectedCard?.bankName)!+"("+numStr!+")"
            }
        default:
            break
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 6:
            pushUserBankListVC()
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
        
        let controller = RepaymentResultViewController()
        controller.state = .intermediate
        self.navigationController?.pushViewController(controller, animated: true)
        
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
