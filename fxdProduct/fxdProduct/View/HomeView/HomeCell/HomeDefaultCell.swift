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
import SDWebImage

@objc protocol HomeDefaultCellDelegate: NSObjectProtocol {
    
    func advancedCertification()
    func drawingBtnClick()
    func applyBtnClick(_ money: String)->Void
    func moreBtnClick()
    func loanBtnClick()
    func productBtnClick(_ productId: String, isOverLimit: String)->Void
}

class HomeDefaultCell: UITableViewCell {

    weak var delegate: HomeDefaultCellDelegate?
    
    var leftLabel: UILabel?
    var rightLabel: UILabel?
    var defaultHeadLabel :UILabel?
    var homeProductData = HomeProductList()
    var defaultBgImage : UIImageView?
    var refuseBgImage : UIImageView?
    var otherPlatformsBgView : UIView?
    var drawingBgImage : UIImageView?
    var productFirstBgImage : UIImageView?
    var productSecondBgImage : UIImageView?
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
    
        defaultBgImage = UIImageView()
        defaultBgImage?.image = UIImage(named:"beijing big")
        defaultBgImage?.isUserInteractionEnabled = true
        self.addSubview(defaultBgImage!)
        defaultBgImage?.snp.makeConstraints { (make) in
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
        defaultBgImage?.addSubview(defaultHeadLabel!)
        defaultHeadLabel?.snp.makeConstraints({ (make) in
            
            make.top.equalTo((defaultBgImage?.snp.top)!).offset(30)
            make.centerX.equalTo((defaultBgImage?.snp.centerX)!)
            make.height.equalTo(30)
        })
        
        if UI_IS_IPONE5 {
            defaultHeadLabel?.snp.updateConstraints({ (make) in
                make.top.equalTo((defaultBgImage?.snp.top)!).offset(15)
            })
        }
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.init(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1.0)
        label.text = "借款额度(元)"
        label.font = UIFont.systemFont(ofSize: 15)
        defaultBgImage?.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo((defaultHeadLabel?.snp.bottom)!).offset(8)
            make.centerX.equalTo((defaultBgImage?.snp.centerX)!)
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
        defaultBgImage?.addSubview(slider)
        slider.snp.makeConstraints { (make) in

            make.top.equalTo(label.snp.bottom).offset(30)
            make.left.equalTo((defaultBgImage?.snp.left)!).offset(20)
            make.right.equalTo((defaultBgImage?.snp.right)!).offset(-20)
            
        }
        
        if UI_IS_IPONE5{
        
            slider.snp.updateConstraints({ (make) in
                make.top.equalTo(label.snp.bottom).offset(10)
            })
        }
        
        let leftLabel = UILabel()
        leftLabel.text = "500元"
        leftLabel.font = UIFont.systemFont(ofSize: 15)
        leftLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        defaultBgImage?.addSubview(leftLabel)
    
        leftLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(slider.snp.bottom).offset(-10)
            make.left.equalTo((defaultBgImage?.snp.left)!).offset(20)
            make.height.equalTo(15)
        }
        
        let rightLabel = UILabel()
        rightLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        rightLabel.text = "3000元"
        rightLabel.font = UIFont.systemFont(ofSize: 15)
        defaultBgImage?.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom).offset(-10)
            make.right.equalTo((defaultBgImage?.snp.right)!).offset(-20)
            make.height.equalTo(15)
        }
        
        let applyBtn = UIButton()
        applyBtn.setTitle("立即申请", for: .normal)
        applyBtn.setTitleColor(UIColor.white, for: .normal)
        applyBtn.setBackgroundImage(UIImage(named:"icon_anniu"), for: .normal)
