//
//  BillingMessageViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/4/25.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class BillingMessageViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource ,UITextFieldDelegate,BankTableViewSelectDelegate{
    
    var tableView : UITableView?
    var titleArray : [String] = ["所属银行","卡号","预留手机号"]
    var dataArray : NSMutableArray?
    var footBtn : UIButton?
    var supportBankListArray : NSMutableArray?
    @objc var requestType:String?
    var cardCode : NSString?
    var cardFlag : Int?
    @objc var type = "0"
    @objc var applicationId = ""
//    @objc var stagingType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        supportBankListArray = NSMutableArray.init(capacity: 100)
        
        self.title = "添加银行卡"
        if type == "0" {
           self.title = "收款信息"
        }
        addBackItem()
        configureView()
        dataArray = ["","","","",""]
        cardCode = ""
        cardFlag = 0
//        getInfo()
        fatchCardInfo()
        // Do any additional setup after loading the view.
    }

    
    func fatchCardInfo(){
        
        let checkBankViewModel = CheckBankViewModel()
        checkBankViewModel.setBlockWithReturn({ (returnValue) in
            
            let baseResult = returnValue as! BaseResultModel
            if baseResult.errCode == "0" {
                
                self.supportBankListArray?.removeAllObjects()
                let array = baseResult.data as! NSArray

                for index in 0 ..< array.count{
                    let model = try! SupportBankList.init(dictionary: array[index] as! [AnyHashable : Any])
                    self.supportBankListArray?.add(model)
                }
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        checkBankViewModel.getSupportBankListInfo("2")
    }
   
    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = PayPasswordBackColor_COLOR
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        if #available(iOS 11.0, *){
            tableView?.contentInsetAdjustmentBehavior = .never;
            tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }else if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = true;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        
        let headerView = UIView.init(frame: CGRect(x:0,y:64,width:_k_w,height:30))
        headerView.backgroundColor = UIColor.clear
        
        let leftImageView = UIImageView()
        leftImageView.image = UIImage.init(named: "topCellIcon")
        headerView.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { (make) in
            make.left.equalTo(headerView.snp.left).offset(17)
            make.centerY.equalTo(headerView.snp.centerY)
        }
        let tipLabel = UILabel()
        tipLabel.text = "绑本人常用卡有助于测评通过"
        tipLabel.font = UIFont.yx_systemFont(ofSize: 12)
        tipLabel.textColor = UIColor.red
        headerView.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftImageView.snp.right).offset(11)
            make.centerY.equalTo(headerView.snp.centerY)
        }
        
        leftImageView.isHidden = true;
        tipLabel.isHidden = true;
        
        if type == "0" {
            tableView?.tableHeaderView = headerView
        }
        
        let footView = UIView.init(frame: CGRect(x:0,y:0,width:_k_w,height:100))
        footBtn = UIButton()
        footBtn?.setTitle("下一步", for: .normal)
        footBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 17)
        footBtn?.setTitleColor(UIColor.white, for: .normal)
        footBtn?.setBackgroundImage(UIImage.init(named: "btn_icon"), for: .normal)
