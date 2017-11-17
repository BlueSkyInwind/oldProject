//
//  CommonSwift.swift
//  fxdProduct
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

import Foundation

let UI_MAIN_COLOR = UIColor.init(red: 0, green: 170/255, blue: 238/255, alpha: 1)

let AuthenticationHeader_COLOR = UIColor.init(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)

let LINE_COLOR = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)

let QUTOA_COLOR = UIColor.init(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1)

let TITLE_COLOR = UIColor.init(red: 77/255.0, green: 77/255.0, blue: 77/255.0, alpha: 1)
let RedPacket_COLOR = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
let RedPacketMoney_COLOR = UIColor.init(red: 126/255.0, green: 135/255.0, blue: 142/255.0, alpha: 1)

let APPLICATION_backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)

let  _k_w = UIScreen.main.bounds.size.width
let  _k_h = UIScreen.main.bounds.size.height

let UI_IS_IPONE = (UIDevice.current.userInterfaceIdiom == .phone)
let UI_IS_IPONE5 = (UI_IS_IPONE && _k_h == 568.0)
let UI_IS_IPONE6P = (UI_IS_IPONE && _k_h == 736.0)
let UI_IS_IPONE6 = (UI_IS_IPONE && _k_h == 667.0)
let UI_IS_IPONE4 = (UI_IS_IPONE && _k_h == 480.0)
let UI_IS_IPHONEX = (UI_IS_IPONE && _k_h == 812.0)

let SalaryLoan = "P001002"   //工薪贷平台
let RapidLoan = "P001004"   //急速贷平台
let DeriveRapidLoan = "P001006"   //急速贷衍生（30天）平台