//        applyBtn.backgroundColor = UIColor.clear
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        applyBtn.layer.cornerRadius = 5.0
        applyBtn.addTarget(self, action: #selector(applyBtnClick), for: .touchUpInside)
        defaultBgImage?.addSubview(applyBtn)
        applyBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo((defaultBgImage?.snp.bottom)!).offset(-60)
            make.left.equalTo((defaultBgImage?.snp.left)!).offset(25)
            make.right.equalTo((defaultBgImage?.snp.right)!).offset(-25)
            make.height.equalTo(50)
        }
        
        
        let bottomLabel = UILabel()
        bottomLabel.text = "最快2分钟审核完成"
        bottomLabel.textColor = UIColor.init(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1.0)
        bottomLabel.font = UIFont.systemFont(ofSize: 15)
        bottomLabel.textAlignment = .center
        
        let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:bottomLabel.text!)
        attrstr.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1.0), range: NSMakeRange(2,1))
        attrstr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(2,1))
        bottomLabel.attributedText = attrstr
        defaultBgImage?.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(applyBtn.snp.bottom).offset(10)
            make.centerX.equalTo((defaultBgImage?.snp.centerX)!)
            make.height.equalTo(20)
        }
        
    }
    //
    //MARK:不满60天被拒，升级高级认证
     func setupRefuseUI(){
    
        refuseBgImage = UIImageView()
        refuseBgImage?.image = UIImage(named:"beijing big")
        refuseBgImage?.isUserInteractionEnabled = true
        self.addSubview(refuseBgImage!)
        refuseBgImage?.snp.makeConstraints { (make) in
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
        refuseBgImage?.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo((refuseBgImage?.snp.top)!).offset(43)
            make.left.equalTo((refuseBgImage?.snp.left)!).offset(15)
            make.right.equalTo((refuseBgImage?.snp.right)!).offset(0)
            make.height.equalTo(20)
        }
        
        
        let firstLabel = UILabel()
        firstLabel.text = "一、60天后，更新基础资料"
        firstLabel.font = UIFont.systemFont(ofSize: 17)
        firstLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        refuseBgImage?.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalTo((refuseBgImage?.snp.left)!).offset(25)
            make.height.equalTo(20)
        }
        
        let secondLabel = UILabel()
        secondLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        secondLabel.text = "二、添加高级认证"
        secondLabel.font = UIFont.systemFont(ofSize: 17)
        refuseBgImage?.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { (make) in
            make.top.equalTo(firstLabel.snp.bottom).offset(30)
            make.left.equalTo((refuseBgImage?.snp.left)!).offset(25)
            make.height.equalTo(20)
        }
    
        let advancedCertificationBtn = UIButton()
        advancedCertificationBtn.setTitle("立即添加高级认证 >>", for: .normal)
        advancedCertificationBtn.setTitleColor(UIColor.init(red: 63/255.0, green: 169/255.0, blue: 245/255.0, alpha: 1.0), for: .normal)
        advancedCertificationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        advancedCertificationBtn.addTarget(self, action: #selector(advancedCertificationClick), for: .touchUpInside)
        refuseBgImage?.addSubview(advancedCertificationBtn)
        advancedCertificationBtn.snp.makeConstraints { (make) in
            make.top.equalTo(secondLabel.snp.bottom).offset(12)
            make.centerX.equalTo((refuseBgImage?.snp.centerX)!)
            make.height.equalTo(44)
        }
    }
    
    //
    //MARK:信用评分不足，导流其他平台
    func setupOtherPlatformsUI(){
    
        otherPlatformsBgView  = UIView()
        self.addSubview(otherPlatformsBgView!)
        otherPlatformsBgView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(0)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        })
        let titleLabel = UILabel()
        titleLabel.text = "您目前的信用评分不足，更新资料可提升(需60天后)"
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = UI_MAIN_COLOR
        titleLabel.textAlignment = .center
        otherPlatformsBgView?.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo((otherPlatformsBgView?.snp.top)!).offset(20)
            make.left.equalTo((otherPlatformsBgView?.snp.left)!).offset(0)
            make.right.equalTo((otherPlatformsBgView?.snp.right)!).offset(0)
            make.height.equalTo(13)
        }
        
        let label = UILabel()
        label.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        label.textAlignment = .center
        label.text = "先试试其他平台"
        label.font = UIFont.systemFont(ofSize: 12)
        otherPlatformsBgView?.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalTo((otherPlatformsBgView?.snp.centerX)!)
            make.height.equalTo(12)
        }
        let bgView = UIView()
        otherPlatformsBgView?.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.left.equalTo((otherPlatformsBgView?.snp.left)!).offset(0)
            make.right.equalTo((otherPlatformsBgView?.snp.right)!).offset(0)
            make.height.equalTo(homeProductData.data.thirdProductList.count * 82)
        }
        
        
        for index in 0..<homeProductData.data.thirdProductList.count {
        
            if index >= 2{
            
                if UI_IS_IPONE5{
                
                    continue
                }
            }
            let thirdRefuseView = HomeRefuseThirdView()
            thirdRefuseView.backgroundColor = UIColor.white
            thirdRefuseView.isUserInteractionEnabled = true
            thirdRefuseView.tag = index + 104
            let tapGest = UITapGestureRecognizer(target: self, action: #selector(clickFirstView(_:)))
            thirdRefuseView.addGestureRecognizer(tapGest)
            bgView.addSubview(thirdRefuseView)
            thirdRefuseView.snp.makeConstraints({ (make) in
                make.top.equalTo(bgView.snp.top).offset(index * 82)
                make.left.equalTo(bgView.snp.left).offset(0)
                make.right.equalTo(bgView.snp.right).offset(0)
                make.height.equalTo(82)
            })
           
            let url = URL(string: homeProductData.data.thirdProductList[index].extAttr.icon_)
            thirdRefuseView.leftImageView?.sd_setImage(with: url)
            
            thirdRefuseView.titleLabel?.text = homeProductData.data.thirdProductList[index].name
            thirdRefuseView.qutaLabel?.text = homeProductData.data.thirdProductList[index].principalTop
            thirdRefuseView.termLabel?.text = homeProductData.data.thirdProductList[index].stagingTop
            thirdRefuseView.termLabel?.text = "期限:"+homeProductData.data.thirdProductList[index].stagingBottom+"-"+homeProductData.data.thirdProductList[index].stagingTop+"天"
            thirdRefuseView.feeLabel?.text = "费用：" + homeProductData.data.thirdProductList[0].extAttr.charge_desc_
            let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(thirdRefuseView.termLabel?.text)!)
            attrstr.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1.0), range: NSMakeRange(3,attrstr.length-4))
            thirdRefuseView.termLabel?.attributedText = attrstr
            let attrstr1 : NSMutableAttributedString = NSMutableAttributedString(string:(thirdRefuseView.feeLabel?.text)!)
            attrstr1.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1.0), range: NSMakeRange(3,attrstr1.length-5))
            thirdRefuseView.feeLabel?.attributedText = attrstr1
            let str = homeProductData.data.thirdProductList[index].extAttr.tags[0]
            thirdRefuseView.descBtn?.setTitle(str as? String, for: .normal)
            thirdRefuseView.descBtn?.setTitleColor(UI_MAIN_COLOR, for: .normal)
            setCornerBorder(view: thirdRefuseView.descBtn!, borderColor: UI_MAIN_COLOR)
            
            
        }
        
        
        let moreBtn = UIButton()
        moreBtn.setTitle("更多", for: .normal)
        moreBtn.titleLabel?.textAlignment = .center
        moreBtn.setTitleColor(UIColor.init(red: 63/255.0, green: 169/255.0, blue: 245/255.0, alpha: 1.0), for: .normal)
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        moreBtn.addTarget(self, action: #selector(moreBtnClick), for: .touchUpInside)
        otherPlatformsBgView?.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
//            if UI_IS_IPONE5 {
//            
//                make.bottom.equalTo(bgView.snp.bottom).offset(25)
//            }else{
            
                make.bottom.equalTo(bgView.snp.bottom).offset(25)
//            }
            
            make.centerX.equalTo((otherPlatformsBgView?.snp.centerX)!)
            make.height.equalTo(20)
        }
        
        if UI_IS_IPONE5{
            
            moreBtn.snp.updateConstraints({ (make) in
                make.bottom.equalTo(bgView.snp.bottom).offset(25)
            })
        }
        
    }
    
    //进件带提款
    //MARK:进件带提款
    func setupDrawingUI(){
    

        var dataArray : [HomeInfoList] = [HomeInfoList]()
        for index in homeProductData.data.infoList {
            dataArray.append(index)
        }
        
        for index in 0..<dataArray.count{
            
            for x in index+1..<dataArray.count{
                
                if dataArray[index].index > dataArray[x].index{
                    
                    let temp = dataArray[index]
                    dataArray[index] = dataArray[x]
                    dataArray[x] = temp
                }
            }
        }
        
        
        drawingBgImage = UIImageView()
        drawingBgImage?.image = UIImage(named:"beijing big")
        drawingBgImage?.isUserInteractionEnabled = true
        self.addSubview(drawingBgImage!)
        drawingBgImage?.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(0)
        }
        
        let bgView = UIView()
    
        drawingBgImage?.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.centerY.equalTo((drawingBgImage?.snp.centerY)!)
            make.left.equalTo((drawingBgImage?.snp.left)!).offset(0)
            make.right.equalTo((drawingBgImage?.snp.right)!).offset(0)
            make.height.equalTo((homeProductData.data.infoList.count*36)+70)

        }
        
