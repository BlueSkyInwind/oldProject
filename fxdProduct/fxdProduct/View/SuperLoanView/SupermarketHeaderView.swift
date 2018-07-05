//
//  SupermarketHeaderView.swift
//  fxdProduct
//
//  Created by sxp on 2018/5/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc protocol SupermarketHeaderViewDelegate: NSObjectProtocol {
    
    //排序
    func sortBtnClick(_ sender: UIButton)
    //筛选
    func filterBtnClick(_ sender: UIButton)
    
}

class SupermarketHeaderView: UIView {

    @objc weak var delegate: SupermarketHeaderViewDelegate?
    @objc var sortImageBtn : UIButton?
    @objc var filterImageBtn : UIButton?
    @objc var sortBtn : UIButton?
    @objc var filterBtn : UIButton?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    convenience init(_ frame: CGRect) {
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SupermarketHeaderView{
    fileprivate func setupUI(){
        let sortBgView = UIView()
        sortBgView.backgroundColor = UIColor.white
        self.addSubview(sortBgView)
        sortBgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.width.equalTo(_k_w / 2)
            make.height.equalTo(45)
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
        
        sortBtn = UIButton()
        sortBtn?.setTitle("排序", for: .normal)
        sortBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        sortBtn?.setTitleColor(TITLE_COLOR, for: .normal)
        sortBtn?.addTarget(self, action: #selector(sortBtnClick(_:)), for: .touchUpInside)
        sortView.addSubview(sortBtn!)
        sortBtn?.snp.makeConstraints { (make) in
            make.left.equalTo(sortView.snp.left).offset(5)
            make.centerY.equalTo(sortView.snp.centerY)
        }
        
        sortImageBtn = UIButton()
        sortImageBtn?.setImage(UIImage.init(named: "sort_icon"), for: .normal)
        sortImageBtn?.addTarget(self, action: #selector(sortBtnClick(_:)), for: .touchUpInside)
        sortView.addSubview(sortImageBtn!)
        sortImageBtn?.snp.makeConstraints { (make) in
            make.right.equalTo(sortView.snp.right).offset(10)
            make.centerY.equalTo(sortView.snp.centerY)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.black
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(sortBgView.snp.centerY)
            make.height.equalTo(22)
            make.width.equalTo(1)
        }
        
        let filterBgView = UIView()
        filterBgView.isUserInteractionEnabled = true
        filterBgView.backgroundColor = UIColor.white
        self.addSubview(filterBgView)
        filterBgView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.width.equalTo(_k_w / 2)
            make.height.equalTo(45)
        }
        
        let filterView = UIView()
        filterView.isUserInteractionEnabled = true
        filterView.backgroundColor = .clear
        filterBgView.addSubview(filterView)
        filterView.snp.makeConstraints { (make) in
            make.centerX.equalTo(filterBgView.snp.centerX)
            make.centerY.equalTo(filterBgView.snp.centerY)
            make.height.equalTo(36)
            make.width.equalTo(50)
        }
        
        filterBtn = UIButton()
        filterBtn?.setTitleColor(TITLE_COLOR, for: .normal)
        filterBtn?.setTitle("筛选", for: .normal)
        filterBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        filterBtn?.addTarget(self, action: #selector(filterBtnClick(_:)), for: .touchUpInside)
        filterView.addSubview(filterBtn!)
        filterBtn?.snp.makeConstraints { (make) in
            make.left.equalTo(filterView.snp.left).offset(5)
            make.centerY.equalTo(filterView.snp.centerY)
        }
        
        filterImageBtn = UIButton()
        filterImageBtn?.setImage(UIImage.init(named: "filter_icon"), for: .normal)
        filterImageBtn?.addTarget(self, action: #selector(filterBtnClick(_:)), for: .touchUpInside)
        filterView.addSubview(filterImageBtn!)
        filterImageBtn?.snp.makeConstraints { (make) in
            make.right.equalTo(filterView.snp.right).offset(10)
            make.centerY.equalTo(filterView.snp.centerY)
        }
        
        let bottomLineView = UIView()
        bottomLineView.backgroundColor = LINE_COLOR
        bottomLineView.isHidden = true
        self.addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        })
    }
}

extension SupermarketHeaderView{
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
