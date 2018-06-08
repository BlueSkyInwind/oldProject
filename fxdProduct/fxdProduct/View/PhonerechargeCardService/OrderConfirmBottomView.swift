//
//  OrderConfirmBottomView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/6.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit


typealias ProtocolBtnClick = (_ status:Bool) -> Void
typealias ProtocolContentClick = (_ index:Int) -> Void
typealias ApplyForBtnClick = () -> Void

class OrderConfirmBottomView: UIView {
    
    var protocolBackView:UIView?
    var applyForBtn:UIButton?
    var protocolBtn:UIButton?
    var protocolLabel:YYLabel?
    var isClick:Bool = false

    @objc var  protocolBtnClick:ProtocolBtnClick?
    @objc var  protocolContentClick:ProtocolContentClick?
    @objc var  applyForBtnClick:ApplyForBtnClick?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func applyForBottonClick() {
        guard isClick else {
            return
        }
        if applyForBtnClick != nil {
            applyForBtnClick!()
        }
    }
    @objc func protocolBottonClick() {
        isClick = !isClick
        if isClick {
            protocolBtn?.setBackgroundImage(UIImage.init(named: "tricked"), for: UIControlState.normal)
            applyForBtn?.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
        }else{
            protocolBtn?.setBackgroundImage(UIImage.init(named: "trick"), for: UIControlState.normal)
            applyForBtn?.setBackgroundImage(UIImage.init(named: "applicationBtn_unselect_Image"), for: UIControlState.normal)
        }
        if protocolBtnClick != nil {
            protocolBtnClick!(isClick)
        }
    }
    
    func addProtocolClick(_ protocolNames:[String])  {
        var protocolContent:String = "我已阅读并同意"
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
                if self?.protocolContentClick != nil {
                    self?.protocolContentClick!(rangeArr.index(of: range)!)
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

extension OrderConfirmBottomView {
    
    func setUpUI()  {
        
        protocolBackView = UIView.init()
        self.addSubview(protocolBackView!)
        protocolBackView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.top.equalTo(self.snp.top).offset(30)
            make.height.equalTo(40)
        })
        
        applyForBtn = UIButton.init(type: UIButtonType.custom)
        applyForBtn?.setBackgroundImage(UIImage.init(named: "applicationBtn_unselect_Image"), for: UIControlState.normal)
        applyForBtn?.setTitle("确定", for: UIControlState.normal)
        applyForBtn?.addTarget(self, action: #selector(applyForBottonClick), for: UIControlEvents.touchUpInside)
        self.addSubview(applyForBtn!)
        applyForBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.bottom.equalTo(self.snp.bottom).offset(-15)
            make.height.equalTo(50)
        })
        
        protocolBtn = UIButton.init(type: UIButtonType.custom)
        protocolBtn?.setBackgroundImage(UIImage.init(named: "trick"), for: UIControlState.normal)
        protocolBtn?.addTarget(self, action: #selector(protocolBottonClick), for: UIControlEvents.touchUpInside)
        protocolBackView?.addSubview(protocolBtn!)
        protocolBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((protocolBackView?.snp.left)!).offset(2)
            make.centerY.equalTo((protocolBackView?.snp.centerY)!)
            make.width.height.equalTo(16)
        })
        
        protocolLabel = YYLabel.init()
        protocolLabel?.textAlignment = NSTextAlignment.left
        protocolLabel?.textVerticalAlignment = YYTextVerticalAlignment.center
        protocolLabel?.numberOfLines = 0
        protocolLabel?.font = UIFont.yx_systemFont(ofSize: 13)
        protocolBackView?.addSubview(protocolLabel!)
        protocolLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((protocolBtn?.snp.right)!).offset(4)
            make.centerY.equalTo((protocolBackView?.snp.centerY)!)
        })
    }
    
    
    
}



