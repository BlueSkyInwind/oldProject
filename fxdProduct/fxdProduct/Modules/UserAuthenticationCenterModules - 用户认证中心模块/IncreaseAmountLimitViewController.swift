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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
