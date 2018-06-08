//
//  OrderConfirmDetailViewController.swift
//  fxdProduct
//
//  Created by admin on 2018/6/6.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class OrderConfirmDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView?
    var cardType:PhoneCardType?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单确认"
        self.addBackItem()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.separatorStyle = .none
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        tableView?.register(UINib.init(nibName: "OrderConfirmInfoCell", bundle: nil), forCellReuseIdentifier: "OrderConfirmInfoCell")
        tableView?.register(UINib.init(nibName: "OrderConfirmDetailInfoCell", bundle: nil), forCellReuseIdentifier: "OrderConfirmDetailInfoCell")
        tableView?.register(PrepaidCardsInfoCell.self, forCellReuseIdentifier: "PrepaidCardsInfoCell")
        
        let headerView = HeaderInstructionsView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 34))
        headerView.instructionsLabel?.text = "充值卡为虚拟物品，一经出售概不退换"
        tableView?.tableHeaderView = headerView
        tableView?.sectionFooterHeight = 0
        
        let bottomView = RechargeBottomView.init(frame: CGRect.zero)
        bottomView.backgroundColor = UIColor.white
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.view)
            make.height.equalTo(60)
        }
        bottomView.rechargeClick = {[weak self] in
            FXD_AlertViewCust.sharedHHAlertView().showPhoneRechargeCompleBlock({ (index) in
                
            })
        }
        bottomView.rechargeTransferClick = {[weak self] in
            FXD_AlertViewCust.sharedHHAlertView().showPhoneRechargeTitle("提示", content: "充值卡转让服务由第三方平台提供，与本平台无关", attributeDic: nil, textAlignment: NSTextAlignment.left, sureTitle: "我已知晓", compleBlock: { (index) in
                
            })
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 150
        switch indexPath.section {
        case 0:
            height = 150
            break
        case 1:
            height = 280
            break
        case 2:
            height = 320
            break
        default:
            break
        }
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderConfirmInfoCell", for: indexPath) as! OrderConfirmInfoCell
            switch cardType {
            case .moblieCard?:
                cell.orderTypeIcon.image = UIImage.init(named: "moblie_Icon")
                break
            case .unicomCard?:
                cell.orderTypeIcon.image = UIImage.init(named: "unicom_Icon")
                break
            case .telecomCard?:
                cell.orderTypeIcon.image = UIImage.init(named: "telecom_Icon")
                break
            default:
                break
            }
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderConfirmDetailInfoCell", for: indexPath) as!  OrderConfirmDetailInfoCell
            return cell
        }else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "PrepaidCardsInfoCell", for: indexPath) as!  PrepaidCardsInfoCell
            if cell == nil {
                cell = PrepaidCardsInfoCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "PrepaidCardsInfoCell")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 15
        }else if section == 2 {
            return 32
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if section == 1 {
            let header = UIView.init()
            header.backgroundColor = UIColor.clear
            return header
        }else {
            let headerView = HeaderInstructionsView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 32))
            headerView.instructionsLabel?.text = "请妥善保管您的卡密，因泄露第三方造成的损失需用户承担"
            headerView.backgroundColor = UIColor.clear
            return headerView
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
