//
//  IntermediateViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/7.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
import MJRefresh

class IntermediateViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource,IntermediateCellDelegate{
    
    var tableView : UITableView?
   @objc var type : String = "1"
    private var countdownTimer: Timer?
    private var remainingSeconds: Int = 6
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "开户中"
        configureView()
    
        if type == "2" {
        
            addBackItem()
            tableView?.isScrollEnabled = false
            self.title = "开户失败"
            self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self as Any, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        }else{
            
            addBackItemRoot()
        }
        // Do any additional setup after loading the view.
    }
    
    @objc fileprivate func updateTime(){
        
        remainingSeconds -= 1
        if remainingSeconds == 0 {
            countdownTimer?.invalidate()
            countdownTimer = nil
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = LINE_COLOR
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        if #available(iOS 11.0, *){
            tableView?.contentInsetAdjustmentBehavior = .never;
            tableView?.contentInset = UIEdgeInsetsMake(CGFloat(obtainBarHeight_New(vc: self)), 0, 0, 0)
        }else if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = true;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        
        if type == "1" {
            //下拉刷新相关设置,使用闭包Block
            tableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
                
                self.headerRefresh()
                
            })
        }
    }
    
    //MARK: 刷新
    /// 下拉刷新
    @objc func headerRefresh(){
        
        let complianceMV = ComplianceViewModel()
        complianceMV.setBlockWithReturn({ [weak self] (returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
                let  dic = returnValue! as! NSDictionary
                let data = dic["data"] as! NSString
                self?.jumpController(userstatus:data as String)
                self?.tableView?.mj_header.endRefreshing()
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        complianceMV.hgQueryUserStatus()
        
    }

    func jumpController(userstatus : String){
        
        let tag = Int(userstatus)
        
        switch tag {
        case 1?:
            print("未开户")
        case 2?:
            self.tableView?.reloadData()
            print("开户中")
        case 3?: 
            self.navigationController?.popToRootViewController(animated: true)
            print("已开户")
        case 4?:
            print(":待激活")
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return _k_h
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:IntermediateCell! = tableView.dequeueReusableCell(withIdentifier:"CellId") as? IntermediateCell
        if cell == nil {
            cell = IntermediateCell.init(style: .default, reuseIdentifier: "CellId")
        }
        cell.delegate = self
        cell.selectionStyle = .none
        cell.type = type
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
    }
    
    func bottomBtnClick() {
        
        self.navigationController?.popToRootViewController(animated: true)
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
