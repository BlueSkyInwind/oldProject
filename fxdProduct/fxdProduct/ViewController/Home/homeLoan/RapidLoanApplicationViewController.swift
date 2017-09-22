//
//  RapidLoanApplicationViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/9/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class RapidLoanApplicationViewController: UIViewController ,RapidLoanApplicationcConfirmationDelegate,PickViewDelegate{
    
    
    var pickView : PickView?

    var rapidLoanView : RapidLoanApplicationcConfirmation?
    override func viewDidLoad() {
        super.viewDidLoad()

    
        self.title = "申请确认"
        // Do any additional setup after loading the view.
        rapidLoanView = RapidLoanApplicationcConfirmation()
        rapidLoanView?.delegate = self
        rapidLoanView?.titleLabel?.text = "急速贷"
        rapidLoanView?.titleImageView?.image = UIImage(named:"icon_Product2")
        rapidLoanView?.qutoaLabel?.text = "额度:1000元"
        
        let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(rapidLoanView!.qutoaLabel?.text)!)
        attrstr.addAttribute(NSForegroundColorAttributeName, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr.length-3))
        attrstr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(3,attrstr.length-3))
        rapidLoanView?.qutoaLabel?.attributedText = attrstr
        
        rapidLoanView?.termLabel?.text = "期限:14天"
        let attrstr1 : NSMutableAttributedString = NSMutableAttributedString(string:(rapidLoanView!.termLabel?.text)!)
        attrstr1.addAttribute(NSForegroundColorAttributeName, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr1.length-3))
        attrstr1.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(3,attrstr1.length-3))
        rapidLoanView?.termLabel?.attributedText = attrstr1
        
        rapidLoanView?.capitalSourceLabel?.text = "善林金融"
        self.view.addSubview(rapidLoanView!)
        
    }

    func capitalSourceBtn() {
        
        pickView = PickView()
        pickView?.delegate = self
        pickView?.backgroundColor = UIColor.init(red: 34/255.0, green: 34/255.0, blue: 34/255.0, alpha: 0.4)
        pickView?.dataArray = ["善林金融","发薪贷","善林金融","善林金融"]
        self.view.addSubview(pickView!)
        
        print("=====controller capitalSourceBtn is click====")
    }
    
    func advancedCertification() {
        print("=====controller bottom is click====")
    }
    
    func cancelBtn() {
        
        UIView.animate(withDuration: 2) {
            
            self.pickView?.removeFromSuperview()
            
        }
        print("=====controller cancelBtn is click====")
    }
    
    func sureBtn(_ selected: String) {
        
        UIView.animate(withDuration: 2) {
            
            self.pickView?.removeFromSuperview()
            
        }
        rapidLoanView?.capitalSourceLabel?.text = selected
        print("=====controller cancelBtn is click====")
        print("%@",selected)
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
