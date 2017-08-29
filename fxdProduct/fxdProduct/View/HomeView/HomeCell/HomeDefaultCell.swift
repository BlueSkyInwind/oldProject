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

//@objc(HomeDefaultCellDelegate)
@objc protocol HomeDefaultCellDelegate: NSObjectProtocol {
    
    func advancedCertification()
    func drawingBtnClick()
    func applyBtnClick(_ money: String)->Void
    func moreBtnClick()
    func loanBtnClick()
}

class HomeDefaultCell: UITableViewCell {

    weak var delegate: HomeDefaultCellDelegate?
    
    var leftLabel: UILabel?
    var rightLabel: UILabel?

    var thirdTitleArray = [""]
    
    var defaultHeadLabel :UILabel?

    var homeProductFirstArray = [""]
    var homeProductOtherArray = [""]
    
    var isWait = false
    var homeProductData = HomeProductList()
    
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

    //
    //MARK:默认情况
    func setupDefaultUI(){
    
        let bgImage = UIImageView()
        bgImage.image = UIImage(named:"beijing big")
        bgImage.isUserInteractionEnabled = true
        self.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(0)
        }
        
        defaultHeadLabel = UILabel()
        defaultHeadLabel?.textColor = UIColor.black
        defaultHeadLabel?.font = UIFont.systemFont(ofSize: 30)
        defaultHeadLabel?.textAlignment = .center
        defaultHeadLabel?.text = "3000元"
        bgImage.addSubview(defaultHeadLabel!)
        defaultHeadLabel?.snp.makeConstraints({ (make) in
            if UI_IS_IPONE5{
                make.top.equalTo(bgImage.snp.top).offset(15)
            }else{
            
                make.top.equalTo(bgImage.snp.top).offset(30)
            }
            
            make.centerX.equalTo(bgImage.snp.centerX)
            make.height.equalTo(30)
        })
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.init(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1.0)
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
        slider.value = 3000
//        // 设置按钮最小端图片
//        slider.minimumValueImage = UIImage.init(named: "2.png")
//        // 设置按钮最大端图片
//        slider.maximumValueImage = UIImage.init(named: "1.png")
        // 设置圆点图片
        slider.setThumbImage(UIImage.init(named: "icon_quan"), for: UIControlState.normal)
        // 设置圆点颜色
//        slider.thumbTintColor = UIColor.red
        // 设置滑动过的颜色
        slider.minimumTrackTintColor = UI_MAIN_COLOR
        // 设置未滑动过的颜色
        slider.maximumTrackTintColor = LINE_COLOR
        
        // 添加事件
        slider.addTarget(self, action: #selector(changed(slider:)), for: UIControlEvents.valueChanged)
        bgImage.addSubview(slider)
        slider.snp.makeConstraints { (make) in
            if UI_IS_IPONE5{
            
                make.top.equalTo(label.snp.bottom).offset(10)
            }else{
                make.top.equalTo(label.snp.bottom).offset(20)
            }
            make.left.equalTo(bgImage.snp.left).offset(15)
            make.right.equalTo(bgImage.snp.right).offset(-15)
            
        }
        
        let leftLabel = UILabel()
        leftLabel.text = "500元"
        leftLabel.font = UIFont.systemFont(ofSize: 15)
        leftLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        bgImage.addSubview(leftLabel)
    
        leftLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(slider.snp.bottom).offset(-10)
            make.left.equalTo(bgImage.snp.left).offset(15)
            make.height.equalTo(15)
        }
        
        let rightLabel = UILabel()
        rightLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        rightLabel.text = "3000元"
        rightLabel.font = UIFont.systemFont(ofSize: 15)
        bgImage.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom).offset(-10)
            make.right.equalTo(bgImage.snp.right).offset(-15)
            make.height.equalTo(15)
        }
        
        let applyBtn = UIButton()
        applyBtn.setTitle("立即申请", for: .normal)
        applyBtn.setTitleColor(UIColor.white, for: .normal)
        applyBtn.backgroundColor = UI_MAIN_COLOR
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        applyBtn.layer.cornerRadius = 5.0
        applyBtn.addTarget(self, action: #selector(applyBtnClick), for: .touchUpInside)
        bgImage.addSubview(applyBtn)
        applyBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(bgImage.snp.bottom).offset(-60)
            make.left.equalTo(bgImage.snp.left).offset(25)
            make.right.equalTo(bgImage.snp.right).offset(-25)
            make.height.equalTo(50)
        }
        
