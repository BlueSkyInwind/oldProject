//
//  ShanLinBackAlertView.swift
//  fxdProduct
//
//  Created by sxp on 2017/9/29.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

@objc protocol ShanLinBackAlertViewDelegate: NSObjectProtocol {
    
    //取消按钮
    @objc func cancelBtn()
    //确认按钮
    @objc func sureBtn()
    
}

class ShanLinBackAlertView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
   @objc weak var delegate: ShanLinBackAlertViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ShanLinBackAlertView{
    
    fileprivate func setupUI(){
        
        let bgImage = UIImageView()
        bgImage.image = UIImage(named:"wenxintishi")
        bgImage.isUserInteractionEnabled = true
        self.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(347)
            make.height.equalTo(210)
        }
        
        let tipLabel = UILabel()
        tipLabel.text = "未完成验证直接退出,放款会失败"
        tipLabel.font = UIFont.systemFont(ofSize: 17)
        tipLabel.textColor = UIColor.white
        bgImage.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bgImage.snp.top).offset(70)
            make.left.equalTo(bgImage.snp.left).offset(55)
            make.height.equalTo(20)
        }
        
        let cancelBtn = UIButton()
        cancelBtn.setTitle("确认退出", for: .normal)
        cancelBtn.setTitleColor(UIColor.white, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelBtn.setBackgroundImage(UIImage(named:"icon_blue"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        bgImage.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.top.equalTo(tipLabel.snp.bottom).offset(32)
            make.left.equalTo(bgImage.snp.left).offset(65)
        }
        
        let sureBtn = UIButton()
        sureBtn.setTitleColor(UIColor.black, for: .normal)
        sureBtn.setTitle("继续验证", for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sureBtn.setBackgroundImage(UIImage(named:"icon_yell"), for: .normal)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        bgImage.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { (make) in
            make.top.equalTo(tipLabel.snp.bottom).offset(32)
            make.right.equalTo(bgImage.snp.right).offset(-65)
        }
        
        
        if UI_IS_IPONE5{
            bgImage.snp.updateConstraints({ (make) in
                make.width.equalTo(_k_w-20)
                make.height.equalTo(180)
            })
            tipLabel.snp.updateConstraints({ (make) in
                make.top.equalTo(bgImage.snp.top).offset(56)
                make.left.equalTo(bgImage.snp.left).offset(40)
            })
            
            cancelBtn.snp.updateConstraints({ (make) in
                make.left.equalTo(bgImage.snp.left).offset(50)
            })
            sureBtn.snp.makeConstraints({ (make) in
                make.right.equalTo(bgImage.snp.right).offset(-50)
            })
        }
    }
    
    override var  frame:(CGRect){
        
        didSet{
            
            let newFrame = CGRect(x:0,y:64,width:_k_w,height:_k_h-64)
            super.frame = newFrame
            
        }
    }
}

//代理方法
extension ShanLinBackAlertView{
    
   @objc fileprivate func cancelBtnClick(){
    
        if delegate != nil {
            delegate?.cancelBtn()
        }
    }
   @objc fileprivate func sureBtnClick(){
        if delegate != nil{
            delegate?.sureBtn()
        }
    }
}
