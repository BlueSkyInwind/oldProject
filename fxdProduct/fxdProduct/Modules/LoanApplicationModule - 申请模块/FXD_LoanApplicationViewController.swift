//
//  FXD_LoanApplicationViewController.swift
//  fxdProduct
//
//  Created by admin on 2017/12/21.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class FXD_LoanApplicationViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView?
    var headerView:FXD_LoanApplicationHeaderView?
    var applicationCell:FXD_LoanApplicationCellTableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "申请确认"
        self.addBackItem()
        configureView()
    }

    func configureView()  {
        
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        headerView = FXD_LoanApplicationHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 420), amount: "3000")
        tableView?.tableHeaderView = headerView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isTranslucent = false

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
              return 4
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        applicationCell = tableView.dequeueReusableCell(withIdentifier:"FXD_LoanApplicationCellTableViewCell") as? FXD_LoanApplicationCellTableViewCell
        if applicationCell == nil {
            applicationCell = FXD_LoanApplicationCellTableViewCell.init(style: .default, reuseIdentifier: "FXD_LoanApplicationCellTableViewCell")
        }
        
        return applicationCell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
