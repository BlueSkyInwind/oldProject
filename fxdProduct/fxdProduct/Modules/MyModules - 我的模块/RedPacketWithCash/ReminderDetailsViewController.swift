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
        
        if #available(iOS 11.0, *){
            tableView?.contentInsetAdjustmentBehavior = .never;
            tableView?.contentInset = UIEdgeInsetsMake(CGFloat(obtainBarHeight_New(vc: self)), 0, 0, 0)
        }else if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = true;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        
    }
    
    
    func createNoneView(){
        
        noneView = NonePageView()
        noneView?.ReminderUI()
        noneView?.backgroundColor = LINE_COLOR
        noneView?.isHidden = true
        self.view.addSubview(noneView!)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        getWithdrawCashDetail()
    }
    
    func getWithdrawCashDetail(){
    
        let cashVM = CashViewModel()
        cashVM.setBlockWithReturn({[weak self] (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
                self?.model = try? WithdrawCashDetailModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                if self?.model?.withdrawCashDetailList.count  != 0{

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
        cashVM.withdrawCashDetailOperateType(FXD_Utility.shared().operateType, pageNum: "1", pageSize: "15")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if ((model?.withdrawCashDetailList.count) != nil) {
            
            return (model?.withdrawCashDetailList.count)! + 1
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

        let  detailModel = model?.withdrawCashDetailList[indexPath.row - 1] as? WithdrawCashDetailListModel
        
        cell.selectionStyle = .none
        
        cell.titleLabel?.text = detailModel?.detailName
        cell.timeLabel?.text = detailModel?.transDate
        cell.moneyLabel?.text = detailModel?.transAmount
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
