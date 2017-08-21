//
//  TrackRect.swift
//  fxdProduct
//
//  Created by sxp on 2017/8/21.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class TrackRect: UISlider {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x:0,y:0,width:self.frame.size.width,height:15)
    }

}
