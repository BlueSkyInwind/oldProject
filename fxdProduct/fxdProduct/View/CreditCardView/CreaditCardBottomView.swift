//
//  CreaditCardBottomView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/21.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

typealias MoreDataViewClick = () -> Void
class CreaditCardBottomView: UIView {

    var moreButton:UIButton?
    var moreClick:MoreDataViewClick?
    convenience init(_ frame:CGRect,_ moreDataClick:@escaping MoreDataViewClick) {
        self.init(frame: frame)
        self.moreClick = moreDataClick
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = "f2f2f2".uiColor()
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func moreButtonClick() {
        if moreClick != nil{
            moreClick!()
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension CreaditCardBottomView {
    
    func configureView()  {
        moreButton = UIButton.init(type: UIButtonType.custom)
        moreButton?.setTitleColor("808080".uiColor(), for: UIControlState.normal)
        moreButton?.setTitle("更多信用卡", for: UIControlState.normal)
        moreButton?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 13)
        moreButton?.addTarget(self, action: #selector(moreButtonClick), for: UIControlEvents.touchUpInside)
        self.addSubview(moreButton!)
        moreButton?.snp.makeConstraints({ (make) in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(150)
            make.height.equalTo(35)
        })
    }
    
}



