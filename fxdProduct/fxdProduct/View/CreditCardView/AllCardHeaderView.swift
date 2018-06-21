//
//  AllCardHeaderView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/20.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit


class AllCardHeaderView: UIView {
    
    var itemViewOne:HeaderItemView?
    var itemViewtTwo:HeaderItemView?
    var itemViewThree:HeaderItemView?
    var superView:UIView?
    var conView:ConditionsScreeningView?
    var dataArr:Array<String>?
    
    convenience init(frame: CGRect,_ superV:UIView){
        self.init(frame: frame)
        superView = superV
    }
    
    func  addConditonView()  {
        conView = ConditionsScreeningView.init(frame: CGRect.init(x: 0, y: frame.origin.y + frame.size.height , width: _k_w, height: 0), dataArr!, { (index) in
            
        })
        superView?.addSubview(conView!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = "f2f2f2".uiColor()
        configureView()
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension AllCardHeaderView {
    func configureView() {
        
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.setCornerRadius(8, withShadow: true, withOpacity: 0.6)
        self.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(self.snp.top).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-7)
        }
        

        
        
        itemViewOne = HeaderItemView.init(frame: CGRect.zero)
        itemViewOne?.titleBtn?.setTitle("全部银行", for: UIControlState.normal)
        itemViewOne?.itemClick = {[weak self] (button,isOpen) in
            if isOpen {
                self?.conView?.showAnimate()
            }else{
                self?.conView?.dismissAnimate()
            }
        }
        backView.addSubview(itemViewOne!)
        itemViewOne?.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(backView.snp.width).multipliedBy(0.333)
        }
        
        let sepView = UIView()
        sepView.backgroundColor = "000000".uiColor()
        backView.addSubview(sepView)
        sepView.snp.makeConstraints { (make) in
            make.left.equalTo((itemViewOne?.snp.right)!).offset(0)
            make.top.equalTo(backView.snp.top).offset(8)
            make.bottom.equalTo(backView.snp.bottom).offset(-8)
            make.width.equalTo(1)
        }
        
        itemViewtTwo = HeaderItemView.init(frame: CGRect.zero)
        itemViewtTwo?.titleBtn?.setTitle("全部等级", for: UIControlState.normal)
        itemViewtTwo?.itemClick = { (button,isOpen) in
            
        }
        backView.addSubview(itemViewtTwo!)
        itemViewtTwo?.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(sepView.snp.right).offset(0)
            make.width.equalTo((itemViewOne?.snp.width)!)
        }
        
        let sepViewTwo = UIView()
        sepViewTwo.backgroundColor = "000000".uiColor()
        backView.addSubview(sepViewTwo)
        sepViewTwo.snp.makeConstraints { (make) in
            make.left.equalTo((itemViewtTwo?.snp.right)!).offset(0)
            make.top.equalTo(backView.snp.top).offset(8)
            make.bottom.equalTo(backView.snp.bottom).offset(-8)
            make.width.equalTo(1)
        }
        
        itemViewThree = HeaderItemView.init(frame: CGRect.zero)
        itemViewThree?.titleBtn?.setTitle("申请人数", for: UIControlState.normal)
        itemViewThree?.itemClick = { (button,isOpen) in
            
        }
        backView.addSubview(itemViewThree!)
        itemViewThree?.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(sepViewTwo.snp.right).offset(0)
            make.width.equalTo((itemViewOne?.snp.width)!)
        }
        
    }
}


