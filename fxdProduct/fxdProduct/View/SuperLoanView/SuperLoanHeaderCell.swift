//
//  SuperLoanHeaderCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc protocol SuperLoanHeaderCellDelegate: NSObjectProtocol {
    
    //排序
    func sortBtnClick(_ sender: UIButton)
    //筛选
    func filterBtnClick(_ sender: UIButton)
    
    //筛选
    func tabBtnClick(_ sender: UIButton)
    
}
class SuperLoanHeaderCell: UITableViewCell {

    @objc weak var delegate: SuperLoanHeaderCellDelegate?
    @objc var sortImageBtn : UIButton?
    @objc var filterImageBtn : UIButton?
    @objc var sortBtn : UIButton?
    @objc var filterBtn : UIButton?
    @objc var tabLineView : UIView?
    @objc var loanBtn : UIButton?
    @objc var gameBtn : UIButton?
    @objc var tourismBtn : UIButton?
//    @objc var index : String?
//    @objc var bottomLineView : UIView?
    
    @objc var type : String?{
        didSet(newValue){
            
            setCellType(type: type!)
        }
    }
    
    @objc var index : String?{
        didSet(newValue){
            
            setLineViewFrame(index: index!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        type = "0"
        index = "1"
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setCellType(type : String){
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        let type = Int(type)
        switch type {
        case 0?:
            setupUI()
        case 1?:
            setHotHeader()
        case 2?:
            setLoanHeader()
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    fileprivate func setLineViewFrame(index : String){
        
        updateTabLineViewFrame(tag: Int(index)! - 1)
    }
}
extension SuperLoanHeaderCell{

    fileprivate func setupUI(){
        
        let tabBgView = UIView()
        tabBgView.backgroundColor = UIColor.white
        self.addSubview(tabBgView)
        tabBgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(40)
        }
        
        loanBtn = UIButton()
        loanBtn?.setTitle("贷款", for: .normal)
        loanBtn?.setTitleColor(UI_MAIN_COLOR, for: .normal)
        loanBtn?.tag = 101
        loanBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        loanBtn?.addTarget(self, action: #selector(loanBtnClick(_:)), for: .touchUpInside)
        tabBgView.addSubview(loanBtn!)
        loanBtn?.snp.makeConstraints { (make) in
            make.left.equalTo(tabBgView.snp.left).offset(20)
            make.centerY.equalTo(tabBgView.snp.centerY)
        }
        
        gameBtn = UIButton()
        gameBtn?.setTitle("游戏", for: .normal)
        gameBtn?.setTitleColor(GAME_COLOR, for: .normal)
        gameBtn?.tag = 102
        gameBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        gameBtn?.addTarget(self, action: #selector(loanBtnClick(_:)), for: .touchUpInside)
        tabBgView.addSubview(gameBtn!)
        gameBtn?.snp.makeConstraints { (make) in
            make.left.equalTo((loanBtn?.snp.right)!).offset(46)
            make.centerY.equalTo(tabBgView.snp.centerY)
        }
        
        tourismBtn = UIButton()
        tourismBtn?.setTitle("旅游", for: .normal)
        tourismBtn?.setTitleColor(GAME_COLOR, for: .normal)
        tourismBtn?.tag = 103
        tourismBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        tourismBtn?.addTarget(self, action: #selector(loanBtnClick(_:)), for: .touchUpInside)
        tabBgView.addSubview(tourismBtn!)
        tourismBtn?.snp.makeConstraints { (make) in
            make.left.equalTo((gameBtn?.snp.right)!).offset(46)
            make.centerY.equalTo(tabBgView.snp.centerY)
        }
        
        tabLineView = UIView()
        tabLineView?.backgroundColor = UI_MAIN_COLOR
        tabBgView.addSubview(tabLineView!)
        tabLineView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(20)
//            make.right.equalTo(loanBtn.snp.right).offset(0)
            make.top.equalTo(tabBgView.snp.bottom).offset(0)
            make.height.equalTo(2)
            make.width.equalTo(35)
        })
        
        let sortBgView = UIView()
        sortBgView.backgroundColor = UIColor.white
        self.addSubview(sortBgView)
        sortBgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(tabBgView.snp.bottom).offset(3)
            make.width.equalTo(_k_w / 2)
            make.height.equalTo(36)
        }
        
        let sortView = UIView()
        sortView.backgroundColor = .clear
        sortBgView.addSubview(sortView)
        sortView.snp.makeConstraints { (make) in
            make.centerX.equalTo(sortBgView.snp.centerX)
            make.centerY.equalTo(sortBgView.snp.centerY)
            make.height.equalTo(36)
            make.width.equalTo(50)
        }
        
        sortBtn = UIButton()
        sortBtn?.setTitle("排序", for: .normal)
        sortBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        sortBtn?.setTitleColor(TITLE_COLOR, for: .normal)
        sortBtn?.addTarget(self, action: #selector(sortBtnClick(_:)), for: .touchUpInside)
        sortView.addSubview(sortBtn!)
        sortBtn?.snp.makeConstraints { (make) in
            make.left.equalTo(sortView.snp.left).offset(5)
            make.centerY.equalTo(sortView.snp.centerY)
        }
        
        sortImageBtn = UIButton()
        sortImageBtn?.setImage(UIImage.init(named: "sort_icon"), for: .normal)
        sortImageBtn?.addTarget(self, action: #selector(sortBtnClick(_:)), for: .touchUpInside)
        sortView.addSubview(sortImageBtn!)
        sortImageBtn?.snp.makeConstraints { (make) in
            make.right.equalTo(sortView.snp.right).offset(-5)
            make.centerY.equalTo(sortView.snp.centerY)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.black
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(sortBgView.snp.centerY)
            make.height.equalTo(22)
            make.width.equalTo(1)
        }
        
        let filterBgView = UIView()
        filterBgView.backgroundColor = UIColor.white
        self.addSubview(filterBgView)
        filterBgView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.top.equalTo(tabBgView.snp.bottom).offset(3)
            make.width.equalTo(_k_w / 2)
            make.height.equalTo(36)
        }
        
        let filterView = UIView()
        filterView.backgroundColor = .clear
        filterBgView.addSubview(filterView)
        filterView.snp.makeConstraints { (make) in
            make.centerX.equalTo(filterBgView.snp.centerX)
            make.centerY.equalTo(filterBgView.snp.centerY)
            make.height.equalTo(36)
            make.width.equalTo(50)
        }
        
        filterBtn = UIButton()
        filterBtn?.setTitleColor(TITLE_COLOR, for: .normal)
        filterBtn?.setTitle("筛选", for: .normal)
        filterBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        filterBtn?.addTarget(self, action: #selector(filterBtnClick(_:)), for: .touchUpInside)
        filterView.addSubview(filterBtn!)
        filterBtn?.snp.makeConstraints { (make) in
            make.left.equalTo(filterView.snp.left).offset(5)
            make.centerY.equalTo(filterView.snp.centerY)
        }
        
        filterImageBtn = UIButton()
        filterImageBtn?.setImage(UIImage.init(named: "filter_icon"), for: .normal)
        filterImageBtn?.addTarget(self, action: #selector(filterBtnClick(_:)), for: .touchUpInside)
        filterView.addSubview(filterImageBtn!)
        filterImageBtn?.snp.makeConstraints { (make) in
            make.right.equalTo(filterView.snp.right).offset(-5)
            make.centerY.equalTo(filterView.snp.centerY)
        }
        
//        bottomLineView = UIView()
//        bottomLineView?.backgroundColor = LINE_COLOR
//        bottomLineView?.isHidden = true
//        self.addSubview(bottomLineView!)
//        bottomLineView?.snp.makeConstraints({ (make) in
//            make.left.equalTo(self).offset(0)
//            make.right.equalTo(self).offset(0)
//            make.bottom.equalTo(self).offset(-1)
//            make.height.equalTo(1)
//        })
        
    }
    
    fileprivate func setHotHeader(){
    
        let tabBgView = UIView()
        tabBgView.backgroundColor = UIColor.white
        self.addSubview(tabBgView)
        tabBgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(40)
        }
        
        loanBtn = UIButton()
        loanBtn?.setTitle("贷款", for: .normal)
        loanBtn?.setTitleColor(UI_MAIN_COLOR, for: .normal)
        loanBtn?.tag = 101
        loanBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        loanBtn?.addTarget(self, action: #selector(loanBtnClick(_:)), for: .touchUpInside)
        tabBgView.addSubview(loanBtn!)
        loanBtn?.snp.makeConstraints { (make) in
            make.left.equalTo(tabBgView.snp.left).offset(20)
            make.centerY.equalTo(tabBgView.snp.centerY)
        }
        
        gameBtn = UIButton()
        gameBtn?.setTitle("游戏", for: .normal)
        gameBtn?.setTitleColor(GAME_COLOR, for: .normal)
        gameBtn?.tag = 102
        gameBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        gameBtn?.addTarget(self, action: #selector(loanBtnClick(_:)), for: .touchUpInside)
        tabBgView.addSubview(gameBtn!)
        gameBtn?.snp.makeConstraints { (make) in
            make.left.equalTo((loanBtn?.snp.right)!).offset(46)
            make.centerY.equalTo(tabBgView.snp.centerY)
        }
        
        tourismBtn = UIButton()
        tourismBtn?.setTitle("旅游", for: .normal)
        tourismBtn?.setTitleColor(GAME_COLOR, for: .normal)
        tourismBtn?.tag = 103
        tourismBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 16)
        tourismBtn?.addTarget(self, action: #selector(loanBtnClick(_:)), for: .touchUpInside)
        tabBgView.addSubview(tourismBtn!)
        tourismBtn?.snp.makeConstraints { (make) in
            make.left.equalTo((gameBtn?.snp.right)!).offset(46)
            make.centerY.equalTo(tabBgView.snp.centerY)
        }
        
        tabLineView = UIView()
        tabLineView?.backgroundColor = UI_MAIN_COLOR
        tabBgView.addSubview(tabLineView!)
        tabLineView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(20)
            //            make.right.equalTo(loanBtn.snp.right).offset(0)
            make.top.equalTo(tabBgView.snp.bottom).offset(0)
            make.height.equalTo(2)
            make.width.equalTo(35)
        })
        
        let sortBgView = UIView()
        sortBgView.backgroundColor = UIColor.white
        self.addSubview(sortBgView)
        sortBgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(tabBgView.snp.bottom).offset(10)
            make.width.equalTo(_k_w / 2)
            make.height.equalTo(36)
        }
        
        let sortView = UIView()
        sortView.backgroundColor = .clear
        sortBgView.addSubview(sortView)
        sortView.snp.makeConstraints { (make) in
            make.centerX.equalTo(sortBgView.snp.centerX)
            make.centerY.equalTo(sortBgView.snp.centerY)
            make.height.equalTo(36)
            make.width.equalTo(50)
        }
        
        sortBtn = UIButton()
        sortBtn?.setTitle("排序", for: .normal)
        sortBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        sortBtn?.setTitleColor(TITLE_COLOR, for: .normal)
        sortBtn?.addTarget(self, action: #selector(sortBtnClick(_:)), for: .touchUpInside)
        sortView.addSubview(sortBtn!)
        sortBtn?.snp.makeConstraints { (make) in
            make.left.equalTo(sortView.snp.left).offset(5)
            make.centerY.equalTo(sortView.snp.centerY)
        }
        
        sortImageBtn = UIButton()
        sortImageBtn?.setImage(UIImage.init(named: "sort_icon"), for: .normal)
        sortImageBtn?.addTarget(self, action: #selector(sortBtnClick(_:)), for: .touchUpInside)
        sortView.addSubview(sortImageBtn!)
        sortImageBtn?.snp.makeConstraints { (make) in
            make.right.equalTo(sortView.snp.right).offset(-5)
            make.centerY.equalTo(sortView.snp.centerY)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.black
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(sortBgView.snp.centerY)
            make.height.equalTo(22)
            make.width.equalTo(1)
        }
        
        let filterBgView = UIView()
        filterBgView.backgroundColor = UIColor.white
        self.addSubview(filterBgView)
        filterBgView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.top.equalTo(tabBgView.snp.bottom).offset(10)
            make.width.equalTo(_k_w / 2)
            make.height.equalTo(36)
        }
        
        let filterView = UIView()
        filterView.backgroundColor = .clear
        filterBgView.addSubview(filterView)
        filterView.snp.makeConstraints { (make) in
            make.centerX.equalTo(filterBgView.snp.centerX)
            make.centerY.equalTo(filterBgView.snp.centerY)
            make.height.equalTo(36)
            make.width.equalTo(50)
        }
        
        filterBtn = UIButton()
        filterBtn?.setTitleColor(TITLE_COLOR, for: .normal)
        filterBtn?.setTitle("筛选", for: .normal)
        filterBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        filterBtn?.addTarget(self, action: #selector(filterBtnClick(_:)), for: .touchUpInside)
        filterView.addSubview(filterBtn!)
        filterBtn?.snp.makeConstraints { (make) in
            make.left.equalTo(filterView.snp.left).offset(5)
            make.centerY.equalTo(filterView.snp.centerY)
        }
        
        filterImageBtn = UIButton()
        filterImageBtn?.setImage(UIImage.init(named: "filter_icon"), for: .normal)
        filterImageBtn?.addTarget(self, action: #selector(filterBtnClick(_:)), for: .touchUpInside)
        filterView.addSubview(filterImageBtn!)
        filterImageBtn?.snp.makeConstraints { (make) in
            make.right.equalTo(filterView.snp.right).offset(-5)
            make.centerY.equalTo(filterView.snp.centerY)
        }
        
        let bottomLineView = UIView()
        bottomLineView.backgroundColor = LINE_COLOR
        bottomLineView.isHidden = true
        self.addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        })
        
    }
    
    fileprivate func setLoanHeader(){
        
        let sortBgView = UIView()
        sortBgView.backgroundColor = UIColor.white
        self.addSubview(sortBgView)
        sortBgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(10)
            make.width.equalTo(_k_w / 2)
            make.height.equalTo(36)
        }
        
        let sortView = UIView()
        sortView.backgroundColor = .clear
        sortBgView.addSubview(sortView)
        sortView.snp.makeConstraints { (make) in
            make.centerX.equalTo(sortBgView.snp.centerX)
            make.centerY.equalTo(sortBgView.snp.centerY)
            make.height.equalTo(36)
            make.width.equalTo(50)
        }
        
        sortBtn = UIButton()
        sortBtn?.setTitle("排序", for: .normal)
        sortBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        sortBtn?.setTitleColor(TITLE_COLOR, for: .normal)
        sortBtn?.addTarget(self, action: #selector(sortBtnClick(_:)), for: .touchUpInside)
        sortView.addSubview(sortBtn!)
        sortBtn?.snp.makeConstraints { (make) in
            make.left.equalTo(sortView.snp.left).offset(5)
            make.centerY.equalTo(sortView.snp.centerY)
        }
        
        sortImageBtn = UIButton()
        sortImageBtn?.setImage(UIImage.init(named: "sort_icon"), for: .normal)
        sortImageBtn?.addTarget(self, action: #selector(sortBtnClick(_:)), for: .touchUpInside)
        sortView.addSubview(sortImageBtn!)
        sortImageBtn?.snp.makeConstraints { (make) in
            make.right.equalTo(sortView.snp.right).offset(-5)
            make.centerY.equalTo(sortView.snp.centerY)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.black
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(sortBgView.snp.centerY)
            make.height.equalTo(22)
            make.width.equalTo(1)
        }
        
        let filterBgView = UIView()
        filterBgView.backgroundColor = UIColor.white
        self.addSubview(filterBgView)
        filterBgView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(10)
            make.width.equalTo(_k_w / 2)
            make.height.equalTo(36)
        }
        
        let filterView = UIView()
        filterView.backgroundColor = .clear
        filterBgView.addSubview(filterView)
        filterView.snp.makeConstraints { (make) in
            make.centerX.equalTo(filterBgView.snp.centerX)
            make.centerY.equalTo(filterBgView.snp.centerY)
            make.height.equalTo(36)
            make.width.equalTo(50)
        }
        
        filterBtn = UIButton()
        filterBtn?.setTitleColor(TITLE_COLOR, for: .normal)
        filterBtn?.setTitle("筛选", for: .normal)
        filterBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        filterBtn?.addTarget(self, action: #selector(filterBtnClick(_:)), for: .touchUpInside)
        filterView.addSubview(filterBtn!)
        filterBtn?.snp.makeConstraints { (make) in
            make.left.equalTo(filterView.snp.left).offset(5)
            make.centerY.equalTo(filterView.snp.centerY)
        }
        
        filterImageBtn = UIButton()
        filterImageBtn?.setImage(UIImage.init(named: "filter_icon"), for: .normal)
        filterImageBtn?.addTarget(self, action: #selector(filterBtnClick(_:)), for: .touchUpInside)
        filterView.addSubview(filterImageBtn!)
        filterImageBtn?.snp.makeConstraints { (make) in
            make.right.equalTo(filterView.snp.right).offset(-5)
            make.centerY.equalTo(filterView.snp.centerY)
        }
        
        let bottomLineView = UIView()
        bottomLineView.backgroundColor = LINE_COLOR
        bottomLineView.isHidden = true
        self.addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        })
        
    }
}

extension SuperLoanHeaderCell{
    
    @objc fileprivate func sortBtnClick(_ sender : UIButton){
        if delegate != nil {
            
            delegate?.sortBtnClick(sender)
        }
    }
    
    @objc fileprivate func filterBtnClick(_ sender : UIButton){
        
        if delegate != nil {
            delegate?.filterBtnClick(sender)
        }
    }
    
    @objc fileprivate func loanBtnClick(_ sender : UIButton){
        
        updateTabLineViewFrame(tag: sender.tag - 101)
        if delegate != nil {
            
            delegate?.tabBtnClick(sender)
        }
    }
    
    fileprivate func updateTabLineViewFrame(tag : Int){
        
//        let x = 20 + 33 * tag + 46 * tag
        var x = 20 + 79 * tag
        if UI_IS_IPONE6P {
            x = 20 + 85 * tag
        }
        tabLineView?.snp.updateConstraints({ (make) in
            make.left.equalTo(self).offset(x)
        })
    }
}
