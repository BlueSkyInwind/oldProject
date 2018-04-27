//
//  SDCycleScrollCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/4/3.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit


@objc protocol SDCycleScrollCellDelegate: NSObjectProtocol {
    
    //贷款按钮
    func loanClick();
    //游戏按钮
    func gameBtnClick();
    //旅游按钮
    func tourismBtnClcik();
    
}
class SDCycleScrollCell: UITableViewCell {

    @objc var sdCycleScrollview : SDCycleScrollView?
    @objc var delegate : SDCycleScrollCellDelegate?
    @objc var loanBtn : UIButton?
    @objc var gameBtn : UIButton?
    @objc var tourismBtn : UIButton?
    @objc var loanBtnImage : UIButton?
    @objc var gameBtnImage : UIButton?
    @objc var tourismBtnImage : UIButton?
    
    
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
        
        setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SDCycleScrollCell{
    
    fileprivate func setUpUI(){
        
        let bgView = UIView()
        bgView.backgroundColor = LINE_COLOR
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.height.equalTo(30)
        }
//        let bgImageView = UIImageView()
//        bgImageView.image = UIImage.init(named: "sdcy_bg_icon")
//        self.addSubview(bgImageView)
//        bgImageView.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(0)
//            make.right.equalTo(self).offset(0)
//            make.top.equalTo(self).offset(0)
//            make.height.equalTo(35)
////            make.bottom.equalTo(self).offset(0)
//        }
        
        let leftImageView = UIImageView()
        leftImageView.image = UIImage.init(named: "icon_cycleICON")
        self.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgView.snp.centerY)
            make.left.equalTo(self).offset(22)
        }
        
        sdCycleScrollview = SDCycleScrollView()
        sdCycleScrollview?.isUserInteractionEnabled = false
        sdCycleScrollview?.onlyDisplayText = true
        sdCycleScrollview?.titleLabelBackgroundColor = LINE_COLOR
        sdCycleScrollview?.titleLabelTextColor = RedPacket_COLOR
        sdCycleScrollview?.scrollDirection = .vertical
        sdCycleScrollview?.titleLabelTextFont = UIFont.yx_systemFont(ofSize: 12)
        self.addSubview(sdCycleScrollview!)
        sdCycleScrollview?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(bgView.snp.centerY)
            make.left.equalTo(leftImageView.snp.right).offset(14)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(20)
        })
        
        loanBtnImage = UIButton()
//        loanBtnImage?.setImage(UIImage.init(named: "loan_icon"), for: .normal)
        loanBtnImage?.addTarget(self, action: #selector(loanBtnClick), for: .touchUpInside)
        self.addSubview(loanBtnImage!)
        loanBtnImage?.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(45)
            make.top.equalTo(bgView.snp.bottom).offset(10)
        }
        
        loanBtn = UIButton()
//        loanBtn?.setTitle("贷款", for: .normal)
        loanBtn?.setTitleColor(RedPacket_COLOR, for: .normal)
        loanBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        loanBtn?.addTarget(self, action: #selector(loanBtnClick), for: .touchUpInside)
        self.addSubview(loanBtn!)
        loanBtn?.snp.makeConstraints { (make) in
            make.left.equalTo((loanBtnImage?.snp.left)!).offset(0)
            make.top.equalTo((loanBtnImage?.snp.bottom)!).offset(5)
        }
        
        gameBtnImage = UIButton()
//        gameBtnImage?.setImage(UIImage.init(named: "game_icon"), for: .normal)
        gameBtnImage?.addTarget(self, action: #selector(gameBtnClick), for: .touchUpInside)
        self.addSubview(gameBtnImage!)
        gameBtnImage?.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo((loanBtnImage?.snp.top)!).offset(0)
        }
        
        gameBtn = UIButton()
//        gameBtn?.setTitle("游戏", for: .normal)
        gameBtn?.setTitleColor(RedPacket_COLOR, for: .normal)
        gameBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        gameBtn?.addTarget(self, action: #selector(gameBtnClick), for: .touchUpInside)
        self.addSubview(gameBtn!)
        gameBtn?.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo((gameBtnImage?.snp.bottom)!).offset(5)
        }
        
        tourismBtnImage = UIButton()
//        tourismBtnImage?.setImage(UIImage.init(named: "tourism_icon"), for: .normal)
        tourismBtnImage?.addTarget(self, action: #selector(tourismBtnClcik), for: .touchUpInside)
        self.addSubview(tourismBtnImage!)
        tourismBtnImage?.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-45)
            make.top.equalTo((loanBtnImage?.snp.top)!).offset(0)
        }
        
        tourismBtn = UIButton()
//        tourismBtn?.setTitle("旅游", for: .normal)
        tourismBtn?.setTitleColor(RedPacket_COLOR, for: .normal)
        tourismBtn?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        tourismBtn?.addTarget(self, action: #selector(tourismBtnClcik), for: .touchUpInside)
        self.addSubview(tourismBtn!)
        tourismBtn?.snp.makeConstraints { (make) in
            make.right.equalTo((tourismBtnImage?.snp.right)!).offset(0)
            make.top.equalTo((tourismBtnImage?.snp.bottom)!).offset(5)
        }
        
        
        
    }
}

extension SDCycleScrollCell{
    @objc func loanBtnClick(){
        if delegate != nil {
            delegate?.loanClick();
        }
    }
    
    @objc func gameBtnClick(){
        if delegate != nil {
            delegate?.gameBtnClick();
        }
    }
    
    @objc func tourismBtnClcik(){
        if delegate != nil {
            delegate?.tourismBtnClcik();
        }
    }
}
