//
//  RapidLoanApplicationViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/9/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class RapidLoanApplicationViewController: BaseViewController ,RapidLoanApplicationcConfirmationDelegate,PickViewDelegate{
    
    
    var pickView : PickView?
    var peoductId : String?
    
    var rapidLoanView : RapidLoanApplicationcConfirmation?
    override func viewDidLoad() {
        super.viewDidLoad()

    
        self.title = "申请确认"
        // Do any additional setup after loading the view.
        addBackItemRoot()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pickView = PickView()
        pickView?.delegate = self
        pickView?.backgroundColor = UIColor.init(red: 34/255.0, green: 34/255.0, blue: 34/255.0, alpha: 0.4)
        
        rapidLoanView = RapidLoanApplicationcConfirmation()
        rapidLoanView?.delegate = self
        
        getApplicationConfirmData()
        getCapitalListData()
    }

    //MARK 申请件申请确认页面数据展示
    func getApplicationConfirmData(){
        
        let applicationMV = ApplicationViewModel()
        applicationMV.setBlockWithReturn({ (returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                
                let applicationVM = try! ApplicaitonViewInfoModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                self.setProductUI(model: applicationVM)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        applicationMV.queryApplicationInfo(RapidLoan)
    }
    
    func setProductUI(model : ApplicaitonViewInfoModel){
        
        
        rapidLoanView?.titleLabel?.text = model.productName
        
        let url = URL(string: model.icon)
        rapidLoanView?.titleImageView?.sd_setImage(with: url)
        rapidLoanView?.qutoaLabel?.text = "额度:" + model.amount
        
        let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(rapidLoanView!.qutoaLabel?.text)!)
        attrstr.addAttribute(NSForegroundColorAttributeName, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr.length-3))
        attrstr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(3,attrstr.length-3))
        rapidLoanView?.qutoaLabel?.attributedText = attrstr
        
        rapidLoanView?.termLabel?.text = "期限:" + model.period
        let attrstr1 : NSMutableAttributedString = NSMutableAttributedString(string:(rapidLoanView!.termLabel?.text)!)
        attrstr1.addAttribute(NSForegroundColorAttributeName, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr1.length-3))
        attrstr1.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(3,attrstr1.length-3))
        rapidLoanView?.termLabel?.attributedText = attrstr1
        
        self.view.addSubview(rapidLoanView!)
    }

    //MARK 资金平台列表
    func getCapitalListData(){
        
        let applicationMV = ApplicationViewModel()
        applicationMV.setBlockWithReturn({ (returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                for dic in baseResult.data! as! NSArray{
                    
                    let capitalListModel = try! CapitalListModel.init(dictionary: dic as! [AnyHashable : Any])
                    self.pickView?.dataArray.append(capitalListModel)
                    
                }
                
                let model = self.pickView?.dataArray[0] as! CapitalListModel
                self.rapidLoanView?.capitalSourceLabel?.text = model.platformName!
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        applicationMV.capitalList(RapidLoan)
    }
    
    //MARK 选择资金来源方按钮
    func capitalSourceBtn() {

        
        self.view.addSubview(self.pickView!)
    
    }
    
    //MARK 确认申请按钮
    func commitBtn() {
     print("确认申请按钮")
    }
    
    //MARK 取消按钮
    func cancelBtn() {
        
        UIView.animate(withDuration: 2) {
            
            self.pickView?.removeFromSuperview()
            
        }
    }
    
    //MARK 确认按钮
    func sureBtn(_ capitalListModel: CapitalListModel) {
        
        UIView.animate(withDuration: 2) {
            
            self.pickView?.removeFromSuperview()
            
        }
        rapidLoanView?.capitalSourceLabel?.text = capitalListModel.platformName

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
