//
//  FXD_AgreementView.swift
//  fxdProduct
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

typealias MembershipAgreementClick = () -> Void
typealias AgreeMembershipAgreementClick = (_ isClick:Bool) -> Void

class FXD_AgreementView: UIView {
    
    var protocolBtn:UIButton?
    var protocolLabel:YYLabel?
    var agreementClick:MembershipAgreementClick?
    var isAgreementClick:AgreeMembershipAgreementClick?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    convenience init(_ frame: CGRect,content:String,protocolNameArr:[String]) {
        self.init(frame: frame)
        addProtocolClick(content, protocolNameArr)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func protocolBottonClick(sender:UIButton)  {
        let button = sender
        button.isSelected = !button.isSelected
        if (self.isAgreementClick != nil) {
            self.isAgreementClick!(button.isSelected)
        }
    }
    
    func addProtocolClick(_ explain:String,_ protocolNames:[String])  {
        //
        var protocolContent:String = explain
        var rangeArr:[NSRange] = []
        for proName in protocolNames {
            protocolContent = protocolContent + proName + "、"
        }
        let index = protocolContent.index(protocolContent.endIndex, offsetBy: -1)
        let attributeStr = NSMutableAttributedString.init(string: String(protocolContent[..<index]))
        for proName in protocolNames {
            let range = (protocolContent as NSString).range(of: proName)
            rangeArr.append(range)
            attributeStr.yy_setTextHighlight(range, color: UI_MAIN_COLOR, backgroundColor: UIColor.init(white: 0, alpha: 0.22)) {[weak self] (view, arrtiText, range, rect) in
                if self?.agreementClick != nil {
                    self?.agreementClick!()
                }
            }
        }
        protocolLabel?.attributedText = attributeStr
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension FXD_AgreementView {
    
    func configureView()  {
        protocolBtn = UIButton.init(type: UIButtonType.custom)
        protocolBtn?.setBackgroundImage(UIImage.init(named: "trick"), for: UIControlState.normal)
        protocolBtn?.setBackgroundImage(UIImage.init(named: "tricked"), for: UIControlState.selected)
        protocolBtn?.addTarget(self, action: #selector(protocolBottonClick(sender:)), for: UIControlEvents.touchUpInside)
        self.addSubview(protocolBtn!)
        protocolBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.width.height.equalTo(16)
        })
        
        protocolLabel = YYLabel.init()
        protocolLabel?.textAlignment = NSTextAlignment.left
        protocolLabel?.textVerticalAlignment = YYTextVerticalAlignment.center
        protocolLabel?.numberOfLines = 0
        protocolLabel?.font = UIFont.yx_systemFont(ofSize: 13)
        self.addSubview(protocolLabel!)
        protocolLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((protocolBtn?.snp.right)!).offset(4)
            make.centerY.equalTo(self.snp.centerY).offset(0)
        })
    }
}


