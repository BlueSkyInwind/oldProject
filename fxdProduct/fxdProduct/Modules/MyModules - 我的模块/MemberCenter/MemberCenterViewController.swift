//
//  MemberCenterViewController.swift
//  fxdProduct
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc enum UserMemberCenterStatus:Int {
    case notMeasure          //未测评
    case measuring            //测评中
    case measureNotPass    // 测评未通过
    case recharge            //充值
    case recharging           //充值中
    case refund                // 退款
    case refunding            //退款中
    case rechargeAndRefund     //退款加充值
    case noStatus     //无状态
}

class MemberCenterViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var titleHeaderView:FXD_displayAmountCommonHeaderView?
    var tableView:UITableView?
    var statusButton:UIButton?
    var memberStatus:UserMemberCenterStatus?
    var footViewHeight:Int?
    var memberShipInfoModel:MemberShipInfoModel?
    var centerHeaderView:MemberCenterHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "会员中心"
        addBackItem()
        self.view.backgroundColor = UIColor.white
        memberStatus = .notMeasure
        obtainMemberShipInfo { [weak self] (isSuccess) in
            if isSuccess{
                self?.navigationController?.isNavigationBarHidden = true
                self?.configureView()
                self?.UserMemberInStatus()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func statusButtonClick()  {
        switch memberStatus {
        case .notMeasure?:
            
            break;
        case .measureNotPass?:
            
            break;
        case .recharge?:
            let membershipFeeRechargedVC = MembershipFeeRechargedViewController.init()
            self.navigationController?.pushViewController(membershipFeeRechargedVC, animated: true)
            break;
        case .refund?:
            let memberShipPayViewController = MemberCenterViewController.init()
            self.navigationController?.pushViewController(memberShipPayViewController, animated: true)
            break;
        default: break
        }
    }
    
    @objc func rechargeButtonClick()  {
        let membershipFeeRechargedVC = MembershipFeeRechargedViewController.init()
        self.navigationController?.pushViewController(membershipFeeRechargedVC, animated: true)
    }
    
    @objc func refundButtonClick()  {
        let memberShipPayViewController = MemberCenterViewController.init()
        self.navigationController?.pushViewController(memberShipPayViewController, animated: true)
    }
    
    func UserMemberInStatus()  {
        footViewHeight = 150
        self.titleHeaderView?.amountStr = (memberShipInfoModel?.availableCredit)!
        self.centerHeaderView?.payAmountLabel.text = "\((memberShipInfoModel?.requestAmount)!)元"
        self.centerHeaderView?.payBackAmountLabel.text = "\((memberShipInfoModel?.chargeAmount)!)元"
        self.centerHeaderView?.returnAmountLabel.text = "\((memberShipInfoModel?.refundAmount)!)元"
        self.centerHeaderView?.settleAmountLabel.text = "\((memberShipInfoModel?.settleCount)!)次"
        tableView?.reloadData()
        switch memberStatus {
        case .notMeasure?:
            setStatusButtonType("前往测评", imageName: "applicationBtn_Image", enable: true)
            break;
        case .measuring?:
            setStatusButtonType("测评中...", imageName: "applicationBtn_unselect_Image", enable: false)
            break;
        case .measureNotPass?:
            setStatusButtonType("测评不通过", imageName: "applicationBtn_unselect_Image", enable: false)
            break;
        case .recharge?:
            setStatusButtonType("充值", imageName: "applicationBtn_Image", enable: true)
            break;
        case .recharging?:
            setStatusButtonType("充值中...", imageName: "applicationBtn_unselect_Image", enable: true)
            break;
        case .refund?:
            setStatusButtonType("退款", imageName: "applicationBtn_Image", enable: true)
            break;
        case .refunding?:
            setStatusButtonType("退款中...", imageName: "applicationBtn_unselect_Image", enable: true)
            break;
        case .rechargeAndRefund?:
            tableView?.reloadData()
            break;
        case .noStatus?:
            footViewHeight = 0;
            tableView?.reloadData()
            break;
        default: break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UI_IS_IPONE6P || UI_IS_IPHONEX{
            return 45 / 0.8
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "identtifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        cell?.accessoryType = .disclosureIndicator
        cell?.selectionStyle  = .none
        cell?.textLabel?.text = "《会员协议》"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 24))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = self.addfooterView()
        return footerView
    }
    
    func addfooterView() -> UIView {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 150))
        footerView.backgroundColor = LOAN_APPLICATION_COLOR
        
        if memberStatus == .rechargeAndRefund {
            
            let rechargeButton = UIButton.init(type: UIButtonType.custom)
            rechargeButton.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
            rechargeButton.setTitle("充值", for: UIControlState.normal)
            rechargeButton.addTarget(self, action: #selector(rechargeButtonClick), for: .touchUpInside)
            footerView.addSubview(rechargeButton)
            rechargeButton.snp.makeConstraints({ (make) in
                make.top.equalTo(footerView.snp.top).offset(40)
                make.centerX.equalTo(footerView.snp.centerX).offset(-80)
                make.height.equalTo(footerView.snp.right).offset(30)
                make.width.equalTo(footerView.snp.right).offset(100)
            })
            
            let refundButton = UIButton.init(type: UIButtonType.custom)
            refundButton.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
            refundButton.setTitle("充值", for: UIControlState.normal)
            refundButton.addTarget(self, action: #selector(refundButtonClick), for: .touchUpInside)
            footerView.addSubview(refundButton)
            refundButton.snp.makeConstraints({ (make) in
                make.top.equalTo(footerView.snp.top).offset(40)
                make.centerX.equalTo(footerView.snp.centerX).offset(80)
                make.height.equalTo(footerView.snp.right).offset(30)
                make.width.equalTo(footerView.snp.right).offset(100)
            })
            
        }else{
            
            statusButton = UIButton.init(type: UIButtonType.custom)
            statusButton?.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
            statusButton?.setTitle("前往测评", for: UIControlState.normal)
            statusButton?.addTarget(self, action: #selector(statusButtonClick), for: .touchUpInside)
            footerView.addSubview(statusButton!)
            statusButton?.snp.makeConstraints({ (make) in
                make.top.equalTo(footerView.snp.top).offset(40)
                make.left.equalTo(footerView.snp.left).offset(25)
                make.right.equalTo(footerView.snp.right).offset(-25)
            })
        }
        return footerView
    }
    
    func setStatusButtonType(_ title:String,imageName:String,enable:Bool)  {
        statusButton?.isEnabled = enable
        statusButton?.setBackgroundImage(UIImage.init(named: imageName), for: UIControlState.normal)
        statusButton?.setTitle(title, for: UIControlState.normal)
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
extension MemberCenterViewController {
    
    func configureView()  {
        
        footViewHeight = 150
        self.view.backgroundColor = LOAN_APPLICATION_COLOR
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        self.tableView?.backgroundColor = LOAN_APPLICATION_COLOR
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.isScrollEnabled = false
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
        
        var heaerViewHeight = 205
        if UI_IS_IPONE6P || UI_IS_IPHONEX{
            heaerViewHeight = 256
        }
        let rect =  CGRect.init(x: 0, y: 0, width: Int(_k_w), height: heaerViewHeight + 74)
        let headerView = UIView.init(frame: rect)
        titleHeaderView = FXD_displayAmountCommonHeaderView.init(frame: CGRect.zero, amount: (memberShipInfoModel?.availableCredit)!, amountTitle: "可借额度")
        titleHeaderView?.titleLabel?.text = "会员中心"
        titleHeaderView?.goBackBtn?.isHidden = false
        titleHeaderView?.hintWordBackImage?.isHidden = true
        titleHeaderView?.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
        headerView.addSubview(titleHeaderView!)
        titleHeaderView?.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(headerView)
            make.height.equalTo(heaerViewHeight)
        })
        
        centerHeaderView = MemberCenterHeaderView.loadNib("MemberCenterHeaderView")
        headerView.addSubview(centerHeaderView!)
        centerHeaderView?.snp.makeConstraints { (make) in
            make.top.equalTo((titleHeaderView?.snp.bottom)!).offset(0)
            make.left.right.equalTo(headerView)
            make.height.equalTo(74)
        }
        tableView?.tableHeaderView = headerView
    }

}
extension MemberCenterViewController {
    
    func obtainMemberShipInfo(_ finish:@escaping (_ success:Bool) -> Void)  {
       let viewModel = UserMemberShipViewModel.init()
        viewModel.setBlockWithReturn({ (returnValue) in
            let baseResult = returnValue  as! BaseResultModel
            if baseResult.errCode == "0"{
                let memberShipInfo = try! MemberShipInfoModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                self.memberShipInfoModel = memberShipInfo
                self.judgeUserStatus(memberShipInfo)
                finish(true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
                finish(false)
            }
        }) {
            finish(false)
        }
        viewModel.obtainMemberShipInfo()
    }
    
    func judgeUserStatus(_ infoModel:MemberShipInfoModel)  {
        if infoModel.status == "1" {
            //会员未开通
            if infoModel.credit == nil {
                memberStatus = .notMeasure
            }else{
                let credit = Int(infoModel.credit)
                if credit! <= 0{
                    memberStatus = .measuring
                }else{
                    memberStatus = .measureNotPass
                }
            }
        }else if infoModel.status == "2"{
            //会员已开通
            memberStatus = .recharge
            if infoModel.isNeedRequest == "0" && infoModel.isRefundAble == "1" {
                memberStatus = .refund
                
            }
            if infoModel.isNeedRequest == "1" && infoModel.isRefundAble == "1" {
                memberStatus = .rechargeAndRefund

            }
            if infoModel.isNeedRequest == "0" && infoModel.isRefundAble == "0" {
                memberStatus = .noStatus
                
            }
        }else if infoModel.status == "3"{
            //会员充值中
            memberStatus = .recharging
            
        }else if infoModel.status == "4"{
            //会员退款中
            memberStatus = .refunding
            
        }
    }
}

