//
//  SetTransactionInfoViewController.swift
//  fxdProduct
//
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

/// 页面展示类型
///
/// - IDCardNumber_Type: 身份证效验
/// - verificationCode_Type: 验证码效验
/// - setTradePassword_Type: 交易密码效验
/// - modificationTradePassword_Type: 修改交易密码
@objc enum SetExhibitionType : Int {
    case IDCardNumber_Type
    case verificationCode_Type
    case setTradePassword_Type
    case modificationTradePassword_Type
}

class SetTransactionInfoViewController: BaseViewController {
    
     var exhibitionType:SetExhibitionType?
    var identitiesOfTradeView:SetIdentitiesOfTradeView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    func configureView() -> Void {
        switch exhibitionType {
        case .IDCardNumber_Type?:
            self.title = "设置交易身份"
        case .verificationCode_Type?:
            self.title = "设置交易密码"
        case .setTradePassword_Type?:
            self.title = "设置交易密码"
        case .modificationTradePassword_Type?:
            self.title = "修改交易密码"
        default:()
        }
    }
    
    func SetIDCardView()  {
        
        identitiesOfTradeView = SetIdentitiesOfTradeView.init(frame: <#T##CGRect#>)
        
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
