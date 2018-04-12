//
//  SuperLoanHeaderView.swift
//  fxdProduct
//
//  Created by sxp on 2018/4/8.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc protocol SuperLoanHeaderViewDelegate: NSObjectProtocol {
    
    //热门推荐
    func hotBtnClick(_ sender: UIButton)
    //最近使用
    func recentBtnClcik(_ sender: UIButton)
    //更多按钮
    func moreBtnClcik()

}

class SuperLoanHeaderView: UIView {

    @objc weak var delegate: SuperLoanHeaderViewDelegate?
    var scrollView : UIScrollView?
    var recentView : UIView?
//    @objc var recentImageNameArray : NSArray?
    @objc var hotImageNameArray : NSArray?{
        
        didSet(newValue){
            
            changeHotImageView()
        }
    }
    
    @objc var recentImageNameArray : NSArray?{
        
        didSet(newValue){
            
            changerecentImageView()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        recentImageNameArray = NSMutableArray()
        hotImageNameArray = NSMutableArray()
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
            make.top.equalTo(hotRecommendationView.snp.top).offset(10)
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
        
        scrollView = UIScrollView()
        scrollView?.showsHorizontalScrollIndicator = false
        
        scrollView?.contentSize = CGSize(width: 120 * (hotImageNameArray?.count)! + 20 * ((hotImageNameArray?.count)! - 1) ,height: 80)
        hotRecommendationView.addSubview(scrollView!)
        scrollView?.snp.makeConstraints { (make) in
            make.left.equalTo(hotRecommendationView.snp.left).offset(20)
            make.top.equalTo(hotTitleLabel.snp.bottom).offset(10)
            make.height.equalTo(80)
            make.right.equalTo(hotRecommendationView.snp.right).offset(-20)
        }
        
//        for index in 0..<(hotImageNameArray?.count)! {
//            let btn = UIButton()
//            btn.tag = 101 + index
//            let model = hotImageNameArray![index] as! HotRecommendModel
//            let url = URL(string: model.plantLogo)
//            btn.sd_setImage(with: url, for: .normal, placeholderImage: UIImage.init(named: "placeholderImage_Icon"), options: .refreshCached, completed: { (uiimage, erroe, cachType, url) in
//
//            })
//            btn.addTarget(self, action: #selector(hotBtnClick(_:)), for: .touchUpInside)
//            scrollView?.addSubview(btn)
//            btn.snp.makeConstraints({ (make) in
//                make.left.equalTo((scrollView?.snp.left)!).offset(index * 140)
//                make.top.equalTo((scrollView?.snp.top)!).offset(0)
//                make.width.equalTo(120)
//                make.height.equalTo(80)
//            })
//        }
        
        
        recentView = UIView()
        recentView?.backgroundColor = UIColor.white
        self.addSubview(recentView!)
        recentView?.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(hotRecommendationView.snp.bottom).offset(13)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(40)
        }
        let recentLineView = UIView()
        recentLineView.backgroundColor = UI_MAIN_COLOR
        recentView?.addSubview(recentLineView)
        recentLineView.snp.makeConstraints { (make) in
            make.left.equalTo((recentView?.snp.left)!).offset(20)
            make.centerY.equalTo((recentView?.snp.centerY)!)
            make.height.equalTo(16)
            make.width.equalTo(3)
        }
        
        let recentTitle = UILabel()
        recentTitle.text = "最近使用"
        recentTitle.font = UIFont.yx_systemFont(ofSize: 16)
        recentTitle.textColor = TITLE_COLOR
        recentView?.addSubview(recentTitle)
        recentTitle.snp.makeConstraints { (make) in
            make.left.equalTo(recentLineView.snp.right).offset(7)
            make.top.equalTo(recentLineView.snp.top).offset(0)
        }
        
//        for index in 0..<(recentImageNameArray?.count)! {
//            let btn = UIButton()
//            btn.tag = 101 + index
//            btn.layer.cornerRadius = 5.0
//            if index > (recentImageNameArray?.count)! - 1{
//                btn.setImage(UIImage.init(named: "btn_image_icon"), for: .normal)
//            }else{
//
//                let url = URL(string: recentImageNameArray![index] as! String)
//                btn.sd_setImage(with: url, for: .normal, placeholderImage: UIImage.init(named: "placeholderImage_Icon"), options: .refreshCached, completed: { (uiimage, erroe, cachType, url) in
//
//                })
//            }
//            btn.addTarget(self, action:#selector(recentBtnClcik(_:)), for: .touchUpInside)
//            recentView?.addSubview(btn)
//            btn.snp.makeConstraints({ (make) in
//                make.left.equalTo(recentTitle.snp.right).offset(17 + 34 * index)
//                make.centerY.equalTo((recentView?.snp.centerY)!)
//                make.height.equalTo(24)
//                make.width.equalTo(24)
//            })
//
//        }
        
        
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage.init(named: "more_btn_icon"), for: .normal)
        rightBtn.addTarget(self, action: #selector(moreBtnClcik), for: .touchUpInside)
        recentView?.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalTo((recentView?.snp.right)!).offset(-20)
            make.centerY.equalTo((recentView?.snp.centerY)!)
        }
        
