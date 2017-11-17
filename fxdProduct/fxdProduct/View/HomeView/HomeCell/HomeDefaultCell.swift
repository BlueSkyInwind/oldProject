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
    
    //高级认证按钮
    func addAdvancedCertificationBtnClick()
    //点击提款按钮
    func drawingBtnClick()
    //首次借款按钮
    func applyImmediatelyBtnClick(_ money: String)->Void
    //更多按钮
    func moreBtnClick()
    //我要借款按钮
    func loanBtnClick()
    //点击产品按钮
    func productListClick(_ productId: String, isOverLimit: String, amount: String)->Void
    //其他平台按钮
    func otherBtnClick()
    //第三方产品列表按钮
    func thirdPartyDiversionListClick(_ index: NSInteger)->Void
    
}


typealias tabRefuseCell = (_ index: NSInteger)->Void

class HomeDefaultCell: UITableViewCell ,UITableViewDelegate,UITableViewDataSource{

   @objc weak var delegate: HomeDefaultCellDelegate?
    
   @objc var tabRefuseCellClosure : tabRefuseCell?
   //进件视图的左边标题
   @objc var leftLabel: UILabel?
    //进件视图的右边内容
   @objc var rightLabel: UILabel?
    //默认视图的金额
   @objc var defaultHeadLabel :UILabel?
    //产品数据
   @objc var homeProductData = HomeProductList()
    //默认视图的背景图片
   @objc var defaultBgImage : UIImageView?
    //拒绝导流的背景图片
   @objc var refuseBgImage : UIImageView?
    //第三方产品列表背景图片
   @objc  var otherPlatformsBgView : UIView?
    //进件详情的背景图片
   @objc var drawingBgImage : UIImageView?
    //产品列表第一个产品背景图片
   @objc  var productFirstBgImage : UIImageView?
    //产品列表第二个产品背景图片
   @objc var productSecondBgImage : UIImageView?
    //
   @objc var refuseBgView : UIView?
    //拒绝导流第三方的左边标题数组
   @objc var refuseLeftTitle : Array<Any>?
    //拒绝导流第三方的右边内容数组
   @objc var refuseRightTitle : Array<Any>?
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
   @objc func setupDefaultUI(){
    
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
            
            make.top.equalTo((defaultBgImage?.snp.top)!).offset(50)
            make.centerX.equalTo((defaultBgImage?.snp.centerX)!)
            make.height.equalTo(30)
        })
    
        
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
        
        var imagea = setImageFrame(UIImage(named:"icon_quan")!, size: CGSize(width:28,height:28))
    
        slider.setThumbImage(imagea, for: .normal)
        
