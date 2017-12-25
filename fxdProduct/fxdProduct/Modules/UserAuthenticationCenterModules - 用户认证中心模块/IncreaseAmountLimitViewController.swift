//
//  IncreaseAmountLimitViewController.swift
//  fxdProduct
//
//  Created by admin on 2017/12/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class IncreaseAmountLimitViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView?
    var headerView:FXD_displayAmountCommonHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
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
        
        tableView?.register(UINib.init(nibName: "DataDisplayCell", bundle: nil), forCellReuseIdentifier: "DataDisplayCell")
        
        if #available(iOS 11.0, *){
            tableView?.contentInsetAdjustmentBehavior = .never;
            tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }else if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = false;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        
        headerView = FXD_displayAmountCommonHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 205), amount: "3000")
        headerView?.titleLabel?.text = "提额"
        headerView?.hintWordLabel?.text = IncreaseAmountLimitMarkeords
        headerView?.goBackBtn?.isHidden = true
        tableView?.tableHeaderView = headerView
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataDisplayCell", for: indexPath) as! DataDisplayCell
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle  = .none
        cell.statusLabel.text = "未完成"
        cell.statusLabel.textColor = UIColor.init(red: 159/255.0, green: 160/255.0, blue: 162/255.0, alpha: 1)
        switch indexPath.row {
        case 0:
            cell.titleLable.text = "信用卡认证";
            break
        case 1:
            cell.titleLable.text = "社保认证";
            break
        default:
            break
        }
        return cell
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
