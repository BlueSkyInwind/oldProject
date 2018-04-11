//
//  SuperLoanCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/27.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc protocol SuperLoanCellDelegate: NSObjectProtocol {
 
    //收藏
    func collectionBtn(_ sender: UIButton)
}

class SuperLoanCell: UITableViewCell {

    
    //左边的图片
    @objc var leftImageView : UIImageView?
    //标题
    @objc var titleLabel: UILabel?
    //额度
    @objc var qutaLabel: UILabel?
    //期限
    @objc var termLabel: UILabel?
    //费用
    @objc var feeLabel: UILabel?
    //描述
    @objc var descBtn : UIButton?
    //收藏
    @objc var collectionBtn : UIButton?
    @objc var lineView : UIView?
    
    
    @objc weak var delegate: SuperLoanCellDelegate?
    
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
        setupUI()
        type = "1"
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SuperLoanCell{
    fileprivate func setCellType(type : String){
        
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let type = Int(type)
        switch type {
        case 1?:
            setupUI()
        case 2?,3?:
            gameCell()
        case .none:
            break
        case .some(_):
            break
        }
    }
}

extension SuperLoanCell{
    
    //贷款cell
    fileprivate func setupUI(){
        
        leftImageView = UIImageView()
        self.contentView.addSubview(leftImageView!)
        leftImageView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self).offset(25)
            make.width.equalTo(57)
            make.height.equalTo(57)
        })
        
        titleLabel = UILabel()
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(20)
            make.left.equalTo((leftImageView?.snp.right)!).offset(20)
            make.height.equalTo(20)
        })
        qutaLabel = UILabel()
        qutaLabel?.textColor = RedPacket_COLOR
        qutaLabel?.font = UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(qutaLabel!)
        qutaLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(20)
            make.left.equalTo((titleLabel?.snp.left)!).offset(100)
            make.height.equalTo(20)
        })
        
        termLabel = UILabel()
        termLabel?.textColor = RedPacket_COLOR
        termLabel?.font = UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(termLabel!)
        termLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(5)
            make.left.equalTo((leftImageView?.snp.right)!).offset(20)
            make.height.equalTo(15)
        })
        
        feeLabel = UILabel()
        feeLabel?.textColor = RedPacket_COLOR
        feeLabel?.font = UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(feeLabel!)
        feeLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((qutaLabel?.snp.bottom)!).offset(5)
            make.left.equalTo((qutaLabel?.snp.left)!).offset(0)
            make.height.equalTo(15)
        })
        
        descBtn = UIButton()
        descBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        descBtn?.setTitleColor(UIColor.red, for: .normal)
        descBtn?.layer.borderWidth = 1.0
        descBtn?.layer.cornerRadius = 10.0
        
        self.contentView.addSubview(descBtn!)
        descBtn?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self).offset(-15)
            make.left.equalTo((leftImageView?.snp.right)!).offset(20)
            make.height.equalTo(20)
            make.width.equalTo(150)
        })
        
        
        collectionBtn = UIButton()
        collectionBtn?.setImage(UIImage.init(named: "collection_icon"), for: .normal)
        collectionBtn?.addTarget(self, action: #selector(collectionBtnClick(_:)), for: .touchUpInside)
        self.contentView.addSubview(collectionBtn!)
        collectionBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self).offset(-20)
        })
        
        lineView = UIView()
        lineView?.backgroundColor = TERM_COLOR
        lineView?.isHidden = false
        self.contentView.addSubview(lineView!)
        lineView?.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        }
        
        if UI_IS_IPONE5 {
            collectionBtn?.snp.updateConstraints({ (make) in
                
                make.right.equalTo(self).offset(-10)
            })
        }
    }
   
    //旅游，游戏cell
    fileprivate func gameCell(){
        
        leftImageView = UIImageView()
        self.contentView.addSubview(leftImageView!)
        leftImageView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self).offset(25)
            make.width.equalTo(57)
            make.height.equalTo(57)
        })
        
        titleLabel = UILabel()
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo((leftImageView?.snp.right)!).offset(20)
            make.height.equalTo(20)
        })
        
        descBtn = UIButton()
        descBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        descBtn?.setTitleColor(UIColor.red, for: .normal)
        descBtn?.layer.borderWidth = 1.0
        descBtn?.layer.cornerRadius = 10.0
        self.contentView.addSubview(descBtn!)
        descBtn?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self).offset(-15)
            make.left.equalTo((leftImageView?.snp.right)!).offset(20)
            make.height.equalTo(20)
//            make.width.equalTo(30)
        })
        
        
        collectionBtn = UIButton()
        collectionBtn?.setImage(UIImage.init(named: "collection_icon"), for: .normal)
        collectionBtn?.addTarget(self, action: #selector(collectionBtnClick(_:)), for: .touchUpInside)
        self.contentView.addSubview(collectionBtn!)
        collectionBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self).offset(-20)
        })
        
        lineView = UIView()
        lineView?.backgroundColor = TERM_COLOR
        lineView?.isHidden = false
        self.contentView.addSubview(lineView!)
        lineView?.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        }
        
    }
    
    @objc fileprivate func collectionBtnClick(_ sender : UIButton){
        
        if delegate != nil{
            delegate?.collectionBtn(sender)
        }
    }
}