//        //渐变颜色
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = applyBtn.frame
//        //设置渐变的主颜色（可多个颜色添加）
//        gradientLayer.colors = [UIColor.red.cgColor, UIColor.init(red: 0/255.0, green: 170/255.0, blue: 238/255.0, alpha: 1.0).cgColor]
//        //将gradientLayer作为子layer添加到主layer上
//        applyBtn.layer.addSublayer(gradientLayer)
        
        
        let bottomLabel = UILabel()
        bottomLabel.text = "最快2分钟审核完成"
        bottomLabel.textColor = UIColor.init(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1.0)
        bottomLabel.font = UIFont.systemFont(ofSize: 15)
        bottomLabel.textAlignment = .center
        
        let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:bottomLabel.text!)
        attrstr.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1.0), range: NSMakeRange(2,1))
        attrstr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(2,1))
        bottomLabel.attributedText = attrstr
        bgImage.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(applyBtn.snp.bottom).offset(10)
            make.centerX.equalTo(bgImage.snp.centerX)
            make.height.equalTo(20)
        }
        
    }
    //
    //MARK:不满60天被拒，升级高级认证
     func setupRefuseUI(){
    
        let bgImage = UIImageView()
        bgImage.image = UIImage(named:"beijing big")
        bgImage.isUserInteractionEnabled = true
        self.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(0)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "您目前的信用评分不足，以下途径可提高评分"
        textLabel?.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        if UI_IS_IPONE5 {
            titleLabel.font = UIFont.systemFont(ofSize: 13)
        }
        titleLabel.textColor = UIColor.init(red: 63/255.0, green: 169/255.0, blue: 245/255.0, alpha: 1.0)
        bgImage.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bgImage.snp.top).offset(43)
