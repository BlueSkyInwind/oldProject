//
//  HomeRefuseThirdView.swift
//  fxdProduct
//
//  Created by sxp on 2017/8/21.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class HomeRefuseThirdView: UIView {

    //左边的图片
    var leftImageView : UIImageView?
    //标题
    var titleLabel: UILabel?
    //额度
    var qutaLabel: UILabel?
    //期限
    var termLabel: UILabel?
    //费用
    var feeLabel: UILabel?
    //描述
    var descBtn : UIButton?
    
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

extension HomeRefuseThirdView{

    fileprivate func setupUI(){
    
        let view = UIView()
        self.addSubview(view)
        leftImageView = UIImageView()
        view.addSubview(leftImageView!)
        leftImageView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(view.snp.left).offset(25)
            make.width.equalTo(57)
            make.height.equalTo(57)
        })
        
        titleLabel = UILabel()
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(view.snp.top).offset(10)
            make.left.equalTo((leftImageView?.snp.right)!).offset(8)
            make.height.equalTo(20)
        })
        qutaLabel = UILabel()
        qutaLabel?.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        qutaLabel?.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(qutaLabel!)
        qutaLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(view.snp.top).offset(10)
            make.left.equalTo((titleLabel?.snp.right)!).offset(8)
            make.height.equalTo(20)
        })
        
        termLabel = UILabel()
        termLabel?.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        termLabel?.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(termLabel!)
        termLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(5)
            make.left.equalTo((leftImageView?.snp.right)!).offset(8)
            make.height.equalTo(15)
        })
        
        feeLabel = UILabel()
        feeLabel?.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        feeLabel?.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(feeLabel!)
        feeLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((qutaLabel?.snp.bottom)!).offset(5)
            make.left.equalTo((termLabel?.snp.right)!).offset(10)
            make.height.equalTo(15)
        })
        
        descBtn = UIButton()
        descBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        view.addSubview(descBtn!)
        descBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((termLabel?.snp.bottom)!).offset(3)
            make.left.equalTo((leftImageView?.snp.right)!).offset(8)
            make.height.equalTo(20)
        })
        
        let lineView = UIView()
        lineView.backgroundColor = LINE_COLOR
        view.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-0.5)
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(0.5)
        }
        
//        let lineImage = UIImageView()
//        lineImage.image = UIImage(named:"line")
//        view.addSubview(lineImage)
//        lineImage.snp.makeConstraints { (make) in
//            make.bottom.equalTo(self).offset(0)
//            make.left.equalTo(self).offset(15)
//            make.right.equalTo(self).offset(-15)
//        }
        
        let rightImage = UIImageView()
        rightImage.image = UIImage(named:"icon_youjiantou")
        view.addSubview(rightImage)
        rightImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self).offset(-20)
            make.width.equalTo(6)
            make.height.equalTo(13)
        }
    }
}