//        footBtn?.backgroundColor = QUTOA_COLOR
//        footBtn?.layer.cornerRadius = 5.0
        footBtn?.isEnabled = false
        footBtn?.addTarget(self, action: #selector(footBtnClick), for: .touchUpInside)
        footView.addSubview(footBtn!)
        footBtn?.snp.makeConstraints { (make) in
//            make.left.equalTo(footView.snp.left).offset(30)
//            make.right.equalTo(footView.snp.right).offset(-30)
            make.top.equalTo(footView.snp.top).offset(50)
            make.height.equalTo(40)
            make.width.equalTo(240)
            make.centerX.equalTo(footView.snp.centerX)
        }
        tableView?.tableFooterView = footView
        
    }
    
    @objc func footBtnClick(){
        
        if (dataArray![0] as! String).count < 0 {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请选择银行")
            return
        }
        if (dataArray![1] as! String).count < 16 {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请输入正确的卡号")
            return
        }
        if (dataArray![2] as! String).count < 11 {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请输入正确的预留手机号")
            return
        }
        
        if type == "0" {
            getInfo(type: "1")
        }else{
            getInfo(type: "")
        }
    }
    
    func getInfo(type : String){
        let bankCardAuthorizationVM = BankCardAuthorizationViewModel()
        bankCardAuthorizationVM.setBlockWithReturn({[weak self] (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
                let model = try! BankCardAuthorizationModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                if model.authList.count > 0{
                    
                    let controller = FXD_WithholdAuthViewController()
                    controller.bankName = (self?.dataArray?[0] as! String)
                    controller.cardNum = (self?.dataArray?[1] as! String)
                    controller.telNum = (self?.dataArray?[2] as! String)
                    controller.bankCode = (self?.dataArray?[3] as! String)
                    controller.bankShortName = (self?.dataArray?[4] as! String)
                    controller.requestType = self?.requestType
                    controller.applicationId = (self?.applicationId)!
                    if type == "0" {
                        controller.type = .personCenter
                    }else{
                        controller.type = .addBankCard
                    }
                    self?.navigationController?.pushViewController(controller, animated: true)
                    
                }else{
                    
                }
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        
        bankCardAuthorizationVM.cardAuthQueryBankShortName((dataArray?[3] as! String), cardNo: (dataArray?[1] as! String),type:type)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:ContentTableViewCell! = tableView.dequeueReusableCell(withIdentifier:"ContentTableViewCell") as? ContentTableViewCell
        if cell == nil {
            cell = ContentTableViewCell.init(style: .default, reuseIdentifier: "ContentTableViewCell")
        }
        cell.backgroundColor = UIColor.white
//        cell.btnClick = ({[weak self] (sender) in
//
//            MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: "选择银行卡")
//        })
        cell.selectionStyle = .none
        cell.titleLabel?.text = titleArray[indexPath.row]
        cell.lineView?.isHidden = false
        cell.arrowsImageBtn?.isHidden = true
        cell.contentTextField?.isEnabled = true
        cell.contentTextField?.delegate = self
        cell.contentTextField?.tag = indexPath.row + 100
        cell.contentTextField?.keyboardType = .numberPad
        cell.contentTextField?.text = (dataArray?[indexPath.row] as! String)
        cell.contentTextField?.addTarget(self, action: #selector(contentTextFieldEdit(textField:)), for: .editingChanged)
        if indexPath.row == 0 {
            cell.arrowsImageBtn?.isHidden = false
            cell.contentTextField?.isEnabled = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let controller = BankCardNameVCModules()
            controller.bankArray = supportBankListArray
            controller.cardTag = (cardCode?.integerValue)!
            controller.cardTag = cardFlag!
            controller.delegate = self
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
    }
    
    //MARK:UITextFieldDelegate
    @objc fileprivate func contentTextFieldEdit(textField:UITextField){
        
        let tag = textField.tag
    
        if tag == 102 {
            
            if (textField.text?.count)! > 11
            {
                let str1 = textField.text?.prefix(11)
                textField.text = String(str1!)
            }
            
            dataArray?.replaceObject(at: 2, with: textField.text as Any)
            
            if footerBtnEnabled() {
                
                footBtn?.setBackgroundImage(UIImage.init(named: "btn_seleted_icon"), for: .normal)
//                footBtn?.backgroundColor = UI_MAIN_COLOR
            }else{
                footBtn?.setBackgroundImage(UIImage.init(named: "btn_icon"), for: .normal)
//                footBtn?.backgroundColor = QUTOA_COLOR
            }
            footBtn?.isEnabled = footerBtnEnabled()
        }
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
        
        if textField.tag == 102 {
            return true
        }
        var returnValue = true
        let newText = NSMutableString.init(capacity: 0)
        newText.append(textField.text!)
        let noBlankStr = textField.text?.replacingOccurrences(of: " ", with: "")
//        let banNo = noBlankStr! + string
        var banNo = noBlankStr!
        if (noBlankStr?.count)! < 20 {
            banNo = noBlankStr! + string
        }
        dataArray?.replaceObject(at: 1, with: banNo as Any)
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
            let str = newText.replacingOccurrences(of: " ", with: "")
            dataArray?.replaceObject(at: 1, with: str)
        }
        
        if footerBtnEnabled() {
            
            footBtn?.setBackgroundImage(UIImage.init(named: "btn_seleted_icon"), for: .normal)
//            footBtn?.backgroundColor = UI_MAIN_COLOR
        }else{
            
            footBtn?.setBackgroundImage(UIImage.init(named: "btn_icon"), for: .normal)
//            footBtn?.backgroundColor = QUTOA_COLOR
        }
        footBtn?.isEnabled = footerBtnEnabled()
        return returnValue
        
    }
    
    func footerBtnEnabled()->Bool{
    
        var isEnabled = false
        if ((dataArray![0] as! String).count > 0) && ((dataArray![1] as! String).count > 0) && ((dataArray![2] as! String).count > 0){
            
            isEnabled = true
        }
        
        return isEnabled
    }
    
    func bankSelect(_ bankInfo: SupportBankList!, andSectionRow sectionRow: Int) {
        
        cardFlag = sectionRow
        dataArray?.replaceObject(at: 0, with: bankInfo.bank_name_)
        dataArray?.replaceObject(at: 3, with: bankInfo.bank_code_)
        dataArray?.replaceObject(at: 4, with: bankInfo.bank_short_name_)
        self.tableView?.reloadData()
        if footerBtnEnabled() {
            
            footBtn?.setBackgroundImage(UIImage.init(named: "btn_seleted_icon"), for: .normal)
//            footBtn?.backgroundColor = UI_MAIN_COLOR
        }else{
            
            footBtn?.setBackgroundImage(UIImage.init(named: "btn_icon"), for: .normal)
//            footBtn?.backgroundColor = QUTOA_COLOR
        }
        footBtn?.isEnabled = footerBtnEnabled()
        
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
