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
    
    var cardInfos:Array<PhoneCardListModel> = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "商城"
  
        self.addBackItem()
        obtainDataSource()
    }
    
    override func loadFailureLoadRefreshButtonClick()  {
        obtainDataSource()
    }
    
    func obtainDataSource()  {
        obtainCardListInfo {[weak self] (isSuccess) in
            if(isSuccess) {
                self?.removeFailView()
                self?.configureView()
            }else{
                self?.setFailView()
            }
        }
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
        return (cardInfos.count)
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
        let listModel = cardInfos[indexPath.row]
        var index = 0;
        switch listModel.operators {
        case "0":
            index = 2
            break
        case "1":
            index = 0
            break
        case "2":
            index = 1
            break
        default:
            break
        }
        cell.backImageView?.image = UIImage.init(named: cardimgs[index])
        if listModel.inStock == "0"{
            cell.backImageView?.image = UIImage.init(named: cardimgsUnused[index])
        }
        cell.titileLabel?.text = listModel.displayCardName;
        cell.amountLabel?.text = listModel.sellingPrice + "元"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let listModel = cardInfos[indexPath.row]
        switch listModel.operators {
        case "0":
            pushOrderConfirmationVC(.telecomCard, listModel.ofpayProductNumber)
            break
        case "1":
            pushOrderConfirmationVC(.moblieCard, listModel.ofpayProductNumber)
            break
        case "2":
            pushOrderConfirmationVC(.unicomCard, listModel.ofpayProductNumber)
            break
        default:
            break
        }
    }
    
    func pushOrderConfirmationVC(_ cardType:PhoneCardType,_ cardOrderId:String)  {
        let orderVC = OrderConfirmationViewController.init()
        orderVC.cardType = cardType
        orderVC.cardOrderId =  cardOrderId
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

extension  ShoppingMallModules {
    
    func obtainCardListInfo(_ result:@escaping ((_ success:Bool) -> Void))  {
        let serviceViewModel = PhonerechargeCardServiceViewModel.init()
        serviceViewModel.setBlockWithReturn({[weak self] (model) in
            let baseModel = model as! BaseResultModel
            if baseModel.errCode == "0"{
                let dataArr = baseModel.data as! NSArray
                if dataArr.count > 0 {
                    self?.cardInfos.removeAll()
                }
                for dic in dataArr {
                    let listInfoModel = try! PhoneCardListModel.init(dictionary: dic as! [AnyHashable : Any])
                    self?.cardInfos.append(listInfoModel)
                }
                result(true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseModel.friendErrMsg)
                result(false)
            }
        }) {
            result(false)
        }
        serviceViewModel.obtainRechargeCardListInfo()
    }

}