        let moreBtn = UIButton()
        moreBtn.setTitle("更多", for: .normal)
        moreBtn.setTitleColor(UI_MAIN_COLOR, for: .normal)
        moreBtn.titleLabel?.font = UIFont.yx_systemFont(ofSize: 15)
        moreBtn.addTarget(self, action: #selector(moreBtnClcik), for: .touchUpInside)
        recentView?.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(rightBtn.snp.left).offset(-8)
            make.centerY.equalTo((recentView?.snp.centerY)!)
        }
        
        let label = UILabel()
        label.text = "..."
        label.textColor = TITLE_COLOR
        label.font = UIFont.yx_systemFont(ofSize: 15)
        recentView?.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.right.equalTo(moreBtn.snp.left).offset(-14)
            make.top.equalTo((recentView?.snp.top)!).offset(8)
        }
    }
}

extension SuperLoanHeaderView{
    
    @objc fileprivate func recentBtnClcik(_ sender : UIButton){
        
        if delegate != nil {
            delegate?.recentBtnClcik(sender)
        }
    }
    
    @objc fileprivate func moreBtnClcik(){
        
        if delegate != nil {
            delegate?.moreBtnClcik()
        }
    }
    
    @objc fileprivate func hotBtnClick(_ sender : UIButton){
        
        if delegate != nil {
            delegate?.hotBtnClick(sender)
        }
    }
    
    override var  frame:(CGRect){
        
        didSet{
            
            let newFrame = CGRect(x:0,y:0,width:_k_w,height:215)
            super.frame = newFrame
            
        }
    }
    
    fileprivate func changeHotImageView(){
        
        scrollView?.contentSize = CGSize(width: 120 * (hotImageNameArray?.count)! + 20 * ((hotImageNameArray?.count)! - 1) ,height: 80)
        for index in 0..<(hotImageNameArray?.count)! {
            let btn = UIButton()
            btn.tag = 101 + index
            let model = hotImageNameArray![index] as! HotRecommendModel
            let url = URL(string: model.plantLogo)
            btn.sd_setImage(with: url, for: .normal, placeholderImage: UIImage.init(named: "placeholderImage_Icon"), options: .refreshCached, completed: { (uiimage, erroe, cachType, url) in
                
            })
            btn.addTarget(self, action: #selector(hotBtnClick(_:)), for: .touchUpInside)
            scrollView?.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.left.equalTo((scrollView?.snp.left)!).offset(index * 140)
                make.top.equalTo((scrollView?.snp.top)!).offset(0)
                make.width.equalTo(120)
                make.height.equalTo(80)
            })
        }
    }
    
    fileprivate func changerecentImageView(){
        
        for index in 0..<5 {
            let btn = UIButton()
            btn.tag = 101 + index
            btn.layer.cornerRadius = 5.0
            if index > (recentImageNameArray?.count)! - 1{
                btn.setImage(UIImage.init(named: "btn_image_icon"), for: .normal)
            }else{

                let model = recentImageNameArray![index] as! HotRecommendModel
                let url = URL(string: model.plantLogo)
                btn.sd_setImage(with: url, for: .normal, placeholderImage: UIImage.init(named: "placeholderImage_Icon"), options: .refreshCached, completed: { (uiimage, erroe, cachType, url) in

                })
            }
            btn.addTarget(self, action:#selector(recentBtnClcik(_:)), for: .touchUpInside)
            recentView?.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.left.equalTo((recentView?.snp.left)!).offset(108 + 34 * index)
                make.centerY.equalTo((recentView?.snp.centerY)!)
                make.height.equalTo(24)
                make.width.equalTo(24)
            })
            
        }
    }
}
