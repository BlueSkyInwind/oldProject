//
//  CommonSwift.swift
//  fxdProduct
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

import Foundation



let  _k_w = UIScreen.main.bounds.size.width
let  _k_h = UIScreen.main.bounds.size.height

let IDCardNum = "0123456789Xx"

let UI_IS_IPONE = (UIDevice.current.userInterfaceIdiom == .phone)
let UI_IS_IPONE5 = (UI_IS_IPONE && _k_h == 568.0)
let UI_IS_IPONE6P = (UI_IS_IPONE && _k_h == 736.0)
let UI_IS_IPONE6 = (UI_IS_IPONE && _k_h == 667.0)
let UI_IS_IPONE4 = (UI_IS_IPONE && _k_h == 480.0)
let UI_IS_IPHONEX = (UI_IS_IPONE && _k_h == 812.0)

let SalaryLoan = "P001002"   //工薪贷平台
let RapidLoan = "P001004"   //急速贷平台
let DeriveRapidLoan = "P001006"   //急速贷衍生（30天）平台


func obtainBarHeight_New(vc:UIViewController) -> Int{
    return Int(UIApplication.shared.statusBarFrame.size.height + (vc.navigationController?.navigationBar.frame.size.height)!)
}

let UI_MAIN_COLOR = UIColor.init(red: 0, green: 170/255, blue: 238/255, alpha: 1)

let AuthenticationHeader_COLOR = UIColor.init(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)

let LINE_COLOR = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)

let QUTOA_COLOR = UIColor.init(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1)

let TITLE_COLOR = UIColor.init(red: 77/255.0, green: 77/255.0, blue: 77/255.0, alpha: 1)

let RedPacket_COLOR = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)

let RedPacketMoney_COLOR = UIColor.init(red: 126/255.0, green: 135/255.0, blue: 142/255.0, alpha: 1)

let RedPacketBottomBtn_COLOR = UIColor.init(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1)

let PayPasswordBackColor_COLOR = UIColor.init(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)

let MIDDLE_LINE_COLOR = UIColor.init(red: 179/255.0, green: 179/255.0, blue: 179/255.0, alpha: 1)

let TIME_COLOR = UIColor.init(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1)

let APPLICATION_backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)

let TERM_COLOR = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)

let LOAN_LINE_COLOR = UIColor.init(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1)

let ORANGE_COLOR = UIColor.init(red: 252/255.0, green: 120/255.0, blue: 3/255.0, alpha: 1)

let LOAN_QUOTA_COLOR = UIColor.init(red: 20/255.0, green: 40/255.0, blue: 65/255.0, alpha: 1)

let SLIDER_CLOLR = UIColor.init(red: 223/255.0, green: 219/255.0, blue: 219/255.0, alpha: 1)

let PAY_LINE_CLOLR = UIColor.init(red: 240/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
//新的金额颜色
let AMOUNT_COLOR = UIColor.init(red: 255/255.0, green: 222/255.0, blue: 0/255.0, alpha: 1)


