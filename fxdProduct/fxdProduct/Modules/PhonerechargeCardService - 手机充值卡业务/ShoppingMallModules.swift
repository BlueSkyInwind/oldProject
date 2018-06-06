//
//  ShoppingMallModules.swift
//  fxdProduct
//
//  Created by admin on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

let FooterView_Height = 130

class ShoppingMallModules: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var cardTableView:UITableView?
    var cardimgs = ["mobile_card","unicom_card","telecom_card"]
    var cardimgsUnused = ["mobile_card_unused","unicom_card_unused","telecom_card_unused"]
    var cardTitle = ["移动手机充值卡-面值","联通手机充值卡-面值","电信手机充值卡-面值"]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "商城"
        self.addBackItem()
        configureView()
    }
    
    func configureView()  {
        cardTableView = UITableView()
        cardTableView?.delegate = self;
        cardTableView?.dataSource = self;
        cardTableView?.separatorStyle = .none
        self.view.addSubview(cardTableView!)
        cardTableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        cardTableView?.register(RechargeCardTableViewCell.self, forCellReuseIdentifier: "RechargeCardTableViewCell")
        let footerView = RechargeBottomView.init(frame: CGRect.init(x: 0, y: 0, width:_k_w, height: CGFloat(FooterView_Height)))
        cardTableView?.tableFooterView = footerView
        footerView.rechargeClick = {[weak self] in
            FXD_AlertViewCust.sharedHHAlertView().showPhoneRechargeCompleBlock({ (index) in
                
            })
        }
        footerView.rechargeTransferClick = {[weak self] in
            FXD_AlertViewCust.sharedHHAlertView().showPhoneRechargeTitle("提示", content: "充值卡转让服务由第三方平台提供，与本平台无关", attributeDic: nil, textAlignment: NSTextAlignment.left, sureTitle: "我已知晓", compleBlock: { (index) in
                
            })
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return obtainCellHeight()
    }
    
    func obtainCellHeight() -> CGFloat {
        let height = FooterView_Height + obtainBarHeight_New(vc: self)
        return (_k_h - CGFloat(height)) / 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "RechargeCardTableViewCell", for: indexPath) as! RechargeCardTableViewCell
        if cell == nil {
            cell = RechargeCardTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "RechargeCardTableViewCell")
        }
        cell.backImageView?.image = UIImage.init(named: cardimgs[indexPath.row])
        cell.titileLabel?.text = cardTitle[indexPath.row];
        cell.amountLabel?.text = "115"
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            pushOrderConfirmationVC(.moblieCard)
            break
        case 1:
            pushOrderConfirmationVC(.unicomCard)
            break
        case 2:
            pushOrderConfirmationVC(.telecomCard)
            break
        default:
            break
        }
    }
    
    func pushOrderConfirmationVC(_ cardType:PhoneCardType)  {
        let orderVC = OrderConfirmationViewController.init()
        orderVC.cardType = cardType
        self.navigationController?.pushViewController(orderVC, animated: true)
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
