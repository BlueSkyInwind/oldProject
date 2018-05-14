//
//  FXD_WithholdAuthViewController.swift
//  fxdProduct
//
//  Created by admin on 2018/4/25.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class FXD_WithholdAuthViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    var tableView:UITableView?
    var contentTableViewCell:ContentTableViewCell?
    let titleArr = [["所属银行:","卡号:","预留手机号:"],["新颜授权码:","银生宝授权码:"]]
    @objc var requestType:String?
    var bankName:String?
    var cardNum:String?
    var telNum:String?
    var bankCode:String?
    var bankShortName:String?
    var isAgreement:Bool = false
    var  bottomButton:UIButton?
    var xinyanTimer:Timer?
    var yinshengbaoTimer:Timer?
    var xinyantimeNum = 60
    var yinshengbaotimeNum = 60
    var bankCardQueryArray : NSMutableArray?
    var smsCodeArray : NSMutableArray?
    @objc var applicationId = ""
    @objc var stagingType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "代扣授权"
        bankCardQueryArray = NSMutableArray.init(capacity: 100)
        smsCodeArray = ["",""]
        addBackItem()
        configureView()
    }
    
    func configureView()  {
        
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        tableView?.register(ContentTableViewCell.self, forCellReuseIdentifier: "ContentTableViewCell")
        tableView?.tableHeaderView = addHeaderView()
        tableView?.tableFooterView = addFooterView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getInfo()
    }
    
    //MARK: 银行卡授权查询页面
    func getInfo(){
        let bankCardAuthorizationVM = BankCardAuthorizationViewModel()
        bankCardAuthorizationVM.setBlockWithReturn({ (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
                self.bankCardQueryArray?.removeAllObjects()
                let model = try! BankCardAuthorizationModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                for index in 0 ..< model.authList.count{
                    
                    let model = model.authList[index] as! BankCardAuthorizationAuthListModel
                    self.bankCardQueryArray?.add(model)
                }
                
                self.tableView?.reloadData()
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        
        bankCardAuthorizationVM.cardAuthQueryBankShortName(bankShortName, cardNo: cardNum)
        
    }
    @objc func bottomButtonClick()  {
        
        let bankCardAuthorizationVM = BankCardAuthorizationViewModel()
        bankCardAuthorizationVM.setBlockWithReturn({ (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
                //银行卡授权成功跳回页面
                let count = self.rt_navigationController.rt_viewControllers.count
                let controller = self.rt_navigationController.rt_viewControllers[count - 3]
                self.navigationController?.popToViewController(controller, animated: true)
        
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        
        bankCardAuthorizationVM.cardAuthauthCodeListArr(bankCardQueryArray as! [Any], smsCodeArray: smsCodeArray as! [Any] , bankCode: bankCode, cardNo: cardNum, phone: telNum, requestType: requestType)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 0
         switch section {
        case 0:
            num = titleArr[section].count
            break
        case 1:
            num = (bankCardQueryArray?.count)!
            break
        default:
            break
        }
        return num
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        contentTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell", for: indexPath) as! ContentTableViewCell)
        contentTableViewCell?.selectionStyle = .none
        switch indexPath.section {
        case 0:
            contentTableViewCell?.titleLabel?.text = titleArr[indexPath.section][indexPath.row]
            contentTableViewCell?.contentTextField?.isEnabled = false
            contentTableViewCell?.arrowsImageBtn?.isHidden = true
            switch indexPath.row {
            case 0:
                contentTableViewCell?.contentTextField?.text = bankName
                break;
            case 1:
                contentTableViewCell?.contentTextField?.text = cardNum
                break;
            case 2 :
                contentTableViewCell?.contentTextField?.text = telNum
                break;
            default:
                break
            }
            break
        case 1:

            let model = bankCardQueryArray![indexPath.row] as! BankCardAuthorizationAuthListModel
            contentTableViewCell?.titleLabel?.text = model.authPlatName
            contentTableViewCell?.contentTextField?.delegate = self
            contentTableViewCell?.contentTextField?.tag = indexPath.row + 101
            contentTableViewCell?.contentTextField?.addTarget(self, action: #selector(contentTextFieldEdit(textField:)), for: UIControlEvents.editingChanged)
            contentTableViewCell?.contentTextField?.keyboardType = .numberPad
            contentTableViewCell?.updateVerfiyCodeImageBtnLayout()
            contentTableViewCell?.updateStarLabelLayout()
            contentTableViewCell?.arrowsImageBtn?.setTitle("获取授权码", for: UIControlState.normal)
            contentTableViewCell?.contentTextField?.placeholder = "必填"
            switch indexPath.row {
            case 0:
                contentTableViewCell?.arrowsImageBtn?.tag = 1001
                contentTableViewCell?.btnClick = {[weak self] (sender) in
                    self?.getXinyanSMS(sender)
                }
                break;
            case 1:
                contentTableViewCell?.arrowsImageBtn?.tag = 1002
                contentTableViewCell?.btnClick = {[weak self] (sender) in
                    self?.getYinshengbaoSMS(sender)
                }
                break;
            default:
                break
            }
            break
        default:
            break
        }
        return contentTableViewCell!
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        return footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getXinyanSMS(_ button:UIButton)  {
        xinyanTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(xinyanKeepTime), userInfo: nil, repeats: true)
        button.isUserInteractionEnabled = false
        button.alpha = 0.4;
        //调用发送验证码
        let tag = button.tag - 1001
        sendSms(tag: tag)
        
    }
    
    @objc func xinyanKeepTime()  {
        let button = self.view.viewWithTag(1001) as! UIButton
        xinyantimeNum -= 1
        button.setTitle("还剩\(xinyantimeNum)秒", for: UIControlState.normal)
        if xinyantimeNum == 0 {
            button.isUserInteractionEnabled = true
            button.alpha = 1;
            button.setTitle("重新获取", for: UIControlState.normal)
            xinyantimeNum = 60
            xinyanTimer?.invalidate()
            xinyanTimer = nil
        }
    }
    
    func getYinshengbaoSMS(_ button:UIButton)  {
        yinshengbaoTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(yinshengbaoKeepTime), userInfo: nil, repeats: true)
        button.isUserInteractionEnabled = false
        button.alpha = 0.4;
        //调用发送验证码
       
        let tag = button.tag - 1001
        sendSms(tag: tag)
        
    }
    
    func sendSms(tag:Int){
        let model = bankCardQueryArray![tag] as! BankCardAuthorizationAuthListModel
        
        let bankCardAuthorizationVM = BankCardAuthorizationViewModel()
        bankCardAuthorizationVM.setBlockWithReturn({ (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        bankCardAuthorizationVM.cardAuthSmsSendAuthPlatCode(model.authPlatCode, bankCode: bankCode, cardNo: cardNum, phone: telNum)
    }
    
    @objc func yinshengbaoKeepTime()  {
        let button = self.view.viewWithTag(1002) as! UIButton
        yinshengbaotimeNum -= 1
        button.setTitle("还剩\(yinshengbaotimeNum)秒", for: UIControlState.normal)
        if yinshengbaotimeNum == 0 {
            button.isUserInteractionEnabled = true
            button.alpha = 1;
            button.setTitle("重新获取", for: UIControlState.normal)
            yinshengbaotimeNum = 60
            yinshengbaoTimer?.invalidate()
            yinshengbaoTimer = nil
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

extension FXD_WithholdAuthViewController {
    
    func addFooterView() -> UIView {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 250))
        footerView.backgroundColor = LOAN_APPLICATION_COLOR
        let agreementView = FXD_AgreementView.init(CGRect.zero,content:"同意",protocolNameArr: ["《银行自动转账授权书》"])
        agreementView.isAgreementClick = {[weak self] (isClick) in
            self?.isAgreement = isClick
            if isClick {
                self?.bottomButton?.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
            }else{
                self?.bottomButton?.setBackgroundImage(UIImage.init(named: "applicationBtn_unselect_Image"), for: UIControlState.normal)
            }
        }
        agreementView.agreementClick = { [weak self] in
            //协议点击
            self?.getProtocolContentProtocolType(productId: "", typeCode: "1", applicationId: (self?.applicationId)!, periods: "")
            
        }
        footerView.addSubview(agreementView)
        agreementView.snp.makeConstraints { (make) in
            make.top.equalTo(footerView.snp.top).offset(13)
            make.left.right.equalTo(footerView)
            make.height.equalTo(20)
        }
        
        bottomButton = UIButton.init(type: UIButtonType.custom)
        bottomButton?.setBackgroundImage(UIImage.init(named: "applicationBtn_unselect_Image"), for: UIControlState.normal)
        //      bottomButton?.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
        bottomButton?.setTitle("确认授权", for: UIControlState.normal)
        bottomButton?.addTarget(self, action: #selector(bottomButtonClick), for: .touchUpInside)
        footerView.addSubview(bottomButton!)
        bottomButton?.snp.makeConstraints({ (make) in
            make.top.equalTo(footerView.snp.top).offset(154)
            make.left.equalTo(footerView.snp.left).offset(25)
            make.right.equalTo(footerView.snp.right).offset(-25)
        })
        return footerView
    }
    
    
    func getProtocolContentProtocolType(productId:String, typeCode:String,applicationId:String,periods:String){
        let commonVM = CommonViewModel()
        commonVM.setBlockWithReturn({ (retrunValue) in
    
            let baseResult = retrunValue as! BaseResultModel
            if baseResult.errCode == "0"{
                
                let content =  (baseResult.data as! [String:String])["productProURL"]
                let fxdWeb = FXDWebViewController.init()
                fxdWeb.urlStr = content
                self.navigationController?.pushViewController(fxdWeb, animated: true)
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        commonVM.obtainTransferAuthProtocolType(productId, typeCode: typeCode, cardBankCode: bankCode, cardNo: cardNum, stagingType: stagingType, applicationId: applicationId)

    }

    
    func addHeaderView() -> UIView {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 30))
        let imageView = UIImageView.init();
        imageView.image = UIImage.init(named: "hint_Icon_Image")
        headerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView.snp.centerY)
            make.left.equalTo(headerView.snp.left).offset(15)
        }
        
        let label = UILabel.init()
        label.text = "新增银行卡需要进行代扣授权"
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 12)
        headerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView.snp.centerY)
            make.left.equalTo(imageView.snp.right).offset(13)
        }
        return headerView
    }
    
    //MARK:UITextFieldDelegate
    @objc fileprivate func contentTextFieldEdit(textField:UITextField){
        
        let tag = textField.tag
        
        if (textField.text?.count)! > 6{
            
            let str1 = textField.text?.prefix(6)
            textField.text = String(str1!)
        }
        switch tag {
        case 101:
            
            smsCodeArray?.replaceObject(at: 0, with: textField.text as Any)
        case 102:
            
            smsCodeArray?.replaceObject(at: 1, with: textField.text as Any)
        default:
            break;
        }
    }
}


