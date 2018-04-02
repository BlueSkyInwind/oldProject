//
//  SuperLoanHeaderCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc protocol SuperLoanHeaderCellDelegate: NSObjectProtocol {
    
    //排序
    func sortBtnClick(_ sender: UIButton)
    //筛选
    
    func filterBtnClick(_ sender: UIButton)
}
class SuperLoanHeaderCell: UITableViewCell {

    @objc weak var delegate: SuperLoanHeaderCellDelegate?
    @objc var sortBtn : UIButton?
    @objc var filterBtn : UIButton?
    @objc var sortLabel : UILabel?
    @objc var filterLabel : UILabel?
    
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
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SuperLoanHeaderCell{
    fileprivate func setupUI(){
        
//        let sortImageView = UIImageView()
//        sortImageView.image = UIImage.init(named: "bg_icon")
//        self.addSubview(sortImageView)
//        sortImageView.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(0)
//            make.top.equalTo(self).offset(12)
//            make.width.equalTo(_k_w / 2)
//        }
        
//        let sortView = UIView()
//        sortView.backgroundColor = .clear
//        sortImageView.addSubview(sortView)
//        sortView.snp.makeConstraints { (make) in
//            make.centerX.equalTo(sortImageView.snp.centerX)
//            make.centerY.equalTo(sortImageView.snp.centerY)
//            make.height.equalTo(36)
//            make.width.equalTo(50)
//        }
        
        let sortBgView = UIView()
        sortBgView.backgroundColor = UIColor.white
        self.addSubview(sortBgView)
        sortBgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(12)
            make.width.equalTo(_k_w / 2)
            make.height.equalTo(36)
        }
        
        let sortView = UIView()
        sortView.backgroundColor = .clear
        sortBgView.addSubview(sortView)
        sortView.snp.makeConstraints { (make) in
            make.centerX.equalTo(sortBgView.snp.centerX)
            make.centerY.equalTo(sortBgView.snp.centerY)
            make.height.equalTo(36)
            make.width.equalTo(50)
        }
        
        sortLabel = UILabel()
        sortLabel?.text = "排序"
        sortLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        sortLabel?.textColor = TITLE_COLOR
        sortView.addSubview(sortLabel!)
        sortLabel?.snp.makeConstraints { (make) in
            make.left.equalTo(sortView.snp.left).offset(5)
            make.centerY.equalTo(sortView.snp.centerY)
        }
        
        sortBtn = UIButton()
        sortBtn?.setImage(UIImage.init(named: "sort_icon"), for: .normal)
        sortBtn?.addTarget(self, action: #selector(sortBtnClick(_:)), for: .touchUpInside)
        sortView.addSubview(sortBtn!)
        sortBtn?.snp.makeConstraints { (make) in
            make.right.equalTo(sortView.snp.right).offset(-5)
            make.centerY.equalTo(sortView.snp.centerY)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.black
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(22)
            make.width.equalTo(1)
        }
        
//        let filterImageView = UIImageView()
//        filterImageView.image = UIImage.init(named: "bg_icon")
//        self.addSubview(filterImageView)
//        filterImageView.snp.makeConstraints { (make) in
//            make.right.equalTo(self).offset(0)
//            make.top.equalTo(self).offset(12)
//            make.width.equalTo(_k_w / 2)
//        }
        
        let filterBgView = UIView()
        filterBgView.backgroundColor = UIColor.white
        self.addSubview(filterBgView)
        filterBgView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(12)
            make.width.equalTo(_k_w / 2)
            make.height.equalTo(36)
        }
        
        let filterView = UIView()
        filterView.backgroundColor = .clear
        filterBgView.addSubview(filterView)
        filterView.snp.makeConstraints { (make) in
            make.centerX.equalTo(filterBgView.snp.centerX)
            make.centerY.equalTo(filterBgView.snp.centerY)
            make.height.equalTo(36)
            make.width.equalTo(50)
        }
        
        filterLabel = UILabel()
        filterLabel?.text = "筛选"
        filterLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        filterLabel?.textColor = TITLE_COLOR
        filterView.addSubview(filterLabel!)
        filterLabel?.snp.makeConstraints { (make) in
            make.left.equalTo(filterView.snp.left).offset(5)
            make.centerY.equalTo(filterView.snp.centerY)
        }
        
        filterBtn = UIButton()
        filterBtn?.setImage(UIImage.init(named: "filter_icon"), for: .normal)
        filterBtn?.addTarget(self, action: #selector(filterBtnClick(_:)), for: .touchUpInside)
        filterView.addSubview(filterBtn!)
        filterBtn?.snp.makeConstraints { (make) in
            make.right.equalTo(filterView.snp.right).offset(-5)
            make.centerY.equalTo(filterView.snp.centerY)
        }
    }
}

extension SuperLoanHeaderCell{
    
    @objc fileprivate func sortBtnClick(_ sender : UIButton){
        if delegate != nil {
            
            delegate?.sortBtnClick(sender)
        }
    }
    
    @objc fileprivate func filterBtnClick(_ sender : UIButton){
        
        if delegate != nil {
            delegate?.filterBtnClick(sender)
        }
    }
}
