//
//  GeneralInputView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

enum GeneralInputType {
    
    case general
    case Phone_Number
    case Pic_Verify_Code
    case Verify_Code
    case Password
}

typealias RightButtonClick = (_ button:UIButton,_ type:GeneralInputType) -> Void
class GeneralInputView: UIView {

    var iconImageView : UIImageView?
    var inputTextField : UITextField?
    var bottomSepView : UIView?
    var rightButton : UIButton?
    var generalInputType:GeneralInputType = .general
    var rightBtnClick:RightButtonClick?
    
    fileprivate var timer:Timer?
    fileprivate var count:Int = 60
    
    convenience init(_ inputtype:GeneralInputType){
        self.init(frame: CGRect.zero)
        generalInputType = inputtype
        configureView(inputtype)
//        self.backgroundColor = UIColor.red
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func rightButtonClick(sender:UIButton) {
        switch generalInputType {
        case .Pic_Verify_Code:
            
            break
        case .Verify_Code:
//            createTimer()
            break
        case .Password:
            let button = sender
            button.isSelected = !button.isSelected
            if button.isSelected {
                inputTextField?.isSecureTextEntry = false
            }else{
                inputTextField?.isSecureTextEntry = true
            }
            break
        default:
            break
        }
        if rightBtnClick != nil {
            rightBtnClick!(sender,generalInputType)
        }
    }
    
     func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCountdown), userInfo: nil, repeats: true)
        count = 60
        rightButton?.backgroundColor = UIColor.lightGray
        rightButton?.isUserInteractionEnabled = false
        rightButton?.alpha = 0.4;
    }
    
    @objc func timerCountdown() {
        count -= 1
        rightButton?.setTitle("\(count)" + "秒", for: UIControlState.normal)
        if count == 0 {
            rightButton?.backgroundColor = UI_MAIN_COLOR
            rightButton?.isUserInteractionEnabled = true
            rightButton?.alpha = 1;
            rightButton?.setTitle("重新获取", for: UIControlState.normal)
            removeTimer()
        }
    }
    
    func removeTimer()  {
        timer?.invalidate()
        timer = nil
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


extension GeneralInputView {
    
    func configureView(_ inputtype:GeneralInputType)  {
        
        iconImageView = UIImageView()
        iconImageView?.contentMode = .center
        self.addSubview(iconImageView!)
        iconImageView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left)
            make.width.equalTo(24)
            make.height.equalTo(24)
        })
        
        rightButton = UIButton.init(type: UIButtonType.custom)
        rightButton?.setTitleColor(UIColor.white, for: UIControlState.normal)
        rightButton?.addTarget(self, action: #selector(rightButtonClick(sender:) ), for: UIControlEvents.touchUpInside)
        rightButton?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        self.addSubview(rightButton!)
        rightButton?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.snp.right)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(0)
        })
        
        inputTextField = UITextField()
        inputTextField?.borderStyle = .none
        inputTextField?.textColor = "333333".uiColor()
        inputTextField?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(inputTextField!)
        inputTextField?.snp.makeConstraints({ (make) in
            make.left.equalTo((iconImageView?.snp.right)!).offset(10)
            make.right.equalTo((rightButton?.snp.left)!)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom).offset(-1)
        })
        
        bottomSepView = UIView()
        bottomSepView?.backgroundColor = "cccccc".uiColor()
        self.addSubview(bottomSepView!)
        bottomSepView?.snp.makeConstraints({ (make) in
            make.top.equalTo((inputTextField?.snp.bottom)!).offset(1)
            make.left.equalTo((inputTextField?.snp.left)!).offset(-5)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(1)
        })
        
        switch inputtype {
        case .Phone_Number:
        
            break
        case .Pic_Verify_Code:
            rightButton?.snp.remakeConstraints({ (make) in
                make.right.equalTo(self.snp.right)
                make.centerY.equalTo(self.snp.centerY)
                make.height.equalTo(self.snp.height)
                make.width.equalTo((rightButton?.snp.height)!).multipliedBy(2.2)
            })
            break
        case .Verify_Code:
            rightButton?.setTitle("发送验证码", for: UIControlState.normal)
            rightButton?.layer.cornerRadius = 15
            rightButton?.backgroundColor = UI_MAIN_COLOR
            rightButton?.clipsToBounds = true
            rightButton?.snp.remakeConstraints({ (make) in
                make.right.equalTo(self.snp.right)
                make.centerY.equalTo(self.snp.centerY)
                make.height.equalTo(self.snp.height)
                make.width.equalTo((rightButton?.snp.height)!).multipliedBy(3)
            })
            bottomSepView?.snp.remakeConstraints({ (make) in
                make.top.equalTo((inputTextField?.snp.bottom)!).offset(1)
                make.left.equalTo((inputTextField?.snp.left)!)
                make.height.equalTo(1)
                make.right.equalTo((rightButton?.snp.left)!)
            })
            break
        case .Password:
            //Sign-in-icon07-1
            inputTextField?.isSecureTextEntry = true
            rightButton?.setImage(UIImage.init(named: "1_Signin_icon_05"), for: UIControlState.normal)
            rightButton?.setImage(UIImage.init(named: "Sign-in-icon07-1"), for: UIControlState.selected)
            rightButton?.snp.updateConstraints({ (make) in
                make.width.equalTo(20)
            })
            break
        default:
            break
        }

    }
}
