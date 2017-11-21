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
        addBackItemRoot()
        self.view.backgroundColor = UIColor.white
        exhibitionType = .IDCardNumber_Type
        configureView()
    }
    
    func configureView() -> Void {
        switch exhibitionType {
        case .IDCardNumber_Type?:
            self.title = "设置交易身份"
            setIDCardView()
        case .verificationCode_Type?:
            self.title = "设置交易密码"
        case .setTradePassword_Type?:
            self.title = "设置交易密码"
        case .modificationTradePassword_Type?:
            self.title = "修改交易密码"
        default:()
        }
    }
    
    /// 身份证效验界面
    func setIDCardView()  {
        identitiesOfTradeView = SetIdentitiesOfTradeView.init(frame: CGRect.zero)
        identitiesOfTradeView?.nextClick = ({ () in
            //下一个按钮点击
            
        })
        self.view.addSubview(identitiesOfTradeView!)
        identitiesOfTradeView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
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
