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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    func noneViewUI(){
    
        noneView = PhonerechargeCardNoneView.init(frame: CGRect(x:0,y:64,width:_k_w,height:_k_h - 64))
        noneView?.noneDesc?.text = "账单都被消灭啦"
        noneView?.noneImageView?.image = UIImage.init(named: "bill_none_icon")
        noneView?.isHidden = true
        self.view.addSubview(noneView!)
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
            tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
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
                
                if self?.repayModel?.debtRepayTotal == nil{
                    self?.noneView?.isHidden = false
                    self?.noneView?.noneDesc?.text = "账单都被消灭啦"
                    self?.tableView?.isHidden = true
                    
                }else{
                    
                    self?.orderModel = self?.repayModel?.order
                    self?.tableView?.reloadData()
                }
//                if self?.repayModel == nil || self?.orderModel == nil{
//
//                    self?.noneView?.isHidden = false
//                    self?.noneView?.noneDesc?.text = "账单都被消灭啦"
//                    self?.tableView?.isHidden = true
//                }else{
//                    self?.orderModel = self?.repayModel?.order
//                    self?.tableView?.reloadData()
//                }
            }else{
                self?.noneView?.isHidden = false
                self?.noneView?.noneDesc?.text = baseResult.friendErrMsg
                self?.tableView?.isHidden = true
//                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        viewModel.fatchQueryWeekShouldAlsoAmount(nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if repayModel == nil {
            return 0
        }
        if orderModel == nil{
            return 1
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
            contentLabel.textColor = Bill_COLOR
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
        //
        if section == 0 && repayModel?.isPending == "1"{
            let bgImageView = UIImageView()
            bgImageView.image = UIImage.init(named: "bill_tip_bg_icon")
            view.addSubview(bgImageView)
            bgImageView.snp.makeConstraints { (make) in
                make.left.equalTo(view.snp.left).offset(0)
                make.right.equalTo(view.snp.right).offset(0)
                make.top.equalTo(view.snp.top).offset(0)
                make.bottom.equalTo(view.snp.bottom).offset(0)
            }
            
            let contentView = UIView()
            contentView.backgroundColor = UIColor.clear
            bgImageView.addSubview(contentView)
            contentView.snp.makeConstraints { (make) in
                make.top.equalTo(bgImageView.snp.top).offset(0)
                make.bottom.equalTo(bgImageView.snp.bottom).offset(0)
                make.width.equalTo(120)
                make.centerX.equalTo(bgImageView.snp.centerX)
            }
            
            let leftImageView = UIImageView()
            leftImageView.image = UIImage.init(named: "bill_repay_icon")
            contentView.addSubview(leftImageView)
            leftImageView.snp.makeConstraints { (make) in
                make.left.equalTo(contentView.snp.left).offset(5)
                make.centerY.equalTo(contentView.snp.centerY)
            }
            
            let titleLabel = UILabel()
            titleLabel.text = "还款结果确认中"
            titleLabel.font = UIFont.systemFont(ofSize: 12)
            titleLabel.textColor = QUTOA_COLOR
            contentView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.right.equalTo(contentView.snp.right).offset(-5)
                make.centerY.equalTo(contentView.snp.centerY)
            }
        }
        return view
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 {
            
            return 40
        }
        
        if section == 0 && repayModel?.isPending == "1" {
            return 30
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
            cell.overdueView?.isHidden = true
            
            cell.moneyLabel?.text = "¥" + (repayModel?.debtRepayTotal)!
            cell.dateLabel?.text = "最后还款日:" + (repayModel?.dueDate)!
            
            if Int((repayModel?.maxOverdueDays)!)! > 0{
                
                cell.overdueView?.isHidden = false
                cell.overdueDateLabel?.text = repayModel?.dueDateTip
            }
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
        cell.moneyLabel?.text = "¥" + (orderModel?.order_price)!
        cell.quantityLabel?.text = "¥" + (orderModel?.phone_card_price)! + "x" + (orderModel?.phone_card_count)!
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            let controller = OrderConfirmDetailViewController()
            controller.orderNo = orderModel?.order_no
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footView = UIView()
        footView.backgroundColor = UIColor.clear
        
        let repayBtn = UIButton.init(type: .custom)
        repayBtn.setTitle("还款", for: .normal)
        repayBtn.setTitleColor(UIColor.white, for: .normal)
        repayBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        repayBtn.setBackgroundImage(UIImage.init(named: "btn_seleted_icon"), for: .normal)
        repayBtn.addTarget(self, action: #selector(repayBtnClic), for: .touchUpInside)
        footView.addSubview(repayBtn)
        repayBtn.snp.makeConstraints { (make) in
            make.top.equalTo(footView.snp.top).offset(100)
            make.width.equalTo(240)
            make.centerX.equalTo(footView.snp.centerX)
            make.height.equalTo(40)
        }
        return footView
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if repayModel?.isPending == "1" {
            return 0
        }
        if repayModel?.debtRepayTotal != nil && orderModel == nil {
            return 150
        }
        if section == 1 && repayModel?.isPending != "1"{
            return 150
        }
        
        return 0
    }
    
    @objc func repayBtnClic(){
        
        if repayModel?.order != nil {
            let controller = MyBillDetailViewController()
            let model = repayModel?.situations_[0] as! Situations
            
            controller.staging_id_ = model.staging_id_
            controller.applicationId = orderModel?.order_no
            self.navigationController?.pushViewController(controller, animated: true)
        }else{
            
            let controller = LoanPeriodListVCModule()
            controller.applicationId = FXD_Utility.shared().userInfo.applicationId
            self.navigationController?.pushViewController(controller, animated: true)
            
        }

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
