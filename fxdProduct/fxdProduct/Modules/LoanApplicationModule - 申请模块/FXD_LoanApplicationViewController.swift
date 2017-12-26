//
//  FXD_LoanApplicationViewController.swift
//  fxdProduct
//
//  Created by admin on 2017/12/21.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

let Application_cell_height:CGFloat = 45
let Application_displayCell_height:CGFloat = 60

enum ApplicationChooseType {
    case Application_Amount
    case Application_Discount
    case Application_Period
    case Application_LoanFor
}


class FXD_LoanApplicationViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,ApplicationChoosePickViewDelegate {

    var tableView:UITableView?
    var headerView:FXD_displayAmountCommonHeaderView?
    var applicationCell:FXD_LoanApplicationCellTableViewCell?
    var displayCell:FXD_LoanApplicationDisplayTableViewCell?
    let titleArrs = ["选择额度（元）","临时提额劵","分期期数","借款用途"]
    var contentArrs:[String]?
    var periodArrs:[String]? = [""]
    var loanForArrs:[String]? =  [""]
    
    var applicationBtn:UIButton?
    var choosePV:FXD_ApplicationChoosePickerView?
    
    var chooseType:ApplicationChooseType?
    var productId:String?
    
    var applicaitonViewIM:ApplicaitonViewInfoModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "申请确认"
        self.addBackItem()
        chooseType = .Application_Amount
        contentArrs = ["2500","+200","12","得分解"]
        obtainApplicationInfo(EliteLoan) {[weak self] (isSuccess) in
            self?.configureView()
        }
    }

    func configureView()  {
        
        self.view.backgroundColor = LOAN_APPLICATION_COLOR
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        self.tableView?.backgroundColor = LOAN_APPLICATION_COLOR
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        if #available(iOS 11.0, *){
            tableView?.contentInsetAdjustmentBehavior = .never;
            tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }else if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = false;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        
        headerView = FXD_displayAmountCommonHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 205), amount: (applicaitonViewIM?.maxAmount == nil ? "": (applicaitonViewIM?.maxAmount)!))
        headerView?.titleLabel?.text = "申请确认"
        tableView?.tableHeaderView = headerView
        headerView?.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false

    }
    
    @objc func applicationBottonClick() {

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1  {
            if UI_IS_IPONE6P || UI_IS_IPHONEX{
                return Application_displayCell_height / 0.8
            }
            return Application_displayCell_height
        }
        if UI_IS_IPONE6P || UI_IS_IPHONEX{
            return Application_cell_height / 0.8
        }
        return Application_cell_height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var tableViewCell:UITableViewCell?
        if indexPath.section == 0 {
            applicationCell = tableView.dequeueReusableCell(withIdentifier:"FXD_LoanApplicationCellTableViewCell") as? FXD_LoanApplicationCellTableViewCell
            if applicationCell == nil {
                applicationCell = FXD_LoanApplicationCellTableViewCell.init(style: .default, reuseIdentifier: "FXD_LoanApplicationCellTableViewCell")
            }
            applicationCell?.titleLabel?.text = titleArrs[indexPath.row]
            applicationCell?.contentLabel?.text = contentArrs?[indexPath.row]
            tableViewCell = applicationCell
        }else if indexPath.section == 1{
            displayCell = tableView.dequeueReusableCell(withIdentifier:"FXD_LoanApplicationDisplayTableViewCell") as? FXD_LoanApplicationDisplayTableViewCell
            if displayCell == nil {
                displayCell = FXD_LoanApplicationDisplayTableViewCell.init(style: .default, reuseIdentifier: "FXD_LoanApplicationDisplayTableViewCell")
            }
            
            displayCell?.explainButtonClick = {
                FXD_AlertViewCust.sharedHHAlertView().showFXDAlertViewTitle("从何时开始算借款的第一天？", content: "答：借款到账后，次日为开始计费的借款第一天。\n例如：2018.1.1日借款到账；则，2018.1.2为借款第一天2018.1.3为第一期最后还款日；", attributeDic: nil, cancelTitle: nil, sureTitle: "我知道了") { (index) in
                }
            }
            
            displayCell?.amountLabel?.text = applicaitonViewIM?.actualAmount == nil ? "": (applicaitonViewIM?.actualAmount)!
            displayCell?.everyAmountLabel?.text = applicaitonViewIM?.repayAmount == nil ? "": (applicaitonViewIM?.repayAmount)!
            displayCell?.dateLabel?.text =  applicaitonViewIM?.period == nil ? "": (applicaitonViewIM?.period)!
            tableViewCell = displayCell
        }
        return tableViewCell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            chooseType = .Application_Amount
            addChoosePickerView(applicaitonViewIM?.amountList as! [String])
            break
        case 1:
            chooseType = .Application_Discount
            break
        case 2:
            chooseType = .Application_Period
            addChoosePickerView(periodArrs!)
            break
        case 3:
            chooseType = .Application_LoanFor
            addChoosePickerView(loanForArrs!)
            break
            
        default: break
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 10))
        headerView.backgroundColor = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 100
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 200))
            footerView.backgroundColor = LOAN_APPLICATION_COLOR
            applicationBtn = UIButton.init(type: UIButtonType.custom)
            applicationBtn?.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
            applicationBtn?.setTitle("确认申请", for: UIControlState.normal)
            applicationBtn?.addTarget(self, action: #selector(applicationBottonClick), for: UIControlEvents.touchUpInside)
            footerView.addSubview(applicationBtn!)
            applicationBtn?.snp.makeConstraints({ (make) in
                make.top.equalTo(footerView.snp.top).offset(40)
                make.left.equalTo(footerView.snp.left).offset(25)
                make.right.equalTo(footerView.snp.right).offset(-25)
            })
            return footerView
        }
        return nil
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addChoosePickerView(_ array:[String])  {
        if choosePV != nil {
            return
        }
        choosePV = FXD_ApplicationChoosePickerView.init(vc: self, dataArr:array)
        choosePV?.delegate = self
        choosePV?.show()
    }
    
    func chooseCancelBtn() {
        choosePV = nil
    }
    func chooseSureBtn(_ content: String,row:NSInteger) {
        
        switch chooseType {
        case .Application_Amount?:
            contentArrs?.replaceSubrange(Range.init(NSRange.init(location: 0, length: 1))!, with: [content])
            break
        case .Application_Period?:
            contentArrs?.replaceSubrange(Range.init(NSRange.init(location: 2, length: 1))!, with: [content])
            break
        case .Application_LoanFor?:
            contentArrs?.replaceSubrange(Range.init(NSRange.init(location: 3, length: 1))!, with: [content])
            break
        default: break
            
        }
        self.tableView?.reloadData()
        choosePV = nil
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
extension FXD_LoanApplicationViewController {
    
    func obtainApplicationInfo(_ productId:String ,_ success:@escaping ((_ isSuccess:Bool) -> Void))  {
        let applicationVM = ApplicationViewModel.init()
        applicationVM.setBlockWithReturn({ (result) in
            let baseResult = try! BaseResultModel.init(dictionary: result as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                let applicaitonViewInfoM = try! ApplicaitonViewInfoModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                self.applicaitonViewIM = applicaitonViewInfoM
                self.getPeriodArr(minStr: (self.applicaitonViewIM?.minPeriod)!, maxStr: (self.applicaitonViewIM?.maxPeriod)!)
                self.getLoanForArr()
                success(true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
                success(false)
            }
        }) {
            success(false)
        }
        applicationVM.obtainNewApplicationInfo(productId)
    }
    
    /// 周期数组
    func getPeriodArr(minStr:String , maxStr:String) {
        let min = Int(minStr)!
        let max = Int(maxStr)!
//        let dur = max - min
        for i  in min...max {
            periodArrs?.append(String.init(format: "%d", (min + 1)))
        }
    }
    
    func getLoanForArr() {
        for dic in (self.applicaitonViewIM?.loanFor)! {
            let loanFors = dic as! LoanMoneyFor
            loanForArrs?.append(loanFors.desc_)
        }
    }
    
        
}

