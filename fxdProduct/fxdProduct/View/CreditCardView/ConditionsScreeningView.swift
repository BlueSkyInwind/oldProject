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
let  CROSS_SEP = 60

typealias ConditionsScreeningViewResult = (_ index:Int) -> Void
class ConditionsScreeningView: UIView {

    
    var conditionsResult:ConditionsScreeningViewResult?
    var  originFrame :CGRect?
    var  animateFrame :CGRect?
    var dataArr:Array<String>?{
        didSet {
            configureView()
        }
    }
    
    convenience init(frame: CGRect,_ arrary:Array<String>,_ result:@escaping ConditionsScreeningViewResult){
        var tempFarme = frame
        var height = tempFarme.size.height
        height = (CGFloat(arrary.count / LINE_NUM) + 1) * (CGFloat(VERTICAL_SEP) + _k_w * 0.25)
        tempFarme.size.height = height
        self.init(frame: frame)
        originFrame = frame
        animateFrame = tempFarme
        self.dataArr = arrary;
        configureView()
        self.isHidden = true
        self.conditionsResult = result
    }
    
    func showAnimate()  {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = self.animateFrame!;
            self.isHidden = false
        }) { (status) in
            
        }
    }
    
    func dismissAnimate()  {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = self.originFrame!;
        }) { (status) in
            self.isHidden = true
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
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
        
        for index in 0..<(dataArr?.count)! {
            let buttonHeight = 26
            let buttonWidth = _k_w * 0.25
            let lineNum = index / LINE_NUM
            let num = index % LINE_NUM
            let string = dataArr![index]
            let conButton = UIButton.init(type: UIButtonType.custom)
            conButton.frame = CGRect.init(x: 0, y: 0, width: Int(buttonWidth), height: buttonHeight)
            let sepX = CGFloat(num) * (CGFloat(CROSS_SEP) + buttonWidth)
            let sepY =  lineNum * (VERTICAL_SEP + buttonHeight)
            let centerX = (CGFloat(CROSS_SEP / 2) + buttonWidth / 2) + sepX
            let centerY = CGFloat((VERTICAL_SEP / 2 + buttonHeight / 2) + sepY)
            conButton.center = CGPoint.init(x: centerX, y: centerY)
            conButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            conButton.setTitle(string, for: UIControlState.normal)
            conButton.titleLabel?.font = UIFont.yx_systemFont(ofSize: 13)
            conButton.layer.cornerRadius = 5
            conButton.clipsToBounds = true
            conButton.layer.borderColor = "4d4d4d".uiColor().cgColor
            conButton.layer.borderWidth = 1
            conButton.tag = 1000 + index
            conButton.addTarget(self, action: #selector(conButtonClick(sender:)), for: UIControlEvents.touchUpInside)
            self.addSubview(conButton)
        }
    }
    
   @objc func conButtonClick(sender:UIButton)  {
    let index = sender.tag - 1000
    if conditionsResult != nil {
        conditionsResult!(index)
    }
    }
    
}


