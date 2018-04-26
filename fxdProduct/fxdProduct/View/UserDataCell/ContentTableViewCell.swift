//
//  ContentTableViewCell.swift
//  fxdProduct
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

typealias ArrowImageBtnClick = (_ button:UIButton) -> Void
class ContentTableViewCell: UITableViewCell{

    @objc var titleLabel : UILabel?
    @objc var promptLabel : UILabel?
    @objc  var contentTextField : YX_TextField?
    @objc var arrowsImageBtn : UIButton?
    @objc var lineView : UIView?
    @objc var btnClick : ArrowImageBtnClick?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func arrowImageBtnClick(sender:UIButton) -> Void {
        if btnClick != nil {
            btnClick!(sender)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ContentTableViewCell {
    
    fileprivate func setupUI (){
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel?.textAlignment = NSTextAlignment.left
        titleLabel?.textColor = UIColor.init(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(100)
            make.height.equalTo(21)
            make.left.equalTo(20)
        })
        
        arrowsImageBtn = UIButton.init(type: UIButtonType.custom)
        arrowsImageBtn?.setBackgroundImage(UIImage.init(named: "icon_arrowRight"), for: UIControlState.normal)
        arrowsImageBtn?.addTarget(self, action: #selector(arrowImageBtnClick(sender:)), for: UIControlEvents.touchUpInside)
        self.addSubview(arrowsImageBtn!)
        arrowsImageBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(15)
            make.height.equalTo((arrowsImageBtn?.snp.width)!).multipliedBy(1)
            make.right.equalTo(self.snp.right).offset(-10)
        })
        
        contentTextField = YX_TextField()
        contentTextField?.font = UIFont.systemFont(ofSize: 14)
        contentTextField?.textColor = UIColor.init(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        contentTextField?.addTarget(self, action: #selector(textFieldChanged(textField:)), for: UIControlEvents.editingChanged)
        self.addSubview(contentTextField!)
        contentTextField?.snp.makeConstraints({ (make) in
            make.left.equalTo((titleLabel?.snp.right)!)
            make.right.equalTo((arrowsImageBtn?.snp.left)!)
            make.top.equalTo(self.snp.top).offset(5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        })
        
        promptLabel = UILabel()
        promptLabel?.font = UIFont.systemFont(ofSize: 14)
        promptLabel?.textColor = UIColor.init(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        promptLabel?.isHidden = true
        self.addSubview(promptLabel!)
        promptLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo((arrowsImageBtn?.snp.left)!).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(60)
            make.height.equalTo(21)
        })
        
        lineView = UIView()
        lineView?.backgroundColor = PayPasswordBackColor_COLOR
        lineView?.isHidden = true
        self.addSubview(lineView!)
        lineView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        })
    }
    
    // 选择联系人按钮位置
   @objc func  updateConatctImageBtnLayout() {
        arrowsImageBtn?.snp.remakeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(32)
            make.width.equalTo((arrowsImageBtn?.snp.height)!).multipliedBy(0.78)
            make.right.equalTo(self.snp.right).offset(-10)
        })
    }
    
    // 选择银行卡扫描按钮位置
   @objc func  updateScanCardImageBtnLayout() {
        arrowsImageBtn?.snp.remakeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(20)
            make.width.equalTo((arrowsImageBtn?.snp.height)!).multipliedBy(1.3)
            make.right.equalTo(self.snp.right).offset(-10)
        })
    }
    
    // 发送验证码
   @objc func  updateVerfiyCodeImageBtnLayout() {
        arrowsImageBtn?.layer.cornerRadius = 15
        arrowsImageBtn?.clipsToBounds = true
        arrowsImageBtn?.backgroundColor = UI_MAIN_COLOR
        arrowsImageBtn?.setBackgroundImage(nil, for: UIControlState.normal)
        arrowsImageBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        arrowsImageBtn?.snp.remakeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo((arrowsImageBtn?.snp.height)!).multipliedBy(3.37)
            make.right.equalTo(self.snp.right).offset(-10)
        })
    }
    
    // 星号
    @objc func  updateStarLabelLayout() {
        let starLabel = UILabel()
        starLabel.font = UIFont.boldSystemFont(ofSize: 15)
        starLabel.textAlignment = NSTextAlignment.left
        starLabel.text = "*"
        starLabel.textColor = UIColor.red
        self.addSubview(starLabel)
        starLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo((titleLabel?.snp.left)!).offset(-3)
        })
    }
    
   @objc func updateTitleLabelLayout() -> Void {
        titleLabel?.snp.updateConstraints({ (make) in
            make.width.equalTo(120)
        })
    }
    
    @objc func textFieldChanged(textField:UITextField) -> Void {
        promptLabel?.isHidden = true
    }
}











