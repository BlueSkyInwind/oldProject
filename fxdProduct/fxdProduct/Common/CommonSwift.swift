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
let EliteLoan = "P001007" //精英贷

let WebView_Style = "<header><meta name='viewport' content='width=device-width, initial-scale=0.8, maximum-scale=0.8, minimum-scale=0.8, user-scalable=no'></header>"

func obtainBarHeight_New(vc:UIViewController) -> Int{
    return Int(UIApplication.shared.statusBarFrame.size.height + (vc.navigationController?.navigationBar.frame.size.height)!)
}



// 这里 T 表示不指定 message参数类型
func DLog<T>(message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        // 需要在 buildSetting 中配置 swift flags的参数为:-D DEBUG, DEBUG可以自定义, 一般用 DEBUG
        // 搜 swift flags-->other swift flags-->DEBUG-->点+号-->输入上面的配置参数
        // 1.对文件进行处理
        let fileName = (file as NSString).lastPathComponent
        // 2.打印内容
        print("[\(fileName)][\(funcName)](\(lineNum)):\(message)")
    #endif
}

let UI_MAIN_COLOR = UIColor.init(red: 87/255, green: 141/255, blue: 249/255, alpha: 1)

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
let AMOUNT_COLOR = UIColor.white
//申请确认背景色
let LOAN_APPLICATION_COLOR = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
//
let LOAN_APPLICATION_TitleBACK_COLOR = UIColor.init(red: 190/255.0, green: 190/255.0, blue: 190/255.0, alpha: 1)

let COMMPLIANCE_LINE_COLOR = UIColor.init(red: 19/255.0, green: 136/255.0, blue: 356/255.0, alpha: 1)

let REFRESH_TITLE_COLOR = UIColor.init(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)

let HOME_ARROW_COLOR = UIColor.init(red: 178.5/255.0, green: 178.5/255.0, blue: 178.5/255.0, alpha: 1)

let GAME_COLOR = UIColor.init(red: 25.5/255.0, green: 25.5/255.0, blue: 25.5/255.0, alpha: 1)

let TIP_TITLE_COLOR = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)

let TIP_LINE_COLOR = UIColor.init(red: 229/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1)

let OVERDUEDATE_COLOR = UIColor.init(red: 249/255.0, green: 87/255.0, blue: 87/255.0, alpha: 1)

let DWONLOAD_COLOR = UIColor.init(red: 131/255.0, green: 131/255.0, blue: 131/255.0, alpha: 1)

let SUPERMARK_LINE_COLOR = UIColor.init(red: 111/255.0, green: 111/255.0, blue: 111/255.0, alpha: 1)

let SUPERMARK_QUOTA_COLOR = UIColor.init(red: 255/255.0, green: 83/255.0, blue: 39/255.0, alpha: 1)

let SUPERMARK_TERM_COLOR = UIColor.init(red: 105/255.0, green: 105/255.0, blue: 105/255.0, alpha: 1)

let MESSAGE_TITLE_COLOR = UIColor.init(red: 63/255.0, green: 63/255.0, blue: 63/255.0, alpha: 1)

let MINE_MONEY_COLOR = UIColor.init(red: 255/255.0, green: 245/255.0, blue: 0/255.0, alpha: 1)

let MINE_BANK_COLOR = UIColor.init(red: 139/255.0, green: 139/255.0, blue: 139/255.0, alpha: 1)

let Bill_COLOR = UIColor.init(red: 126/255.0, green: 128/255.0, blue: 127/255.0, alpha: 1)

