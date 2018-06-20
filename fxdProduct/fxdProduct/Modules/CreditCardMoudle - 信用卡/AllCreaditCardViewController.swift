//
//  AllCreaditCardViewController.swift
//  fxdProduct
//
//  Created by admin on 2018/6/20.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class AllCreaditCardViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var contentTableView:UITableView?
    var headerView:AllCardHeaderView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "全部信用卡";
        self.view.backgroundColor = UIColor.white
        self.addBackItem()
        configureView()
    }

    func configureView()  {
        
        contentTableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        contentTableView?.delegate = self;
        contentTableView?.dataSource = self;
        contentTableView?.separatorStyle = .none
        contentTableView?.backgroundColor = "f2f2f2".uiColor()
        self.view.addSubview(contentTableView!)
        contentTableView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view.snp.top).offset(55 + 64)
            make.left.right.bottom.equalTo(0)
        })
        contentTableView?.registerCell([CreaditCardTableViewCell.self],true)
        
        headerView = AllCardHeaderView.init(frame: CGRect.init(x: 0, y: 64, width: _k_w, height: 55), self.view)
        headerView?.dataArr = ["全部银行","全部银行","全部银行","全部银行","全部银行"]
        headerView?.addConditonView()
        self.view.addSubview(headerView!)
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = 95
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CreaditCardTableViewCell", for: indexPath) as! CreaditCardTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
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
