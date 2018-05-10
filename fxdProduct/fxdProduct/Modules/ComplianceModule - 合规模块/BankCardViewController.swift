//
//  BankCardViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/6.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class BankCardViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource,OpenAccountCellDelegate,UITextFieldDelegate{

    var tableView : UITableView?
    var titleArray : NSArray?
    private var countdownTimer: Timer?
    private var remainingSeconds: Int = 0
    var codeBtn: UIButton?
    var smsSeq : String?
    var smsCode : String?
    var cardInfo : CardInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "更换绑卡-解卡"
        configureView()
        addBackItem()
        titleArray = ["预留手机号:","验证码:"]
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
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        codeBtn?.isEnabled = true
        codeBtn?.setBackgroundImage(UIImage.init(named: "code_icon"), for: .normal)
        codeBtn?.setTitle("发送验证码", for: .normal)
        countdownTimer?.invalidate()
        countdownTimer = nil
        smsCode = nil
        tableView?.reloadData()
    }
    
    //MARK:下一步按钮
    @objc fileprivate func nextBtnBtnClick(){
        
        if smsCode == nil {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请输入验证码")
            return
        }
        let controller = OpenAccountViewController()
        controller.isOPenAccount = false
//        smsSeq = "AAAAAAAA"
//        controller.orgSmsSeq = String(format:"%@%@",smsCode!,smsSeq!)
        controller.orgSmsCode = smsCode
        controller.orgSmsSeq = smsSeq
//        controller.orgSmsSeq = "\(smsCode)" + "\(smsSeq)"

        self.navigationController?.pushViewController(controller, animated: true)
        print("点击下一步按钮")
    }
    
    
    //MARK:验证码按钮事件
    func codeBtnClick(sender: UIButton) {
        
        codeBtn = sender
        sendSmsCode()
        
    }
    
    
    fileprivate func sendSmsCode(){
        
        let complianceVM = ComplianceViewModel()
        complianceVM.setBlockWithReturn({ [weak self](returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                let model = try? SmsCodeModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                self?.smsSeq = model?.smsSeq
                self?.remainingSeconds = 60
                self?.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self as Any, selector: #selector(self?.updateTime), userInfo: nil, repeats: true)
                
            }else{
                
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        
        complianceVM.hgSendSmsCodeBusiType("rebind", smsTempType: "O", bankCardNo: cardInfo?.cardNo, capitalPlatform: "2", mobile: cardInfo?.bankPhone, userCode: "")
    }
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 110
        }
        
        return 47
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = LINE_COLOR
        
        return headerView
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            var cell:BankCardCell! = tableView.dequeueReusableCell(withIdentifier:"BankCardCellId") as? BankCardCell
            if cell == nil {
                cell = BankCardCell.init(style: .default, reuseIdentifier: "BankCardCellId")
            }
            cell.selectionStyle = .none
            let url = URL(string: (cardInfo?.cardIcon)!)
            
            cell.cardImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholderImage_Icon"), options: .refreshCached, completed: { (uiimage, erroe, cachType, url) in
                
            })

            cell.cardNameLabel?.text = cardInfo?.bankName
            cell.cardSpeciesLabel?.text = cardInfo?.cardShortName
            cell.cardNumLabel?.text = cardInfo?.cardNo
            return cell
        }else{
            
            var cell:OpenAccountCell! = tableView.dequeueReusableCell(withIdentifier:"CellId") as? OpenAccountCell
            if cell == nil {
                cell = OpenAccountCell.init(style: .default, reuseIdentifier: "CellId")
            }
            cell.selectionStyle = .none
            cell.delegate = self
            cell.titleLabel?.text = titleArray?[indexPath.row] as? String
            cell.contentTextField?.tag = indexPath.row + 1
            cell.contentTextField?.isEnabled = true
            cell.contentTextField?.delegate = self
            cell.contentTextField?.addTarget(self, action: #selector(contentTextFieldEdit(textField:)), for: .editingChanged)

            if indexPath.row == 1 {
                cell.verificationCodeBtn?.isHidden = false
                cell.contentTextField?.text = ""
            }else{
                
                cell.contentTextField?.text = cardInfo?.bankPhone
            }
            if indexPath.row == (titleArray?.count)! - 1 {
                cell.lineView?.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @objc fileprivate func contentTextFieldEdit(textField:UITextField){
        
        let tag = textField.tag
        
        switch tag {
        case 1:
            if (textField.text?.count)! > 11
            {
                let str1 = textField.text?.prefix(11)
                textField.text = String(str1!)
            }
            
        case 2:
            if (textField.text?.count)! > 6
            {
                
                let str1 = textField.text?.prefix(6)
                textField.text = String(str1!)
                
            }
            
            self.smsCode = textField.text
        default:
            break
        }
        
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
