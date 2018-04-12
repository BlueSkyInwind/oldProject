//
//  MineHeaderView.swift
//  fxdProduct
//
//  Created by sxp on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit


@objc protocol MineHeaderViewDelegate: NSObjectProtocol {
    
    //
    func shadowImageViewClick()
    func memberBtnClick()
    
    
}
class MineHeaderView: UIView {

    //用户名字
   @objc var nameLabel : UILabel?
    //用户账号
   @objc var accountLabel : UILabel?

    //最左边的等级图片
   @objc var leftImageView : UIImageView?
    
    var bgImageView : UIImageView?
    
//   @objc var isFirstLevel : String?{
//        didSet(newValue){
//
//            changeLeftImageViewLocation()
//
//        }
//    }
    
    @objc weak var delegate: MineHeaderViewDelegate?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupUI()
//        isFirstLevel = "1"
        setupNewUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MineHeaderView{

    fileprivate func setupUI(){
    
        //左边图片
        let leftImage = UIImageView()
        leftImage.image = UIImage(named:"icon_my_logo")
        self.addSubview(leftImage)
        leftImage.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-20)
        }
        
        //上面的名字
        let headLabel = UILabel()
        headLabel.text = "我的"
        headLabel.textColor = UIColor.white
        headLabel.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(headLabel)
        headLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(35)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(20)
        }
        
        //用户的名字
        nameLabel = UILabel()
        nameLabel?.textColor = UIColor.white
        nameLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(90)
            make.left.equalTo(leftImage.snp.right).offset(30)
            make.height.equalTo(15)
        })
        //用户的账号
        accountLabel = UILabel()
        accountLabel?.textColor = UIColor.white
        accountLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(accountLabel!)
        accountLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((nameLabel?.snp.bottom)!).offset(10)
            make.left.equalTo(leftImage.snp.right).offset(30)
            make.height.equalTo(15)
        })
        
    }
    
//    fileprivate func setupNewUI(){
//
//        bgImageView = UIImageView()
//        bgImageView?.image = UIImage(named:"kongbai")
//        self.addSubview(bgImageView!)
//        bgImageView?.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(30)
//            make.bottom.equalTo(self).offset(-15)
//        }
//
//        leftImageView = UIImageView()
//        self.addSubview(leftImageView!)
//        leftImageView?.snp.makeConstraints({ (make) in
//
//            make.centerX.equalTo((bgImageView?.snp.centerX)!)
//            make.top.equalTo((bgImageView?.snp.top)!).offset(5)
//            make.width.equalTo(67)
//            make.height.equalTo(67)
//        })
//
//        accountLabel = UILabel()
//        accountLabel?.textColor = UIColor.white
//        accountLabel?.font = UIFont.systemFont(ofSize: 14)
//        self.addSubview(accountLabel!)
//        accountLabel?.snp.makeConstraints({ (make) in
//            make.left.equalTo((leftImageView?.snp.right)!).offset(57)
//            make.top.equalTo(self).offset(52)
//            make.height.equalTo(20)
//        })
//
//        if UI_IS_IPONE6P {
//            accountLabel?.snp.updateConstraints({ (make) in
//                make.top.equalTo(self).offset(82)
//            })
//        }
//        let shadowImageView = UIImageView()
//        shadowImageView.isUserInteractionEnabled = true
//        let tapGest = UITapGestureRecognizer(target: self, action: #selector(clickFirstView(_:)))
//        shadowImageView.addGestureRecognizer(tapGest)
//        shadowImageView.image = UIImage(named:"levelshadow")
//        self.addSubview(shadowImageView)
//        shadowImageView.snp.makeConstraints { (make) in
//            make.left.equalTo((leftImageView?.snp.right)!).offset(57)
//            make.top.equalTo((accountLabel?.snp.bottom)!).offset(15)
//        }
//
//        nameLabel = UILabel()
//        nameLabel?.textColor = UIColor.white
//        nameLabel?.font = UIFont.systemFont(ofSize: 14)
//        shadowImageView.addSubview(nameLabel!)
//        nameLabel?.snp.makeConstraints({ (make) in
//            make.left.equalTo(shadowImageView.snp.left).offset(11)
//            make.centerY.equalTo(shadowImageView.snp.centerY)
//            make.height.equalTo(20)
//        })
//
//        let rightImageView = UIImageView()
//        rightImageView.image = UIImage(named:"arrow")
//        shadowImageView.addSubview(rightImageView)
//        rightImageView.snp.makeConstraints { (make) in
//            make.right.equalTo(shadowImageView.snp.right).offset(-7)
//            make.centerY.equalTo(shadowImageView.snp.centerY)
//        }
//    }
    
    fileprivate func setupNewUI(){
        
//        bgImageView = UIImageView()
//        bgImageView?.image = UIImage(named:"kongbai")
//        self.addSubview(bgImageView!)
//        bgImageView?.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(30)
//            make.bottom.equalTo(self).offset(-15)
//        }
        
        leftImageView = UIImageView()
        leftImageView?.image = UIImage.init(named: "left_image_icon")
        self.addSubview(leftImageView!)
        leftImageView?.snp.makeConstraints({ (make) in
            
            make.left.equalTo(self).offset(30)
            make.top.equalTo(self).offset(40)
//            make.width.equalTo(67)
//            make.height.equalTo(67)
        })
        
        let memberBtn = UIButton()
        memberBtn.backgroundColor = UIColor.white
        memberBtn.layer.cornerRadius = 5.0
        memberBtn.setTitle("会员中心 >", for: .normal)
        memberBtn.setTitleColor(UI_MAIN_COLOR, for: .normal)
        memberBtn.addTarget(self, action: #selector(memberBtnClick), for: .touchUpInside)
        memberBtn.titleLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        self.addSubview(memberBtn)
        memberBtn.snp.makeConstraints { (make) in
            make.left.equalTo((leftImageView?.snp.right)!).offset(57)
            make.top.equalTo(self).offset(57)
            make.width.equalTo(95)
            make.height.equalTo(24)
        }
        
        
        accountLabel = UILabel()
        accountLabel?.textColor = UIColor.white
        accountLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(accountLabel!)
        accountLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((leftImageView?.snp.right)!).offset(57)
            make.top.equalTo(memberBtn.snp.bottom).offset(8)
            make.height.equalTo(20)
        })
        
