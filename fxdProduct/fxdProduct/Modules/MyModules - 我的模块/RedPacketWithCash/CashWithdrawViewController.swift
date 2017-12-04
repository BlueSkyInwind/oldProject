//
//  WithdrawViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/20.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit
import IQKeyboardManager

class CashWithdrawViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource,ImportPayPasswordViewDelegate{

    var tableView : UITableView?
    let cellId = "CellId"
    var currentindex : Int?
    var cardInfo : CardInfo?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "提现"
        addBackItem()
        currentindex = 0
        // Do any additional setup after loading the view.
        configureView()
        bottomView()
        getBankCardsList()

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
    
    override func popBack(){
        
        PopFirstController()
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MRAK:返回上一级
    func PopFirstController()  {
        for  vc in self.rt_navigationController.rt_viewControllers {
            if vc.isKind(of: CashRedEnvelopeViewController.self) {
                self.navigationController?.popToViewController(vc, animated: true)
                return
            }
        }
    }
    
    //MARK:设置tableview
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
        
        let withdrawBtn = UIButton()
        withdrawBtn.setTitle("提现", for: .normal)
        withdrawBtn.setTitleColor(UIColor.white, for: .normal)
        withdrawBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        withdrawBtn.backgroundColor = UI_MAIN_COLOR
        withdrawBtn.layer.cornerRadius = 5.0
        withdrawBtn.addTarget(self, action: #selector(withdrawBtnClick), for: .touchUpInside)
        tableView?.addSubview(withdrawBtn)
        withdrawBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(18)
            make.right.equalTo(self.view).offset(-18)
            make.top.equalTo(self.view).offset(280)
            make.height.equalTo(50)
        }
        if UI_IS_IPONE6P {
            withdrawBtn.snp.updateConstraints({ (make) in
                make.top.equalTo(self.view).offset(320)
            })
        }
    }
    
    //MARK:设置底部View
    func bottomView(){
        
        let bgView = UIView()
        self.view.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(self.view).offset(-22)
            make.width.equalTo(222)
            make.height.equalTo(15)
        }
        
