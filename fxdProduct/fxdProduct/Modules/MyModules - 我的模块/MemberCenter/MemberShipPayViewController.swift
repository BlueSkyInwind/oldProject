//
//  MemberShipPayViewController.swift
//  fxdProduct
//
//  Created by admin on 2018/4/9.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class MemberShipPayViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView?
    var titleHeaderView:FXD_displayAmountCommonHeaderView?
    var titleArr:[String] = ["应付金额","使用券","使用账户余额","支付方式"]
    var  bottomButton:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureView()
    }

    @objc func bottomButtonClick()  {

        
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
        if indexPath.row == 3 || indexPath.row == 1 {
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
        let footerView = self.addFooterView()
        return footerView
    }
    
    func addFooterView() -> UIView {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 150))
        footerView.backgroundColor = LOAN_APPLICATION_COLOR
        bottomButton = UIButton.init(type: UIButtonType.custom)
        bottomButton?.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
        bottomButton?.setTitle("确认", for: UIControlState.normal)
        bottomButton?.addTarget(self, action: #selector(bottomButtonClick), for: .touchUpInside)
        footerView.addSubview(bottomButton!)
        bottomButton?.snp.makeConstraints({ (make) in
            make.top.equalTo(footerView.snp.top).offset(154)
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



extension MemberShipPayViewController {
    
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
        titleHeaderView?.titleLabel?.text = "支付详情"
        titleHeaderView?.hintWordBackImage?.isHidden = true
        titleHeaderView?.goBackBtn?.isHidden = false
        titleHeaderView?.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
        self.tableView?.tableHeaderView = titleHeaderView
    }
    
}

extension MemberShipPayViewController {


    
    
}