//        if UI_IS_IPONE5{
//        
//            bgView.snp.updateConstraints({ (make) in
//                make.height.equalTo((homeProductData.data.infoList.count*25)+70)
//            })
//        }
        
        var i = 0
        if homeProductData.data.warnText != "" && homeProductData.data.warnText != nil {
            let drawingTitleLabel = UILabel()
            drawingTitleLabel.textAlignment = .center
            drawingTitleLabel.textColor = UIColor.init(red: 237/255.0, green: 28/255.0, blue: 36/255.0, alpha: 1.0)
            drawingTitleLabel.text = homeProductData.data.warnText
            drawingTitleLabel.font = UIFont.systemFont(ofSize: 19)
            bgView.addSubview(drawingTitleLabel)
            drawingTitleLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(bgView.snp.top).offset(0)
                make.centerX.equalTo(bgView.snp.centerX)
                make.height.equalTo(20)
            })
            i = 20
        }
        
        if homeProductData.data.subWarnText != "" && homeProductData.data.subWarnText != nil{
        
            let tipLabel = UILabel()
            tipLabel.textColor = UIColor.init(red: 179/255.0, green: 179/255.0, blue: 179/255.0, alpha: 1.0)
            tipLabel.textAlignment = .center
            tipLabel.font = UIFont.systemFont(ofSize: 14)
            tipLabel.text = homeProductData.data.subWarnText
            bgView.addSubview(tipLabel)
            tipLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(bgView.snp.top).offset(35)
                make.centerX.equalTo(bgView.snp.centerX)
                make.height.equalTo(14)
            })
            
            i = 50
        }
        
        
        var j = 0
        for index in 0..<homeProductData.data.infoList.count {
            let indexView = setView()
            bgView.addSubview(indexView)
            
            if index == 0 {
                if(i == 0){
                
                    j = 0
                }else{
                
                    j = 10+i
                }
                
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
            
            leftLabel?.text = dataArray[index].label
            rightLabel?.text = dataArray[index].value
           
//            for k in 0..<homeProductData.data.infoList.count{
//            
//                let str = homeProductData.data.infoList[k].index
//                
//                if (index+1 == Int(str!)!){
//                
//                    leftLabel?.text = homeProductData.data.infoList[k].label
//                    rightLabel?.text = homeProductData.data.infoList[k].value
//                    
//                }
//            }
            
//            for k in 0..<dataArray.count{
//                    
//                leftLabel?.text = dataArray[k].label
//                rightLabel?.text = dataArray[k].value
//                
//            }
        }
        
        bgView.snp.updateConstraints({ (make) in
            make.height.equalTo(j+84)
        })
        let bottomBtn = UIButton()
        bottomBtn.setTitle(homeProductData.data.buttonText, for: .normal)
        bottomBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        bottomBtn.setTitleColor(UIColor.white, for: .normal)
        bottomBtn.setBackgroundImage(UIImage(named:"icon_anniu"), for: .normal)
        bottomBtn.layer.cornerRadius = 5.0
        bottomBtn.addTarget(self, action: #selector(bottomBtnClick), for: .touchUpInside)
        bgView.addSubview(bottomBtn)
        bottomBtn.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.top).offset(j+40)
            make.left.equalTo(bgView.snp.left).offset(40)
            make.right.equalTo(bgView.snp.right).offset(-40)
            make.height.equalTo(44)
        }
        
    }
    
    //产品列表，第一个
    //MARK:产品列表，第一个
    func productListFirst(){
    
        productFirstBgImage = UIImageView()
        productFirstBgImage?.isUserInteractionEnabled = true
        productFirstBgImage?.image = UIImage(named:"beijing small")
        productFirstBgImage?.tag = 101
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(clickFirstView(_:)))
        productFirstBgImage?.addGestureRecognizer(tapGest)
        self.addSubview(productFirstBgImage!)
        productFirstBgImage?.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(0)
        }
        
        let leftImage = UIImageView()
        let url = URL(string: homeProductData.data.productList[0].icon)
        leftImage.sd_setImage(with: url)
        productFirstBgImage?.addSubview(leftImage)
        leftImage.snp.makeConstraints { (make) in
            make.top.equalTo((productFirstBgImage?.snp.top)!).offset(20)
            make.left.equalTo((productFirstBgImage?.snp.left)!).offset(25)
            make.width.equalTo(38)
            make.height.equalTo(38)
        }
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.init(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.text = homeProductData.data.productList[0].productName
        productFirstBgImage?.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo((productFirstBgImage?.snp.top)!).offset(30)
            make.left.equalTo(leftImage.snp.right).offset(8)
            make.height.equalTo(20)
        }
        let rightImage = UIImageView()
        
        rightImage.image = UIImage(named:"home_04")
        if homeProductData.data.productList[0].productId == RapidLoan || homeProductData.data.productList[0].productId == DeriveRapidLoan{
        
            rightImage.image = UIImage(named:"home_05")
        }
        productFirstBgImage?.addSubview(rightImage)
        rightImage.snp.makeConstraints { (make) in
            make.top.equalTo((productFirstBgImage?.snp.top)!).offset(30)
            make.left.equalTo(titleLabel.snp.right).offset(20)
        }
        
        let moneyLabel = UILabel()
        moneyLabel.textColor = UIColor.black
        moneyLabel.textAlignment = .center
        moneyLabel.font = UIFont.systemFont(ofSize: 30)
        moneyLabel.text = homeProductData.data.productList[0].amount
        productFirstBgImage?.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(rightImage.snp.bottom).offset(10)
            make.centerX.equalTo((productFirstBgImage?.snp.centerX)!)
            make.height.equalTo(30)
        }
        
        let termLabel = UILabel()
        termLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        termLabel.font = UIFont.systemFont(ofSize: 14)
        termLabel.text = homeProductData.data.productList[0].period
        productFirstBgImage?.addSubview(termLabel)
        termLabel.snp.makeConstraints { (make) in
            make.top.equalTo(rightImage.snp.bottom).offset(20)
            make.right.equalTo((productFirstBgImage?.snp.right)!).offset(-30)
            make.height.equalTo(20)
        }
        
        let loanBtn = UIButton()
        loanBtn.setTitle("我要借款", for: .normal)
        loanBtn.setTitleColor(UIColor.white, for: .normal)
        loanBtn.layer.cornerRadius = 5.0
        loanBtn.setBackgroundImage(UIImage(named:"icon_anniu"), for: .normal)
        loanBtn.addTarget(self, action: #selector(loanBtnClick), for: .touchUpInside)
        loanBtn.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        productFirstBgImage?.addSubview(loanBtn)
        loanBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo((productFirstBgImage?.snp.bottom)!).offset(-20)
            make.left.equalTo((productFirstBgImage?.snp.left)!).offset(20)
            make.right.equalTo((productFirstBgImage?.snp.right)!).offset(-20)
            make.height.equalTo(50)
        }

    }
    
    //MARK:产品列表，其他的
    func productListOther(index:NSInteger){
    
        productSecondBgImage = UIImageView()
        productSecondBgImage?.isUserInteractionEnabled = true
        productSecondBgImage?.image = UIImage(named:"xiaokuang")
        self.addSubview(productSecondBgImage!)
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(clickFirstView(_:)))
        productSecondBgImage?.addGestureRecognizer(tapGest)
        
        productSecondBgImage?.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(0)
        }
        
        let bgView = UIView()
        productSecondBgImage?.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo((productSecondBgImage?.snp.left)!).offset(20)
            make.right.equalTo((productSecondBgImage?.snp.right)!).offset(-20)
            make.centerY.equalTo((productSecondBgImage?.snp.centerY)!)
            make.height.equalTo(50)
        }
        
        let leftImage = UIImageView()
        bgView.addSubview(leftImage)
        leftImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgView.snp.centerY)
            make.left.equalTo(bgView.snp.left).offset(0)
            make.width.equalTo(38)
            make.height.equalTo(38)
        }
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        bgView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.top).offset(0)
            make.left.equalTo(leftImage.snp.right).offset(10)
            make.height.equalTo(22)
        }
        let rightImage = UIImageView()
        
