//
//  MembershipFeeRechargedViewController.swift
//  fxdProduct
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class MembershipFeeRechargedViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var titleHeaderView:FXD_displayAmountCommonHeaderView?
    var tableView:UITableView?
    var isAgreement:Bool?
    let titleArr:[String] = ["支付金额","使用账户余额","银行卡"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addBackItem()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UI_IS_IPONE6P || UI_IS_IPHONEX{
            return 45 / 0.8
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MembershipRechargeTableViewCell", for: indexPath) as! MembershipRechargeTableViewCell
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "MembershipRechargeTableViewCell") as! MembershipRechargeTableViewCell
        }
        cell.titleLabel.text = titleArr[indexPath.row]
        if indexPath.row == 2 {
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = self.addfooterView()
        return footerView
    }
    
    func addfooterView() -> UIView {
        let footerView = addFooterView()
        return footerView
    }
    
    func addFooterView() -> UIView {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 150))
        footerView.backgroundColor = LOAN_APPLICATION_COLOR
        let agreementView = MembershipAgreementView.init(CGRect.zero, protocolNameArr: ["《会员协议》"])
        agreementView.isAgreementClick = {[weak self] (isClick) in
            self?.isAgreement = isClick
        }
        agreementView.agreementClick = {
            
        }
        footerView.addSubview(agreementView)
        agreementView.snp.makeConstraints { (make) in
            make.top.equalTo(footerView.snp.top).offset(13)
            make.left.right.equalTo(footerView)
            make.height.equalTo(20)
        }

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

extension MembershipFeeRechargedViewController{
    
    func configureView()  {
        
        self.view.backgroundColor = LOAN_APPLICATION_COLOR
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        self.tableView?.backgroundColor = LOAN_APPLICATION_COLOR
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.isScrollEnabled = false
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        tableView?.register(UINib.init(nibName: "MembershipRechargeTableViewCell", bundle: nil), forCellReuseIdentifier: "MembershipRechargeTableViewCell")
        
        if #available(iOS 11.0, *){
            tableView?.contentInsetAdjustmentBehavior = .never;
            tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }else if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = false;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        
        var heaerViewHeight = 205
        if UI_IS_IPONE6P || UI_IS_IPHONEX{
            heaerViewHeight = 256
        }
        titleHeaderView = FXD_displayAmountCommonHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: Int(_k_w), height: heaerViewHeight), amount: "3000", amountTitle: "实付金额(元)")
        titleHeaderView?.titleLabel?.text = "会员费充值"
        titleHeaderView?.hintWordLabel?.text = "温馨提示：确保银行卡余额充足"
        titleHeaderView?.goBackBtn?.isHidden = false
        titleHeaderView?.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
        self.tableView?.tableHeaderView = titleHeaderView
    }
    
}