//        slider.setThumbImage(UIImage.init(named: "icon_quan"), for: UIControlState.normal)
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
            make.left.equalTo((defaultBgImage?.snp.left)!).offset(15)
            make.right.equalTo((defaultBgImage?.snp.right)!).offset(-15)
            
        }
        
        let leftLabel = UILabel()
        leftLabel.text = "500元"
        leftLabel.font = UIFont.systemFont(ofSize: 15)
        leftLabel.textAlignment = .left
        leftLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        defaultBgImage?.addSubview(leftLabel)
    
        leftLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(slider.snp.bottom).offset(5)
            make.left.equalTo((defaultBgImage?.snp.left)!).offset(30)
            make.height.equalTo(15)
        }
        
        let rightLabel = UILabel()
        rightLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        rightLabel.text = "3000元"
        rightLabel.textAlignment = .right
        rightLabel.font = UIFont.systemFont(ofSize: 15)
        defaultBgImage?.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom).offset(5)
            make.right.equalTo((defaultBgImage?.snp.right)!).offset(-30)
            make.height.equalTo(15)
        }
        
        let applyBtn = UIButton()
        applyBtn.setTitle("立即申请", for: .normal)
        applyBtn.setTitleColor(UIColor.white, for: .normal)
        applyBtn.setBackgroundImage(UIImage(named:"icon_anniu"), for: .normal)
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
        attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1.0), range: NSMakeRange(2,1))
        attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(2,1))
        bottomLabel.attributedText = attrstr
        defaultBgImage?.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(applyBtn.snp.bottom).offset(10)
            make.centerX.equalTo((defaultBgImage?.snp.centerX)!)
            make.height.equalTo(20)
        }
    
    //适配iPhone4
        if UI_IS_IPONE4{
        
            defaultHeadLabel?.snp.updateConstraints({ (make) in
                make.top.equalTo((defaultBgImage?.snp.top)!).offset(0)
            })
            defaultHeadLabel?.font = UIFont.systemFont(ofSize: 20)
            
            label.snp.updateConstraints({ (make) in
                 make.top.equalTo((defaultHeadLabel?.snp.bottom)!).offset(0)
            })
            
            imagea  = setImageFrame(UIImage(named:"icon_quan")!, size: CGSize(width:20,height:20))
            slider.setThumbImage(imagea, for: .normal)
            slider.snp.updateConstraints({ (make) in
                
                make.top.equalTo(label.snp.bottom).offset(5)
                make.left.equalTo((defaultBgImage?.snp.left)!).offset(20)
                make.right.equalTo((defaultBgImage?.snp.right)!).offset(-20)
            })
            
            leftLabel.snp.updateConstraints({ (make) in
                make.top.equalTo(slider.snp.bottom).offset(5)
            })
            
            rightLabel.snp.updateConstraints({ (make) in
                
                make.top.equalTo(slider.snp.bottom).offset(5)
            })
            applyBtn.snp.updateConstraints({ (make) in
                make.bottom.equalTo((defaultBgImage?.snp.bottom)!).offset(-30)
                make.height.equalTo(25)
            })
            applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            bottomLabel.snp.updateConstraints({ (make) in
                
                make.top.equalTo(applyBtn.snp.bottom).offset(5)
                make.height.equalTo(10)
            })
            bottomLabel.font = UIFont.systemFont(ofSize: 10)
        }
    
     //适配iPhone5
        if UI_IS_IPONE5 {
            defaultHeadLabel?.snp.updateConstraints({ (make) in
                make.top.equalTo((defaultBgImage?.snp.top)!).offset(15)
            })
            
            defaultHeadLabel?.font = UIFont.systemFont(ofSize: 25)
            
            imagea  = setImageFrame(UIImage(named:"icon_quan")!, size: CGSize(width:24,height:24))
            
            slider.snp.updateConstraints({ (make) in
                make.top.equalTo(label.snp.bottom).offset(10)
            })
            
            applyBtn.snp.updateConstraints({ (make) in
                
                make.bottom.equalTo((defaultBgImage?.snp.bottom)!).offset(-50)
                make.height.equalTo(40)
            })
            applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            
            leftLabel.snp.updateConstraints({ (make) in
                make.top.equalTo(slider.snp.bottom).offset(0)
            })
            
            rightLabel.snp.updateConstraints({ (make) in
                make.top.equalTo(slider.snp.bottom).offset(0)
            })
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
            make.top.equalTo(self).offset(24)
            make.left.equalTo(self).offset(17)
            make.right.equalTo(self).offset(-17)
            make.bottom.equalTo(self).offset(0)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "您目前的信用评分不足，以下途径可提高评分"
        textLabel?.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        if UI_IS_IPONE5 {
            titleLabel.font = UIFont.systemFont(ofSize: 12)
        }
        titleLabel.textColor = UIColor.init(red: 63/255.0, green: 169/255.0, blue: 245/255.0, alpha: 1.0)
        refuseBgImage?.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo((refuseBgImage?.snp.top)!).offset(43)
            make.left.equalTo((refuseBgImage?.snp.left)!).offset(25)
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
        
        let thirdLabel = UILabel()
        thirdLabel.textColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        thirdLabel.text = "三、尝试其他平台"
        thirdLabel.font = UIFont.systemFont(ofSize: 17)
        refuseBgImage?.addSubview(thirdLabel)
        thirdLabel.snp.makeConstraints { (make) in
            make.top.equalTo(advancedCertificationBtn.snp.bottom).offset(20)
            make.left.equalTo((refuseBgImage?.snp.left)!).offset(25)
            make.height.equalTo(20)
        }
        
        let otherBtn = UIButton()
        otherBtn.setTitle("进入精选平台 >>", for: .normal)
        otherBtn.setTitleColor(UIColor.init(red: 63/255.0, green: 169/255.0, blue: 245/255.0, alpha: 1.0), for: .normal)
        otherBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        otherBtn.addTarget(self, action: #selector(otherBtnClick), for: .touchUpInside)
        refuseBgImage?.addSubview(otherBtn)
        otherBtn.snp.makeConstraints { (make) in
            make.top.equalTo(thirdLabel.snp.bottom).offset(20)
            make.left.equalTo((refuseBgImage?.snp.left)!).offset(35)
            make.height.equalTo(20)
        }
        
    }
    
    
   @objc func refuseTab(){
    
        refuseLeftTitle = ["60天后,更新基础资料","添加高级认证","尝试其他平台"]
        refuseRightTitle = ["前往更新","立即添加","精选平台"]
        refuseBgView = UIView()
        refuseBgView?.backgroundColor = LINE_COLOR
        self.addSubview(refuseBgView!)
        refuseBgView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(-2)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(7)
        })
        
        let headerLabel = UILabel()
        headerLabel.text = "您目前的信用评分不足,可进行以下操作"
        headerLabel.textColor = UI_MAIN_COLOR
        headerLabel.font = UIFont.systemFont(ofSize: 15)
        refuseBgView?.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.top.equalTo((refuseBgView?.snp.top)!).offset(20)
            make.centerX.equalTo((refuseBgView?.snp.centerX)!)
            make.height.equalTo(20)
        }
        
        let refuseTab = UITableView()
        refuseTab.delegate = self
        refuseTab.dataSource = self
        refuseTab.showsHorizontalScrollIndicator = false
        refuseTab.isScrollEnabled = false
        refuseTab.separatorStyle = .none
        self.addSubview(refuseTab)
        refuseTab.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(20)
            make.left.equalTo((refuseBgView?.snp.left)!).offset(0)
            make.right.equalTo((refuseBgView?.snp.right)!).offset(00)
            make.bottom.equalTo((refuseBgView?.snp.bottom)!).offset(-40)
        }
    }
    //
    //MARK:信用评分不足，导流其他平台
  @objc  func setupOtherPlatformsUI(){
    
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
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1.0), range: NSMakeRange(3,attrstr.length-4))
            thirdRefuseView.termLabel?.attributedText = attrstr
            let attrstr1 : NSMutableAttributedString = NSMutableAttributedString(string:(thirdRefuseView.feeLabel?.text)!)
            attrstr1.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 251/255.0, green: 176/255.0, blue: 59/255.0, alpha: 1.0), range: NSMakeRange(3,attrstr1.length-5))
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

            make.bottom.equalTo(bgView.snp.bottom).offset(25)
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
   @objc func setupDrawingUI(){
    

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
        
        
        
        var i = 0
        if homeProductData.data.warnText != "" && homeProductData.data.warnText != nil {
            let drawingTitleLabel = UILabel()
            drawingTitleLabel.textAlignment = .center
            drawingTitleLabel.textColor = UIColor.init(red: 237/255.0, green: 28/255.0, blue: 36/255.0, alpha: 1.0)
            drawingTitleLabel.text = homeProductData.data.warnText
            drawingTitleLabel.font = UIFont.systemFont(ofSize: 19)
            drawingBgImage?.addSubview(drawingTitleLabel)
            drawingTitleLabel.snp.makeConstraints({ (make) in

                make.top.equalTo((drawingBgImage?.snp.top)!).offset(30)
                make.centerX.equalTo((drawingBgImage?.snp.centerX)!)
                make.height.equalTo(20)
            })
            i = 50
            
            if UI_IS_IPONE5{
                
                drawingTitleLabel.snp.updateConstraints({ (make) in
                    make.top.equalTo((drawingBgImage?.snp.top)!).offset(20)
                })
                i = 40
            }
            
        }
        
        if homeProductData.data.subWarnText != "" && homeProductData.data.subWarnText != nil{
        
            let tipLabel = UILabel()
            tipLabel.textColor = UIColor.init(red: 179/255.0, green: 179/255.0, blue: 179/255.0, alpha: 1.0)
            tipLabel.textAlignment = .center
            tipLabel.font = UIFont.systemFont(ofSize: 14)
            tipLabel.text = homeProductData.data.subWarnText
            drawingBgImage?.addSubview(tipLabel)
            tipLabel.snp.makeConstraints({ (make) in
                make.top.equalTo((drawingBgImage?.snp.top)!).offset(60)
                make.centerX.equalTo((drawingBgImage?.snp.centerX)!)
                make.height.equalTo(14)
            })
            
            i = 80
            
            if UI_IS_IPONE5{
                
                tipLabel.snp.updateConstraints({ (make) in
                    make.top.equalTo((drawingBgImage?.snp.top)!).offset(50)
                })
                i = 70
            }
        }
        
        let contentView = UIView()
        drawingBgImage?.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo((drawingBgImage?.snp.top)!).offset(i)
            make.left.equalTo((drawingBgImage?.snp.left)!).offset(0)
            make.right.equalTo((drawingBgImage?.snp.right)!).offset(0)
            make.bottom.equalTo((drawingBgImage?.snp.bottom)!).offset(-110)
        }
        
        let bgView = UIView()
        
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.centerY.equalTo((contentView.snp.centerY))
            make.left.equalTo((contentView.snp.left)).offset(0)
            make.right.equalTo((contentView.snp.right)).offset(0)
            make.height.equalTo((homeProductData.data.infoList.count*36))
            
        }
        
        
        var j = 0
        for index in 0..<homeProductData.data.infoList.count {
            let indexView = setView()
            bgView.addSubview(indexView)

            indexView.snp.makeConstraints({ (make) in
                make.top.equalTo(bgView.snp.top).offset(j)
                make.left.equalTo(bgView.snp.left).offset(0)
                make.right.equalTo(bgView.snp.right).offset(0)
                make.height.equalTo(30)
            })
            
            if UI_IS_IPONE5{
                
                j = j+25
            }else{
                
                j = j+36
            }
            leftLabel?.text = dataArray[index].label
            rightLabel?.text = dataArray[index].value
           
        }
        
        bgView.snp.updateConstraints({ (make) in
            make.height.equalTo(j)
        })
        let bottomBtn = UIButton()
        bottomBtn.setTitle(homeProductData.data.buttonText, for: .normal)
        bottomBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        bottomBtn.setTitleColor(UIColor.white, for: .normal)
        bottomBtn.setBackgroundImage(UIImage(named:"icon_anniu"), for: .normal)
        bottomBtn.layer.cornerRadius = 5.0
        bottomBtn.addTarget(self, action: #selector(bottomBtnClick), for: .touchUpInside)
        drawingBgImage?.addSubview(bottomBtn)
        bottomBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo((drawingBgImage?.snp.bottom)!).offset(-60)
            make.left.equalTo((drawingBgImage?.snp.left)!).offset(40)
            make.right.equalTo((drawingBgImage?.snp.right)!).offset(-40)
            make.height.equalTo(44)
        }
        
        if UI_IS_IPONE6P{
        
            bottomBtn.snp.updateConstraints({ (make) in
                make.bottom.equalTo((drawingBgImage?.snp.bottom)!).offset(-80)
            })
            
            contentView.snp.updateConstraints({ (make) in
                
                make.bottom.equalTo((drawingBgImage?.snp.bottom)!).offset(-130)
            })
            
        }
        
        if UI_IS_IPONE5{
        
            bottomBtn.snp.updateConstraints({ (make) in
                make.bottom.equalTo((drawingBgImage?.snp.bottom)!).offset(-20)
                make.height.equalTo(40)
            })
            
            
            contentView.snp.updateConstraints({ (make) in
                
                make.bottom.equalTo((drawingBgImage?.snp.bottom)!).offset(-70)
            })
        }
        
        if homeProductData.data.productId == SalaryLoan{
        
            if homeProductData.data.flag == "7"{

                bottomBtn.snp.updateConstraints({ (make) in
                    make.bottom.equalTo((drawingBgImage?.snp.bottom)!).offset(-30)
                })
 
                contentView.snp.updateConstraints({ (make) in
                    
                    make.bottom.equalTo((drawingBgImage?.snp.bottom)!).offset(-80)
                })
                if UI_IS_IPONE5{
                
                    bottomBtn.snp.updateConstraints({ (make) in
                        make.bottom.equalTo((drawingBgImage?.snp.bottom)!).offset(-20)
                    })
                    
                    contentView.snp.updateConstraints({ (make) in
                        
                        make.bottom.equalTo((drawingBgImage?.snp.bottom)!).offset(-70)
                    })
                }
            }
        }
    }
    
    //产品列表，第一个
    //MARK:产品列表，第一个
  @objc  func productListFirst(){
    
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
            make.top.equalTo(moneyLabel.snp.bottom).offset(18)
            make.centerX.equalTo((productFirstBgImage?.snp.centerX)!)
            make.width.equalTo(240)
            make.height.equalTo(38)
        }
    
        let tipLable = UILabel()
        tipLable.text = "借款享提额, 最高5000元"
        tipLable.font = UIFont.systemFont(ofSize: 12)
        tipLable.textColor = UIColor.red
        productFirstBgImage?.addSubview(tipLable)
        tipLable.snp.makeConstraints { (make) in
            make.centerX.equalTo((productFirstBgImage?.snp.centerX)!)
            make.bottom.equalTo((productFirstBgImage?.snp.bottom)!).offset(-19)
        }
    
    if UI_IS_IPONE5 {
        loanBtn.snp.updateConstraints({ (make) in
            make.top.equalTo(moneyLabel.snp.bottom).offset(5)
        })
        
        tipLable.snp.updateConstraints({ (make) in
            make.bottom.equalTo((productFirstBgImage?.snp.bottom)!).offset(-12)
        })
    }
    }
    
    //MARK:产品列表，其他的
   @objc func productListOther(index:NSInteger){
    
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
    
    //MARK:设置CornerBorder
    fileprivate func setCornerBorder(view:UIView,borderColor:UIColor) -> Void {
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1;
        view.layer.borderColor = borderColor.cgColor
    }
    
    //MARK:设置slider图片大小
    fileprivate func setImageFrame(_ image: UIImage, size: CGSize) ->(UIImage){
    
            UIGraphicsBeginImageContext(size);
            image.draw(in: CGRect(x:0,y:0,width:size.width,height:size.height))
            let scaleImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return scaleImage!;  
       
    }
    fileprivate func refuseView(){
    
        
    }
}
//MARK:点击事件
extension HomeDefaultCell{

