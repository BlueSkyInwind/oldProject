//
//  BillingMessageViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/4/25.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class BillingMessageViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource ,UITextFieldDelegate{

    var tableView : UITableView?
    var titleArray : [String] = ["所属银行","卡号","预留手机号"]
    var dataArray : NSMutableArray?
    var footBtn : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "收款信息"
        addBackItem()
        configureView()
        dataArray = ["","",""]
        
        // Do any additional setup after loading the view.
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
            tableView?.contentInset = UIEdgeInsetsMake(CGFloat(obtainBarHeight_New(vc: self)), 0, 0, 0)
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
        
        tableView?.tableHeaderView = headerView
        
        
        let footView = UIView.init(frame: CGRect(x:0,y:0,width:_k_w,height:100))
        
        footBtn = UIButton()
        footBtn?.setTitle("下一步", for: .normal)
        footBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 17)
        footBtn?.setTitleColor(UIColor.white, for: .normal)
        footBtn?.backgroundColor = QUTOA_COLOR
        footBtn?.layer.cornerRadius = 5.0
        footBtn?.isEnabled = false
        footBtn?.addTarget(self, action: #selector(footBtnClick), for: .touchUpInside)
        footView.addSubview(footBtn!)
        footBtn?.snp.makeConstraints { (make) in
            make.left.equalTo(footView.snp.left).offset(30)
            make.right.equalTo(footView.snp.right).offset(-30)
            make.top.equalTo(footView.snp.top).offset(50)
            make.height.equalTo(45)
        }
        tableView?.tableFooterView = footView
        
    }
    
    @objc func footBtnClick(){
        
        if (dataArray![0] as! String).count < 0 {
            
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请选择开户银行")
            return
        }
        if (dataArray![1] as! String).count < 18 {
            
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请输入正确的卡号")
            return
        }
        if (dataArray![2] as! String).count < 11 {
            
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请输入正确的预留手机号")
            return
        }
        
        MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "点击下一步按钮")
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
        
        cell.btnClick = ({[weak self] (sender) in
        
            MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: "选择银行卡")
        })
        cell.selectionStyle = .none
        cell.titleLabel?.text = titleArray[indexPath.row]
        cell.lineView?.isHidden = false
        cell.arrowsImageBtn?.isHidden = true
        cell.contentTextField?.isEnabled = true
        cell.contentTextField?.delegate = self
        cell.contentTextField?.tag = indexPath.row + 100
        cell.contentTextField?.addTarget(self, action: #selector(contentTextFieldEdit(textField:)), for: .editingChanged)
        if indexPath.row == 0 {
            cell.arrowsImageBtn?.isHidden = false
            cell.contentTextField?.isEnabled = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
//            let controller = BankListViewController()
////            controller.bankListArray = openAccountModel?.bankList as! NSArray
////            controller.selectedTag = index
//            controller.selectedBankClosure = {(bankModel: BankListModel, selectedTag : NSInteger) -> Void in
////                self.index = selectedTag
////                self.contentArray.replaceObject(at: 2, with: bankModel.bankName)
////                self.submitArray?.replaceObject(at: 7, with: bankModel.bankNo)
////                self.submitArray?.replaceObject(at: 0, with: bankModel.bankCode)
//
//                self.dataArray?.replaceObject(at: 0, with: "1234")
//            }
//            
//            self.navigationController?.pushViewController(controller, animated: true)
            
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
                
                footBtn?.backgroundColor = UI_MAIN_COLOR
            }else{
                footBtn?.backgroundColor = QUTOA_COLOR
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
        let banNo = noBlankStr! + string
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
            
            footBtn?.backgroundColor = UI_MAIN_COLOR
        }else{
            footBtn?.backgroundColor = QUTOA_COLOR
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
