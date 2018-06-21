//
//  OrderConfirmationViewController.swift
//  fxdProduct
//
//  Created by admin on 2018/6/6.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

enum PhoneCardType {
    case moblieCard
    case unicomCard
    case telecomCard
}

class OrderConfirmationViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView?
    var cardType:PhoneCardType?
    var orderModel:PhoneCardOrderModel?
    var cardOrderId:String?
    var isAgree:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单确认"
        self.addBackItem()
        // Do any additional setup after loading the view.
        obtainDataSource()
    }
    
    override func loadFailureLoadRefreshButtonClick()  {
        obtainDataSource()
    }
    
    func obtainDataSource()  {
        obtainOrderInfo(cardOrderId!) {[weak self] (isSuccess) in
            if(isSuccess) {
                self?.removeFailView()
                self?.configureView()
            }else{
                self?.setFailView()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().shouldResignOnTouchOutside = false
        IQKeyboardManager.shared().isEnabled = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().isEnabled = true
    }
    
    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.separatorStyle = .none
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        tableView?.register(UINib.init(nibName: "OrderConfirmInfoCell", bundle: nil), forCellReuseIdentifier: "OrderConfirmInfoCell")
        tableView?.register(UINib.init(nibName: "OrderConfirmDetailCell", bundle: nil), forCellReuseIdentifier: "OrderConfirmDetailCell")
        
        let headerView = HeaderInstructionsView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 34))
        headerView.instructionsLabel?.text = "充值卡为虚拟物品，一经出售概不退换"
        tableView?.tableHeaderView = headerView

        let footerView = OrderConfirmBottomView.init(frame: CGRect.init(x: 0, y: 0, width:_k_w, height: 150))
        footerView.addProtocolClick(["《延期支付服务协议》"])
        tableView?.tableFooterView = footerView
        tableView?.sectionFooterHeight = 0
        footerView.protocolContentClick = { [weak self] (index) in
            self?.obtainProcotolAddress({ (status, content) in
                if status {
                    let fxdWeb = FXDWebViewController.init()
                    fxdWeb.urlStr = content
                    self?.navigationController?.pushViewController(fxdWeb, animated: true)
                }
            })
        }
        footerView.protocolBtnClick = { [weak self] (status) in
            
        }
        footerView.applyForBtnClick = { [weak self]  in
            self?.obtainOrderCheck((self?.orderModel?.productNumber)!, (self?.orderModel?.totalCount)!, { (isSuccess) in
                if isSuccess {
                    self?.sendOrderConfirmSMS({ (result) in
                        if result {
                            self?.popVerifyCodeView()
                        }
                    })
                }
            })
        }
    }
    
    func popVerifyCodeView()  {
        OrderVerifyCodeView.showOrderVerifyCodeView(self, displayStr: "短信验证码已经发送至" + FXD_Tool.share().changeTelephone(FXD_Utility.shared().userInfo.userMobilePhone), result: { (verifyStr) in
            print(verifyStr)
            self.createPhoneCardOrder((self.orderModel?.productNumber)!, verifyStr, { (result,orderNo) in
                if result {
                    self.popSuccessVC(orderNo)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        OrderVerifyCodeView.dismissImportPayPasswordView()
                    }
                }
            })
        }, verifyCodeClick: {
            self.sendOrderConfirmSMS({ (result) in
                if result{
                    OrderVerifyCodeView.againCreateVerifyTimer()
                }
            })
        })
    }
    
    func popSuccessVC(_ orderStr:String)  {
        let controller = RepaymentResultViewController()
        controller.state = .submittedSuccessfully
        controller.orderNo = orderStr
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func popPrompt()  {
        FXD_AlertViewCust.sharedHHAlertView().showPhoneRechargeTitle("提示", content: "当前商品库存不足，请选择其他商品", attributeDic: nil, textAlignment: NSTextAlignment.center, sureTitle: "返回商城") { (index) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 150
        switch indexPath.section {
        case 0:
            height = 150
            break
        case 1:
            height = 175
            break
        default:
            break
        }
        return CGFloat(height)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "OrderConfirmInfoCell", for: indexPath) as! OrderConfirmInfoCell
//            cell.addShadow()
            cell.selectionStyle = .none
            switch cardType {
            case .moblieCard?:
                cell.orderTypeIcon.image = UIImage.init(named: "moblie_Icon")
                break
            case .unicomCard?:
                cell.orderTypeIcon.image = UIImage.init(named: "unicom_Icon")
                break
            case .telecomCard?:
                cell.orderTypeIcon.image = UIImage.init(named: "telecom_Icon")
                break
            default:
                break
            }
            cell.orderModel = orderModel
            return cell
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "OrderConfirmDetailCell", for: indexPath) as! OrderConfirmDetailCell
//            cell.addShadow()
            cell.selectionStyle = .none

            cell.orderModel = orderModel
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 15
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.init()
        header.backgroundColor = UIColor.clear
        return header
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

extension OrderConfirmationViewController {
    
    func obtainOrderInfo(_ productId:String, _ result:@escaping ((_ success:Bool) -> Void))  {
        let serviceViewModel = PhonerechargeCardServiceViewModel.init()
        serviceViewModel.setBlockWithReturn({[weak self] (model) in
            let baseModel = model as! BaseResultModel
            if baseModel.errCode == "0"{
                let cardOrderModel = try! PhoneCardOrderModel.init(dictionary: baseModel.data as! [AnyHashable : Any])
                self?.orderModel = cardOrderModel
                result(true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseModel.friendErrMsg)
                result(false)
            }
        }) {
            result(false)
        }
        serviceViewModel.obtainOrderConfirmInfo(productId)
    }
    
    func obtainOrderCheck(_ productId:String, _ num:String,_ result:@escaping ((_ success:Bool) -> Void))  {
        let serviceViewModel = PhonerechargeCardServiceViewModel.init()
        serviceViewModel.setBlockWithReturn({[weak self] (model) in
            let baseModel = model as! BaseResultModel
            if baseModel.errCode == "0"{
                result(true)
            }else if baseModel.errCode == "1"{
                self?.popPrompt()
                 result(false)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseModel.friendErrMsg)
                result(false)
            }
        }) {
            result(false)
        }
        serviceViewModel.obtainOrderConfirmRequest(productId, cardNum: num)
    }
    
    func sendOrderConfirmSMS(_ result : @escaping (_ isSuccess : Bool) -> Void)  {
        let tradeSMS =  SMSViewModel.init()
        tradeSMS.setBlockWithReturn({ (returnValue) in
            let baseResult  = returnValue as! BaseResultModel
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            if baseResult.errCode == "0" {
                result(true)
            }else{
                result(false)
            }
        }) {
            result(false)
        }
        tradeSMS.fatchRequestSMSParamPhoneNumber(FXD_Utility.shared().userInfo.userMobilePhone, verifyCodeType:ORDERCONFIRM_CODE)
    }
    
    func createPhoneCardOrder(_ cardNO:String, _ verifyCode:String,_ result : @escaping (_ isSuccess : Bool ,_ orderNO:String) -> Void)  {
        let serviceViewModel = PhonerechargeCardServiceViewModel.init()
        serviceViewModel.setBlockWithReturn({[weak self] (model) in
            let baseModel = model as! BaseResultModel
            if baseModel.errCode == "0"{
                let orderNo = baseModel.data as! String
                result(true,orderNo)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(UIApplication.shared.keyWindow, message: baseModel.friendErrMsg)
                result(false,"")
            }
        }) {
            result(false,"")
        }
        serviceViewModel.createPhoneCardOrder(cardNO, verifyCode: verifyCode)
    }
    
    func obtainProcotolAddress(_ result : @escaping (_ isSuccess : Bool ,_ address:String) -> Void)  {
        let commonVC = CommonViewModel.init()
        commonVC.setBlockWithReturn({[weak self] (model) in
            let baseModel = model as! BaseResultModel
            if baseModel.errCode == "0"{
                let content =  (baseModel.data as! [String:String])["productProURL"]
                result(true,content!)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseModel.friendErrMsg)
                result(false,"")
            }
        }) {
            
        }
        commonVC.obtainPhoneCardProtocolType(Phone_RechargeCard, totalPrice: orderModel?.totalPrice, applicationId: "")
    }
}