//            make.centerX.equalTo(bgImage.snp.centerX)
            make.left.equalTo(bgImage.snp.left).offset(15)
            make.right.equalTo(bgImage.snp.right).offset(0)
            make.height.equalTo(20)
        }
        
        let firstLabel = UILabel()
        firstLabel.text = "一、60天后，更新基础资料"
        firstLabel.font = UIFont.systemFont(ofSize: 17)
        firstLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        bgImage.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalTo(bgImage.snp.left).offset(25)
            make.height.equalTo(20)
        }
        
        let secondLabel = UILabel()
        secondLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        secondLabel.text = "二、添加高级认证"
        secondLabel.font = UIFont.systemFont(ofSize: 17)
        bgImage.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { (make) in
            make.top.equalTo(firstLabel.snp.bottom).offset(30)
            make.left.equalTo(bgImage.snp.left).offset(25)
            make.height.equalTo(20)
        }
    
        let advancedCertificationBtn = UIButton()
        advancedCertificationBtn.setTitle("立即添加高级认证 >>", for: .normal)
        advancedCertificationBtn.setTitleColor(UIColor.init(red: 63/255.0, green: 169/255.0, blue: 245/255.0, alpha: 1.0), for: .normal)
        advancedCertificationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        advancedCertificationBtn.addTarget(self, action: #selector(advancedCertificationClick), for: .touchUpInside)
        bgImage.addSubview(advancedCertificationBtn)
        advancedCertificationBtn.snp.makeConstraints { (make) in
            make.top.equalTo(secondLabel.snp.bottom).offset(12)
            make.centerX.equalTo(bgImage.snp.centerX)
            make.height.equalTo(44)
        }
    }
    
    //
    //MARK:信用评分不足，导流其他平台
    func setupOtherPlatformsUI(){
    
        let titleLabel = UILabel()
        titleLabel.text = "您目前的信用评分不足，更新资料可提升(需60天后)"
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = UIColor.init(red: 63/255.0, green: 169/255.0, blue: 245/255.0, alpha: 1.0)
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(13)
        }
        
        let label = UILabel()
        label.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        label.textAlignment = .center
        label.text = "先试试其他平台"
        label.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(12)
        }
        
        let firstView = HomeRefuseThirdView()
        firstView.backgroundColor = UIColor.white
        self.addSubview(firstView)
        firstView.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(82)
        }
        firstView.leftImageView?.image = UIImage(named:"logo_yongqianbao")
        firstView.titleLabel?.text = "用钱宝"
        firstView.qutaLabel?.text = "额度：最高5000元"
        firstView.termLabel?.text = "期限：7-30天"
        let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(firstView.termLabel?.text)!)
        attrstr.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1.0), range: NSMakeRange(3,attrstr.length-4))
        firstView.termLabel?.attributedText = attrstr
        firstView.feeLabel?.text = "费用：0.3%/日"
        let attrstr1 : NSMutableAttributedString = NSMutableAttributedString(string:(firstView.feeLabel?.text)!)
        attrstr1.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1.0), range: NSMakeRange(3,attrstr1.length-5))
        firstView.feeLabel?.attributedText = attrstr1
        firstView.descImage?.image = UIImage(named:"zhuishi1")
        
        let secondView = HomeRefuseThirdView()
        secondView.backgroundColor = UIColor.white
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
        let attrstr2 : NSMutableAttributedString = NSMutableAttributedString(string:(secondView.termLabel?.text)!)
        attrstr2.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1.0), range: NSMakeRange(3,attrstr2.length-4))
        secondView.termLabel?.attributedText = attrstr2
        secondView.feeLabel?.text = "费用：0.35%-2%/月"
        let attrstr3 : NSMutableAttributedString = NSMutableAttributedString(string:(secondView.feeLabel?.text)!)
        attrstr3.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1.0), range: NSMakeRange(3,attrstr3.length-5))
        secondView.feeLabel?.attributedText = attrstr3
        secondView.descImage?.image = UIImage(named:"zhushi2")
        
        if !UI_IS_IPONE5 {
            
            let thirdView = HomeRefuseThirdView()
            thirdView.backgroundColor = UIColor.white
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
            let attrstr4 : NSMutableAttributedString = NSMutableAttributedString(string:(thirdView.termLabel?.text)!)
            attrstr4.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1.0), range: NSMakeRange(3,attrstr4.length-4))
            thirdView.termLabel?.attributedText = attrstr4
            thirdView.feeLabel?.text = "费用：1.25%/月"
            let attrstr5 : NSMutableAttributedString = NSMutableAttributedString(string:(thirdView.feeLabel?.text)!)
            attrstr5.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1.0), range: NSMakeRange(3,attrstr5.length-4))
            thirdView.feeLabel?.attributedText = attrstr5
            thirdView.descImage?.image = UIImage(named:"zhushi3")
        }
        
        let moreBtn = UIButton()
        moreBtn.setTitle("更多", for: .normal)
        moreBtn.titleLabel?.textAlignment = .center
        moreBtn.setTitleColor(UIColor.init(red: 63/255.0, green: 169/255.0, blue: 245/255.0, alpha: 1.0), for: .normal)
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        moreBtn.addTarget(self, action: #selector(moreBtnClick), for: .touchUpInside)
        self.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            if UI_IS_IPONE5 {
            
                make.top.equalTo(secondView.snp.bottom).offset(5)
            }else{
            
                make.top.equalTo(secondView.snp.bottom).offset(87)
            }
            
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(20)
        }
        
    }
    
    //进件带提款
    //MARK:进件带提款
    func setupDrawingUI(){
    
        let bgImage = UIImageView()
        bgImage.image = UIImage(named:"beijing big")
        bgImage.isUserInteractionEnabled = true
        self.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(0)
        }
        
        let bgView = UIView()
        bgImage.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgImage.snp.centerY)
            make.left.equalTo(bgImage.snp.left).offset(0)
            make.right.equalTo(bgImage.snp.right).offset(0)
            if UI_IS_IPONE5{
            
                make.height.equalTo((homeProductData.data.infoList.count*36)+60)
            }else{
            
                make.height.equalTo((homeProductData.data.infoList.count*46)+60)
            }
        }
        
        var i = 0
        if homeProductData.data.warnText != "" && homeProductData.data.warnText != nil {
            let drawingTitleLabel = UILabel()
            drawingTitleLabel.textAlignment = .center
            drawingTitleLabel.textColor = UIColor.init(red: 237/255.0, green: 28/255.0, blue: 36/255.0, alpha: 1.0)
            drawingTitleLabel.text = homeProductData.data.warnText
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
        for index in 0..<homeProductData.data.infoList.count {
            let indexView = setView()
            bgView.addSubview(indexView)
            
            if index == 0 {
                j = 20+i
            }else{
            
                if UI_IS_IPONE5{
                
                    j = j+25
                }else{
                
                    j = j+36
                }
                
            }
            indexView.snp.makeConstraints({ (make) in
                make.top.equalTo(bgView.snp.top).offset(j)
                make.left.equalTo(bgView.snp.left).offset(0)
                make.right.equalTo(bgView.snp.right).offset(0)
                make.height.equalTo(30)
            })
            leftLabel?.text = homeProductData.data.infoList[index].label
            rightLabel?.text = homeProductData.data.infoList[index].value
        }
        
        let bottomBtn = UIButton()
        bottomBtn.setTitle(homeProductData.data.buttonText, for: .normal)
        bottomBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        bottomBtn.setTitleColor(UIColor.white, for: .normal)
        bottomBtn.backgroundColor = UI_MAIN_COLOR
        bottomBtn.layer.cornerRadius = 5.0
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
    //MARK:产品列表，第一个
    func productListFirst(){
    
        let bgImage = UIImageView()
        bgImage.image = UIImage(named:"beijing small")
        self.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(0)
        }
        let leftImage = UIImageView()
        leftImage.image = UIImage(named:homeProductFirstArray[0])
        bgImage.addSubview(leftImage)
        leftImage.snp.makeConstraints { (make) in
            make.top.equalTo(bgImage.snp.top).offset(20)
            make.left.equalTo(bgImage.snp.left).offset(25)
        }
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.init(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.text = homeProductFirstArray[1]
        bgImage.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bgImage.snp.top).offset(30)
            make.left.equalTo(leftImage.snp.right).offset(8)
            make.height.equalTo(20)
        }
        let rightImage = UIImageView()
        rightImage.image = UIImage(named:homeProductFirstArray[2])
        bgImage.addSubview(rightImage)
        rightImage.snp.makeConstraints { (make) in
            make.top.equalTo(bgImage.snp.top).offset(30)
            make.left.equalTo(titleLabel.snp.right).offset(20)
        }
        
        let moneyLabel = UILabel()
        moneyLabel.textColor = UIColor.black
        moneyLabel.textAlignment = .center
        moneyLabel.font = UIFont.systemFont(ofSize: 30)
        moneyLabel.text = homeProductFirstArray[3]
        bgImage.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(rightImage.snp.bottom).offset(10)
            make.centerX.equalTo(bgImage.snp.centerX)
            make.height.equalTo(30)
        }
        
        let termLabel = UILabel()
        termLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        termLabel.font = UIFont.systemFont(ofSize: 14)
        termLabel.text = homeProductFirstArray[4]
        bgImage.addSubview(termLabel)
        termLabel.snp.makeConstraints { (make) in
            make.top.equalTo(rightImage.snp.bottom).offset(20)
            make.right.equalTo(bgImage.snp.right).offset(-30)
            make.height.equalTo(20)
        }
        
        let loanBtn = UIButton()
        loanBtn.setTitle("我要借款", for: .normal)
        loanBtn.setTitleColor(UIColor.white, for: .normal)
        loanBtn.backgroundColor = UI_MAIN_COLOR
        loanBtn.layer.cornerRadius = 5.0
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
    
    //MARK:产品列表，其他的
    func productListOther(){
    
        let bgImage = UIImageView()
        bgImage.image = UIImage(named:"xiaokuang")
        self.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(0)
        }
        
        let bgView = UIView()
        bgImage.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(bgImage.snp.left).offset(15)
            make.right.equalTo(bgImage.snp.right).offset(-15)
            make.centerY.equalTo(bgImage.snp.centerY)
            make.height.equalTo(50)
        }
        
        let leftImage = UIImageView()
        leftImage.image = UIImage(named:homeProductOtherArray[0])
        bgView.addSubview(leftImage)
        leftImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgView.snp.centerY)
            make.left.equalTo(bgView.snp.left).offset(10)
        }
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        titleLabel.text = homeProductOtherArray[1]
        bgView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.top).offset(0)
            make.left.equalTo(leftImage.snp.right).offset(10)
            make.height.equalTo(22)
        }
        let rightImage = UIImageView()
        rightImage.image = UIImage(named:homeProductOtherArray[2])
        bgView.addSubview(rightImage)
        rightImage.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.top).offset(0)
            make.left.equalTo(titleLabel.snp.right).offset(20)
        }
        
        let moneyLabel = UILabel()
        moneyLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        moneyLabel.font = UIFont.systemFont(ofSize: 14)
        moneyLabel.text = homeProductOtherArray[3]
        bgView.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(leftImage.snp.right).offset(10)
            make.height.equalTo(20)
        }
        let termLabel = UILabel()
        termLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        termLabel.font = UIFont.systemFont(ofSize: 14)
        termLabel.text = homeProductOtherArray[4]
        bgView.addSubview(termLabel)
        termLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(moneyLabel.snp.right).offset(20)
            make.height.equalTo(20)
        }
        
        let jiantouImage = UIImageView()
        jiantouImage.image = UIImage(named:"icon_youjiantou")
        bgView.addSubview(jiantouImage)
        jiantouImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgView.snp.centerY)
            make.right.equalTo(bgView.snp.right).offset(-15)
        }
        
        let loanLabel = UILabel()
        loanLabel.textColor = UI_MAIN_COLOR
        loanLabel.font = UIFont.systemFont(ofSize: 12)
        loanLabel.text = "我要借款"
        bgView.addSubview(loanLabel)
        loanLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgView.snp.centerY)
            make.right.equalTo(jiantouImage.snp.left).offset(-8)
            make.height.equalTo(20)
        }
        if isWait{
        
            let hiddleView = UIView()
            hiddleView.backgroundColor = UIColor.black
            hiddleView.alpha = 0.5
            bgImage.addSubview(hiddleView)
            hiddleView.snp.makeConstraints({ (make) in
                make.top.equalTo(bgImage.snp.top).offset(7)
                make.left.equalTo(bgImage.snp.left).offset(8)
                make.right.equalTo(bgImage.snp.right).offset(-8)
                make.bottom.equalTo(bgImage.snp.bottom).offset(-14)
            })
            
            let label = UILabel()
            label.text = "敬请期待"
            label.textColor = UIColor.white
            label.font = UIFont.systemFont(ofSize: 30)
            hiddleView.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.centerY.equalTo(hiddleView.snp.centerY)
                make.centerX.equalTo(hiddleView.snp.centerX)
                make.height.equalTo(20)
            })
        }
    }
}


