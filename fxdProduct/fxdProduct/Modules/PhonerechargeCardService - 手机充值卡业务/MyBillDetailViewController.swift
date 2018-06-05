//
//  MyBillDetailViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class MyBillDetailViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView : UITableView?
    var dataArray : NSMutableArray?
    
    var moneyLabel : UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的账单"
        addBackItem()
        configureView()
//        headerView()
        dataArray = ["赊销金额","服务费","违约金","逾期罚息","使用券","使用账余额","支付方式"]
        // Do any additional setup after loading the view.
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
        
        let confirmBtn = UIButton.init(frame: CGRect(x:0,y:0,width:_k_w - 40,height:45))
        confirmBtn.setTitle("确认", for: .normal)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.setBackgroundImage(UIImage.init(named: "applayBtnImage"), for: .normal)
        confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        confirmBtn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        tableView?.tableFooterView = confirmBtn
    }
    
    fileprivate func headerView(){
        
        let headerView = UIView.init(frame: CGRect(x:0,y:0,width:_k_w,height:117))
        headerView.backgroundColor = LINE_COLOR
        tableView?.tableHeaderView = headerView
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage.init(named: "bill_header_icon")
        headerView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.top).offset(12)
            make.left.equalTo(headerView.snp.left).offset(0)
            make.right.equalTo(headerView.snp.right).offset(0)
            make.bottom.equalTo(headerView.snp.bottom).offset(0)
        }
        
        let headerTitle = UILabel()
        headerTitle.text = "还款金额"
        headerTitle.textColor = TITLE_COLOR
        headerTitle.font = UIFont.systemFont(ofSize: 15)
        headerView.addSubview(headerTitle)
        headerTitle.snp.makeConstraints { (make) in
            make.top.equalTo(bgImageView.snp.top).offset(20)
            make.centerX.equalTo(bgImageView.snp.centerX)
        }
        
        moneyLabel = UILabel()
        moneyLabel?.textColor = UI_MAIN_COLOR
        moneyLabel?.font = UIFont.systemFont(ofSize: 30)
        headerView.addSubview(moneyLabel!)
        moneyLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(headerTitle.snp.bottom).offset(20)
            make.centerX.equalTo(headerView.snp.centerX)
        })
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (dataArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:MyBillCell! = tableView.dequeueReusableCell(withIdentifier:"MyBillCell") as? MyBillCell
        if cell == nil {
            cell = MyBillCell.init(style: .default, reuseIdentifier: "MyBillCell")
        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        cell.isSelected = false
        cell.leftLabel?.text = (dataArray?[indexPath.row] as! String)
        cell.rightLabel?.text = "2018.03.23 15:32:23"
        
        cell.arrowImage?.isHidden = true
        if indexPath.row == 4 || indexPath.row == 6 {
            cell.arrowImage?.isHidden = false
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    @objc fileprivate func confirmBtnClick(){
        
        let controller = RepaymentResultViewController()
        controller.state = .intermediate
//        controller.titleStr = "还款确认中"
//        controller.tipStr = "还款结果确认中"
//        controller.imageStr = "fail"
        self.navigationController?.pushViewController(controller, animated: true)
        
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
