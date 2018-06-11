//
//  MyBillViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class MyBillViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView : UITableView?
    var repayModel : RepayListInfo?
    var noneView : PhonerechargeCardNoneView?
    var orderModel : OrderModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "我的账单"
        addBackItem()
        configureView()
        
        getData()
        noneViewUI()
    }

    func noneViewUI(){
    
        noneView = PhonerechargeCardNoneView.init(frame: CGRect(x:0,y:64,width:_k_w,height:_k_h - 64))
        noneView?.noneDesc?.text = "账单都被消灭了"
        noneView?.isHidden = true
        self.view.addSubview(noneView!)
    }
    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = UIColor.clear
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
    }
    
    func getData(){
        
        let viewModel = RepayMentViewModel()
        viewModel.setBlockWithReturn({[weak self] (returnValue) in
            
            let baseResult = returnValue as! BaseResultModel
            
            if baseResult.errCode == "0"{
                
                self?.noneView?.isHidden = true
                self?.tableView?.isHidden = false
                self?.repayModel = try! RepayListInfo.init(dictionary: baseResult.data as! [AnyHashable : Any])
                
                self?.orderModel = self?.repayModel?.order
                
                self?.tableView?.reloadData()
                
            }else{
                
                self?.noneView?.isHidden = false
                self?.tableView?.isHidden = true
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
            
        }) {
            
        }
        viewModel.fatchQueryWeekShouldAlsoAmount(nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if repayModel == nil {
            return 0
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            
            let headerView = UIView()
            headerView.backgroundColor = LINE_COLOR
            let contentLabel = UILabel()
            contentLabel.textColor = TITLE_COLOR
            contentLabel.font = UIFont.systemFont(ofSize: 14)
            contentLabel.text = "关联订单"
            headerView.addSubview(contentLabel)
            contentLabel.snp.makeConstraints { (make) in
                make.left.equalTo(headerView.snp.left).offset(22)
                make.centerY.equalTo(headerView.snp.centerY)
            }
            
            return headerView
        }
        
        let view = UIView()
        view.backgroundColor = LINE_COLOR
        return view
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 {
            
            return 33
        }
        return 12
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 155
        }
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            var cell:MyBillAmountCell! = tableView.dequeueReusableCell(withIdentifier:"MyBillAmountCell") as? MyBillAmountCell
            if cell == nil {
                cell = MyBillAmountCell.init(style: .default, reuseIdentifier: "MyBillAmountCell")
            }
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.white
            cell.isSelected = false
            cell.overdueView?.isHidden = false
            cell.overdueDateLabel?.text = "已逾期3天"
            cell.moneyLabel?.text = "¥" + (repayModel?.debtRepayTotal)!
            cell.dateLabel?.text = "最后还款日:" + (repayModel?.dueDate)!
            return cell!
        }
        
        var cell:MyOrdersCell! = tableView.dequeueReusableCell(withIdentifier:"MyOrdersCell") as? MyOrdersCell
        if cell == nil {
            cell = MyOrdersCell.init(style: .default, reuseIdentifier: "MyOrdersCell")
        }
        cell.selectionStyle = .none
        cell.isSelected = false
        cell.backgroundColor = UIColor.clear
        
        cell.titleLabel?.text = orderModel?.phone_card_name
        cell.timeLabel?.text = orderModel?.payment_date
        cell.moneyLabel?.text = orderModel?.order_price
        cell.quantityLabel?.text = (orderModel?.phone_card_price)! + "*" + (orderModel?.phone_card_count)!
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footView = UIView()
        footView.backgroundColor = UIColor.clear
        
        let repayBtn = UIButton()
        repayBtn.setTitle("还款", for: .normal)
        repayBtn.setTitleColor(UIColor.white, for: .normal)
        repayBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        repayBtn.setBackgroundImage(UIImage.init(named: "applayBtnImage"), for: .normal)
        repayBtn.addTarget(self, action: #selector(repayBtnClic), for: .touchUpInside)
        footView.addSubview(repayBtn)
        repayBtn.snp.makeConstraints { (make) in
            make.top.equalTo(footView.snp.top).offset(100)
            make.left.equalTo(footView.snp.left).offset(20)
            make.right.equalTo(footView.snp.right).offset(-20)
            make.height.equalTo(45)
        }
        return footView
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 1 {
            return 150
        }
        
        return 0
    }
    
    @objc func repayBtnClic(){
        
        let controller = MyBillDetailViewController()
        let model = repayModel?.situations_[0] as! Situations
        controller.staging_id_ = model.staging_id_
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