    //MARK:立即添加高级认证
    @objc func advancedCertificationClick(){
    
        if delegate != nil {
            
            delegate?.addAdvancedCertificationBtnClick()
        }
        print("立即添加高级认证")
    }
    
    //MARK:精选平台
    @objc func otherBtnClick(){
    
        if delegate != nil {
        
            delegate?.otherBtnClick()
        }
        print("精选平台")
    }
    
    //MARK:点击提款
    @objc func bottomBtnClick(){
    
        if delegate != nil {
            
            delegate?.drawingBtnClick()
        }
        print("点击提款")
    }
    
    //MARK:UISlider滑动事件
    @objc func changed(slider:UISlider){
//        print("slider.value = %d",slider.value)

        let money = Int(slider.value)
//        print("整除后的数字=%d",(money/500)*500)
        defaultHeadLabel?.text = NSString(format: "%d元", (money/500)*500) as String
        
//        print("整除后的数字=%d",(money/100)*100)
//        defaultHeadLabel?.text = NSString(format: "%d元", (money/100)*100) as String

    }
    
    //MARK:点击立即申请
    @objc func applyBtnClick(){
    
        if delegate != nil {
        
            let moneyStr = NSString(format: "%@", (defaultHeadLabel?.text)!) as String
            let index = moneyStr.index(moneyStr.endIndex, offsetBy: -1)
            let money = moneyStr.substring(to: index)
            
            delegate?.applyImmediatelyBtnClick(money)
        }
        print("点击立即申请")
    }
    
