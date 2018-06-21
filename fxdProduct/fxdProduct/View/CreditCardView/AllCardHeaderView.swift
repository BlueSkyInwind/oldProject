//
//  AllCardHeaderView.swift
//  fxdProduct
//
//  Created by admin on 2018/6/20.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

enum CurrentConditonType {
    case bankType
    case levelType
    case sortType
}

typealias UserChooseResult = (_ bankIndex:Int,_ levelIndex:Int,_ isSort:Bool) -> Void
class AllCardHeaderView: UIView {
    
    var itemViewOne:HeaderItemView?
    var itemViewtTwo:HeaderItemView?
    var itemViewThree:HeaderItemView?
    var superView:UIView?
    var conView:ConditionsScreeningView?
    var isUnfold:Bool = false
    var levelNameArr:Array<String> = ["全部等级"]
    var bankNameArr:Array<String> = ["全部银行"]
    
    var currentBank:Int = 0
    var currentlevel:Int = 0
    var sorts:Bool = true
    
    var currentType:CurrentConditonType = .bankType
    var conditionScreenResult:UserChooseResult?
    
    var levelDataArr:Array<CreaditCardLevelModel> = [] {
        didSet{
            for model in levelDataArr {
                levelNameArr.append(model.name)
            }
        }
    }
    var bankDataArr:Array<CreaditCardBanksListModel> = [] {
        didSet{
            for model in bankDataArr {
                bankNameArr.append(model.cardBankName)
            }
        }
    }
    
    convenience init(frame: CGRect,_ superV:UIView,_ chooseResult:@escaping UserChooseResult){
        self.init(frame: frame)
        superView = superV
        self.conditionScreenResult = chooseResult
    }
    
    func  addConditonView()  {
        conView = ConditionsScreeningView.init(frame: CGRect.init(x: 0, y: frame.origin.y + frame.size.height , width: _k_w, height: 0), bankNameArr, superView!, {[weak self] (index) in
            switch self?.currentType {
            case .bankType?:
                self?.currentBank = index
                break
            case .levelType?:
                self?.currentlevel = index
                break
            default:
                break
            }
            if self?.conditionScreenResult != nil {
                self?.conditionScreenResult!((self?.currentBank)!,(self?.currentlevel)!,(self?.sorts)!)
            }
            self?.itemViewtTwo?.closeIcon(false)
            self?.itemViewOne?.closeIcon(false)
            self?.conView?.dismissAnimate()
        }, { (open) in
            self.isUnfold = open
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
                self?.currentType = .bankType
                self?.itemViewtTwo?.closeIcon(false)
                self?.conView?.currentIndex = (self?.currentBank)!
                self?.conView?.dataArr = self?.bankNameArr;
                if (self?.isUnfold == false) {
                    self?.conView?.showAnimate()
                }
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
        sepView.backgroundColor = "cccccc".uiColor()
        backView.addSubview(sepView)
        sepView.snp.makeConstraints { (make) in
            make.left.equalTo((itemViewOne?.snp.right)!).offset(0)
            make.top.equalTo(backView.snp.top).offset(8)
            make.bottom.equalTo(backView.snp.bottom).offset(-8)
            make.width.equalTo(1)
        }
        
        itemViewtTwo = HeaderItemView.init(frame: CGRect.zero)
        itemViewtTwo?.titleBtn?.setTitle("全部等级", for: UIControlState.normal)
        itemViewtTwo?.itemClick = {[weak self] (button,isOpen) in
            if isOpen {
                self?.currentType = .levelType
                self?.itemViewOne?.closeIcon(false)
                self?.conView?.currentIndex = (self?.currentlevel)!
                self?.conView?.dataArr = self?.levelNameArr;
                if (self?.isUnfold == false) {
                    self?.conView?.showAnimate()
                }
            }else{
                self?.conView?.dismissAnimate()
            }
        }
        backView.addSubview(itemViewtTwo!)
        itemViewtTwo?.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(sepView.snp.right).offset(0)
            make.width.equalTo((itemViewOne?.snp.width)!)
        }
        
        let sepViewTwo = UIView()
        sepViewTwo.backgroundColor = "cccccc".uiColor()
        backView.addSubview(sepViewTwo)
        sepViewTwo.snp.makeConstraints { (make) in
            make.left.equalTo((itemViewtTwo?.snp.right)!).offset(0)
            make.top.equalTo(backView.snp.top).offset(8)
            make.bottom.equalTo(backView.snp.bottom).offset(-8)
            make.width.equalTo(1)
        }
        
        itemViewThree = HeaderItemView.init(frame: CGRect.zero)
        itemViewThree?.titleBtn?.setTitle("申请人数", for: UIControlState.normal)
        itemViewThree?.iconView?.image = UIImage.init(named: "twoWay_Icon")
        itemViewThree?.itemClick = {[weak self] (button,isOpen) in
            self?.currentType = .sortType
            self?.itemViewtTwo?.closeIcon(false)
            self?.itemViewOne?.closeIcon(false)
            if self?.conditionScreenResult != nil {
                self?.conditionScreenResult!((self?.currentBank)!,(self?.currentlevel)!,!isOpen)
            }
            if (self?.isUnfold)! {
                self?.conView?.dismissAnimate()
            }
        }
        backView.addSubview(itemViewThree!)
        itemViewThree?.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(sepViewTwo.snp.right).offset(0)
            make.width.equalTo((itemViewOne?.snp.width)!)
        }
        
    }
}