        let changePwdBtn = UIButton()
        changePwdBtn.setTitle("修改交易密码", for: .normal)
        changePwdBtn.setTitleColor(UI_MAIN_COLOR, for: .normal)
        changePwdBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        changePwdBtn.addTarget(self, action: #selector(changePwdBtnClick), for: .touchUpInside)
        bgView.addSubview(changePwdBtn)
        changePwdBtn.snp.makeConstraints { (make) in
            
            make.left.equalTo(bgView.snp.left).offset(2)
            make.width.equalTo(100)
            make.height.equalTo(15)
            make.centerY.equalTo(bgView.snp.centerY)
        }
        let middleLine = UIView()
        middleLine.backgroundColor = MIDDLE_LINE_COLOR
        bgView.addSubview(middleLine)
        middleLine.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgView.snp.centerX)
            make.centerY.equalTo(bgView.snp.centerY)
            make.height.equalTo(15)
            make.width.equalTo(1)
        }
        
        let resetPwdBtn = UIButton()
        resetPwdBtn.setTitle("重置交易密码", for: .normal)
        resetPwdBtn.setTitleColor(UI_MAIN_COLOR, for: .normal)
        resetPwdBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        resetPwdBtn.addTarget(self, action: #selector(resetPwdBtnClick), for: .touchUpInside)
        bgView.addSubview(resetPwdBtn)
        resetPwdBtn.snp.makeConstraints { (make) in
            make.right.equalTo(bgView.snp.right).offset(-2)
            make.centerY.equalTo(bgView.snp.centerY)
            make.height.equalTo(15)
            make.width.equalTo(100)
        }
    }
    
    
    //MARK:各种点击事件
    
    /// 修改交易密码
    @objc func changePwdBtnClick(){
        
        let transactionInfoVC = SetTransactionInfoViewController.init()
        transactionInfoVC.exhibitionType = .modificationTradePassword_Type
        self.navigationController?.pushViewController(transactionInfoVC, animated: true)

    }
    
    /// 重置交易密码
    @objc func resetPwdBtnClick(){
        
        let transactionInfoVC = SetTransactionInfoViewController.init()
        transactionInfoVC.exhibitionType = .resetTradePassword_Type
        self.navigationController?.pushViewController(transactionInfoVC, animated: true)

    }
    
    /// 提现按钮点击
    @objc func withdrawBtnClick(){
        
        popImportPayPasswordView()
        
    }
    
    func popImportPayPasswordView()  {
        ImportPayPasswordView.showImportPayPasswordView(self, amountStr: FXD_Utility.shared().amount)
    }
    
    //MARK:ImportPayPasswordViewDelegate
    func userInputCashPasswordCode(_ code: String) {
        print(code)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            ImportPayPasswordView.dismissImportPayPasswordView()
        }
        withdrawCash(payPassword: code)
    }
    func userForgetPasswordClick() {
        ImportPayPasswordView.dismissImportPayPasswordView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let transactionInfoVC = SetTransactionInfoViewController.init()
            transactionInfoVC.exhibitionType = .resetTradePassword_Type
            self.navigationController?.pushViewController(transactionInfoVC, animated: true)
        }
    }
    
    //提现
    func withdrawCash(payPassword : String){
        let cashViewModel = CashViewModel()
        cashViewModel.setBlockWithReturn({ (returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                let withdrawCashModel = try? WithdrawCashModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                let status = Int((withdrawCashModel?.status)!)
                //返回状态（0提现申请已提交、1提现执行异常、2交易密码错误、3交易密码已冻结）
                switch status {
                case 0?:
                    let controller = WithdrawDetailsViewController()
                    controller.withdrawCashModel = withdrawCashModel
                    self.navigationController?.pushViewController(controller, animated: true)
                case 1?:
                    
                    MBPAlertView.sharedMBPText().showTextOnly(self.view, message: withdrawCashModel?.message)
                case 2?:
                    self.setAlertView(title: "交易密码不正确", message: (withdrawCashModel?.message)!, sureTitle: "找回密码", cancelTitle: "重新输入", tag: "1")
                case 3?:
                    self.setAlertView(title: "交易密码冻结", message: (withdrawCashModel?.message)!, sureTitle: "取消", cancelTitle: "找回密码", tag: "2")
                default:
                    break
                }
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
        }
        cashViewModel.withdrawCashAmount(FXD_Utility.shared().amount, bankCardId: self.cardInfo?.cardId, operateType: FXD_Utility.shared().operateType, payPassword: payPassword)
    }
    
    func setAlertView(title: String, message: String, sureTitle: String, cancelTitle: String, tag: String){
        let alertController = UIAlertController(title: title , message: message , preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: cancelTitle, style: .cancel, handler: { (cancelAction) in
            
            if tag == "1"{
                
                let transactionInfoVC = SetTransactionInfoViewController.init()
                transactionInfoVC.exhibitionType = .resetTradePassword_Type
                self.navigationController?.pushViewController(transactionInfoVC, animated: true)
            }else if tag == "2"{
                ImportPayPasswordView.cleanUpPayPasswordView()
            }
        }))
        
        alertController.addAction(UIAlertAction.init(title: sureTitle, style: .default, handler: { (action) in
            if tag == "1"{
                
                ImportPayPasswordView.dismissImportPayPasswordView()
                
            }else if tag == "2"{
                
                ImportPayPasswordView.cleanUpPayPasswordView()
                
                let transactionInfoVC = SetTransactionInfoViewController.init()
                transactionInfoVC.exhibitionType = .resetTradePassword_Type
                self.navigationController?.pushViewController(transactionInfoVC, animated: true)
                
            }
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
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
                        self.cardInfo = cardInfo
                        self.tableView?.reloadData()
                        break
                    }
                }
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
        }
        bankInfoVM.obtainUserBankCardList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if UI_IS_IPONE6P {
            return 80
        }
        return 68
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = LINE_COLOR
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:CurrentInformationCell! = tableView.dequeueReusableCell(withIdentifier:cellId) as? CurrentInformationCell
        if cell == nil {
            cell = CurrentInformationCell.init(style: .default, reuseIdentifier: cellId)
        }
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            
            cell.cellType = CurrentInfoCellType(cellType: .Default)
            cell.leftLabel?.text = "提现金额"
            cell.rightLabel?.text = "¥" + "\( FXD_Utility.shared().amount ?? "")"
            
            let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(cell.rightLabel?.text)!)
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(1,attrstr.length-1))
            attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.yx_systemFont(ofSize: 35) ?? 35, range: NSMakeRange(1,attrstr.length-1))
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: RedPacketMoney_COLOR, range: NSMakeRange(0,1))
            attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.yx_systemFont(ofSize: 25) ?? 25, range: NSMakeRange(0,1))
            cell.rightLabel?.attributedText = attrstr
            
            return cell
        }
        
        cell.cellType = CurrentInfoCellType(cellType: .Payment)
        cell.leftLabel?.text = "到账银行卡"
        
        if cardInfo != nil {
            
            let index = cardInfo?.cardNo.index((cardInfo?.cardNo.endIndex)!, offsetBy: -4)
            let numStr = cardInfo?.cardNo[index!...]
            cell.rightLabel?.text = (cardInfo?.bankName)!+"("+numStr!+")"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            
            let userBankCardListVC = UserBankCardListVCModule()
            userBankCardListVC.currentIndex = currentindex!
            userBankCardListVC.userSelectedBankCard({ [weak self] (cardInfo, currentIndex) in
                self?.cardInfo = cardInfo
                self?.currentindex = currentIndex
                self?.tableView?.reloadData()
            })
            self.navigationController?.pushViewController(userBankCardListVC, animated: true)
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
