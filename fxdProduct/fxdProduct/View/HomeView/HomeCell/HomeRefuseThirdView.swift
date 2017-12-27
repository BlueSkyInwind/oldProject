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
    
//        let view = UIView()
//        self.addSubview(view)
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named:"refuseBg")
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        leftImageView = UIImageView()
        bgImageView.addSubview(leftImageView!)
        leftImageView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(bgImageView.snp.left).offset(25)
            make.width.equalTo(57)
            make.height.equalTo(57)
        })
        
        titleLabel = UILabel()
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        bgImageView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(bgImageView.snp.top).offset(20)
            make.left.equalTo((leftImageView?.snp.right)!).offset(20)
            make.height.equalTo(20)
        })
        qutaLabel = UILabel()
        qutaLabel?.textColor = RedPacket_COLOR
        qutaLabel?.font = UIFont.systemFont(ofSize: 12)
        bgImageView.addSubview(qutaLabel!)
        qutaLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(bgImageView.snp.top).offset(20)
            make.left.equalTo((titleLabel?.snp.left)!).offset(80)
            make.height.equalTo(20)
        })
        
        termLabel = UILabel()
        termLabel?.textColor = RedPacket_COLOR
        termLabel?.font = UIFont.systemFont(ofSize: 12)
        bgImageView.addSubview(termLabel!)
        termLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(5)
            make.left.equalTo((leftImageView?.snp.right)!).offset(20)
            make.height.equalTo(15)
        })
        
        feeLabel = UILabel()
        feeLabel?.textColor = RedPacket_COLOR
        feeLabel?.font = UIFont.systemFont(ofSize: 12)
        bgImageView.addSubview(feeLabel!)
        feeLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((qutaLabel?.snp.bottom)!).offset(5)
            make.left.equalTo((termLabel?.snp.left)!).offset(80)
            make.height.equalTo(15)
        })
        
        descBtn = UIButton()
        descBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        bgImageView.addSubview(descBtn!)
        descBtn?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self).offset(-20)
            make.left.equalTo((leftImageView?.snp.right)!).offset(20)
            make.height.equalTo(20)
        })
        
//        let lineView = UIView()
//        lineView.backgroundColor = LINE_COLOR
//        bgImageView.addSubview(lineView)
//        lineView.snp.makeConstraints { (make) in
//            make.bottom.equalTo(self).offset(-0.5)
//            make.left.equalTo(self).offset(15)
//            make.right.equalTo(self).offset(-15)
//            make.height.equalTo(0.5)
//        }

        
        let rightImage = UIImageView()
        rightImage.image = UIImage(named:"icon_youjiantou")
        bgImageView.addSubview(rightImage)
        rightImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self).offset(-20)
            make.width.equalTo(6)
            make.height.equalTo(13)
        }
        
        if UI_IS_IPONE5 {
            rightImage.snp.updateConstraints({ (make) in
                
                make.right.equalTo(self).offset(-10)
            })
        }
    }
}
