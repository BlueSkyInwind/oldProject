//
//  ConditionsScreeningView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/20.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit


let  LINE_NUM = 3
let  VERTICAL_SEP = 24
let  CROSS_SEP = 54
let  CROSS_SEP_iphone5 = 40

typealias ConditionsScreeningViewResult = (_ index:Int) -> Void
typealias ConditionsScreeningViewOpen = (_ isOpen:Bool) -> Void
class ConditionsScreeningView: UIView {

    var conditionsResult:ConditionsScreeningViewResult?
    var isOpen:ConditionsScreeningViewOpen?
    var  originFrame :CGRect?
    var  animateFrame :CGRect?
    var superView: UIView?
    var maskV:UIView?
    var currentIndex:Int = 0
    var dataArr:Array<String>?{
        didSet {
            reloaddata()
        }
    }
    
    convenience init(frame: CGRect,_ arrary:Array<String>,_ superV:UIView,_ result:@escaping ConditionsScreeningViewResult,_ open:@escaping ConditionsScreeningViewOpen){
        var tempFarme = frame
        var height = tempFarme.size.height
        let lineNum = arrary.count % LINE_NUM != 0 ? (CGFloat(arrary.count / LINE_NUM) + 1) : CGFloat(arrary.count / LINE_NUM)
        height = lineNum * (CGFloat(VERTICAL_SEP) + 26)
        tempFarme.size.height = height
        var initFrame = tempFarme
        initFrame.origin.y  =  -height
        self.init(frame: initFrame)
        originFrame = initFrame
        animateFrame = tempFarme
        superView = superV
        self.dataArr = arrary;
        configureView()
        self.conditionsResult = result
        self.isOpen = open
    }
    
    func addMaskView() {
        maskV = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: _k_h))
        maskV?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        self.superView?.addSubview(self.maskV!)
        self.superView?.insertSubview(self.maskV!, belowSubview: self)
    }
    
    func showAnimate()  {
        addMaskView()
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = self.animateFrame!;
            self.maskV?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        }) { (status) in
            self.isOpen!(true)
        }
    }
    
    func dismissAnimate()  {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = self.originFrame!;
            self.maskV?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (status) in
            self.maskV?.removeFromSuperview()
            self.maskV = nil
            self.isOpen!(false)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = "F2F2F2".uiColor()
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
extension ConditionsScreeningView {
    
    func configureView()  {
        
        var  cross_sep_ = CROSS_SEP
        if UI_IS_IPONE5 {
            cross_sep_ = CROSS_SEP_iphone5
        }
        
        for index in 0..<(dataArr?.count)! {
            let buttonHeight = 26
            let buttonWidth = _k_w * 0.2
            let lineNum = index / LINE_NUM
            let num = index % LINE_NUM
            let string = dataArr![index]
            let conButton = UIButton.init(type: UIButtonType.custom)
            conButton.backgroundColor = UIColor.white
            if index == currentIndex {
                conButton.backgroundColor = UI_MAIN_COLOR
            }
            conButton.frame = CGRect.init(x: 0, y: 0, width: Int(buttonWidth), height: buttonHeight)
            let sepX = CGFloat(num) * (CGFloat(cross_sep_) + buttonWidth)
            let sepY =  lineNum * (VERTICAL_SEP + buttonHeight)
            let centerX = (CGFloat(cross_sep_ / 2) + buttonWidth / 2) + sepX
            let centerY = CGFloat((VERTICAL_SEP / 2 + buttonHeight / 2) + sepY)
            conButton.center = CGPoint.init(x: centerX, y: centerY)
            conButton.setTitleColor("4d4d4d".uiColor(), for: UIControlState.normal)
            if currentIndex == index {
                conButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            }
            conButton.setTitle(string, for: UIControlState.normal)
            conButton.titleLabel?.font = UIFont.yx_systemFont(ofSize: 13)
            conButton.layer.cornerRadius = 5
            conButton.clipsToBounds = true
            conButton.layer.borderColor = "a0a0a0".uiColor().cgColor
            conButton.layer.borderWidth = 1
            conButton.tag = 1000 + index
            conButton.addTarget(self, action: #selector(conButtonClick(sender:)), for: UIControlEvents.touchUpInside)
            self.addSubview(conButton)
        }
    }
    
   @objc func conButtonClick(sender:UIButton)  {
        let index = sender.tag - 1000
        resetAllBottonColor(sender.tag)
        if conditionsResult != nil {
            conditionsResult!(index)
        }
    }
    
    func resetAllBottonColor(_ tag:Int)  {
        for view in self.subviews {
            if view.isKind(of: UIButton.self) {
                view.backgroundColor = UIColor.white
                if view.tag == tag {
                    view.backgroundColor = UI_MAIN_COLOR
                    let button = view as! UIButton
                    button.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }
        }
    }
    
    func reloaddata()  {
        for view in self.subviews {
            if view.isKind(of: UIButton.self) {
                view.removeFromSuperview()
            }
        }
        var frame = self.frame
        let lineNum = dataArr!.count % LINE_NUM != 0 ? (CGFloat(dataArr!.count / LINE_NUM) + 1) : CGFloat(dataArr!.count / LINE_NUM)
        let height = lineNum * (CGFloat(VERTICAL_SEP) + 26)
        frame.size.height = height
        originFrame?.origin.y = -height
        originFrame?.size.height = height
        animateFrame?.size.height = height
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = frame
        }) { (status) in
            self.configureView()
        }
    }
}