//        if UI_IS_IPONE6P {
//            accountLabel?.snp.updateConstraints({ (make) in
//                make.top.equalTo(self).offset(82)
//            })
//        }
        
//        let shadowImageView = UIImageView()
//        shadowImageView.isUserInteractionEnabled = true
//        let tapGest = UITapGestureRecognizer(target: self, action: #selector(clickFirstView(_:)))
//        shadowImageView.addGestureRecognizer(tapGest)
//        shadowImageView.image = UIImage(named:"levelshadow")
//        self.addSubview(shadowImageView)
//        shadowImageView.snp.makeConstraints { (make) in
//            make.left.equalTo((leftImageView?.snp.right)!).offset(57)
//            make.top.equalTo((accountLabel?.snp.bottom)!).offset(15)
//        }
//
//        nameLabel = UILabel()
//        nameLabel?.textColor = UIColor.white
//        nameLabel?.font = UIFont.systemFont(ofSize: 14)
//        shadowImageView.addSubview(nameLabel!)
//        nameLabel?.snp.makeConstraints({ (make) in
//            make.left.equalTo(shadowImageView.snp.left).offset(11)
//            make.centerY.equalTo(shadowImageView.snp.centerY)
//            make.height.equalTo(20)
//        })
//
//        let rightImageView = UIImageView()
//        rightImageView.image = UIImage(named:"arrow")
//        shadowImageView.addSubview(rightImageView)
//        rightImageView.snp.makeConstraints { (make) in
//            make.right.equalTo(shadowImageView.snp.right).offset(-7)
//            make.centerY.equalTo(shadowImageView.snp.centerY)
//        }
    }
    
    @objc func clickFirstView(_ tapGes : UITapGestureRecognizer){
        
        if delegate != nil {
            delegate?.shadowImageViewClick()
        }
    }
    
    override var  frame:(CGRect){
        
        didSet{
            let k_w = UIScreen.main.bounds.size.width
            var height = 130
            
            if UI_IS_IPONE6P {
                height = 160
            }
            let newFrame = CGRect(x:0,y:0,width:Int(k_w),height:height)
            super.frame = newFrame
            
        }
    }
    
    fileprivate func changeLeftImageViewLocation(){
        
        if UI_IS_IPONE6 {
            
            leftImageView?.snp.updateConstraints({ (make) in
                
                make.top.equalTo((bgImageView?.snp.top)!).offset(2)
            })
        }else{
            
            leftImageView?.snp.updateConstraints({ (make) in
                
                make.top.equalTo((bgImageView?.snp.top)!).offset(-5)
            })
        }
        
    }
    
    @objc fileprivate func memberBtnClick(){
        
        if delegate != nil {
            delegate?.memberBtnClick()
        }
    }
}