extension HomeDefaultCell{

    //提款的View
    //MARK:提款的View
   fileprivate func setView()->UIView{
    
        let view = UIView()
        self.addSubview(view)
        
        leftLabel = UILabel()
        leftLabel?.font = UIFont.systemFont(ofSize: 15)
        leftLabel?.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        leftLabel?.textAlignment = .right
        view.addSubview(leftLabel!)
        leftLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(view.snp.top).offset(0)
            make.left.equalTo(view.snp.left).offset(_k_w/2-160)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.width.equalTo(120)
        })
    
       let width = _k_w/2-160
    
        rightLabel = UILabel()
        rightLabel?.font = UIFont.systemFont(ofSize: 15)
        rightLabel?.textColor = UIColor.init(red: 63/255.0, green: 169/255.0, blue: 245/255.0, alpha: 1.0)
        rightLabel?.textAlignment = .left
        view.addSubview(rightLabel!)
        rightLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(view.snp.top).offset(0)
            make.right.equalTo(view.snp.right).offset(-width)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.width.equalTo(120)
        })
    
        return view
    }
}
//MARK:点击事件
extension HomeDefaultCell{

    //MARK:立即添加高级认证
    func advancedCertificationClick(){
    
        if delegate != nil {
            
            delegate?.advancedCertification()
        }
        print("立即添加高级认证")
    }
    
    //MARK:点击提款
    func bottomBtnClick(){
    
        if delegate != nil {
            
            delegate?.drawingBtnClick()
        }
        print("点击提款")
    }
    
    //MARK:UISlider滑动事件
    func changed(slider:UISlider){
//        print("slider.value = %d",slider.value)

        let money = Int(slider.value)
        print("整除后的数字=%d",(money/100)*100)
        defaultHeadLabel?.text = NSString(format: "%d元", (money/100)*100) as String
    }
    
    //MARK:点击立即申请
    func applyBtnClick(){
    
        if delegate != nil {
        
            let moneyStr = NSString(format: "%@", (defaultHeadLabel?.text)!) as String
            let index = moneyStr.index(moneyStr.endIndex, offsetBy: -1)
            let money = moneyStr.substring(to: index)
            
            delegate?.applyBtnClick(money)
        }
        print("点击立即申请")
    }
    
    //MARK:点击导流平台的更多
    func moreBtnClick(){
    
        if delegate != nil {
            
            delegate?.moreBtnClick()
        }
        print("点击导流平台的更多")
    }
    
    //MARK:我要借款
    func loanBtnClick(){
    
        if delegate != nil {
            
            delegate?.loanBtnClick()
        }
        print("我要借款")
    }
}