    //MARK:点击导流平台的更多
    @objc func moreBtnClick(){
    
        if delegate != nil {
            
            delegate?.moreBtnClick()
        }
        print("点击导流平台的更多")
    }
    
    //MARK:我要借款
    @objc func loanBtnClick(){
    
        if delegate != nil {
            
            delegate?.loanBtnClick()
        }
        print("我要借款")
    }
    
    @objc func clickFirstView(_ tapGes : UITapGestureRecognizer){
        
        var productId = ""
        var isOverLimit = ""
        var amount = ""
        let tag = tapGes.view?.tag
        //101：产品列表第一个产品
        //102：产品列表第二个产品
        //103：产品列表第三个产品
        //104：拒绝导流第一个产品
        //105：拒绝导流第二个产品
        //106：拒绝导流第三个产品
        
        switch tag! {
        case 101:
            productId = homeProductData.data.productList[0].productId
            isOverLimit = homeProductData.data.productList[0].isOverLimit
            amount = homeProductData.data.productList[0].amount
//            productId = "第一个View"
        case 102:
            productId = homeProductData.data.productList[1].productId
            isOverLimit = homeProductData.data.productList[1].isOverLimit
            amount = homeProductData.data.productList[1].amount
//            productId = "点击第二个View"
        case 103:
            productId = homeProductData.data.productList[2].productId
            isOverLimit = homeProductData.data.productList[2].isOverLimit
            amount = homeProductData.data.productList[2].amount
        case 104:
            productId = homeProductData.data.thirdProductList[0].extAttr.path_

        case 105:
            productId = homeProductData.data.thirdProductList[1].extAttr.path_

        case 106:
            productId = homeProductData.data.thirdProductList[2].extAttr.path_

        default:
            break
        }
        if amount != ""{
            let length = amount.characters.count
            amount = amount.substring(to: amount.index(amount.startIndex, offsetBy: length - 1))
            
        }
        if delegate != nil {
        
            delegate?.productListClick(productId ,isOverLimit: isOverLimit ,amount: amount)
            
        }
        print("点击产品列表")
    }
}

extension HomeDefaultCell{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
//        return 90
        return ((refuseBgView?.bounds.size.height)!-100)/3
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:RefuseCell! = tableView.dequeueReusableCell(withIdentifier:"homeRefuseCell") as? RefuseCell
        if cell == nil {
            cell = RefuseCell.init(style: .default, reuseIdentifier: "homeRefuseCell")
        }
        cell.selectionStyle = .none
        cell.isSelected = false;
        cell.leftLabel?.text = refuseLeftTitle?[indexPath.row] as? String
        cell.rightLabel?.text = refuseRightTitle?[indexPath.row] as?String
        if indexPath.row == 2{
        
            cell.lineView?.isHidden = true
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        thirdPartyDiversionListClick(index: indexPath.row)
    }
    
    func thirdPartyDiversionListClick(index : NSInteger)->Void{
    
        if self.tabRefuseCellClosure != nil {
            
            self.tabRefuseCellClosure!(index)
        }
        print(index)
    }
}
