//
//  ReminderDetailsViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/20.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit
import MJRefresh

class ReminderDetailsViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView : UITableView?
    var noneView : NonePageView?
    var pageNum : Int?
    var redPacketMapModel : RedPacketMapModel?
    var withdrawCashDetailListModel : WithdrawCashDetailListModel?
    var model : WithdrawCashDetailModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "收提明细"
        addBackItem()
        configureView()
        
        createNoneView()
    }
    
    //MARK:设置tableview
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
        
//        //下拉刷新相关设置,使用闭包Block
//        tableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
//
//            self.headerRefresh()
//
//        })
//
//
//        //上拉加载相关设置,使用闭包Block
//        tableView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
//
//            self.footerLoad()
//
//        })
        
    }
    
    //MARK: 刷新
    /// 下拉刷新
//    @objc func headerRefresh(){
//
//        pageNum = 1
//        //重现加载表格数据
//        getWithdrawCashDetail()
////        self.tableView?.reloadData()
//        //结束刷新
////        self.tableView?.mj_header.endRefreshing()
//    }
//
//    /// 上拉加载
//    @objc func footerLoad(){
//        pageNum = pageNum! + 1
//        //重现加载表格数据
//        getWithdrawCashDetail()
////        self.tableView?.reloadData()
//        //结束刷新
////        self.tableView?.mj_footer.endRefreshing()
//
//    }
    func createNoneView(){
        
        noneView = NonePageView()
        noneView?.backgroundColor = LINE_COLOR
        self.view.addSubview(noneView!)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        pageNum = 1
        getWithdrawCashDetail()
    }
    
    func getWithdrawCashDetail(){
        
        let pageStr : String = String.init(format: "%d", pageNum!)
        let cashVM = CashViewModel()
        cashVM.setBlockWithReturn({[weak self] (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
                self?.model = try? WithdrawCashDetailModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                if self?.model?.redPacketMap.count != 0 || self?.model?.withdrawCashDetailList.count  != 0{
                    
//                    self?.redPacketMapModel = withdrawCashDetailModel?.redPacketMap
//                    self?.withdrawCashDetailListModel = withdrawCashDetailModel?.withdrawCashDetailList
                    self?.noneView?.isHidden = true
         
                    self?.tableView?.isHidden = false
                    self?.tableView?.reloadData()
                    
                }else{
                    
                    self?.tableView?.isHidden = true
                    self?.noneView?.isHidden = false
                }
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        cashVM.withdrawCashDetailOperateType(FXD_Utility.shared().operateType, pageNum: pageStr, pageSize: "15")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ((model?.redPacketMap.count) != nil || ((model?.withdrawCashDetailList.count) != nil)) {
            return (model?.redPacketMap.count)! + (model?.withdrawCashDetailList.count)! + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 15
        }
        if UI_IS_IPONE6P {
            return 80
        }
        return 68
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:ReminderDetailsCell! = tableView.dequeueReusableCell(withIdentifier:"ReminderDetailsCell") as? ReminderDetailsCell
        if cell == nil {
            cell = ReminderDetailsCell.init(style: .default, reuseIdentifier: "ReminderDetailsCell")
        }
        
        var messageCell:MessageCell! = tableView.dequeueReusableCell(withIdentifier:"MessageCell") as? MessageCell
        if messageCell == nil {
            messageCell = MessageCell.init(style: .default, reuseIdentifier: "MessageCell")
        }
        if indexPath.row == 0 {
            
            messageCell.cellType = MessageCellType(cellType: .Header)
            return messageCell
        }

        let  detailModel = model?.redPacketMap[indexPath.row - 1] as? RedPacketMapModel
        
        cell.selectionStyle = .none
        cell.titleLabel?.text = detailModel?.redpacket_name_
        cell.timeLabel?.text = detailModel?.get_date_
        cell.moneyLabel?.text = detailModel?.total_amount_
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
