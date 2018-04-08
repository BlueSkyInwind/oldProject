//
//  SuperLoanHeaderView.swift
//  fxdProduct
//
//  Created by sxp on 2018/4/8.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class SuperLoanHeaderView: UIView {

    
    @objc var sdCycleScrollview : SDCycleScrollView?
    
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SuperLoanHeaderView{
    fileprivate func setupUI(){
        
        let hotRecommendationView = UIView()
        hotRecommendationView.backgroundColor = UIColor.white
        self.addSubview(hotRecommendationView)
        hotRecommendationView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(14)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(135)
        }
        
        let hotLineView = UIView()
        hotLineView.backgroundColor = UI_MAIN_COLOR
        hotRecommendationView.addSubview(hotLineView)
        hotLineView.snp.makeConstraints { (make) in
            make.left.equalTo(hotRecommendationView.snp.left).offset(20)
            make.top.equalTo(hotRecommendationView.snp.top).offset(20)
            make.height.equalTo(16)
            make.width.equalTo(3)
        }
        
        let hotTitleLabel = UILabel()
        hotTitleLabel.text = "热门推荐"
        hotTitleLabel.font = UIFont.yx_systemFont(ofSize: 16)
        hotTitleLabel.textColor = TITLE_COLOR
        hotRecommendationView.addSubview(hotTitleLabel)
        hotTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(hotLineView.snp.right).offset(7)
            make.top.equalTo(hotLineView.snp.top).offset(0)
        }
        
        sdCycleScrollview = SDCycleScrollView()
        sdCycleScrollview?.isUserInteractionEnabled = false
        sdCycleScrollview?.onlyDisplayText = true
        sdCycleScrollview?.titleLabelBackgroundColor = UIColor.white
        sdCycleScrollview?.titleLabelTextColor = RedPacket_COLOR
        sdCycleScrollview?.scrollDirection = .vertical
        sdCycleScrollview?.titleLabelTextFont = UIFont.yx_systemFont(ofSize: 12)
        hotRecommendationView.addSubview(sdCycleScrollview!)
        sdCycleScrollview?.snp.makeConstraints({ (make) in
            make.left.equalTo(hotRecommendationView.snp.left).offset(20)
            make.top.equalTo(hotTitleLabel.snp.bottom).offset(10)
            make.height.equalTo(80)
            make.right.equalTo(hotRecommendationView.snp.right).offset(-20)
        })
        
        let recentView = UIView()
        recentView.backgroundColor = UIColor.white
        self.addSubview(recentView)
        recentView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(hotRecommendationView.snp.bottom).offset(13)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(40)
        }
        let recentLineView = UIView()
        recentLineView.backgroundColor = UI_MAIN_COLOR
        recentView.addSubview(recentLineView)
        recentLineView.snp.makeConstraints { (make) in
            make.left.equalTo(recentView.snp.left).offset(20)
            make.centerY.equalTo(recentView.snp.centerY)
            make.height.equalTo(16)
            make.width.equalTo(3)
        }
        
        let recentTitle = UILabel()
        recentTitle.text = "最近使用"
        recentTitle.font = UIFont.yx_systemFont(ofSize: 16)
        recentTitle.textColor = TITLE_COLOR
        recentView.addSubview(recentTitle)
        recentTitle.snp.makeConstraints { (make) in
            make.left.equalTo(recentLineView.snp.right).offset(7)
            make.top.equalTo(recentLineView.snp.top).offset(0)
        }
        
    }
}
