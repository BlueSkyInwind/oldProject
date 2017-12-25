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
    
}
class MineHeaderView: UIView {

    //用户名字
   @objc var nameLabel : UILabel?
    //用户账号
   @objc var accountLabel : UILabel?

    //最左边的等级图片
   @objc var leftImageView : UIImageView?
    
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
        
//        let bgView = UIView()
//        bgView.isUserInteractionEnabled = true
//        bgView.backgroundColor = UI_MAIN_COLOR
//        self.addSubview(bgView)
//        bgView.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(0)
//            make.top.equalTo(self).offset(0)
//            make.right.equalTo(self).offset(0)
//            make.bottom.equalTo(self).offset(-10)
//        }
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named:"kongbai")
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30)
            make.top.equalTo(self).offset(45)
        }
        
        leftImageView = UIImageView()
        self.addSubview(leftImageView!)
        leftImageView?.snp.makeConstraints({ (make) in
//            make.left.equalTo(self).offset(30)
//            make.top.equalTo(self).offset(45)
            make.centerX.equalTo(bgImageView.snp.centerX)
            make.centerY.equalTo(bgImageView.snp.centerY)
            make.width.equalTo(67)
            make.height.equalTo(67)
        })
        
        accountLabel = UILabel()
        accountLabel?.textColor = UIColor.white
        accountLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(accountLabel!)
        accountLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((leftImageView?.snp.right)!).offset(57)
            make.top.equalTo(self).offset(52)
            make.height.equalTo(20)
        })
        
        let shadowImageView = UIImageView()
        shadowImageView.isUserInteractionEnabled = true
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(clickFirstView(_:)))
        shadowImageView.addGestureRecognizer(tapGest)
        shadowImageView.image = UIImage(named:"levelshadow")
        self.addSubview(shadowImageView)
        shadowImageView.snp.makeConstraints { (make) in
            make.left.equalTo((leftImageView?.snp.right)!).offset(57)
            make.top.equalTo((accountLabel?.snp.bottom)!).offset(15)
        }
        
        nameLabel = UILabel()
        nameLabel?.textColor = UIColor.white
        nameLabel?.font = UIFont.systemFont(ofSize: 14)
        shadowImageView.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(shadowImageView.snp.left).offset(11)
            make.centerY.equalTo(shadowImageView.snp.centerY)
            make.height.equalTo(20)
        })
        
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named:"arrow")
        shadowImageView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints { (make) in
            make.right.equalTo(shadowImageView.snp.right).offset(-7)
            make.centerY.equalTo(shadowImageView.snp.centerY)
        }
    }
    
    @objc func clickFirstView(_ tapGes : UITapGestureRecognizer){
        
        if delegate != nil {
            delegate?.shadowImageViewClick()
        }
    }
    
    override var  frame:(CGRect){
        
        didSet{
            let k_w = UIScreen.main.bounds.size.width
            let newFrame = CGRect(x:0,y:0,width:k_w,height:130)
            super.frame = newFrame
            
        }
    }
    
}
