//
//  CommonProtocol .swift
//  fxdProduct
//
//  Created by admin on 2017/12/28.
//  Copyright © 2017年 dd. All rights reserved.
//

import Foundation

protocol NibLoadProtocol {
    
}

extension NibLoadProtocol where Self : UIView{
    
    static func loadNib(_ nibNmae :String? = nil) -> Self{
        return Bundle.main.loadNibNamed(nibNmae ?? "\(self)", owner: nil, options: nil)?.first as! Self
    }
    
}







