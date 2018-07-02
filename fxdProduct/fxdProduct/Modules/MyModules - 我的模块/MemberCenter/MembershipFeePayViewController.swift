//
//  MembershipFeePayViewController.swift
//  fxdProduct
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc enum UserMemberCenterPayType:Int {
    case recharge          //充值
    case refund            //退款
}

typealias MembershipFeePaySuccessBlock = () -> Void

class MembershipFeePayViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var titleHeaderView:FXD_displayAmountCommonHeaderView?
    var tableView:UITableView?
    var isAgreement:Bool = false
    var titleArr:[String] = ["银行卡"]
    var  bottomButton:UIButton?
    
    var amount:String?
    var settleCount:String?
    
    var userSelectIndex:Int? = 0
    var selectedCard:CardInfo?
    
    var payType:UserMemberCenterPayType?
    var paySuccessBlock:MembershipFeePaySuccessBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addBackItem()
        configureView()
        self.fatchCardInfo { (isSuccess, isCardBank) in
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func bottomButtonClick()  {
        /*
        if !self.isAgreement {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请点击同意会员协议")
            return
        }
        */
        switch payType {
        case .recharge?:
            self.requestMemberCenterRecharge { (isSuccess) in
                if isSuccess {
                    self.navigationController?.popViewController(animated: true)
                    if (self.paySuccessBlock != nil) {
                        self.paySuccessBlock!()
                    }
                }
            }
            break
        case .refund?:
            
            let num = Int(settleCount!)
            if num! > 8 {
                FXD_AlertViewCust.sharedHHAlertView().showFXDAlertViewTitle("", content: "退款后将不能借款，确认退款", attributeDic: nil, textAlignment: NSTextAlignment.center, cancelTitle: "确认", sureTitle: "取消") { (index) in
                    if index == 0 {
                        self.InitiateArefund()
                    }
                }
            }else{
                self.InitiateArefund()
            }
            break
        default:
            break
        }
    }
    
    // 退款
    func InitiateArefund()  {
        self.requestMemberCenterRefund { (isSuccess) in
            if isSuccess {
                self.navigationController?.popViewController(animated: true)
                if (self.paySuccessBlock != nil) {
                    self.paySuccessBlock!()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UI_IS_IPONE6P || UI_IS_IPHONEX{
            return 45 / 0.8
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MembershipRechargeTableViewCell", for: indexPath) as! MembershipRechargeTableViewCell
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "MembershipRechargeTableViewCell") as! MembershipRechargeTableViewCell
        }
        cell.titleLabel.text = titleArr[indexPath.row]
        if payType == .recharge {
            cell.accessoryType = .disclosureIndicator
            cell.contentLabel.text = ""
            if selectedCard != nil {
                cell.contentLabel.text = String.init(format: "%@ (%@)", (selectedCard?.bankName)!,((selectedCard?.cardNo! as NSString?)?.formatTailNumber())!)
            }
        }else{
            cell.contentLabel.text = "\(amount ?? "")元"
            if indexPath.row == 1{
                cell.accessoryType = .disclosureIndicator
                cell.contentLabel.text = ""
                if selectedCard != nil {
                    cell.contentLabel.text = String.init(format: "%@ (%@)", (selectedCard?.bankName)!,((selectedCard?.cardNo! as NSString?)?.formatTailNumber())!)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch payType {
        case .recharge?:
            pushUserBankListVC()
            break;
        case .refund?:
            if  indexPath.row == 1{
                pushUserBankListVC()
            }
            break;
        default:
            break;
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = self.addFooterView()
        return footerView
    }

    func addFooterView() -> UIView {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 250))
        footerView.backgroundColor = LOAN_APPLICATION_COLOR
        let agreementView = HF_AgreementView.init(CGRect.zero,content:"我已阅读并同意",protocolNameArr: ["《会员协议》"])
        agreementView.isAgreementClick = {[weak self] (isClick) in
            self?.isAgreement = isClick
            if isClick {
                self?.bottomButton?.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
            }else{
                self?.bottomButton?.setBackgroundImage(UIImage.init(named: "applicationBtn_unselect_Image"), for: UIControlState.normal)
            }
        }
        agreementView.agreementClick = { [weak self] (index) in
            self?.getMemberCenterProtocol()
        }
        agreementView.isHidden = true
        footerView.addSubview(agreementView)
        agreementView.snp.makeConstraints { (make) in
            make.top.equalTo(footerView.snp.top).offset(13)
            make.left.right.equalTo(footerView)
            make.height.equalTo(20)
        }
        
        bottomButton = UIButton.init(type: UIButtonType.custom)
//        bottomButton?.setBackgroundImage(UIImage.init(named: "applicationBtn_unselect_Image"), for: UIControlState.normal)
      bottomButton?.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
        if payType == .recharge {
            bottomButton?.setTitle("确认支付", for: UIControlState.normal)
        }else{
            bottomButton?.setTitle("退款", for: UIControlState.normal)
        }
        bottomButton?.addTarget(self, action: #selector(bottomButtonClick), for: .touchUpInside)
        footerView.addSubview(bottomButton!)
        bottomButton?.snp.makeConstraints({ (make) in
            make.top.equalTo(footerView.snp.top).offset(154)
            make.left.equalTo(footerView.snp.left).offset(25)
            make.right.equalTo(footerView.snp.right).offset(-25)
        })
        return footerView
    }
    
    func pushUserBankListVC()  {
        let userBankCardListVC = UserBankCardListVCModule.init()
        userBankCardListVC.currentIndex = userSelectIndex!
        userBankCardListVC.payPatternSelectBlock = {[weak self] (cardInfo,currentIndex) in
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension MembershipFeePayViewController{
    
    func configureView()  {
        
        var title = "会员费充值"
        var amountTitle = "实付金额(元)"
        var hintTitle = "温馨提示：确保银行卡余额充足"
        
        switch payType {
        case .recharge?:
            titleArr = ["银行卡"]
            break;
        case .refund?:
            titleArr = ["退还金额","银行卡"]
            title = "会员费退还"
            amountTitle = "可退金额(元)"
            hintTitle = "温馨提示：全部退还将不能借款"
            break;
        default:
            break;
        }
        
        self.view.backgroundColor = LOAN_APPLICATION_COLOR
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        self.tableView?.backgroundColor = LOAN_APPLICATION_COLOR
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.isScrollEnabled = false
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        tableView?.register(UINib.init(nibName: "MembershipRechargeTableViewCell", bundle: nil), forCellReuseIdentifier: "MembershipRechargeTableViewCell")
        
        if #available(iOS 11.0, *){
            tableView?.contentInsetAdjustmentBehavior = .never;
            tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }else if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = false;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        
        var heaerViewHeight = 205
        if UI_IS_IPONE6P || UI_IS_IPHONEX{
            heaerViewHeight = 256
        }
        titleHeaderView = FXD_displayAmountCommonHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: Int(_k_w), height: heaerViewHeight), amount: self.amount!, amountTitle: amountTitle,centerImage:"circle_center_Image")
        titleHeaderView?.titleLabel?.text = title
        titleHeaderView?.hintWordLabel?.text = hintTitle
        titleHeaderView?.hintWordBackImage?.isHidden = true
        titleHeaderView?.goBackBtn?.isHidden = false
        titleHeaderView?.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
        self.tableView?.tableHeaderView = titleHeaderView
        self.tableView?.tableFooterView = self.addFooterView()
    }
}

extension MembershipFeePayViewController {
    
    func requestMemberCenterRecharge(_ finish:@escaping (_ success:Bool) -> Void)  {
        let viewModel = UserMemberShipViewModel.init()
        viewModel.setBlockWithReturn({ (returnValue) in
            let baseResult = returnValue  as! BaseResultModel
            if baseResult.errCode == "0"{
                finish(true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
                finish(false)
            }
        }) {
            finish(false)
        }
        viewModel.requestMemberCenterRecharge(selectedCard?.cardId, rechargeAmount: self.amount)
    }
    
    func requestMemberCenterRefund(_ finish:@escaping (_ success:Bool) -> Void)  {
        let viewModel = UserMemberShipViewModel.init()
        viewModel.setBlockWithReturn({ (returnValue) in
            let baseResult = returnValue  as! BaseResultModel
            if baseResult.errCode == "0"{
                finish(true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
                finish(false)
            }
        }) {
            finish(false)
        }
        viewModel.requestMemberCenterRefund(selectedCard?.cardId, refundAmount: self.amount)
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
        bankInfoVM.obtainUserBankCardListPlatformType("")
    }
    
    func getMemberCenterProtocol()  {
        let complianceViewModel = ComplianceViewModel.init()
        complianceViewModel.setBlockWithReturn({ (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                if let content = (baseResult.data as! [String:String])["protocolContent"] {
                    let protocolContent = content
                    let navTitle = (baseResult.data as! [String:String])["title"]
                    let webController = DetailViewController()
                    webController.content = protocolContent;
                    webController.navTitle = navTitle;
                    self.navigationController?.pushViewController(webController, animated: true)
                }
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        complianceViewModel.hgGetProductNewProtocolApplicationId(nil, inverBorrowId: nil, periods: nil, productId: "fxd_member", productType: nil, protocolType: "19", stagingType: nil)
    }
    
}