//        if homeProductData.data.productList[1].productId == "P001004"{
//            
//            rightImage.image = UIImage(named:"home_05")
//        }
        rightImage.image = UIImage(named:"home_05")
        bgView.addSubview(rightImage)
        rightImage.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.top).offset(0)
            make.left.equalTo(titleLabel.snp.right).offset(15)
        }
        
        let moneyLabel = UILabel()
        moneyLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        moneyLabel.font = UIFont.systemFont(ofSize: 14)
        bgView.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(leftImage.snp.right).offset(10)
            make.height.equalTo(20)
        }
        let termLabel = UILabel()
        termLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        termLabel.font = UIFont.systemFont(ofSize: 14)
        bgView.addSubview(termLabel)
        termLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(moneyLabel.snp.right).offset(20)
            make.height.equalTo(20)
        }
        
        var product :HomeProductsList
        
        product = homeProductData.data.productList[index-1]
//        product = homeProductData.data.productList[2]
//        if index == 2{
//        
//            product = homeProductData.data.productList[1]
//            
//        }
        
        productSecondBgImage?.tag = 100+index
        if product.productId == SalaryLoan{
            
            rightImage.image = UIImage(named:"home_04")
        }
        let url1 = URL(string: product.icon)
        leftImage.sd_setImage(with: url1)
        titleLabel.text = product.productName
        moneyLabel.text = product.amount
        termLabel.text = product.period
        
        
        let jiantouImage = UIImageView()
        jiantouImage.image = UIImage(named:"icon_youjiantou")
        bgView.addSubview(jiantouImage)
        jiantouImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgView.snp.centerY)
            make.right.equalTo(bgView.snp.right).offset(0)
            make.height.equalTo(14)
            make.width.equalTo(8)
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
        if (product.isValidate == "0"){
        
            productSecondBgImage?.isUserInteractionEnabled = false
            let hiddleImage = UIImageView()
            hiddleImage.image = UIImage(named:"yinying")
            productSecondBgImage?.addSubview(hiddleImage)
            hiddleImage.snp.makeConstraints({ (make) in
                
                make.top.equalTo((productSecondBgImage?.snp.top)!).offset(-2)
                make.left.equalTo((productSecondBgImage?.snp.left)!).offset(0)
                make.right.equalTo((productSecondBgImage?.snp.right)!).offset(0)
                make.bottom.equalTo((productSecondBgImage?.snp.bottom)!).offset(-2)
            })
            
            let label = UILabel()
            label.text = "敬请期待"
            label.textColor = UIColor.white
            label.font = UIFont.systemFont(ofSize: 30)
            hiddleImage.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.centerY.equalTo(hiddleImage.snp.centerY)
                make.centerX.equalTo(hiddleImage.snp.centerX)
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
            make.width.equalTo(130)
        })
    
       let width = _k_w/2-170
    
        rightLabel = UILabel()
        rightLabel?.font = UIFont.systemFont(ofSize: 15)
        rightLabel?.textColor = UIColor.init(red: 63/255.0, green: 169/255.0, blue: 245/255.0, alpha: 1.0)
        rightLabel?.textAlignment = .left
        view.addSubview(rightLabel!)
        rightLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(view.snp.top).offset(0)
            make.right.equalTo(view.snp.right).offset(-width)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.width.equalTo(130)
        })
    
        return view
    }
    
    func setCornerBorder(view:UIView,borderColor:UIColor) -> Void {
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1;
        view.layer.borderColor = borderColor.cgColor
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
//        print("整除后的数字=%d",(money/500)*500)
        defaultHeadLabel?.text = NSString(format: "%d元", (money/500)*500) as String
        
//        print("整除后的数字=%d",(money/100)*100)
//        defaultHeadLabel?.text = NSString(format: "%d元", (money/100)*100) as String

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
    
    func clickFirstView(_ tapGes : UITapGestureRecognizer){
        
        var productId = ""
        var isOverLimit = ""
        let tag = tapGes.view?.tag
        switch tag! {
        case 101:
            productId = homeProductData.data.productList[0].productId
            isOverLimit = homeProductData.data.productList[0].isOverLimit
//            productId = "第一个View"
        case 102:
            productId = homeProductData.data.productList[1].productId
            isOverLimit = homeProductData.data.productList[1].isOverLimit
//            productId = "点击第二个View"
        case 103:
            productId = homeProductData.data.productList[2].productId
            isOverLimit = homeProductData.data.productList[2].isOverLimit
        case 104:
            productId = homeProductData.data.thirdProductList[0].extAttr.path_

        case 105:
            productId = homeProductData.data.thirdProductList[1].extAttr.path_

        case 106:
            productId = homeProductData.data.thirdProductList[2].extAttr.path_

        default:
            break
        }
        
        if delegate != nil {
        
            delegate?.productBtnClick(productId ,isOverLimit: isOverLimit)
            
        }
        print("点击产品列表")
    }
}
