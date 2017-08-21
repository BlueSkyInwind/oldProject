//
//  HomeDefaultCell.swift
//  FXDProduct
//
//  Created by sxp on 2017/8/18.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit
import Masonry
import SnapKit

class HomeDefaultCell: UITableViewCell {

    var leftLabel: UILabel?
    var rightLabel: UILabel?
    var leftTitleArray = [""]
    var rightContentArray = [""]

    var thirdTitleArray = [""]
    
    var defaultHeadLabel :UILabel?
    
    var drawingTitle = ""
    
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
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//homeCell各种视图
extension HomeDefaultCell{

    //默认情况
    func setupDefaultUI(){
    
        let bgImage = UIImageView()
        bgImage.image = UIImage(named:"beijing big")
        bgImage.isUserInteractionEnabled = true
        self.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(24)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(-24)
        }
        
        defaultHeadLabel = UILabel()
        defaultHeadLabel?.textColor = UIColor.black
        defaultHeadLabel?.font = UIFont.systemFont(ofSize: 30)
        defaultHeadLabel?.textAlignment = .center
        defaultHeadLabel?.text = "1500元"
        bgImage.addSubview(defaultHeadLabel!)
        defaultHeadLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(bgImage.snp.top).offset(50)
            make.centerX.equalTo(bgImage.snp.centerX)
            make.height.equalTo(30)
        })
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "借款额度(元)"
        label.font = UIFont.systemFont(ofSize: 15)
        bgImage.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo((defaultHeadLabel?.snp.bottom)!).offset(8)
            make.centerX.equalTo(bgImage.snp.centerX)
            make.height.equalTo(20)
        }
        
        // 定义
        let slider = TrackRect()
//        let slider = UISlider()
        //slider.value = 1
        // 设置最小值
        slider.minimumValue = 500
        // 设置最大值
        slider.maximumValue = 3000
//        // 设置按钮最小端图片
//        slider.minimumValueImage = UIImage.init(named: "2.png")
//        // 设置按钮最大端图片
//        slider.maximumValueImage = UIImage.init(named: "1.png")
        // 设置圆点图片
        slider.setThumbImage(UIImage.init(named: "icon_quan"), for: UIControlState.normal)
        // 设置圆点颜色
