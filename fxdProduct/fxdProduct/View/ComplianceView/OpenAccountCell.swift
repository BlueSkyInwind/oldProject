//
//  OpenAccountCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc protocol OpenAccountCellDelegate: NSObjectProtocol {
    //发送验证码
    func codeBtnClick(sender: UIButton)
}
class OpenAccountCell: UITableViewCell {

    var titleLabel : UILabel?
    var contentLabel : UILabel?
    var rightBtn : UIButton?
    var verificationCodeBtn : UIButton?
    var lineView : UIView?
    var contentTextField : UITextField?
    
    @objc weak var delegate: OpenAccountCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension OpenAccountCell{
    
    fileprivate func setUpUI() {
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        titleLabel?.textColor = TITLE_COLOR
        titleLabel?.textAlignment = .left
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(22)
            make.centerY.equalTo(self.snp.centerY)
        })
        
//        contentLabel = UILabel()
//        contentLabel?.font = UIFont.yx_systemFont(ofSize: 14)
//        contentLabel?.textColor = RedPacket_COLOR
//        contentLabel?.textAlignment = .left
//        self.addSubview(contentLabel!)
//        contentLabel?.snp.makeConstraints({ (make) in
//            make.left.equalTo(self).offset(145)
//            make.centerY.equalTo(self.snp.centerY)
//        })
        
        contentTextField = UITextField()
        contentTextField?.font = UIFont.yx_systemFont(ofSize: 14)
        contentTextField?.textColor = RedPacket_COLOR
        contentTextField?.isEnabled = false
        contentTextField?.textAlignment = .left
        self.addSubview(contentTextField!)
        contentTextField?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(145)
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self).offset(-40)
        })
        
        rightBtn = UIButton()
        rightBtn?.isHidden = true
        rightBtn?.setImage(UIImage.init(named: "cell_Icon_Image"), for: .normal)
        rightBtn?.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
        self.addSubview(rightBtn!)
        rightBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        verificationCodeBtn = UIButton()
        verificationCodeBtn?.isHidden = true
        verificationCodeBtn?.setTitle("发送验证码", for: .normal)
        verificationCodeBtn?.setBackgroundImage(UIImage.init(named: "code_icon"), for: .normal)
        verificationCodeBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        verificationCodeBtn?.setTitleColor(UIColor.white, for: .normal)
        verificationCodeBtn?.addTarget(self, action: #selector(codeClick), for: .touchUpInside)
        self.addSubview(verificationCodeBtn!)
        verificationCodeBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(30)
        })
        
        lineView = UIView()
        lineView?.backgroundColor = TIME_COLOR
        self.addSubview(lineView!)
        lineView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(19)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        })
    }
}
extension OpenAccountCell{
    @objc fileprivate func rightBtnClick(){
        
    }
    
    @objc fileprivate func codeClick(){
        if delegate != nil {
            delegate?.codeBtnClick(sender: verificationCodeBtn!)
        }
    }
}
