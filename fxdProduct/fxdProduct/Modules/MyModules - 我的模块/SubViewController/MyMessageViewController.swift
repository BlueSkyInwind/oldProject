//
//  MyMessageViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/14.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit
import MJRefresh

class MyMessageViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView : UITableView?
    var num : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的消息"
        addBackItemRoot()
        configureView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
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
       num = 15
        
        //下拉刷新相关设置,使用闭包Block
        tableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {

            self.headerRefresh()

        })


        //上拉加载相关设置,使用闭包Block
        tableView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {

            self.footerLoad()

        })
    }
    
    //MARK: 刷新
    /// 下拉刷新
    @objc func headerRefresh(){
        
        num = 15
        //重现加载表格数据
        self.tableView?.reloadData()
        //结束刷新
        self.tableView?.mj_header.endRefreshing()
    }
    
    /// 上拉加载
    @objc func footerLoad(){
        num = 30
       
        //重现加载表格数据
        self.tableView?.reloadData()
        //结束刷新
        self.tableView?.mj_footer.endRefreshing()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num!+1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 15
        }
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var messageCell:MessageCell! = tableView.dequeueReusableCell(withIdentifier:"MessageCell") as? MessageCell
        if messageCell == nil {
            messageCell = MessageCell.init(style: .default, reuseIdentifier: "MessageCell")
        }
        if indexPath.row == 0 {

            messageCell.cellType = MessageCellType(cellType: .Header)
            return messageCell
        }
        
        messageCell.cellType = MessageCellType(cellType: .Default)
        messageCell.selectionStyle = .none
        
        return messageCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webView = FXDWebViewController()
        webView.urlStr = _H5_url+_aboutus_url;
        self.navigationController?.pushViewController(webView, animated: true)
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
