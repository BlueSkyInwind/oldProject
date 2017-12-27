//
//  OptionalRapidLoanApplicationVCModules.swift
//  fxdProduct
//
//  Created by sxp on 2017/9/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class OptionalRapidLoanApplicationVCModules: BaseViewController ,RapidLoanApplicationcConfirmationDelegate,PickViewDelegate{
    
    //选择资金列表弹窗
    var pickView : PickView?
    //产品id
   @objc var productId : String?
    //平台id
   @objc var platformCode : String?
    //选择资金页面视图
   @objc var rapidLoanView : RapidLoanApplicationcConfirmation?
    //资金列表数组
   @objc var dataArray : NSMutableArray?
    var chooseIndex :NSInteger = 1
    var  discountTM:DiscountTicketModel?
    var chooseDiscountTDM:DiscountTicketDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择资金方"
        // Do any additional setup after loading the view.
        addBackItemRoot()
        productId = RapidLoan
 
        self.view.backgroundColor = UIColor.white
        if (pickView != nil){
            pickView?.removeFromSuperview()
        }
        if (rapidLoanView != nil) {
            rapidLoanView?.removeFromSuperview()
        }
        //选择资金列表弹窗
        pickView = PickView()
        pickView?.delegate = self
        pickView?.backgroundColor = UIColor.init(red: 34/255.0, green: 34/255.0, blue: 34/255.0, alpha: 0.4)
        self.pickView?.dataArray = dataArray! as [AnyObject]
        
        //选择资金页面视图
        rapidLoanView = RapidLoanApplicationcConfirmation()
        rapidLoanView?.delegate = self
        let model = dataArray![0] as! CapitalListModel
        self.rapidLoanView?.capitalSourceLabel?.text = model.platformName!
        platformCode = model.platformCode
        getApplicationConfirmData()
        //        getCapitalListData()
        
        self.obtainDiscountTicket { (discountTicketM) in
            if discountTicketM.canuselist != nil && discountTicketM.canuselist.count != 0 {
                self.chooseDiscountTDM = (discountTicketM.canuselist[0] as! DiscountTicketDetailModel)
                self.rapidLoanView?.addDiscountCoupons(discountTicketDetailM: self.chooseDiscountTDM!)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    //MARK:申请件申请确认页面数据展示
    func getApplicationConfirmData(){
        
        let applicationMV = ApplicationViewModel()
        applicationMV.setBlockWithReturn({ [weak self](returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                let applicationVM = try! ApplicaitonViewInfoModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                self?.setProductUI(model: applicationVM)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        applicationMV.queryApplicationInfo(productId)
    }
    //MARK:获取提额券
    func obtainDiscountTicket(_ finish:@escaping (_ discountTicketModel:DiscountTicketModel) -> Void)  {
        let applicationVM = ApplicationViewModel()
        applicationVM.setBlockWithReturn({ (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                let discountTicketM = try! DiscountTicketModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                self.discountTM = discountTicketM;
                finish(discountTicketM)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        applicationVM.new_obtainUserDiscountTicketListDisplayType("1", product_id: productId, pageNum: nil, pageSize: nil)
    }
    
    func setProductUI(model : ApplicaitonViewInfoModel){
        
        rapidLoanView?.titleLabel?.text = model.productName
        
        let url = URL(string: model.icon)
        rapidLoanView?.titleImageView?.sd_setImage(with: url)
        rapidLoanView?.qutoaLabel?.text = "额度:" + model.amount
        
        //更改区间字体颜色
        let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(rapidLoanView!.qutoaLabel?.text)!)
        attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr.length-3))
        attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(3,attrstr.length-3))
        rapidLoanView?.qutoaLabel?.attributedText = attrstr
        
        rapidLoanView?.termLabel?.text = "期限:" + model.period
        let attrstr1 : NSMutableAttributedString = NSMutableAttributedString(string:(rapidLoanView!.termLabel?.text)!)
        attrstr1.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr1.length-3))
        attrstr1.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(3,attrstr1.length-3))
        rapidLoanView?.termLabel?.attributedText = attrstr1
        
        self.view.addSubview(rapidLoanView!)
    }
    
    //MARK: 选择资金来源方按钮
    func capitalSourceBtn() {

        self.view.addSubview(self.pickView!)
    
    }
    
    //MARK: 确认申请按钮
    func commitBtn() {
     print("确认申请按钮")
        let applicationMV = ApplicationViewModel()
        applicationMV.setBlockWithReturn({ [weak self](returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
                let checkVC = WithdrawalsVCModule()
                self?.navigationController?.pushViewController(checkVC, animated: true)
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        applicationMV.userCreateApplication(productId, platformCode: platformCode,baseId:chooseDiscountTDM?.base_id)
    }
    
    //MARK: 取消按钮
    func cancelBtn() {
        
        UIView.animate(withDuration: 2) {
            
            self.pickView?.removeFromSuperview()
            
        }
    }
    
    //MARK: 确认按钮
    func sureBtn(_ capitalListModel: CapitalListModel) {
        
        UIView.animate(withDuration: 2) {
            
            self.pickView?.removeFromSuperview()
            
        }
        rapidLoanView?.capitalSourceLabel?.text = capitalListModel.platformName

        platformCode = capitalListModel.platformCode
    }
    
    //MARK:选择提额券
    func showChooseAmountView(){
        let discountCouponVC = DiscountCouponListVCModules()
        discountCouponVC.dataListArr = (discountTM?.canuselist! as! NSArray)
        discountCouponVC.currentIndex = "\(chooseIndex)" as NSString
        discountCouponVC.view.frame = CGRect.init(x: 0, y: 0, width: _k_w, height: _k_h * 0.6)
        discountCouponVC.chooseDiscountTicket = ({[weak self] (index,discountTicketDetailModel,str ) in
            self?.chooseIndex = index;
            self?.chooseDiscountTDM = discountTicketDetailModel;
            if index != 0 {
                self?.rapidLoanView?.discountCouponsV?.amountLabel?.text = "+￥" + "\(self?.chooseDiscountTDM?.total_amount ?? "")"
            }else{
                 self?.rapidLoanView?.discountCouponsV?.amountLabel?.text = "+￥0"
            }
        })
        
        self.presentSemiViewController(discountCouponVC, withOptions: [KNSemiModalOptionKeys.pushParentBack.takeUnretainedValue() : false,KNSemiModalOptionKeys.parentAlpha.takeUnretainedValue() : 0.8], completion: nil, dismiss: {
        })
    }
    //MARK:使用帮助
    func showDirectionsForUse(){
        let  webVC = FXDWebViewController()
        webVC.urlStr = "\(_H5_url)"+"\(_DiscountTicketRule_url)"
        self.navigationController?.pushViewController(webVC, animated: true)
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
