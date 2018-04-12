//
//  OpenAccountViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class OpenAccountViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource,OpenAccountCellDelegate,UITextFieldDelegate{

    var tableView : UITableView?
    var titleArray : NSArray?
    var contentArray : NSMutableArray = [""]
    private var countdownTimer: Timer?
    private var remainingSeconds: Int = 0
    var orgSmsSeq : String?
    var orgSmsCode : String?
    var codeBtn: UIButton?
    var isOPenAccount : Bool = true
    var openAccountModel : AccountModel?
    var submitArray : NSMutableArray?//0、开户银行  1、银行卡号  2、预留手机号  3、验证码  4、carId  5、SmsSeq  6、userCode  7、银行编号
    var index : Int = -1{
        didSet{
            
            contentArray.replaceObject(at: 3, with: "")
            contentArray.replaceObject(at: 4, with: "")
            submitArray?.replaceObject(at: 1, with: "")
            submitArray?.replaceObject(at: 2, with: "")
            self.tableView?.reloadData()
        }
    }
//    var isdispalyCard : Bool? = false
//
//    var userSelectIndex:Int? = 0
//    var selectedCard:CardInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleArray = ["姓名:","身份证号:","开户银行:","银行卡号:","预留手机号:","验证码:"]
        self.title = "平台开户"
        submitArray = NSMutableArray.init()
        configureView()
        addBackItem()
        if isOPenAccount {
            
            getHGAccountInfo()
            
        }else{
            
            getChangeBankCardInfo()
        }
        
        // Do any additional setup after loading the view.
    }

    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = LINE_COLOR
        tableView?.isScrollEnabled = false
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
        
        let nextBtn = UIButton()
        nextBtn.setTitle("点击新增", for: .normal)
        if isOPenAccount {
            nextBtn.setTitle("下一步", for: .normal)
        }
        nextBtn.setTitleColor(UIColor.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        nextBtn.setBackgroundImage(UIImage(named:"applayBtnImage"), for: .normal)
        nextBtn.addTarget(self, action: #selector(nextBtnBtnClick), for: .touchUpInside)
        self.view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(18)
            make.right.equalTo(self.view).offset(-18)
            make.top.equalTo(self.view).offset(520)
            make.height.equalTo(50)
        }
        
        if UI_IS_IPONE5 {
            nextBtn.snp.updateConstraints({ (make) in
                make.top.equalTo(self.view).offset(480)
            })
        }
        if UI_IS_IPONE6P {
            nextBtn.snp.updateConstraints({ (make) in
                make.top.equalTo(self.view).offset(570)
            })
        }
    }
    
    
    //MARK:下一步按钮点击事件
    @objc fileprivate func nextBtnBtnClick(){
        
        if (submitArray![0] as! String).count < 3 {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请选择开户银行")
            return
        }
        if (submitArray![1] as! String).count < 18 {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请输入银行卡号")
            return
        }
        if (submitArray![2] as! String).count < 11 {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请输入预留手机号")
            return
        }
        if (submitArray![3] as! String).count < 6 {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请输入验证码")
            return
        }
        
        if isOPenAccount {
            submitAccount()
        }else{
            changeBankCardSubmit()
        }
        
        print("点击下一步按钮")
    }
    
    //MARK:提交绑定银行卡
    fileprivate func changeBankCardSubmit(){
        
        HG_Manager.sharedHG().hgChangeBankCardBankNo(submitArray![7] as! String, bankReservePhone: submitArray![2] as! String, bankShortName: submitArray![0] as! String, cardNo: submitArray![1] as! String, retUrl: _transition_url, orgSmsCode: orgSmsCode, orgSmsSeq: orgSmsSeq, smsSeq: submitArray![5] as! String, userCode: submitArray![6] as! String, verifyCode: submitArray![3] as! String, vc: self)
        
    }
    
    //MARK:提交开户
    fileprivate func submitAccount(){
        
        HG_Manager.sharedHG().hgUserRegJumpP2pCtrlBankNo(submitArray![7] as! String, bankReservePhone: submitArray![2] as! String, bankShortName:submitArray![0] as! String, cardId: submitArray![4] as! String, cardNo: submitArray![1] as! String, retUrl: _transition_url, smsSeq: submitArray![5] as! String, userCode: submitArray![6] as! String, verifyCode: submitArray![3] as! String,capitalPlatform:"2", vc: self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        remainingSeconds = 0
        codeBtn?.isEnabled = true
        codeBtn?.setBackgroundImage(UIImage.init(named: "code_icon"), for: .normal)
        codeBtn?.setTitle("发送验证码", for: .normal)
        countdownTimer?.invalidate()
        countdownTimer = nil
        
        if (submitArray?.count)! > 4 {
            
            submitArray?.replaceObject(at: 3, with: "")
            contentArray.replaceObject(at: 5, with: "")
            tableView?.reloadData()
        }
    }
    
    //MARK:获取换绑卡信息
    func getChangeBankCardInfo(){
        let complianceVM = ComplianceViewModel()
        complianceVM.setBlockWithReturn({ [weak self] (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
                self?.contentArray.removeAllObjects()
                self?.openAccountModel = try? AccountModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                self?.dataProcessing()
                
            }else{
                
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        complianceVM.hgChangeBankCardInfo()
    }
    
    //MARK:获取开户信息
    func getHGAccountInfo(){
    
        let complianceVM = ComplianceViewModel()
        complianceVM.setBlockWithReturn({ [weak self](returnValue) in
           
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
                self?.contentArray.removeAllObjects()
                self?.openAccountModel = try? AccountModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                self?.dataProcessing()
                
            }else{
                
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
            
        }) {
            
        }
        
        complianceVM.hgAccountInfo()
        
    }
    
    //MARK:处理获取数据
    func dataProcessing(){
        
        self.contentArray.add(self.openAccountModel?.name != nil ? self.openAccountModel?.name as Any : "" as Any)
        self.contentArray.add(self.openAccountModel?.idCode != nil ? self.openAccountModel?.idCode as Any : "" as Any)
        self.contentArray.add(self.openAccountModel?.bankName != nil ? self.openAccountModel?.bankName as Any : "" as Any)
        self.contentArray.add(self.openAccountModel?.bankNum != nil ? self.openAccountModel?.bankNum as Any : "" as Any)
        self.contentArray.add(self.openAccountModel?.telephone != nil ? self.openAccountModel?.telephone as Any : "" as Any)
        self.contentArray.add("")
        
        self.submitArray?.add(self.openAccountModel?.bankShortName != nil ? self.openAccountModel?.bankShortName as Any : "" as Any)
        self.submitArray?.add(self.openAccountModel?.bankNum != nil ? self.openAccountModel?.bankNum as Any : "" as Any)
        self.submitArray?.add(self.openAccountModel?.telephone != nil ? self.openAccountModel?.telephone as Any : "" as Any)
        self.submitArray?.add("")
        self.submitArray?.add(self.openAccountModel?.cardId != nil ? self.openAccountModel?.cardId as Any : "" as Any)
        self.submitArray?.add("")
        self.submitArray?.add(self.openAccountModel?.userCode != nil ? self.openAccountModel?.userCode as Any : "" as Any)
        self.submitArray?.add(self.openAccountModel?.bankNo != nil ? self.openAccountModel?.bankNo as Any : "" as Any)
        self.tableView?.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (titleArray?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if UI_IS_IPONE6P {
            return 60
        }
        return 46
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = LINE_COLOR
        
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "tip_icon")
        headerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(headerView.snp.left).offset(17)
            make.centerY.equalTo(headerView.snp.centerY)
        }
        
        let contentLabel = UILabel()
        contentLabel.text = "温馨提示:确保本人为银行开户人"
        contentLabel.textColor = UIColor.red
        contentLabel.font = UIFont.yx_systemFont(ofSize: 12)
        headerView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(7)
            make.centerY.equalTo(headerView.snp.centerY)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = TIME_COLOR
        headerView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(headerView.snp.left).offset(0)
            make.right.equalTo(headerView.snp.right).offset(0)
            make.bottom.equalTo(headerView.snp.bottom).offset(-1)
            make.height.equalTo(1)
        }
        
        return headerView
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:OpenAccountCell! = tableView.dequeueReusableCell(withIdentifier:"CellId") as? OpenAccountCell
        if cell == nil {
            cell = OpenAccountCell.init(style: .default, reuseIdentifier: "CellId")
        }
        cell.selectionStyle = .none
        cell.delegate = self
        cell.contentTextField?.delegate = self
        cell.titleLabel?.text = titleArray?[indexPath.row] as? String
        cell.contentTextField?.keyboardType = .numberPad
        
        if contentArray.count > 1{
            
            cell.contentTextField?.text = contentArray[indexPath.row] as? String
            cell.contentTextField?.tag = indexPath.row + 1
//            cell.contentTextField?.isEnabled = false
            cell.contentTextField?.addTarget(self, action: #selector(contentTextFieldEdit(textField:)), for: .editingChanged)
            
            if indexPath.row == 3 {
                
                cell.contentTextField?.text = bankCardNo(bankNo: (contentArray[indexPath.row] as? String)!)
            }
        }
        if !isOPenAccount {
            if indexPath.row == 3{
                cell.contentTextField?.isEnabled = true
            }
        }
        
        if indexPath.row == 4 || indexPath.row == 5 {
            cell.contentTextField?.isEnabled = true
        }
        if index > 0 && indexPath.row == 3 {
            cell.contentTextField?.isEnabled = true
        }
        if indexPath.row == 2 {
            cell.rightBtn?.isHidden = false
        }
        if indexPath.row == 5 {
            cell.verificationCodeBtn?.isHidden = false
        }
        if indexPath.row == (titleArray?.count)! - 1 {
            cell.lineView?.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {

            let controller = BankListViewController()
//            controller.bankListArray = openAccountModel?.bankList! as NSArray?
            controller.bankListArray = openAccountModel?.bankList as! NSArray
            controller.selectedTag = index
            controller.selectedBankClosure = {(bankModel: BankListModel, selectedTag : NSInteger) -> Void in
                self.index = selectedTag
                self.contentArray.replaceObject(at: 2, with: bankModel.bankName)
                self.submitArray?.replaceObject(at: 7, with: bankModel.bankNo)
                self.submitArray?.replaceObject(at: 0, with: bankModel.bankCode)
                

            }
            
            self.navigationController?.pushViewController(controller, animated: true)

        }
    }
    
    //MARK:UITextFieldDelegate
    @objc fileprivate func contentTextFieldEdit(textField:UITextField){
        
        let tag = textField.tag
        
        switch tag {
        case 4:
            print("银行卡号")
        case 5:
            if (textField.text?.count)! > 11
            {
                let str1 = textField.text?.prefix(11)
                textField.text = String(str1!)
            }
            submitArray?.replaceObject(at: 2, with: textField.text as Any)
        case 6:
            if (textField.text?.count)! > 6
            {
                
                let str1 = textField.text?.prefix(6)
                textField.text = String(str1!)
            }
            submitArray?.replaceObject(at: 3, with: textField.text as Any)
            
        default:
            break
        }
        
    }
    
    //MARK:验证码按钮点击事件
    func codeBtnClick(sender:UIButton) {
        codeBtn = sender
        
        if isOPenAccount {
            sendSmsCode()
        }else{
            changeBankSendSmsCode()
        }
    }
    

    //MARK:验证码倒计时
    @objc fileprivate func updateTime(){
        
        remainingSeconds -= 1
        if remainingSeconds > 0 {
            codeBtn?.setBackgroundImage(UIImage.init(named: "selected_icon"), for: .normal)
            codeBtn?.setTitle("还剩" + "\(remainingSeconds)" + "s", for: .normal)
            codeBtn?.isEnabled = false
            
        }else{
            codeBtn?.isEnabled = true
            codeBtn?.setBackgroundImage(UIImage.init(named: "code_icon"), for: .normal)
            codeBtn?.setTitle("发送验证码", for: .normal)
            countdownTimer?.invalidate()
            countdownTimer = nil
        }
    }
    
    //MARK:绑定银行卡发送短信请求
    fileprivate func changeBankSendSmsCode(){
        let complianceVM = ComplianceViewModel()
        complianceVM.setBlockWithReturn({ [weak self](returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                let model = try? SmsCodeModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                self?.submitArray?.replaceObject(at: 5, with: model?.smsSeq as Any)
//                self?.submitArray?.replaceObject(at: 5, with: "AAAAAAAA")
                self?.remainingSeconds = 60
                self?.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self as Any, selector: #selector(self?.updateTime), userInfo: nil, repeats: true)
                
            }else{
                
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        
        complianceVM.hgSendSmsCodeBusiType("rebind", smsTempType: "N", bankCardNo: submitArray![1] as! String, capitalPlatform: "2", mobile: submitArray![2] as! String, userCode: submitArray![6] as! String)
    }
    
    //MARK:开户发送短信请求
    fileprivate func sendSmsCode(){
        
        let complianceVM = ComplianceViewModel()
        complianceVM.setBlockWithReturn({ [weak self](returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                let model = try? SmsCodeModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                self?.submitArray?.replaceObject(at: 5, with: model?.smsSeq as Any)
//                self?.submitArray?.replaceObject(at: 5, with: "AAAAAAAA")
                self?.remainingSeconds = 60
                self?.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self as Any, selector: #selector(self?.updateTime), userInfo: nil, repeats: true)
                
            }else{
                
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        
        complianceVM.hgSendSmsCodeBusiType("user_register", smsTempType: nil, bankCardNo: submitArray![1] as! String, capitalPlatform: "2", mobile: submitArray![2] as! String, userCode: submitArray![6] as! String)
    }
    
    //MARK:处理银行卡号位数空格
    func bankCardNo(bankNo : String) -> String{
        
        let newBankNo = NSMutableString.init(string: bankNo)
        var index = 0
        var j = 0
        for _ in bankNo{
            index += 1
            j += 1
            if index % 4 == 0 {
                
                newBankNo.insert(" ", at: j)
                j += 1
    
            }
        }
        return newBankNo as String
        
    }
    
    //MARK:UITextFieldDelegate处理银行卡输入
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == 5 || textField.tag == 6 || textField.tag == 1 || textField.tag == 2{
            return true
        }
        var returnValue = true
        let newText = NSMutableString.init(capacity: 0)
        newText.append(textField.text!)
        let noBlankStr = textField.text?.replacingOccurrences(of: " ", with: "")
        let banNo = noBlankStr! + string
        
        submitArray?.replaceObject(at: 1, with: banNo as Any)
        let textLength = noBlankStr?.count
        if string.count > 0{
            if textLength! < 20 {
                
                if textLength! > 0 && textLength! % 4 == 0 {
                    newText.append(" ")
                    newText.append(string)
                    textField.text = newText as String
                    returnValue = false
                }else{
                    newText.append(string)
                }
            }else{
                returnValue = false
            }
        }else{
            newText.replaceCharacters(in: range, with: string)
        }
        
        return returnValue
        
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
