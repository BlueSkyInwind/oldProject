//
//  MineHeaderView.swift
//  fxdProduct
//
//  Created by sxp on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit


@objc protocol MineHeaderViewDelegate: NSObjectProtocol {
    
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
    
    
    fileprivate func setupNewUI(){

        
        leftImageView = UIImageView()
        leftImageView?.image = UIImage.init(named: "left_image_icon")
        self.addSubview(leftImageView!)
        leftImageView?.snp.makeConstraints({ (make) in
            
            make.left.equalTo(self).offset(30)
            make.top.equalTo(self).offset(40)

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
        

    }
    
    @objc func clickFirstView(_ tapGes : UITapGestureRecognizer){
        
    
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
