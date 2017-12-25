//
//  FXD_ToWithdrawFundsViewController.swift
//  fxdProduct
//
//  Created by admin on 2017/12/25.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class FXD_ToWithdrawFundsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var headerView:FXD_displayAmountCommonHeaderView?
    var tableView:UITableView?
    var applyForBtn:UIButton?
    var isBankCard:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    func configureView()  {
        
        self.view.backgroundColor = LOAN_APPLICATION_COLOR
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        self.tableView?.backgroundColor = LOAN_APPLICATION_COLOR
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        if #available(iOS 11.0, *){
            tableView?.contentInsetAdjustmentBehavior = .never;
            tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }else if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = false;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        
        headerView = FXD_displayAmountCommonHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 205), amount: "3000")
        headerView?.titleLabel?.text = "待提款"
        tableView?.tableHeaderView = headerView
        headerView?.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func applyForBottonClick(){
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UI_IS_IPONE6P || UI_IS_IPHONEX{
            return 45 / 0.8
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighRankingAuthTableViewCell", for: indexPath) as! HighRankingAuthTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle  = .none
        cell.titleLabel.text = "信用卡认证";
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            MXVerifyManager.shareInstance.creditCard()
            break
        case 1:
            MXVerifyManager.shareInstance.socialSecurity()
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 42))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 150))
        footerView.backgroundColor = LOAN_APPLICATION_COLOR
        applyForBtn = UIButton.init(type: UIButtonType.custom)
        applyForBtn?.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
        applyForBtn?.setTitle("确认申请", for: UIControlState.normal)
        applyForBtn?.addTarget(self, action: #selector(applyForBottonClick), for: UIControlEvents.touchUpInside)
        footerView.addSubview(applyForBtn!)
        applyForBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo(footerView.snp.top).offset(40)
            make.left.equalTo(footerView.snp.left).offset(25)
            make.right.equalTo(footerView.snp.right).offset(-25)
        })
        return footerView
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

extension FXD_ToWithdrawFundsViewController {
    
    /// 获取发薪贷银行卡信息
    func fatchCardInfo()  {
        let bankInfoVM = BankInfoViewModel.init()
        bankInfoVM.setBlockWithReturn({[weak self] (resultObject) in
            let baseResult = try! BaseResultModel.init(dictionary: resultObject as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                let cardArr = baseResult.data as! NSArray
                if cardArr.count <= 0{
                    self?.isBankCard = false
                    return
                }
//                for  dic in cardArr{
//                    let cardInfo = try! CardInfo.init(dictionary: dic as! [AnyHashable : Any])
//                    if cardInfo.cardType == "2" {
//
//                    }
//                }
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
        }
        bankInfoVM.obtainUserBankCardList()
    }
}