//        slider.thumbTintColor = UIColor.red
        // 设置滑动过的颜色
        slider.minimumTrackTintColor = UIColor.green
        // 设置未滑动过的颜色
        slider.maximumTrackTintColor = UIColor.blue
        
        // 添加事件
        slider.addTarget(self, action: #selector(changed(slider:)), for: UIControlEvents.valueChanged)
        bgImage.addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.left.equalTo(bgImage.snp.left).offset(15)
            make.right.equalTo(bgImage.snp.right).offset(-15)
            
        }
        
        let leftLabel = UILabel()
        leftLabel.text = "500元"
        leftLabel.font = UIFont.systemFont(ofSize: 15)
        leftLabel.textColor = UIColor.black
        bgImage.addSubview(leftLabel)
    
        leftLabel.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom).offset(5)
            make.left.equalTo(bgImage.snp.left).offset(15)
            make.height.equalTo(20)
        }
        
        let rightLabel = UILabel()
        rightLabel.textColor = UIColor.black
        rightLabel.text = "3000元"
        rightLabel.font = UIFont.systemFont(ofSize: 15)
        bgImage.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom).offset(5)
            make.right.equalTo(bgImage.snp.right).offset(-15)
            make.height.equalTo(20)
        }
        
        let applyBtn = UIButton()
        applyBtn.setTitle("立即申请", for: .normal)
        applyBtn.setTitleColor(UIColor.white, for: .normal)
        applyBtn.backgroundColor = UIColor.blue
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 22)
//        APPTool.shareInstance.setCornerBorder(view: applyBtn, borderColor: UIColor.red)
        applyBtn.addTarget(self, action: #selector(applyBtnClick), for: .touchUpInside)
        bgImage.addSubview(applyBtn)
        applyBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(bgImage.snp.bottom).offset(-70)
            make.left.equalTo(bgImage.snp.left).offset(25)
            make.right.equalTo(bgImage.snp.right).offset(-25)
            make.height.equalTo(50)
        }
        
        let bottomLabel = UILabel()
        bottomLabel.text = "最快2分钟审核完成"
        bottomLabel.textColor = UIColor.black
        bottomLabel.font = UIFont.systemFont(ofSize: 15)
        bottomLabel.textAlignment = .center
        bgImage.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(applyBtn.snp.bottom).offset(15)
            make.centerX.equalTo(bgImage.snp.centerX)
            make.height.equalTo(20)
        }
        
    }
    //不满60天被拒，升级高级认证
     func setupRefuseUI(){
    
        let bgImage = UIImageView()
        bgImage.image = UIImage(named:"beijing big")
        bgImage.isUserInteractionEnabled = true
        self.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(24)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(-24)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "您目前的信用评分不足，以下途径可提高评分"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.black
        bgImage.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bgImage.snp.top).offset(43)
            make.centerX.equalTo(bgImage.snp.centerX)
            make.left.equalTo(bgImage.snp.left).offset(0)
            make.right.equalTo(bgImage.snp.right).offset(0)
            make.height.equalTo(20)
        }
        
        let firstLabel = UILabel()
        firstLabel.text = "一、60天后，更新基础资料"
        firstLabel.font = UIFont.systemFont(ofSize: 17)
        firstLabel.textColor = UIColor.black
        bgImage.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalTo(bgImage.snp.left).offset(25)
            make.height.equalTo(20)
        }
        
        let secondLabel = UILabel()
        secondLabel.textColor = UIColor.black
        secondLabel.text = "二、添加高级认证"
        secondLabel.font = UIFont.systemFont(ofSize: 17)
        bgImage.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { (make) in
            make.top.equalTo(firstLabel.snp.bottom).offset(30)
            make.left.equalTo(bgImage.snp.left).offset(25)
            make.height.equalTo(20)
        }
    
        let advancedCertificationBtn = UIButton()
        advancedCertificationBtn.setTitle("立即添加高级认证 》", for: .normal)
        advancedCertificationBtn.setTitleColor(UIColor.black, for: .normal)
        advancedCertificationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        advancedCertificationBtn.addTarget(self, action: #selector(advancedCertificationClick), for: .touchUpInside)
        bgImage.addSubview(advancedCertificationBtn)
        advancedCertificationBtn.snp.makeConstraints { (make) in
            make.top.equalTo(secondLabel.snp.bottom).offset(12)
            make.centerX.equalTo(bgImage.snp.centerX)
            make.height.equalTo(44)
        }
    }
    
    //信用评分不足，导流其他平台
    func setupOtherPlatformsUI(){
    
        let titleLabel = UILabel()
        titleLabel.text = "您目前的信用评分不足，更新资料可提升(需60天后)"
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(20)
        }
        
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "先试试其他平台"
        label.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(20)
        }
        
        let firstView = HomeRefuseThirdView()
        self.addSubview(firstView)
        firstView.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(5)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(82)
        }
        firstView.leftImageView?.image = UIImage(named:"logo_yongqianbao")
        firstView.titleLabel?.text = "用钱宝"
        firstView.qutaLabel?.text = "额度：最高5000元"
        firstView.termLabel?.text = "期限：7-30天"
        firstView.feeLabel?.text = "费用：0.3%/日"
        firstView.descImage?.image = UIImage(named:"zhuishi1")
        
        let secondView = HomeRefuseThirdView()
        self.addSubview(secondView)
        secondView.snp.makeConstraints { (make) in
            make.top.equalTo(firstView.snp.bottom).offset(0)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(82)
        }
        secondView.leftImageView?.image = UIImage(named:"logo_daima")
        secondView.titleLabel?.text = "贷嘛"
        secondView.qutaLabel?.text = "额度：最高5000元"
        secondView.termLabel?.text = "期限：1-60月"
        secondView.feeLabel?.text = "费用：0.35%-2%/月"
        secondView.descImage?.image = UIImage(named:"zhushi2")
        
        let thirdView = HomeRefuseThirdView()
        self.addSubview(thirdView)
        thirdView.snp.makeConstraints { (make) in
            make.top.equalTo(secondView.snp.bottom).offset(0)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(82)
        }
        thirdView.leftImageView?.image = UIImage(named:"logo_daima")
        thirdView.titleLabel?.text = "平安i贷"
        thirdView.qutaLabel?.text = "额度：最高5000元"
        thirdView.termLabel?.text = "期限：20月"
        thirdView.feeLabel?.text = "费用：1.25%/月"
        thirdView.descImage?.image = UIImage(named:"zhushi3")
        
        
        let moreBtn = UIButton()
        moreBtn.setTitle("更多", for: .normal)
        moreBtn.titleLabel?.textAlignment = .center
        moreBtn.setTitleColor(UIColor.blue, for: .normal)
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        moreBtn.addTarget(self, action: #selector(moreBtnClick), for: .touchUpInside)
        self.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(32)
        }
        
    }
    
    //进件带提款
    func setupDrawingUI(){
    
        let bgImage = UIImageView()
        bgImage.image = UIImage(named:"beijing big")
        bgImage.isUserInteractionEnabled = true
        self.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(24)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(-24)
        }
        
        let bgView = UIView()
        bgImage.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgImage.snp.centerY)
            make.left.equalTo(bgImage.snp.left).offset(0)
            make.right.equalTo(bgImage.snp.right).offset(0)
            make.height.equalTo((leftTitleArray.count*46)+80)
        }
        
        var i = 0
        if drawingTitle != "" {
            let drawingTitleLabel = UILabel()
            drawingTitleLabel.textAlignment = .center
            drawingTitleLabel.textColor = UIColor.red
            drawingTitleLabel.text = drawingTitle
            drawingTitleLabel.font = UIFont.systemFont(ofSize: 19)
            bgView.addSubview(drawingTitleLabel)
            drawingTitleLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(bgView.snp.top).offset(25)
                make.centerX.equalTo(bgView.snp.centerX)
                make.height.equalTo(20)
            })
            i = 30
        }
        var j = 0
        for index in 0..<leftTitleArray.count {
            let indexView = setView()
            bgView.addSubview(indexView)
            
            if index == 0 {
                j = 20+i
            }else{
            
                j = j+36
            }
            indexView.snp.makeConstraints({ (make) in
                make.top.equalTo(bgView.snp.top).offset(j)
                make.left.equalTo(bgView.snp.left).offset(0)
                make.right.equalTo(bgView.snp.right).offset(0)
                make.height.equalTo(30)
            })
            leftLabel?.text = leftTitleArray[index]
            rightLabel?.text = rightContentArray[index]
        }
        
        let bottomBtn = UIButton()
        bottomBtn.setTitle("点击提款", for: .normal)
        bottomBtn.setTitleColor(UIColor.white, for: .normal)
        bottomBtn.backgroundColor = UIColor.init(red: 0/255.0, green: 170/255.0, blue: 238/255.0, alpha: 1.0)
