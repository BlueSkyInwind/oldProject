//
//  FXD_ToWithdrawFundsFooterView.swift
//  fxdProduct
//
//  Created by admin on 2017/12/25.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit
import WebKit



@objc protocol WithdrawFundsFooterViewDelegate: NSObjectProtocol {
    
    //协议点击
    func protocolNameClick(_ index:Int)
    //遵守协议点击
    func keepProtocolClick(_ isKeep:Bool)
    //提款按钮点击
    func WithdrawFundsClick()
    
}

class FXD_ToWithdrawFundsFooterView: UIView{
    
    var displayTitle:UILabel?
    var displayContent:UILabel?
    var protocolBackView:UIView?
    var applyForBtn:UIButton?
    var protocolBtn:UIButton?
    var protocolLabel:YYLabel?
    
    var delegate:WithdrawFundsFooterViewDelegate?
    var isClick:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = LOAN_APPLICATION_COLOR
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame:CGRect,htmlContentArr:[String],protocolNames:[String]){
        self.init(frame: frame)
        setProtocolcontent(htmlContentArr)
        addProtocolClick(protocolNames)
    }
    
    func setProtocolcontent(_ htmlContentArr:[String])  {
        var contentStr:String? = ""
        for str in htmlContentArr {
            contentStr = contentStr! + "\n" + str
        }
        displayTitle?.text = "保证金收取提示"
        contentStr?.removeFirst()
        let  contentAttri = NSMutableAttributedString.init(string: contentStr!)
        let contentPara = NSMutableParagraphStyle.init()
        contentPara.paragraphSpacing = 8
        contentAttri.addAttributes([NSAttributedStringKey.font:UIFont.yx_systemFont(ofSize: 14) ?? 14,NSAttributedStringKey.paragraphStyle:contentPara], range: NSMakeRange(0, (contentStr?.count)!))
        displayContent?.attributedText = contentAttri
    }
    
    func addProtocolClick(_ protocolNames:[String])  {
        var protocolContent:String = "我已阅读并认可发薪贷"
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
                if self?.delegate != nil  {
                    self?.delegate?.protocolNameClick(rangeArr.index(of: range)!)
                }
            }
        }
        protocolLabel?.attributedText = attributeStr
    }
    
    @objc func applyForBottonClick(){
        if delegate != nil  {
            delegate?.WithdrawFundsClick()
        }
    }
    
    @objc func protocolBottonClick() {
        isClick = !isClick
        if isClick {
            protocolBtn?.setBackgroundImage(UIImage.init(named: "tricked"), for: UIControlState.normal)
        }else{
            protocolBtn?.setBackgroundImage(UIImage.init(named: "trick"), for: UIControlState.normal)
        }
        if delegate != nil  {
            delegate?.keepProtocolClick(isClick)
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
extension FXD_ToWithdrawFundsFooterView {
    
    func setUpUI()  {
        
        displayTitle = UILabel()
        displayTitle?.font = UIFont.yx_systemFont(ofSize: 16)
        displayTitle?.textAlignment = NSTextAlignment.center
        displayTitle?.textColor = UIColor.init(red: 77/255.0, green: 77/255.0, blue: 77/255.0, alpha: 1)
        self.addSubview(displayTitle!)
        displayTitle?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
        })
        
        displayContent = UILabel()
        displayContent?.font = UIFont.yx_boldSystemFont(ofSize: 14)
        displayContent?.textColor = UIColor.init(red: 127/255.0, green: 127/255.0, blue: 127/255.0, alpha: 1)
        displayContent?.textAlignment  = NSTextAlignment.left
        displayContent?.numberOfLines = 0
        self.addSubview(displayContent!)
        displayContent?.snp.makeConstraints({ (make) in
            make.top.equalTo((displayTitle?.snp.bottom)!).offset(15)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
        })
        
        protocolBackView = UIView.init()
        self.addSubview(protocolBackView!)
        protocolBackView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.top.equalTo((displayContent?.snp.bottom)!).offset(10)
            make.height.equalTo(40)
        })
        
        applyForBtn = UIButton.init(type: UIButtonType.custom)
        applyForBtn?.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
        applyForBtn?.setTitle("确认申请", for: UIControlState.normal)
        applyForBtn?.addTarget(self, action: #selector(applyForBottonClick), for: UIControlEvents.touchUpInside)
        self.addSubview(applyForBtn!)
        applyForBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.top.equalTo((protocolBackView?.snp.bottom)!).offset(5)
        })
        
        protocolBtn = UIButton.init(type: UIButtonType.custom)
        protocolBtn?.setBackgroundImage(UIImage.init(named: "trick"), for: UIControlState.normal)
        protocolBtn?.addTarget(self, action: #selector(protocolBottonClick), for: UIControlEvents.touchUpInside)
        protocolBackView?.addSubview(protocolBtn!)
        protocolBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((protocolBackView?.snp.left)!).offset(2)
            make.top.equalTo((protocolBackView?.snp.top)!).offset(2)
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
            make.top.equalTo((protocolBackView?.snp.top)!).offset(2)
        })


    }
}


