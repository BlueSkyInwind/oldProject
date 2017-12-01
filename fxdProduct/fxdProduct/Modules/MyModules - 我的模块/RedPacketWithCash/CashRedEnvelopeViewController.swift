//
//  CashRedEnvelopeViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/17.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class CashRedEnvelopeViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource,RedPacketHeaderViewDelegate,RedPacketCellDelegate{

    var tableView : UITableView?
    var headerView : RedPacketHeaderView?
    var model : WithdrawCashInfoModel?
    @objc var isWithdraw = false     // 区别现金红包 和账户余额   （账户余额  ）
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        addBackItemRoot()
        setNavRightBar()
        // Do any additional setup after loading the view.
        if isWithdraw {
            self.title = "现金红包"
            FXD_Utility.shared().operateType = "1"
        }else{
            self.title = "账户余额"
            FXD_Utility.shared().operateType = "2"
        }
        self.setAlertView(title: "设置密码提示", message: "为了您的资金安全，提现前请先设置交易密码", sureTitle: "去设置",tag: "0")

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var flag = ""
        if isWithdraw {
            flag = "1"
        }else{
            flag = "2"
        }
        
        loadWithdrawCashInfo(flag, { (isSuccess) in
            if isSuccess{
                
                self.configureView()
                let str=NSString(string:(self.model?.amount)!)
                let amount = String(format: "%.2f", str.floatValue)
                
                self.headerView?.moneyLabel?.text = "¥" + amount
                let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(self.headerView!.moneyLabel?.text)!)
                attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(1,attrstr.length-1))
                attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 35), range: NSMakeRange(1,attrstr.length-1))
                self.headerView?.moneyLabel?.attributedText = attrstr
                self.tableView?.reloadData()
            }
        })
    }
    
    //MARK:网络请求
    func loadWithdrawCashInfo(_ operateType:String, _ result : @escaping (_ isSuccess : Bool) -> Void)  {
        
        let cashVM = CashViewModel()
        cashVM.setBlockWithReturn({ [weak self] (returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
                self?.model = try? WithdrawCashInfoModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                result(true)

            }else{
                result(false)
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
            
        }) {
            result(false)
        }
        
        cashVM.loadWithdrawCashInfoOperateType(operateType)
    }
    
    //MARK:设置右上角按钮
    func setNavRightBar(){
        
        let aBarbi = UIBarButtonItem.init(title: "收提明细", style: .plain, target: self, action: #selector(rightClick))
        self.navigationItem.rightBarButtonItem = aBarbi
        aBarbi.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:RedPacket_COLOR,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        aBarbi.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:RedPacket_COLOR,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], for: .selected)
       
    }
   
    //MARK:设置tableview
    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        headerView = RedPacketHeaderView()
        if isWithdraw {
            headerView?.headerImage?.image = UIImage(named:"packet")
            headerView?.titleLabel?.text = "我的现金"
        }else{
            
            headerView?.headerImage?.image = UIImage(named:"accountBig")
            headerView?.titleLabel?.text = "我的余额"
        }
        
        headerView?.delegate = self
        tableView?.tableHeaderView = headerView
    }
    
    @objc func rightClick(){
        
        let controller = ReminderDetailsViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if UI_IS_IPONE5 {
            return _k_h-285-74
        }
        return _k_h-335-74
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
        
        var redPacketCell:RedPacketCell! = tableView.dequeueReusableCell(withIdentifier:"RedPacketCell") as? RedPacketCell
        if redPacketCell == nil {
            redPacketCell = RedPacketCell.init(style: .default, reuseIdentifier: "RedPacketCell")
        }

        if isWithdraw {
            redPacketCell.bottomBtn?.setTitle("关于现金红包", for: .normal)
        }else{
            redPacketCell.bottomBtn?.setTitle("关于账户余额", for: .normal)
        }
        redPacketCell.delegate = self
        redPacketCell.selectionStyle = .none
        redPacketCell.descLabel?.text = self.model?.withdrawDesc
        return redPacketCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func withdrawBtnClick(){
        
    let controller = CashWithdrawViewController()
    self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    //MARK:点击提现
    func withdrawBtnClick1(){
        
        if isWithdraw {
            checkWithdrawCash(operateType: "1")
        }else{
            checkWithdrawCash(operateType: "2")
        }
    }
    
    
    func checkWithdrawCash(operateType: String){
        let cashVM = CashViewModel()
        cashVM.setBlockWithReturn({ [weak self] (returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
               let checkModel = try? CheckWithdrawCashModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                let status = Int((checkModel?.status)!)
                
                //返回状态（0校验通过、1校验异常、2已逾期、3金额不足、4未设置交易密码、5身份认证和绑卡认证未完成）
                switch status {
                case 0?:
                    let controller = CashWithdrawViewController()
                    self?.navigationController?.pushViewController(controller, animated: true)

                case 1?,2?,3?:

                    MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: checkModel?.message)

                case 3?:

                    self?.setAlertView(title: "设置密码提示", message: "为了您的资金安全，提现前请先设置交易密码", sureTitle: "去设置",tag: "0")

                case 4?:

                    self?.setAlertView(title: "完善资料提示",message: "为了顺利提现，请先完成身份认证及绑卡", sureTitle: "去完善",tag: "1")

                default:
                    break
                }
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        cashVM.checkWithdrawCashOperateType(operateType)
    }

    func setAlertView(title: String, message: String, sureTitle: String, tag: String){
        let alertController = UIAlertController(title: title , message: message , preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (cancelAction) in
            
        }))
        
        alertController.addAction(UIAlertAction.init(title: sureTitle, style: .default, handler: { (action) in
            if tag == "0"{
                
//                let controller = CashWithdrawViewController()
//                self.navigationController?.pushViewController(controller, animated:true)
                let transactionInfoVC = SetTransactionInfoViewController.init()
                transactionInfoVC.exhibitionType = .modificationTradePassword_Type
                self.navigationController?.pushViewController(transactionInfoVC, animated: true)
            }else{
                let controlller = UserDataAuthenticationListVCModules()
                self.navigationController?.pushViewController(controlller, animated: true)
            }
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK:底部按钮点击
    func bottomBtnClick(){
        
        let webView = ShanLinWebVCModules()
    
        webView.isHaveAlert = false
        webView.loadContent = self.model?.problemDesc

        self.navigationController?.pushViewController(webView, animated: true)
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
