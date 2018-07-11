//
//  WithdrawDetailsViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class WithdrawDetailsViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView : UITableView?
    var leftTitleArray : NSArray?
    var rightTitleArray : NSArray?
    var withdrawCashModel : WithdrawCashModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = "提现详情"
        leftTitleArray = ["提现金额","银行卡","预计到账时间"]
        addBackItem()
        configureView()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:设置tableview
    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = LINE_COLOR
        tableView?.isScrollEnabled = false
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
        
        let headerView = WithdrawHeaderView()
        tableView?.tableHeaderView = headerView
        
        let withdrawBtn = UIButton()
        withdrawBtn.setTitle("完成", for: .normal)
        withdrawBtn.setTitleColor(UIColor.white, for: .normal)
        withdrawBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        withdrawBtn.setBackgroundImage(UIImage(named:"btn_seleted_icon"), for: .normal)
        withdrawBtn.addTarget(self, action: #selector(withdrawBtnClick), for: .touchUpInside)
        self.view.addSubview(withdrawBtn)
        withdrawBtn.snp.makeConstraints { (make) in
//            make.left.equalTo(self.view).offset(18)
//            make.right.equalTo(self.view).offset(-18)
            make.top.equalTo(self.view).offset(520)
            make.height.equalTo(40)
            make.width.equalTo(240)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        if UI_IS_IPONE5 {
            withdrawBtn.snp.updateConstraints({ (make) in
                make.top.equalTo(self.view).offset(480)
            })
        }
        if UI_IS_IPONE6P {
            withdrawBtn.snp.updateConstraints({ (make) in
                make.top.equalTo(self.view).offset(570)
            })
        }
    }

    override func popBack(){
        
        PopFirstController()
    }
    
    //MARK:点击完成按钮
    @objc func withdrawBtnClick(){
        
        PopFirstController()
    }
    
    //MRAK:返回上一级
    func PopFirstController()  {
        for  vc in self.rt_navigationController.rt_viewControllers {
            if vc.isKind(of: CashRedEnvelopeViewController.self) {
                self.navigationController?.popToViewController(vc, animated: true)
                return
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (leftTitleArray?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if UI_IS_IPONE6P {
            return 80
        }
        return 68
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:CurrentInformationCell! = tableView.dequeueReusableCell(withIdentifier:"CellId") as? CurrentInformationCell
        if cell == nil {
            cell = CurrentInformationCell.init(style: .default, reuseIdentifier: "CellId")
        }
        cell.selectionStyle = .none
        cell.cellType = CurrentInfoCellType(cellType: .Default)
        cell.leftLabel?.text = leftTitleArray?[indexPath.row] as? String
        cell.rightLabel?.textColor = UI_MAIN_COLOR
        if indexPath.row == 0 {
            cell.rightLabel?.text = "¥" + (self.withdrawCashModel?.amount)!
            let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(cell.rightLabel?.text)!)
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(1,attrstr.length-1))
            attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.yx_systemFont(ofSize: 35) ?? 35, range: NSMakeRange(1,attrstr.length-1))
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: RedPacketMoney_COLOR, range: NSMakeRange(0,1))
            attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.yx_systemFont(ofSize: 25) ?? 25, range: NSMakeRange(0,1))
            cell.rightLabel?.attributedText = attrstr
        }
        if indexPath.row == 1 {
            cell.rightLabel?.text = self.withdrawCashModel?.bankCode
        }
        if indexPath.row == 2 {
            cell.rightLabel?.text = self.withdrawCashModel?.arriveDate
        }
        return cell
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