//        APPTool.shareInstance.setCornerBorder(view: bottomBtn, borderColor: UIColor.red)
        bottomBtn.addTarget(self, action: #selector(bottomBtnClick), for: .touchUpInside)
        bgView.addSubview(bottomBtn)
        bottomBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(bgView.snp.bottom).offset(-20)
            make.left.equalTo(bgView.snp.left).offset(25)
            make.right.equalTo(bgView.snp.right).offset(-25)
            make.height.equalTo(44)
        }
    }
    
    //产品列表，第一个
    func productListFirst(){
    
        let bgImage = UIImageView()
        bgImage.image = UIImage(named:"")
        self.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(-10)
        }
        let leftImage = UIImageView()
        bgImage.addSubview(leftImage)
        leftImage.snp.makeConstraints { (make) in
            make.top.equalTo(bgImage.snp.top).offset(30)
            make.left.equalTo(bgImage.snp.left).offset(15)
        }
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        bgImage.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bgImage.snp.top).offset(30)
            make.left.equalTo(leftImage.snp.right).offset(8)
            make.height.equalTo(20)
        }
        let rightImage = UIImageView()
        bgImage.addSubview(rightImage)
        rightImage.snp.makeConstraints { (make) in
            make.top.equalTo(bgImage.snp.top).offset(30)
            make.left.equalTo(titleLabel.snp.right).offset(20)
        }
        
        let moneyLabel = UILabel()
        moneyLabel.textColor = UIColor.black
        moneyLabel.textAlignment = .center
        moneyLabel.font = UIFont.systemFont(ofSize: 30)
        bgImage.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(rightImage.snp.bottom).offset(10)
            make.centerX.equalTo(bgImage.snp.centerX)
            make.height.equalTo(30)
        }
        
        let termLabel = UILabel()
        termLabel.textColor = UIColor.gray
        termLabel.font = UIFont.systemFont(ofSize: 14)
        bgImage.addSubview(termLabel)
        termLabel.snp.makeConstraints { (make) in
            make.top.equalTo(rightImage.snp.bottom).offset(20)
            make.right.equalTo(bgImage.snp.right).offset(30)
            make.height.equalTo(20)
        }
        
        let loanBtn = UIButton()
        loanBtn.setTitle("", for: .normal)
        loanBtn.setTitleColor(UIColor.white, for: .normal)
        loanBtn.backgroundColor = UIColor.blue
        loanBtn.addTarget(self, action: #selector(loanBtnClick), for: .touchUpInside)
        loanBtn.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        bgImage.addSubview(loanBtn)
        loanBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(bgImage.snp.bottom).offset(-20)
            make.left.equalTo(bgImage.snp.left).offset(20)
            make.right.equalTo(bgImage.snp.right).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    func productListOther(){
    
        let bgView = UIView()
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(-10)
        }
        
        let leftImage = UIImageView()
        bgView.addSubview(leftImage)
        leftImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgView.snp.centerY)
        }
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        bgView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.top).offset(30)
            make.left.equalTo(leftImage.snp.right).offset(10)
            make.height.equalTo(22)
        }
        let rightImage = UIImageView()
        bgView.addSubview(rightImage)
        rightImage.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.top).offset(30)
            make.left.equalTo(titleLabel.snp.right).offset(20)
        }
        
        let moneyLabel = UILabel()
        moneyLabel.textColor = UIColor.gray
        moneyLabel.font = UIFont.systemFont(ofSize: 15)
        bgView.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(leftImage.snp.right).offset(10)
            make.height.equalTo(20)
        }
        let termLabel = UILabel()
        termLabel.textColor = UIColor.gray
        termLabel.font = UIFont.systemFont(ofSize: 15)
        bgView.addSubview(termLabel)
        termLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(moneyLabel.snp.right).offset(20)
            make.height.equalTo(20)
        }
        
        let jiantouImage = UIImageView()
        jiantouImage.image = UIImage(named:"")
        bgView.addSubview(jiantouImage)
        jiantouImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgView.snp.centerY)
            make.right.equalTo(bgView.snp.right).offset(-15)
        }
        
        let loanLabel = UILabel()
        loanLabel.textColor = UIColor.blue
        loanLabel.font = UIFont.systemFont(ofSize: 14)
        bgView.addSubview(loanLabel)
        loanLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgView.snp.centerY)
            make.right.equalTo(jiantouImage.snp.left).offset(8)
            make.height.equalTo(20)
        }
    }
}


