//
//  YX_TextField.swift
//  fxdProduct
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit


class YX_TextField: UITextField {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect.init(x: bounds.width - 100, y: bounds.origin.y, width: 100, height: bounds.height)
        return rect
    }

}
