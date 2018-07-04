//
//  RepaymentResultViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc enum Enum_Result:Int{
    
    case intermediate
    case submitFailure
    case repayFailure
    case success
    case submittedSuccessfully
    
}

class RepaymentResultViewController: BaseViewController {

    var state:Enum_Result?
    var orderNo:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        addCloseItem()
        switch state {
        case .intermediate?:
            self.title = "还款确认中"
        case .submitFailure?:
            self.title = "提交失败"
        case .repayFailure?:
            self.title = "还款失败"
        case .success?:
            self.title = "还款成功"
        case .submittedSuccessfully?:
            self.title = "提交成功"
        default:
            break
        }
        resultView()
        // Do any additional setup after loading the view.
    }


    fileprivate func resultView(){
        
        var imageStr = ""
        var tipStr = ""
        var btnTitle = "返回"
        switch state {
        case .intermediate?:
            imageStr = "repay_intermediate_icon"
            tipStr = "还款确认中"
        case .submitFailure?:
            imageStr = "bill_fail_icon"
            tipStr = "订单提交失败"
        case .repayFailure?:
            imageStr = "bill_fail_icon"
            tipStr = "还款失败"
        case .success?:
            imageStr = "bill_none_icon"
            tipStr = "还款成功"
        case .submittedSuccessfully?:
            imageStr = "bill_none_icon"
            tipStr = "您的订单已经提交成功"
            btnTitle = "查看订单"
        default:
            break
        }
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: imageStr)
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(110)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        let tipLabel = UILabel()
        tipLabel.textColor = RedPacketBottomBtn_COLOR
        tipLabel.text = tipStr
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(45)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        let backBtn = UIButton()
        backBtn.setTitle(btnTitle, for: .normal)
        backBtn.setTitleColor(UIColor.white, for: .normal)
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        backBtn.setBackgroundImage(UIImage.init(named: "btn_seleted_icon"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.view.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
//            make.left.equalTo(self.view).offset(30)
            make.top.equalTo(self.view).offset(340)
//            make.right.equalTo(self.view).offset(-30)
            make.height.equalTo(40)
            make.width.equalTo(240)
            make.centerX.equalTo(self.view.snp.centerX)
        }
    }
    
    @objc fileprivate func backBtnClick(){
        
        back()
    }
    
    override func popBack(){
        
        switch state {
        case .intermediate?,.success?:
            for  vc in self.rt_navigationController.rt_viewControllers {
                if vc.isKind(of: MyBillViewController.self) {
                    self.navigationController?.popToViewController(vc, animated: true)
                    return
                }
            }
        case .submittedSuccessfully?:
            for  vc in self.rt_navigationController.rt_viewControllers {
                if vc.isKind(of: ShoppingMallModules.self) {
                    self.navigationController?.popToViewController(vc, animated: true)
                    return
                }
            }
            
        case .submitFailure?,.repayFailure?:
            self.navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
    
    func back(){
        
        switch state {
        case .intermediate?,.success?:
            
            for  vc in self.rt_navigationController.rt_viewControllers {
                if vc.isKind(of: MyBillViewController.self) {
                    self.navigationController?.popToViewController(vc, animated: true)
                    return
                }
            }
            
        case .submitFailure?,.repayFailure?:
            self.navigationController?.popViewController(animated: true)
        case .submittedSuccessfully?:
            let detailOrderVC = OrderConfirmDetailViewController()
            detailOrderVC.orderNo = orderNo
            self.navigationController?.pushViewController(detailOrderVC, animated: true)
            break
        default:
            break
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
