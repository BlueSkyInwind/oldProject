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
    var codeBtn: UIButton?
//    var bankNameStr : String?
    var index : Int = -1{
        didSet{
            
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
        contentArray = ["黄渤","459503850073456","招商银行","459403850073656","16789404903","167894"]
        self.title = "平台开户"
        configureView()
        addBackItem()
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
        nextBtn.setTitle("下一步", for: .normal)
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
    
    
    @objc fileprivate func nextBtnBtnClick(){
        
        let controller = BankCardViewController()
        self.navigationController?.pushViewController(controller, animated: true)
        print("点击下一步按钮")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        getHGAccountInfo()
    }
    
    func getHGAccountInfo(){
    
        let complianceVM = ComplianceViewModel()
        complianceVM.setBlockWithReturn({ [weak self](returnValue) in
           
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                let model = try? AccountModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                self?.contentArray.add(model?.name as Any)
                self?.contentArray.add(model?.idCode as Any)
                self?.contentArray.add(model?.bankName as Any)
                self?.contentArray.add(model?.bankNum as Any)
                self?.contentArray.add(model?.telephone as Any)
                self?.tableView?.reloadData()
                
            }else{
                
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
            
        }) {
            
        }
        
        complianceVM.hgAccountInfo()
        
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
//        cell.contentLabel?.text = cntentArray?[indexPath.row] as? String
        if contentArray.count > 1{
            
            cell.contentTextField?.text = contentArray[indexPath.row] as? String
            cell.contentTextField?.tag = indexPath.row + 1
            cell.contentTextField?.isEnabled = false
            cell.contentTextField?.addTarget(self, action: #selector(contentTextFieldEdit(textField:)), for: .editingChanged)
            
            if indexPath.row == 3{

                cell.contentTextField?.text = bankCardNo(bankNo: (contentArray[indexPath.row] as? String)!)
            }
        }
        
        if indexPath.row == 4 || indexPath.row == 5{
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
            controller.selectedTag = index
            controller.selectedBankClosure = {(bankName: String, selectedTag : NSInteger) -> Void in
                self.index = selectedTag
                self.contentArray.replaceObject(at: 2, with: bankName)
//                self.bankNameStr = bankName
            }
            
            self.navigationController?.pushViewController(controller, animated: true)
            
//            pushUserBankListVC()

        }
        
    }
    
//    func pushUserBankListVC()  {
//        let userBankCardListVC = UserBankCardListVCModule.init()
//        userBankCardListVC.currentIndex = userSelectIndex!
//        userBankCardListVC.payPatternSelectBlock = {[weak self] (cardInfo,currentIndex) in
//            self?.isdispalyCard = true
//            self?.selectedCard = cardInfo
//            self?.userSelectIndex = currentIndex
//            if cardInfo == nil {
////                self?.fatchCardInfo({ (isSuccess, isBankCard) in
////                })
//            }
//            self?.tableView?.reloadData()
//        }
//        self.navigationController?.pushViewController(userBankCardListVC, animated: true)
//    }
    
    @objc fileprivate func contentTextFieldEdit(textField:UITextField){
        
        let tag = textField.tag
        
        switch tag {
        case 3:
            print("开户银行")
        case 4:
            print("银行卡号")
        case 5:
            if (textField.text?.count)! > 11
            {
                let str1 = textField.text?.prefix(11)
                textField.text = String(str1!)
            }
            
        case 6:
            if (textField.text?.count)! > 6
            {
                
                let str1 = textField.text?.prefix(6)
                textField.text = String(str1!)
            
            }
            
        default:
            break
        }
        
    }
    
    func codeBtnClick(sender:UIButton) {
        remainingSeconds = 60
        codeBtn = sender
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
//        sendSmsCode()

    }
    

    @objc fileprivate func updateTime(){
        
        remainingSeconds -= 1
        if remainingSeconds > 0 {
            codeBtn?.setBackgroundImage(UIImage.init(named: "selected_icon"), for: .normal)
            codeBtn?.setTitle("\(remainingSeconds)", for: .normal)
            codeBtn?.isEnabled = false
            
        }else{
            codeBtn?.isEnabled = true
            codeBtn?.setBackgroundImage(UIImage.init(named: "code_icon"), for: .normal)
            codeBtn?.setTitle("验证码", for: .normal)
            countdownTimer?.invalidate()
            countdownTimer = nil
        }
    }
    
    fileprivate func sendSmsCode(){
        
        let complianceVM = ComplianceViewModel()
        complianceVM.setBlockWithReturn({ (returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
            }else{
                
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        
        complianceVM.hgSendSmsCodeBusiType("user_register", smsTempType: nil, bankCardNo: contentArray[3] as! String, capitalPlatform: "1", mobile: contentArray[4] as! String, userCode: nil)
    }
    
    func bankCardNo(bankNo : String) -> String{
        
        let newBankNo = NSMutableString.init(string: bankNo)
        var index = 0
        var j = 0
        for str in bankNo{
            index += 1
            j += 1
            if index % 4 == 0 {
                
                newBankNo.insert(" ", at: j)
                j += 1
    
            }
        }
        return newBankNo as String
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var returnValue = true
        let newText = NSMutableString.init(capacity: 0)
        newText.append(textField.text!)
        let noBlankStr = textField.text?.replacingOccurrences(of: " ", with: "")
        let textLength = noBlankStr?.count
        if string.count > 0{
            if textLength! < 18 {
                if textLength! > 0 && textLength! % 4 == 0 {
//                    newText = newText.trimmingCharacters(in: NSCharacterSet.whitespaces) as! NSMutableString
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