extension HomeDefaultCell{

    //提款的View
   fileprivate func setView()->UIView{
    
        let view = UIView()
        self.addSubview(view)
        
        leftLabel = UILabel()
        leftLabel?.font = UIFont.systemFont(ofSize: 15)
        leftLabel?.textColor = UIColor.black
        leftLabel?.textAlignment = .right
        view.addSubview(leftLabel!)
        leftLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(view.snp.top).offset(0)
            make.left.equalTo(view.snp.left).offset(60)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.width.equalTo(120)
        })
        
        rightLabel = UILabel()
        rightLabel?.font = UIFont.systemFont(ofSize: 16)
        rightLabel?.textColor = UIColor.black
        rightLabel?.textAlignment = .left
        view.addSubview(rightLabel!)
        rightLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(view.snp.top).offset(0)
            make.right.equalTo(view.snp.right).offset(-60)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.width.equalTo(120)
        })
        return view
    }
}
//点击事件
extension HomeDefaultCell{

    func advancedCertificationClick(){
    
        print("立即添加高级认证")
    }
    
    func bottomBtnClick(){
    
        print("点击提款")
    }
    
    func changed(slider:UISlider){
        print("slider.value = %d",slider.value)
    }
    
    func applyBtnClick(){
    
        print("点击立即申请")
    }
    
    func moreBtnClick(){
    
        print("点击导流平台的更多")
    }
    
    func loanBtnClick(){
    
        print("我要借款")
    }
}
