//
//  AllCardHeaderView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/20.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class AllCardHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension AllCardHeaderView {
    func configureView() {
        
        let itemView = HeaderItemView.init(frame: CGRect.zero)
        itemView.titleBtn?.setTitle("全部银行", for: UIControlState.normal)
        
        
        
        
    }
}


