//
//  IntermediateCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/7.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit


@objc protocol IntermediateCellDelegate: NSObjectProtocol {
    //发送验证码
    func bottomBtnClick()
}

class IntermediateCell: UITableViewCell {

    @objc weak var delegate: IntermediateCellDelegate?
    
    @objc var type : String?{
        didSet(newValue){
            
            setCellType(type: type!)
        }
    }
    
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
        
        type = "1"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IntermediateCell {
    fileprivate func setCellType(type : String){
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        let type = Int(type)
        switch type {
        case 1?:
            openAccountCell()
        case 2?:
            failureCell()
        case .none:
            break
        case .some(_):
            break
        }
    }
}

extension IntermediateCell{
    
    fileprivate func openAccountCell(){
        
        let refreshView = UIView()
        refreshView.backgroundColor = UIColor.clear
        self.addSubview(refreshView)
        refreshView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(95)
            make.height.equalTo(20)
        }
        
        let refreshImageView = UIImageView()
        refreshImageView.image = UIImage.init(named: "refresh_icon")
        refreshView.addSubview(refreshImageView)
        refreshImageView.snp.makeConstraints { (make) in
            make.left.equalTo(refreshView.snp.left).offset(5)
            make.centerY.equalTo(refreshView.snp.centerY)
            make.height.equalTo(17)
        }
        
        let refreshTitleLabel = UILabel()
        refreshTitleLabel.text = "下拉可刷新"
        refreshTitleLabel.font = UIFont.yx_systemFont(ofSize: 12)
        refreshTitleLabel.textColor = REFRESH_TITLE_COLOR
        refreshView.addSubview(refreshTitleLabel)
        refreshTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(refreshImageView.snp.right).offset(5)
            make.centerY.equalTo(refreshView.snp.centerY)
            make.height.equalTo(20)
        }
        
        let y_location = (_k_h - 40 - 200 - 135) / 2 + 40
        
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "wait_icon")
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self).offset(y_location)
        }
        
        let tipLabel = UILabel()
        tipLabel.text = "开户中，请耐心等待"
        tipLabel.font = UIFont.yx_systemFont(ofSize: 17)
        tipLabel.textColor = UIColor.black
        self.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(39)
        }
        
        let bottomBtn = UIButton()
        bottomBtn.setTitle("返回首页", for: .normal)
        bottomBtn.setBackgroundImage(UIImage.init(named: "applayBtnImage"), for: .normal)
        bottomBtn.setTitleColor(UIColor.white, for: .normal)
        bottomBtn.titleLabel?.font = UIFont.yx_systemFont(ofSize: 17)
        bottomBtn.addTarget(self, action: #selector(bottomBtnClick), for: .touchUpInside)
        self.addSubview(bottomBtn)
        bottomBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-150)
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).offset(-30)
        }
    }
    
    fileprivate func failureCell(){
        
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "failure_icon")
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self).offset(102)
        }
        
        let tipLabel = UILabel()
        tipLabel.text = "开户失败"
        tipLabel.font = UIFont.yx_systemFont(ofSize: 17)
        tipLabel.textColor = UIColor.black
        self.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(50)
        }
        
        let tipLabel1 = UILabel()
        tipLabel1.textColor = UIColor.black
        tipLabel1.text = "正为您跳转页面，重新开户..."
        tipLabel1.font = UIFont.yx_systemFont(ofSize: 15)
        self.addSubview(tipLabel1)
        tipLabel1.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(tipLabel.snp.bottom).offset(32)
        }
    }
}
extension IntermediateCell{
    
    @objc fileprivate func bottomBtnClick(){
        if delegate != nil{
            delegate?.bottomBtnClick()
        }
    }
}
