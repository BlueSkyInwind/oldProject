//
//  ShoppingMallModules.swift
//  fxdProduct
//
//  Created by admin on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class ShoppingMallModules: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var cardTableView:UITableView?
    var cardimgs = ["mobile_card","unicom_card","telecom_card"]
    var cardimgsUnused = ["mobile_card_unused","unicom_card_unused","telecom_card_unused"]
    var cardTitle = ["移动手机充值卡-面值","联通手机充值卡-面值","电信手机充值卡-面值"]
    var rechargeBtn:UIButton?
    var rechargeTransferBtn:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "商城"
        self.addBackItem()
        configureView()
    }
    
    
    @objc func rechargeBtnClick() {
    
    }
    @objc func rechargeTransferBtnClick() {
        
    }
    

    func configureView()  {
        cardTableView = UITableView()
        cardTableView?.delegate = self;
        cardTableView?.dataSource = self;
        self.view.addSubview(cardTableView!)
        cardTableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        cardTableView?.register(RechargeCardTableViewCell.self, forCellReuseIdentifier: "RechargeCardTableViewCell")
        cardTableView?.tableFooterView = setTableViewFooter()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
        
    }
    
    func setTableViewFooter() -> UIView {
        
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 150))
        footerView.backgroundColor = "f2f2f2".uiColor()

        rechargeBtn = UIButton.init(type: UIButtonType.custom)
        rechargeBtn?.setBackgroundImage(UIImage.init(named: "recharge_button_card"), for: UIControlState.normal)
        rechargeBtn?.setTitleColor(UIColor.black, for: UIControlState.normal)
        rechargeBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 17)
        rechargeBtn?.addTarget(self, action: #selector(rechargeBtnClick), for: UIControlEvents.touchUpInside)
        footerView.addSubview(rechargeBtn!)
        rechargeBtn?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(footerView.snp.centerX).offset(-90)
            make.centerY.equalTo(footerView.snp.centerY)
        })
        
        
        rechargeTransferBtn = UIButton.init(type: UIButtonType.custom)
        rechargeTransferBtn?.setBackgroundImage(UIImage.init(named: "recharge_button_card"), for: UIControlState.normal)
        rechargeTransferBtn?.setTitleColor(UIColor.black, for: UIControlState.normal)
        rechargeTransferBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 17)
        rechargeTransferBtn?.addTarget(self, action: #selector(rechargeTransferBtnClick), for: UIControlEvents.touchUpInside)
        footerView.addSubview(rechargeTransferBtn!)
        rechargeTransferBtn?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(footerView.snp.centerX).offset(90)
            make.centerY.equalTo(footerView.snp.centerY)
        })
        return footerView
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
