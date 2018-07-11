//
//  MyOrdersViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class MyOrdersViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView : UITableView?
    var dataArray : NSMutableArray?
    var noneView : PhonerechargeCardNoneView?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的订单"
        addBackItem()
        dataArray = NSMutableArray.init(capacity: 100)
        configureView()
        getData()
        noneViewUI()

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
            tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }else if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = true;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
    }

    func noneViewUI(){
        
        noneView = PhonerechargeCardNoneView.init(frame: CGRect(x:0,y:64,width:_k_w,height:_k_h - 64))
        noneView?.noneDesc?.text = "亲, 您暂时还没有订单"
        noneView?.noneImageView?.image = UIImage.init(named: "order_none_icon")
        noneView?.isHidden = true
        self.view.addSubview(noneView!)
    }
    
    func getData(){
        
        tableView?.isHidden = true
        let viewModel = PhonerechargeCardServiceViewModel()
        viewModel.setBlockWithReturn({[weak self] (returnValue) in
            
            let baseResult = returnValue as! BaseResultModel
            
            if baseResult.errCode == "0"{
                
                self?.removeFailView()
                let dataArr = baseResult.data as! NSArray
                if dataArr.count == 0{
                    
                    self?.noneView?.isHidden = false
                    
                }else{
                    self?.tableView?.isHidden = false
//                    self?.configureView()
                    self?.noneView?.isHidden = true
                    self?.tableView?.isHidden = false
                    self?.dataArray?.removeAllObjects()
                    for dic in dataArr{
                        
                        let model = try! PhoneOrderListModel.init(dictionary: dic as! [AnyHashable : Any])
                        self?.dataArray?.add(model)
                    }
                    self?.tableView?.reloadData()
                }
            }else{
                
                self?.noneView?.isHidden = true
                self?.setFailView()
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
            
        }) {
            
            self.noneView?.isHidden = true
            self.setFailView()
        }
        viewModel.obtainOrderContractStagingSelectOrdersByUserId()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (dataArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = LINE_COLOR
        let contentLabel = UILabel()
        contentLabel.textColor = RedPacketBottomBtn_COLOR
        contentLabel.font = UIFont.systemFont(ofSize: 11)
        contentLabel.text = "共" + String((dataArray?.count)!) + "笔"
        headerView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerView.snp.left).offset(22)
            make.centerY.equalTo(headerView.snp.centerY)
        }
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 31
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 82
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:MyOrdersCell! = tableView.dequeueReusableCell(withIdentifier:"MyOrdersCell") as? MyOrdersCell
        if cell == nil {
            cell = MyOrdersCell.init(style: .default, reuseIdentifier: "MyOrdersCell")
        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.isSelected = false
        let model = dataArray![indexPath.row] as! PhoneOrderListModel
        
        cell.titleLabel?.text = model.phone_card_name
        cell.timeLabel?.text = model.payment_date
        cell.moneyLabel?.text = "¥" + model.order_price
        cell.quantityLabel?.text = "¥" + model.phone_card_price + "x" + model.phone_card_count
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = dataArray![indexPath.row] as! PhoneOrderListModel
        let controller = OrderConfirmDetailViewController()
        controller.orderNo = model.order_no
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
