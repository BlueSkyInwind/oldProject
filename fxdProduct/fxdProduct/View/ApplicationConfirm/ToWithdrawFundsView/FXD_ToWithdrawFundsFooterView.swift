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
    //协议列表点击
    func protocolListClick(_ sender: UIButton)
    
}

class FXD_ToWithdrawFundsFooterView: UIView{
    
    var displayTitle:UILabel?
    var displayContent:UITextView?
    var protocolBackView:UIView?
    var applyForBtn:UIButton?
    var protocolBtn:UIButton?
    var protocolLabel:YYLabel?
    @objc var arrowDescLabel : UILabel?
    @objc var protocolListView : UIView?
    
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
    
    convenience init(frame:CGRect,htmlContentArr:[String],protocolNames:[HgLoanProtoolListModel],titleStr:String){
        self.init(frame: frame)
        
//        setProtocolcontent(htmlContentArr,titleStr: titleStr)
        
        var protocolName = ""
        
        if protocolNames.count > 0 {
            
            protocolName = protocolNames[0].protocolName
        
        }
        addProtocolClick([protocolName])
        
        if protocolNames.count > 1 {
            
            createProtocolUI(array: protocolNames)
        }
    }
    
    func setProtocolcontent(_ htmlContentArr:[String],titleStr:String)  {
        var contentStr:String? = ""
        for str in htmlContentArr {
            contentStr = contentStr! + "\n" + str
        }
        displayTitle?.text = titleStr
        contentStr?.removeFirst()
        let  contentAttri = NSMutableAttributedString.init(string: contentStr!)
        let contentPara = NSMutableParagraphStyle.init()
        contentPara.paragraphSpacing = 8
        contentAttri.addAttributes([NSAttributedStringKey.font:UIFont.yx_systemFont(ofSize: 14) ?? 14,NSAttributedStringKey.paragraphStyle:contentPara,NSAttributedStringKey.foregroundColor:UIColor.init(red: 127/255.0, green: 127/255.0, blue: 127/255.0, alpha: 1)], range: NSMakeRange(0, (contentStr?.count)!))
        displayContent?.attributedText = contentAttri
        adaptHeightContent(contentAttri)
    }
    
    ///根据提示框内容自适应高度
    func adaptHeightContent(_ contentAttri:NSAttributedString) {
        var height = contentAttri.boundingRect(with:CGSize.init(width: _k_w - 40, height: UIScreen.main.bounds.size.height), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.RawValue(UInt8(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue) | UInt8(NSStringDrawingOptions.usesFontLeading.rawValue))), context: nil).height + 30
        height  = height < 150.0 ? 150.0 : height
        if UI_IS_IPONE5 {
            height = 150
        }
        displayContent?.snp.remakeConstraints({ (make) in
            make.top.equalTo((displayTitle?.snp.bottom)!).offset(8)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.height.equalTo(height)
        })
    }
    
    func addProtocolClick(_ protocolNames:[String])  {
        var protocolContent:String = "我已阅读并认可憨分"
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
    
    //协议列表点击事件
    @objc func protocolListClick(_ sender : UIButton){
        if delegate != nil {
            delegate?.protocolListClick(sender)
        }
    }
    
    //展开收回协议按钮
    @objc func arrowBtnClick(_ sender : UIButton){
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setImage(UIImage(named:"up_icon"), for: .normal)
            arrowDescLabel?.text = "收回"
        
            protocolListView?.isHidden = false
            
        }else{
            sender.setImage(UIImage(named:"down_icon"), for: .normal)
            arrowDescLabel?.text = "展开"
            protocolListView?.isHidden = true

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
    
    func setOldUpUI()  {
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
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
        
        displayContent = UITextView()
        displayContent?.font = UIFont.yx_boldSystemFont(ofSize: 14)
        displayContent?.textColor = UIColor.init(red: 127/255.0, green: 127/255.0, blue: 127/255.0, alpha: 1)
        displayContent?.backgroundColor = LOAN_APPLICATION_COLOR
        displayContent?.textAlignment  = NSTextAlignment.left
        displayContent?.isEditable = false
        displayContent?.isSelectable = false
//        displayContent?.numberOfLines = 0
        self.addSubview(displayContent!)
        displayContent?.snp.makeConstraints({ (make) in
            make.top.equalTo((displayTitle?.snp.bottom)!).offset(8)
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
        applyForBtn?.setTitle("提款", for: UIControlState.normal)
        applyForBtn?.addTarget(self, action: #selector(applyForBottonClick), for: UIControlEvents.touchUpInside)
        self.addSubview(applyForBtn!)
        applyForBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.bottom.equalTo(self.snp.bottom).offset(-15)
//            make.top.equalTo((protocolBackView?.snp.bottom)!).offset(5)
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
    
    func setUpUI()  {
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        protocolBackView = UIView.init()
        self.addSubview(protocolBackView!)
        protocolBackView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.top.equalTo(self).offset(20)
            make.height.equalTo(40)
        })
        
        applyForBtn = UIButton.init(type: UIButtonType.custom)
        applyForBtn?.setBackgroundImage(UIImage.init(named: "applicationBtn_Image"), for: UIControlState.normal)
        applyForBtn?.setTitle("提款", for: UIControlState.normal)
        applyForBtn?.addTarget(self, action: #selector(applyForBottonClick), for: UIControlEvents.touchUpInside)
        self.addSubview(applyForBtn!)
        applyForBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.bottom.equalTo(self.snp.bottom).offset(-150)
            //            make.top.equalTo((protocolBackView?.snp.bottom)!).offset(5)
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
    
    
    func createProtocolUI(array:[HgLoanProtoolListModel]) {
        
        arrowDescLabel = UILabel()
        arrowDescLabel?.text = "展开"
        arrowDescLabel?.textColor = HOME_ARROW_COLOR
        arrowDescLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        self.addSubview(arrowDescLabel!)
        arrowDescLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-30)
            make.top.equalTo((protocolLabel?.snp.top)!).offset(-10)
            make.height.equalTo(40)
        })
        
        let arrowBtn = UIButton()
        arrowBtn.setImage(UIImage.init(named: "down_icon"), for: .normal)
        arrowBtn.addTarget(self, action: #selector(arrowBtnClick(_:)), for: .touchUpInside)
        self.addSubview(arrowBtn)
        arrowBtn.snp.makeConstraints { (make) in
            make.right.equalTo((arrowDescLabel?.snp.left)!).offset(-5)
            make.top.equalTo((arrowDescLabel?.snp.top)!).offset(10)
        }
        
        protocolView(array: array)
        
    }
    
    func createProtocolBtn()->(UIButton){
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        btn.setTitleColor(UI_MAIN_COLOR, for: .normal)
        return btn
    }
    
    func protocolView(array:[HgLoanProtoolListModel]){
        
        protocolListView = UIView()
        protocolListView?.backgroundColor = .clear
        self.addSubview(protocolListView!)
        protocolListView?.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo((protocolLabel?.snp.bottom)!).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(array.count * 30)
//            make.height.equalTo(30)
        }
        
        for index in 0..<array.count{
            let model = array[index]
            
            let btn = createProtocolBtn()
            btn.setTitle(model.protocolName, for: .normal)
            btn.titleLabel?.textAlignment = .left
            btn.tag = index + 1
            btn.addTarget(self, action: #selector(protocolListClick(_:)), for: .touchUpInside)
            protocolListView?.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.left.equalTo((protocolListView?.snp.left)!).offset(40)
                make.top.equalTo((protocolListView?.snp.top)!).offset(index * 30)
            })
        }
    }
    
}


