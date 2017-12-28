//
//  DataUpdatePopView.swift
//  fxdProduct
//
//  Created by sxp on 2017/12/28.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class DataUpdatePopView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var bgView : UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DataUpdatePopView{
    fileprivate func setupUI(){
        
        bgView = UIView()
        bgView?.backgroundColor = UIColor.white
        bgView?.layer.cornerRadius = 5.0
        self.addSubview(bgView!)
        bgView?.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(61)
            make.right.equalTo(self).offset(-61)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named:""), for: .normal)
        closeButton.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        bgView?.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.left.equalTo((bgView?.snp.right)!).offset(-10)
            make.top.equalTo((bgView?.snp.top)!).offset(-10)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "资料更新提示"
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = TITLE_COLOR
        titleLabel.textAlignment = .center
        bgView?.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo((bgView?.snp.top)!).offset(20)
            make.centerX.equalTo((bgView?.snp.centerX)!)
            make.height.equalTo(20)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = TIME_COLOR
        bgView?.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo((bgView?.snp.left)!).offset(27)
            make.right.equalTo((bgView?.snp.right)!).offset(-27)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        let contentLabel = UILabel()
        contentLabel.text = "亲爱的用户：\n由于距上次提交资料时间较长，你有部分资料需更新提交。\n我们会依据您的最新资料信息及历史还款记录，给你最新的借款额度。"
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = RedPacketBottomBtn_COLOR
        bgView?.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(22)
            make.left.equalTo((bgView?.snp.left)!).offset(25)
            make.right.equalTo((bgView?.snp.right)!).offset(-25)
        }
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = TIME_COLOR
        bgView?.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.left.equalTo((bgView?.snp.left)!).offset(27)
            make.right.equalTo((bgView?.snp.right)!).offset(-27)
            make.height.equalTo(1)
        }
        
        let bottomBtn = UIButton()
        bottomBtn.setTitle("前去更新", for: .normal)
        bottomBtn.setTitleColor(UI_MAIN_COLOR, for: .normal)
        bottomBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        bottomBtn.addTarget(self, action: #selector(bottomBtnClick), for: .touchUpInside)
        bgView?.addSubview(bottomBtn)
        bottomBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo((bgView?.snp.centerX)!)
            make.top.equalTo(bottomLine.snp.bottom).offset(15)
            make.height.equalTo(42)
        }
        
    }
    
    
    @objc func closeBtnClick(){
        
    }
    
    @objc func bottomBtnClick(){
        
    }
    
//    //MARK: 弹窗动画
//    @objc  func show()  {
//        UIApplication.shared.keyWindow?.addSubview(self)
//        UIApplication.shared.keyWindow?.bringSubview(toFront: self)
//        self.bgView?.transform = CGAffineTransform(scaleX: 1.21, y: 1.21);
//        self.bgView?.alpha = 0
//        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//            self.bgView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
//            self.bgView?.alpha = 1
//        }, completion: nil)
//    }
    
    @objc  func dismiss()  {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.bgView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
            self.bgView?.alpha = 0
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    override var  frame:(CGRect){
        
        didSet{
            
            let newFrame = CGRect(x:0,y:0,width:_k_w,height:_k_h)
            super.frame = newFrame
            
        }
    }
    
}
