//
//  DiscountCouponListVCModules.swift
//  fxdProduct
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

typealias ChooseDiscountTicket = (_ index: NSInteger,_ discountTicketM:DiscountTicketDetailModel,_ str:String)->Void
class DiscountCouponListVCModules: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @objc var dataListArr : NSArray?
    var tableView : UITableView?
    @objc var discountTicketModel:DiscountTicketDetailModel?
    @objc var currentIndex : NSString?
    @objc var chooseDiscountTicket : ChooseDiscountTicket?
    var index : NSInteger?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        index = currentIndex?.integerValue
        configureView()
    }
    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataListArr?.count)! + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var discountcell:ChooseDiscountTableViewCell! = tableView.dequeueReusableCell(withIdentifier:"ChooseDiscountTableViewCell") as? ChooseDiscountTableViewCell
        if discountcell == nil {
            discountcell = ChooseDiscountTableViewCell.init(style: .default, reuseIdentifier: "ChooseDiscountTableViewCell")
        }
        if indexPath.row == 0 {
            discountcell?.titleLabel?.text = "不使用提额券"
        }else{
            let discountTicketM = dataListArr![indexPath.row - 1] as! DiscountTicketDetailModel
            discountcell?.titleLabel?.text = String(format:"+%@元:有效期至%@",discountTicketM.amount_payment_,discountTicketM.end_time_)
        }
        
        if index == indexPath.row{
            discountcell?.chooseBtn?.setImage(UIImage.init(named: "choose_Icon"), for: UIControlState.normal);
        }else{
            discountcell?.chooseBtn?.setImage(UIImage.init(named: "unChoose_Icon"), for: UIControlState.normal);
        }
        return discountcell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        tableView.reloadData()
        if self.chooseDiscountTicket == nil {
            return
        }
        if indexPath.row == 0{
            let discountTicketMM = DiscountTicketDetailModel.init()
            self.chooseDiscountTicket!(index!,discountTicketMM,"不使用提额券")
        }else{
            let discountTicketM = dataListArr![indexPath.row - 1] as! DiscountTicketDetailModel
            self.chooseDiscountTicket!(index!,discountTicketM,"")
        }
        self.dismissSemiModalView(completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        let titleLabel = UILabel()
        titleLabel.text = "选择提额券"
        titleLabel.textColor = UIColor.init(red: 0, green: 0.633, blue: 0.933, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = NSTextAlignment.center
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(headerView.snp.center)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(red: 0, green: 0.633, blue: 0.933, alpha: 1)
        headerView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(1)
            make.bottom.equalTo(headerView.snp.bottom).offset(0)
        }
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView()
        footerView.backgroundColor = UIColor.white
        let  cancelBtn = UIButton.init(type: UIButtonType.custom)
        cancelBtn.setTitle("取消", for: UIControlState.normal)
        cancelBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        cancelBtn.backgroundColor = UI_MAIN_COLOR
        cancelBtn.addTarget(self, action: #selector(cancelChoose), for: UIControlEvents.touchUpInside)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelBtn.layer.cornerRadius = 3
        cancelBtn.clipsToBounds = true
        footerView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints({ (make) in
            make.center.equalTo(footerView.snp.center)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(40)
        })
        return footerView
    }
    
    @objc func cancelChoose()  {
        self.dismissSemiModalView(completion: nil)
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
