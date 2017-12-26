//
//  HomePageCell.swift
//  fxdProduct
//
//  Created by sxp on 2017/12/20.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import Masonry

@objc protocol HomePageCellDelegate: NSObjectProtocol {
    
    //首次借款按钮
    func applyImmediatelyBtnClick(_ money: String , _ time: String)->Void
    //帮助中心
    func helpBtnClick()
    //量子互助
    func daoliuBtnClick()
    //立即提款
    func withdrawMoneyImmediatelyBtnClick()
    //更多按钮
    func moreBtnClick()
    //我要借款按钮
    func loanBtnClick()
    //点击产品按钮
    func productListClick(_ productId: String, isOverLimit: String, amount: String ,Path:String)->Void
    //帮助图标按钮
    func questionDescBtnClick()
    //立即还款按钮
    func repayImmediatelyBtnClick(_ isSelected: Bool)
    //银行自动转账授权书
    func bankProtocolClick()
    //三方借款协议
    func loanProtocolClick()
}


class HomePageCell: UITableViewCell {
    
    @objc weak var delegate: HomePageCellDelegate?

    @objc var type : String?{
        didSet(newValue){
            
            setCellType(type: type!)
        }
    }
    //产品数据
    @objc var homeProductListModel = FXD_HomeProductListModel()
    //滑动标识的钱
    @objc var defaultMoneyLabel : UILabel?
    //滑动标识的时间
    @objc var defaultTimeLabel : UILabel?
//    //中间状态第一条状态标题
//    @objc var loanTopLabel : UILabel?
//    //中间状态第一条状态内容
//    @objc var loanTopContentLabel : UILabel?
//    //中间状态第二条状态标题
//    @objc var loanBottomLabel : UILabel?
//    //中间状态时间
//    @objc var loanTimeLabel : UILabel?
//    //量子互助导流View
//    @objc var loanBottomBgView : UIView?
//    //可借额度
//    @objc var quotaLabel : UILabel?
//
//    @objc var payTipLabel : UILabel?
//    //还款的月份
//    @objc var monthLabel : UILabel?
//    //还款的日期
//    @objc var dayLabel : UILabel?
//    //还款的money
//    @objc var payMoneyLabel : UILabel?
//    //逾期money
//    @objc var overdueMoneyLabel : UILabel?
    //复选框
    @objc var checkBoxBtn : UIButton?
    

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
        
        type = "1"
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomePageCell {
    
    //1:资料测评前 2:资料测评后 可进件 3:资料测评后:两不可申请（评分不足且高级认证未填完整） 4:资料测评后:两不可申请（其他原因，续贷规则不通过） 5:待提款 6:放款中 7:待还款 8:还款中 9 延期中 10 延期失败 11合规标的处理中 12测评中 13提款失败 14逾期 15还款失败
    //默认的cell
    fileprivate func setCellType(type : String){

        for view in self.subviews {
            view.removeFromSuperview()
        }

        let type = Int(type)
        switch type {
        case 1?:
            defaultCell()
        case 2?:
            quotaCell()
        case 3?:
            refuseView()
        case 4?:
            refuseView()
        case 5?:
            withdrawMoneyImmediatelyView()
        case 6?,8?,9?,12?,15?,10?,13?:
            loanProcessCell()
        case 7?,14?:
            repayImmediatelyView()
        case .none:
            break
        case .some(_):
            break
        }
    }
}

extension HomePageCell {
    
    //默认的
    fileprivate func defaultCell(){
        
        defaultMoneyLabel = UILabel()
        defaultMoneyLabel?.text = "10000元"
        defaultMoneyLabel?.textColor = UI_MAIN_COLOR
        defaultMoneyLabel?.textAlignment = .center
        defaultMoneyLabel?.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(defaultMoneyLabel!)
        defaultMoneyLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(29)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(28)
        })
        
        // 定义
        let slider = TrackRect()
        slider.tag = 101
        //slider.value = 1
        // 设置最小值
        slider.minimumValue = 1000
        // 设置最大值
        slider.maximumValue = 20000
        slider.value = 10000
        // 设置圆点图片
//        let imagea = setImageFrame(UIImage(named:"icon_quan")!, size: CGSize(width:46,height:46))
//        slider.setThumbImage(imagea, for: .normal)
        
        // 设置圆点图片
        slider.setThumbImage(UIImage.init(named: "icon_quan"), for: .normal)
        // 设置滑动过的颜色
        slider.minimumTrackTintColor = UI_MAIN_COLOR
        // 设置未滑动过的颜色
        slider.maximumTrackTintColor = SLIDER_CLOLR
        
        // 添加事件
        slider.addTarget(self, action: #selector(changed(slider:)), for: UIControlEvents.valueChanged)
        self.addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.top.equalTo((defaultMoneyLabel?.snp.bottom)!).offset(28)
            make.left.equalTo(self).offset(39)
            make.right.equalTo(self).offset(-39)
        }
        
        let moneyLeftLabel = UILabel()
        moneyLeftLabel.text = "1000元"
        moneyLeftLabel.textColor = MIDDLE_LINE_COLOR
        moneyLeftLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(moneyLeftLabel)
        moneyLeftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(49)
            make.top.equalTo(slider.snp.bottom).offset(14)
            make.height.equalTo(20)
        }
        
        let moneyRightLabel = UILabel()
        moneyRightLabel.text = "20000元"
        moneyRightLabel.textColor = MIDDLE_LINE_COLOR
        moneyRightLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(moneyRightLabel)
        moneyRightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom).offset(14)
            make.right.equalTo(self).offset(-49)
            make.height.equalTo(20)
        }
        
        defaultTimeLabel = UILabel()
        defaultTimeLabel?.text = "180天"
        defaultTimeLabel?.textColor = UI_MAIN_COLOR
        defaultTimeLabel?.font = UIFont.systemFont(ofSize: 20)
        defaultTimeLabel?.textAlignment = .center
        self.addSubview(defaultTimeLabel!)
        defaultTimeLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(slider.snp.bottom).offset(32)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(28)
        })
        
        // 定义
        let sliderTime = TrackRect()
        sliderTime.tag = 102
        //slider.value = 1
        // 设置最小值
        sliderTime.minimumValue = 30
        // 设置最大值
        sliderTime.maximumValue = 360
        sliderTime.value = 180
        // 设置圆点图片
//        let imagea1 = setImageFrame(UIImage(named:"icon_quan")!, size: CGSize(width:46,height:46))
//        sliderTime.setThumbImage(imagea1, for: .normal)
        
        sliderTime.setThumbImage(UIImage.init(named: "icon_quan"), for: .normal)
        // 设置滑动过的颜色
        sliderTime.minimumTrackTintColor = UI_MAIN_COLOR
        // 设置未滑动过的颜色
        sliderTime.maximumTrackTintColor = SLIDER_CLOLR
        
        // 添加事件
        sliderTime.addTarget(self, action: #selector(changed(slider:)), for: UIControlEvents.valueChanged)
        self.addSubview(sliderTime)
        sliderTime.snp.makeConstraints { (make) in
            make.top.equalTo((defaultTimeLabel?.snp.bottom)!).offset(28)
            make.left.equalTo(self).offset(39)
            make.right.equalTo(self).offset(-39)
        }
        
        let timeLeftLable = UILabel()
        timeLeftLable.text = "30天"
        timeLeftLable.textColor = MIDDLE_LINE_COLOR
        timeLeftLable.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(timeLeftLable)
        timeLeftLable.snp.makeConstraints { (make) in
            make.top.equalTo(sliderTime.snp.bottom).offset(14)
            make.left.equalTo(self).offset(49)
            make.height.equalTo(20)
        }
        
        let timeRightLabel = UILabel()
        timeRightLabel.text = "360天"
        timeRightLabel.textColor = MIDDLE_LINE_COLOR
        timeRightLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(timeRightLabel)
        timeRightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sliderTime.snp.bottom).offset(14)
            make.right.equalTo(self).offset(-49)
            make.height.equalTo(20)
        }
        
        let applayBtn = UIButton()
        applayBtn.setTitle(homeProductListModel.buttonText, for: .normal)
        applayBtn.setTitleColor(UIColor.white, for: .normal)
        applayBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        applayBtn.setBackgroundImage(UIImage(named:"applayBtnImage"), for: .normal)
        applayBtn.addTarget(self, action: #selector(applyBtnClick), for: .touchUpInside)
        self.addSubview(applayBtn)
        applayBtn.snp.makeConstraints { (make) in
            make.top.equalTo(timeRightLabel.snp.bottom).offset(45)
            make.left.equalTo(self).offset(26)
            make.right.equalTo(self).offset(-26)
            make.height.equalTo(50)
        }
        
        let helpBtn = UIButton()
        helpBtn.setTitle("帮助中心", for: .normal)
        helpBtn.setTitleColor(UI_MAIN_COLOR, for: .normal)
        helpBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        helpBtn.addTarget(self, action: #selector(helpBtnClick), for: .touchUpInside)
        self.addSubview(helpBtn)
        helpBtn.snp.makeConstraints { (make) in
            make.top.equalTo(applayBtn.snp.bottom).offset(18)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(20)
        }
        
        if UI_IS_IPONE6 {
            applayBtn.snp.updateConstraints({ (make) in
                make.top.equalTo(timeRightLabel.snp.bottom).offset(20)
            })
        }
        
        if UI_IS_IPONE5 {
            defaultMoneyLabel?.snp.updateConstraints({ (make) in
                make.top.equalTo(self).offset(9)
            })
            
            slider.snp.updateConstraints({ (make) in
                make.top.equalTo((defaultMoneyLabel?.snp.bottom)!).offset(14)
            })
            
            moneyLeftLabel.snp.updateConstraints({ (make) in
                make.top.equalTo(slider.snp.bottom).offset(0)
            })
            
            moneyRightLabel.snp.updateConstraints({ (make) in
                make.top.equalTo(slider.snp.bottom).offset(0)
            })
            
            defaultTimeLabel?.snp.updateConstraints({ (make) in
                make.top.equalTo(slider.snp.bottom).offset(10)
            })
            
            sliderTime.snp.updateConstraints({ (make) in
                make.top.equalTo((defaultTimeLabel?.snp.bottom)!).offset(14)
            })
            timeLeftLable.snp.updateConstraints({ (make) in
                make.top.equalTo(sliderTime.snp.bottom).offset(0)
            })
            timeRightLabel.snp.updateConstraints({ (make) in
                make.top.equalTo(sliderTime.snp.bottom).offset(0)
            })
            applayBtn.snp.updateConstraints({ (make) in
                make.top.equalTo(timeRightLabel.snp.bottom).offset(20)
            })
            
            helpBtn.snp.updateConstraints({ (make) in
                make.top.equalTo(applayBtn.snp.bottom).offset(9)
            })
        }
    }
    
    //借款的各种中间状态
    fileprivate func loanProcessCell(){
        
        let tipLabel = UILabel()
        tipLabel.textColor = UI_MAIN_COLOR
        tipLabel.text = "温馨提示:下拉可刷新结果"
        tipLabel.font = UIFont.systemFont(ofSize: 12)
        tipLabel.textAlignment = .center
        self.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(19)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(20)
        }
        
        let topImageView = UIImageView()
        topImageView.image = UIImage(named:"tuoyuan")
        self.addSubview(topImageView)
        topImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(88)
            make.left.equalTo(self).offset(20)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = LOAN_LINE_COLOR
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(topImageView.snp.bottom).offset(0)
            make.left.equalTo(self).offset(26)
            make.width.equalTo(2)
            make.height.equalTo(78)
        }
        let bottomImageView = UIImageView()
        bottomImageView.image = UIImage(named:"tuoyuanhui")
        self.addSubview(bottomImageView)
        bottomImageView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(0)
            make.left.equalTo(self).offset(20)
        }
        
        let loanTopLabel = UILabel()
        loanTopLabel.text = homeProductListModel.handingAndFailText.currentStatus
        loanTopLabel.textColor = UI_MAIN_COLOR
        loanTopLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(loanTopLabel)
        loanTopLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(topImageView.snp.top).offset(0)
            make.left.equalTo(topImageView.snp.right).offset(20)
            make.height.equalTo(14)
        })
        
        let loanTopContentLabel = UILabel()
        loanTopContentLabel.text = homeProductListModel.handingAndFailText.currentStatusTips
        loanTopContentLabel.textColor = MIDDLE_LINE_COLOR
        loanTopContentLabel.numberOfLines = 0
        loanTopContentLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(loanTopContentLabel)
        loanTopContentLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(loanTopLabel.snp.bottom).offset(10)
            make.left.equalTo(lineView.snp.right).offset(25)
//            make.height.equalTo(60)
            make.right.equalTo(-22)
        })
        
        let loanBottomLabel = UILabel()
        loanBottomLabel.text = homeProductListModel.handingAndFailText.preStatus
        loanBottomLabel.textColor = RedPacketBottomBtn_COLOR
        loanBottomLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(loanBottomLabel)
        loanBottomLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(bottomImageView.snp.top).offset(-2)
            make.left.equalTo(bottomImageView.snp.right).offset(20)
            make.height.equalTo(20)
        })
        
        if homeProductListModel.flag != "12" {
            
            let loanBottomContentLabel = UILabel()
            loanBottomContentLabel.textColor = MIDDLE_LINE_COLOR
            loanBottomContentLabel.text = homeProductListModel.handingAndFailText.preStatusTips
            loanBottomContentLabel.font = UIFont.systemFont(ofSize: 12)
            self.addSubview(loanBottomContentLabel)
            loanBottomContentLabel.snp.makeConstraints { (make) in
                make.top.equalTo(loanBottomLabel.snp.bottom).offset(10)
                make.left.equalTo(bottomImageView.snp.right).offset(20)
                make.height.equalTo(20)
            }
        }
        
        let loanTimeLabel = UILabel()
        loanTimeLabel.text = homeProductListModel.handingAndFailText.createDate
        loanTimeLabel.textColor = MIDDLE_LINE_COLOR
        loanTimeLabel.font = UIFont.systemFont(ofSize: 12)
        loanTimeLabel.textAlignment = .right
        self.addSubview(loanTimeLabel)
        loanTimeLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(loanBottomLabel.snp.top).offset(0)
            make.right.equalTo(self).offset(-22)
            make.height.equalTo(20)
        })
        
        if homeProductListModel.flag == "13" || homeProductListModel.flag == "15" {
            
            let bottomBtn = UIButton()
            bottomBtn.setTitle(homeProductListModel.buttonText, for: .normal)
            bottomBtn.setTitleColor(UIColor.white, for: .normal)
            bottomBtn.setBackgroundImage(UIImage(named:"applayBtnImage"), for: .normal)
            bottomBtn.addTarget(self, action: #selector(bottomClick), for: .touchUpInside)
            self.addSubview(bottomBtn)
            bottomBtn.snp.makeConstraints({ (make) in
                make.top.equalTo(loanTimeLabel.snp.bottom).offset(50)
                make.left.equalTo(self.snp.left).offset(30)
                make.right.equalTo(self.snp.right).offset(-30)
                make.height.equalTo(50)
            })
            
        }
        
        if homeProductListModel.flag == "12" {
            
            let loanBottomBgView = UIView()
            self.addSubview(loanBottomBgView)
            loanBottomBgView.snp.makeConstraints({ (make) in
                make.left.equalTo(self).offset(0)
                make.right.equalTo(self).offset(0)
                make.height.equalTo(100)
                make.bottom.equalTo(self).offset(-50)
            })
            
            let bottomDesclabel = UILabel()
            bottomDesclabel.textColor = ORANGE_COLOR
            bottomDesclabel.font = UIFont.systemFont(ofSize: 14)
            bottomDesclabel.textAlignment = .center
            bottomDesclabel.text = "30万大病保障,100万人的共同之选"
            loanBottomBgView.addSubview(bottomDesclabel)
            bottomDesclabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX)
                make.top.equalTo(loanBottomBgView.snp.top).offset(10)
                make.height.equalTo(20)
            }
            
            let bottomBtn = UIButton()
            bottomBtn.setTitle("点击立即领取", for: .normal)
            bottomBtn.setTitleColor(UIColor.white, for: .normal)
            bottomBtn.setBackgroundImage(UIImage(named:"liangzihuzhu"), for: .normal)
            bottomBtn.addTarget(self, action: #selector(bottomClick), for: .touchUpInside)
            loanBottomBgView.addSubview(bottomBtn)
            bottomBtn.snp.makeConstraints { (make) in
                make.top.equalTo(bottomDesclabel.snp.bottom).offset(14)
                make.width.equalTo(205)
                make.centerX.equalTo(self.snp.centerX)
            }
            if UI_IS_IPONE6 {
                loanBottomBgView.snp.updateConstraints({ (make) in
                    make.bottom.equalTo(self).offset(-10)
                })
            }
            
            if UI_IS_IPONE5 {
                loanBottomBgView.snp.updateConstraints({ (make) in
                    make.bottom.equalTo(self).offset(-15)
                })
            }
            
        }
    
        if UI_IS_IPONE5 {
            
            topImageView.snp.updateConstraints({ (make) in
                make.top.equalTo(self).offset(55)
            })
            
        }
    }
    
    //可借额度，我要借款
    
    fileprivate func quotaCell(){

        let bgView = UIView()
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
//            make.centerY.equalTo(self.snp.centerY)
            make.top.equalTo(self).offset(50)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(250)
        }
        
        let topLabel = UILabel()
        topLabel.textColor = UI_MAIN_COLOR
        topLabel.text = "可借额度 (元)"
        topLabel.textAlignment = .center
        bgView.addSubview(topLabel)
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.top).offset(10)
            make.centerX.equalTo(bgView.snp.centerX)
            make.height.equalTo(20)
        }
        
        let quotaLabel = UILabel()
        quotaLabel.text = homeProductListModel.drawInfo.amount
        quotaLabel.textColor = LOAN_QUOTA_COLOR
        quotaLabel.font = UIFont.systemFont(ofSize: 25)
        quotaLabel.textAlignment = .center
        bgView.addSubview(quotaLabel)
        quotaLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(41)
            make.centerX.equalTo(bgView.snp.centerX)
            make.height.equalTo(25)
        })
        
        let loanBtn = UIButton()
        loanBtn.setTitle("我要借款", for: .normal)
        loanBtn.setTitleColor(UIColor.white, for: .normal)
        loanBtn.setBackgroundImage(UIImage(named:"applayBtnImage"), for: .normal)
        loanBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        loanBtn.addTarget(self, action: #selector(loanBtnClick), for: .touchUpInside)
        bgView.addSubview(loanBtn)
        loanBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(bgView.snp.bottom).offset(-10)
            make.left.equalTo(bgView.snp.left).offset(29)
            make.right.equalTo(bgView.snp.right).offset(-29)
            make.height.equalTo(55)
        }
        
        if UI_IS_IPONE6 {
            loanBtn.snp.updateConstraints({ (make) in
                make.bottom.equalTo(bgView.snp.bottom).offset(-20)
            })
        }
        
        if UI_IS_IPONE5 {
            
            loanBtn.snp.updateConstraints({ (make) in
                make.bottom.equalTo(bgView.snp.bottom).offset(-50)
            })
        }
    }
    
    //信用评分不足
    fileprivate func refuseView(){
        
        let titleLabel = UILabel()
        titleLabel.text = homeProductListModel.testFailInfo.tips
        titleLabel.textColor = UI_MAIN_COLOR
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self).offset(20)
            make.height.equalTo(20)
        }
        
        var array : NSArray
        
        array = homeProductListModel.testFailInfo.text! as NSArray
        
        let firstLabel = UILabel()
        firstLabel.textColor = RedPacket_COLOR
        firstLabel.text = array[0] as? String
        firstLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.left.equalTo(self).offset(55)
            make.height.equalTo(20)
        }
        
        let secondLabel = UILabel()
        secondLabel.textColor = RedPacket_COLOR
        secondLabel.text = array[1] as? String
        secondLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { (make) in
            make.top.equalTo(firstLabel.snp.bottom).offset(12)
            make.left.equalTo(self).offset(55)
            make.height.equalTo(20)
        }
        
        let thirdLabel = UILabel()
        thirdLabel.text = array[2] as? String
        thirdLabel.textColor = RedPacket_COLOR
        thirdLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(thirdLabel)
        thirdLabel.snp.makeConstraints { (make) in
            make.top.equalTo(secondLabel.snp.bottom).offset(12)
            make.left.equalTo(self).offset(55)
            make.height.equalTo(20)
        }
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(thirdLabel.snp.bottom).offset(20)
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.height.equalTo(2*103)
        }
        
        for index in 0..<2 {
            if index > 0{
                if UI_IS_IPONE5{
                    continue
                }
            }
            let thirdRefuseView = HomeRefuseThirdView()
            thirdRefuseView.isUserInteractionEnabled = true
            thirdRefuseView.tag = index + 104
            let tapGest = UITapGestureRecognizer(target: self, action: #selector(clickFirstView(_:)))
            thirdRefuseView.addGestureRecognizer(tapGest)
            bgView.addSubview(thirdRefuseView)
            thirdRefuseView.snp.makeConstraints({ (make) in
                make.top.equalTo(bgView.snp.top).offset(index * 103)
                make.left.equalTo(bgView.snp.left).offset(14)
                make.right.equalTo(bgView.snp.right).offset(-14)
                make.height.equalTo(103)
            })
            
            let thirdProduct = homeProductListModel.testFailInfo.thirdProductList[index] as! ThirdProductListModel
            let tags = thirdProduct.extAttr.tags as NSArray
            
            
            let url = URL(string: thirdProduct.extAttr.icon_)
            thirdRefuseView.leftImageView?.sd_setImage(with: url)

            thirdRefuseView.titleLabel?.text = thirdProduct.name
            thirdRefuseView.qutaLabel?.text = "额度:最高" + thirdProduct.principalTop + "元"
            thirdRefuseView.termLabel?.text = "期限:" + thirdProduct.stagingDuration + "-" + thirdProduct.stagingBottom + "天"
            if (thirdProduct.extAttr.charge_desc_ != nil){
                
                thirdRefuseView.feeLabel?.text = "费用：" + thirdProduct.extAttr.charge_desc_
                let attrstr1 : NSMutableAttributedString = NSMutableAttributedString(string:(thirdRefuseView.feeLabel?.text)!)
                attrstr1.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr1.length-5))
                thirdRefuseView.feeLabel?.attributedText = attrstr1
            }
            
            let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(thirdRefuseView.termLabel?.text)!)
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr.length-4))
            thirdRefuseView.termLabel?.attributedText = attrstr
            
            thirdRefuseView.descBtn?.setTitle(tags[0] as? String, for: .normal)
            thirdRefuseView.descBtn?.setTitleColor(UI_MAIN_COLOR, for: .normal)
            setCornerBorder(view: thirdRefuseView.descBtn!, borderColor: UI_MAIN_COLOR)
        }
        
        let moreBtn = UIButton()
        moreBtn.setTitle("更多", for: .normal)
        moreBtn.titleLabel?.textAlignment = .center
        moreBtn.setTitleColor(UI_MAIN_COLOR, for: .normal)
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        moreBtn.addTarget(self, action: #selector(moreBtnClick), for: .touchUpInside)
        self.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            
            make.bottom.equalTo(bgView.snp.bottom).offset(23)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(20)
        }
        
        if UI_IS_IPONE5{
            
            
            firstLabel.snp.updateConstraints({ (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(12)
            })
            
            bgView.snp.updateConstraints({ (make) in
                make.top.equalTo(thirdLabel.snp.bottom).offset(10)
            })
            
            moreBtn.snp.updateConstraints({ (make) in
                make.bottom.equalTo(bgView.snp.bottom).offset(-75)
            })
        }
        
        
        if UI_IS_IPONE6P {
            moreBtn.snp.updateConstraints({ (make) in
                
                make.bottom.equalTo(bgView.snp.bottom).offset(45)
            })
        }
        
        if UI_IS_IPONE6 {
            bgView.snp.updateConstraints({ (make) in
                make.top.equalTo(thirdLabel.snp.bottom).offset(5)
            })
        }
    }
    
    //立即还款
    fileprivate func repayImmediatelyView(){
        
        
        let tipImageView = UIImageView()
        tipImageView.image = UIImage(named:"paytip")
        self.addSubview(tipImageView)
        tipImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
        }
        
        let payTipLabel = UILabel()
        
        payTipLabel.textColor = UI_MAIN_COLOR
        payTipLabel.font = UIFont.systemFont(ofSize: 12)
        tipImageView.addSubview(payTipLabel)
        payTipLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(tipImageView.snp.left).offset(22)
            make.centerY.equalTo(tipImageView.snp.centerY)
            make.right.equalTo(tipImageView.snp.right).offset(-22)
        })
        
        let titleLabel = UILabel()
        titleLabel.textColor = RedPacketBottomBtn_COLOR
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tipImageView.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        var middleView:UIView?
        if homeProductListModel.flag == "7" {
            titleLabel.text = "下一期还款日期"
            payTipLabel.text = homeProductListModel.repayInfo.repayTips
            middleView = setNormalView()
            self.addSubview(middleView!)
            middleView?.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(0)
                make.right.equalTo(self).offset(0)
                make.top.equalTo(titleLabel.snp.bottom).offset(14)
                make.height.equalTo(170)
            }
        }else{
           
            titleLabel.text = "逾期时间"
            payTipLabel.text = homeProductListModel.overdueInfo.repayTips
            middleView = setOverdueView()
            self.addSubview(middleView!)
            middleView?.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(0)
                make.right.equalTo(self).offset(0)
                make.top.equalTo(titleLabel.snp.bottom).offset(14)
                make.height.equalTo(170)
            }
        }
        
        let repayImmediatelyBtn = UIButton()
        repayImmediatelyBtn.setTitle(homeProductListModel.buttonText, for: .normal)
        repayImmediatelyBtn.setBackgroundImage(UIImage(named:"applayBtnImage"), for: .normal)
        repayImmediatelyBtn.setTitleColor(UIColor.white, for: .normal)
        repayImmediatelyBtn.addTarget(self, action: #selector(repayImmediatelyBtnClick), for: .touchUpInside)
        self.addSubview(repayImmediatelyBtn)
        repayImmediatelyBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(25)
            make.right.equalTo(self).offset(-25)
            make.top.equalTo((middleView?.snp.bottom)!).offset(38)
            make.height.equalTo(50)
        }
        
        
        checkBoxBtn = UIButton()
        checkBoxBtn?.setImage(UIImage(named:"checkBox"), for: .normal)
        checkBoxBtn?.addTarget(self, action: #selector(checkBoxBtnClick(_:)), for: .touchUpInside)
        self.addSubview(checkBoxBtn!)
        checkBoxBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(30)
            make.top.equalTo(repayImmediatelyBtn.snp.bottom).offset(20)
        })
        
        
        let protocolLabel = UILabel()
        protocolLabel.text = "我已阅读并认可发薪贷《银行自动转账授权书》、《三方借款协议》"
        protocolLabel.font = UIFont.systemFont(ofSize: 12)
        protocolLabel.numberOfLines = 0
        protocolLabel.textColor = QUTOA_COLOR
        self.addSubview(protocolLabel)
        protocolLabel.snp.makeConstraints { (make) in
            make.left.equalTo((checkBoxBtn?.snp.right)!).offset(5)
            make.right.equalTo(self).offset(-25)
            make.height.equalTo(40)
            make.top.equalTo(repayImmediatelyBtn.snp.bottom).offset(17)
        }
        
        let attStr = NSMutableAttributedString.init(string: protocolLabel.text!)
        
        let sty = NSMutableParagraphStyle()
        sty.alignment = NSTextAlignment.left
        attStr.addAttribute(NSAttributedStringKey.paragraphStyle, value: sty, range: NSMakeRange(0, attStr.length))
        attStr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, attStr.length))
        attStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(10, 11))
        attStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(20, 10))
        
        protocolLabel.attributedText = attStr
        protocolLabel.yb_addAttributeTapAction(["《银行自动转账授权书》","、《三方借款协议》"]) { (string, range, int) in
            print("点击了\(string)标签 - {\(range.location) , \(range.length)} - \(int)")
            
            if int == 0{
                self.bankProtocolClick()
            }else{
                self.loanProtocolClick()
            }
        }
        
        // MARK: 关闭点击效果 默认是开启的
        protocolLabel.enabledTapEffect = false
        
        
        if UI_IS_IPONE5 {
            
            titleLabel.snp.updateConstraints({ (make) in
                
                make.top.equalTo(tipImageView.snp.bottom).offset(5)
            })
            
            middleView?.snp.updateConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(0)
                make.height.equalTo(140)
            }
            
            repayImmediatelyBtn.snp.updateConstraints { (make) in
                make.top.equalTo((middleView?.snp.bottom)!).offset(5)
            }
            
            checkBoxBtn?.snp.updateConstraints({ (make) in
                make.top.equalTo(repayImmediatelyBtn.snp.bottom).offset(8)
            })
            
            protocolLabel.snp.updateConstraints({ (make) in
                make.top.equalTo(repayImmediatelyBtn.snp.bottom).offset(6)
            })
        }
    }
    
    //立即提款
    fileprivate func withdrawMoneyImmediatelyView(){
        
        let tipLabel = UILabel()
        tipLabel.text = homeProductListModel.drawInfo.warn
        tipLabel.font = UIFont.systemFont(ofSize: 12)
        tipLabel.textColor = UI_MAIN_COLOR
        tipLabel.textAlignment = .center
        self.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self).offset(18)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = homeProductListModel.drawInfo.label
        titleLabel.textAlignment = .center
        titleLabel.textColor = UI_MAIN_COLOR
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(tipLabel.snp.bottom).offset(47)
        }
        
        let quotaLabel = UILabel()
        quotaLabel.textAlignment = .center
        quotaLabel.textColor = UIColor.black
        quotaLabel.text = homeProductListModel.drawInfo.amount
        quotaLabel.font = UIFont.systemFont(ofSize: 25)
        self.addSubview(quotaLabel)
        quotaLabel.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
        })
        
        let withdrawMoneyImmediatelyBtn = UIButton()
        withdrawMoneyImmediatelyBtn.setTitle(homeProductListModel.buttonText, for: .normal)
        withdrawMoneyImmediatelyBtn.setTitleColor(UIColor.white, for: .normal)
        withdrawMoneyImmediatelyBtn.setBackgroundImage(UIImage(named:"applayBtnImage"), for: .normal)
        withdrawMoneyImmediatelyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        withdrawMoneyImmediatelyBtn.addTarget(self, action: #selector(withdrawMoneyImmediatelyBtnClick), for: .touchUpInside)
        self.addSubview(withdrawMoneyImmediatelyBtn)
        withdrawMoneyImmediatelyBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(28)
            make.right.equalTo(self).offset(-28)
            make.top.equalTo(quotaLabel.snp.bottom).offset(47)
            make.height.equalTo(55)
        }
        
        
        if UI_IS_IPONE6P {
            titleLabel.snp.updateConstraints({ (make) in
                make.top.equalTo(tipLabel.snp.bottom).offset(70)
            })
        }
    }
    
}

extension HomePageCell{
    //MARK:设置slider图片大小
    fileprivate func setImageFrame(_ image: UIImage, size: CGSize) ->(UIImage){
        
        UIGraphicsBeginImageContext(size);
        image.draw(in: CGRect(x:0,y:0,width:size.width,height:size.height))
        let scaleImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaleImage!;
        
    }
    
    //MARK:设置CornerBorder
    fileprivate func setCornerBorder(view:UIView,borderColor:UIColor) -> Void {
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1;
        view.layer.borderColor = borderColor.cgColor
    }
    
    fileprivate func setNormalView() -> UIView{
        
        let view = UIView()
        self.addSubview(view)
        let timeView = UIView()
        view.addSubview(timeView)
        timeView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(14)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(180)
        }
        
        let monthImageView = UIImageView()
        monthImageView.image = UIImage(named:"rili")
        timeView.addSubview(monthImageView)
        monthImageView.snp.makeConstraints { (make) in
            make.left.equalTo(timeView.snp.left).offset(5)
            make.centerY.equalTo(timeView.snp.centerY)
        }
        
        let date = NSString(format: "%@", homeProductListModel.repayInfo.repayDate) as String
        let index1 = date.index(date.endIndex, offsetBy: -5)
        let day1 = date[index1...] // One-sided Slicing
        
        var month : NSString
        var index: Substring.Index
        if day1.hasPrefix("0") {
            
            index = day1.index(day1.startIndex, offsetBy: 2)
            let month1 = day1[..<index]
            let index2 = month1.index(month1.endIndex, offsetBy: -1)
            month = month1[index2...] as NSString
            
        }else{
            
            index = day1.index(day1.startIndex, offsetBy: 2)
            month = day1[..<index] as NSString
        }
        
        let monthLabel = UILabel()
        monthLabel.text = month as String
        monthLabel.textColor = UI_MAIN_COLOR
        monthLabel.font = UIFont.systemFont(ofSize: 20)
        monthImageView.addSubview(monthLabel)
        monthLabel.snp.makeConstraints({ (make) in
            make.centerX.equalTo(monthImageView.snp.centerX)
            make.top.equalTo(monthImageView.snp.top).offset(18)
        })
        
        let label1 = UILabel()
        label1.text = "月"
        label1.font = UIFont.systemFont(ofSize: 17)
        label1.textColor = UIColor.black
        timeView.addSubview(label1)
        label1.snp.makeConstraints { (make) in
            make.left.equalTo(monthImageView.snp.right).offset(11)
            make.top.equalTo(timeView.snp.top).offset(20)
        }
        
        let dayImageView = UIImageView()
        dayImageView.image = UIImage(named:"rili")
        timeView.addSubview(dayImageView)
        dayImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeView.snp.centerY)
            make.left.equalTo(label1.snp.right).offset(16)
        }
        
        let values = NSString(format: "%@", homeProductListModel.repayInfo.repayDate) as String
        let startSlicingIndex = values.index(values.endIndex, offsetBy: -2)
        let day = values[startSlicingIndex...] // One-sided Slicing
        
        let dayLabel = UILabel()
        dayLabel.textColor = UI_MAIN_COLOR
        dayLabel.text = String(day) as String
        dayLabel.font = UIFont.systemFont(ofSize: 20)
        dayImageView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints({ (make) in
            make.centerX.equalTo(dayImageView.snp.centerX)
            make.top.equalTo(dayImageView.snp.top).offset(18)
        })
        
        let label2 = UILabel()
        label2.textColor = UIColor.black
        label2.text = "日"
        label2.font = UIFont.systemFont(ofSize: 17)
        timeView.addSubview(label2)
        label2.snp.makeConstraints { (make) in
            make.left.equalTo(dayImageView.snp.right).offset(11)
            make.top.equalTo(timeView.snp.top).offset(20)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = PAY_LINE_CLOLR
        view.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(46)
            make.right.equalTo(view.snp.right).offset(-46)
            make.top.equalTo(timeView.snp.bottom).offset(17)
            make.height.equalTo(2)
        }
        
        let payMoneyLabel = UILabel()
        payMoneyLabel.text = homeProductListModel.repayInfo.repayAmount + "元"
        payMoneyLabel.textColor = UI_MAIN_COLOR
        payMoneyLabel.font = UIFont.systemFont(ofSize: 25)
        payMoneyLabel.textAlignment = .center
        view.addSubview(payMoneyLabel)
        payMoneyLabel.snp.makeConstraints({ (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(lineView.snp.bottom).offset(22)
        })
        
        let payMoneyDesc = UILabel()
        payMoneyDesc.text = "下一期还款金额"
        payMoneyDesc.textAlignment = .center
        payMoneyDesc.textColor = RedPacketBottomBtn_COLOR
        payMoneyDesc.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(payMoneyDesc)
        payMoneyDesc.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(payMoneyLabel.snp.bottom).offset(14)
        }
        
        return view
        
    }
    
    fileprivate func setOverdueView() -> UIView{
        
        let view = UIView()
        self.addSubview(view)
        
        let timeView = UIView()
        view.addSubview(timeView)
        timeView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(14)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(90)
        }
        
        let dayImageView = UIImageView()
        dayImageView.image = UIImage(named:"rili")
        timeView.addSubview(dayImageView)
        dayImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeView.snp.centerY)
            make.left.equalTo(timeView.snp.left).offset(5)
        }
        
        let dayLabel = UILabel()
        dayLabel.textColor = UIColor.red
        dayLabel.text = homeProductListModel.overdueInfo.overdueDays
        dayLabel.font = UIFont.systemFont(ofSize: 20)
        dayImageView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints({ (make) in
            make.centerX.equalTo(dayImageView.snp.centerX)
            make.top.equalTo(dayImageView.snp.top).offset(18)
        })
        
        let label2 = UILabel()
        label2.textColor = UIColor.black
        label2.text = "日"
        label2.font = UIFont.systemFont(ofSize: 17)
        timeView.addSubview(label2)
        label2.snp.makeConstraints { (make) in
            make.left.equalTo(dayImageView.snp.right).offset(11)
            make.top.equalTo(timeView.snp.top).offset(20)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = PAY_LINE_CLOLR
        view.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(46)
            make.right.equalTo(view.snp.right).offset(-46)
            make.top.equalTo(timeView.snp.bottom).offset(17)
            make.height.equalTo(2)
        }
    
        let moneyView = UIView()
        moneyView.backgroundColor = UIColor.clear
        view.addSubview(moneyView)
        moneyView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(270)
            make.height.equalTo(20)
            make.top.equalTo(lineView.snp.bottom).offset(40)
        }
        
        let leftMoneyLabel = UILabel()
        leftMoneyLabel.text = homeProductListModel.overdueInfo.stagingAmount
        leftMoneyLabel.textColor = TITLE_COLOR
        leftMoneyLabel.font = UIFont.systemFont(ofSize: 17)
        leftMoneyLabel.textAlignment = .left
        moneyView.addSubview(leftMoneyLabel)
        leftMoneyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(moneyView.snp.left).offset(0)
            make.centerY.equalTo(moneyView.snp.centerY)
        }
        
        let symbolLabel = UILabel()
        symbolLabel.text = "+"
        symbolLabel.textColor = TITLE_COLOR
        symbolLabel.font = UIFont.systemFont(ofSize: 17)
        moneyView.addSubview(symbolLabel)
        symbolLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftMoneyLabel.snp.right).offset(10)
            make.centerY.equalTo(moneyView.snp.centerY)
        }
        
        
        let overMoneyLabel = UILabel()
        overMoneyLabel.text = homeProductListModel.overdueInfo.feeAmount
        overMoneyLabel.textColor = TITLE_COLOR
        overMoneyLabel.font = UIFont.systemFont(ofSize: 17)
        overMoneyLabel.textAlignment = .left
        moneyView.addSubview(overMoneyLabel)
        overMoneyLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(moneyView.snp.centerY)
            make.left.equalTo(symbolLabel.snp.right).offset(20)

        }
        

        let equalLabel = UILabel()
        equalLabel.textColor = TITLE_COLOR
        equalLabel.text = "="
        equalLabel.font = UIFont.systemFont(ofSize: 17)
        moneyView.addSubview(equalLabel)
        equalLabel.snp.makeConstraints { (make) in
            make.left.equalTo(overMoneyLabel.snp.right).offset(10)
            make.centerY.equalTo(moneyView.snp.centerY)
        }
        
        
        let rightMoneyLabel = UILabel()
        rightMoneyLabel.text = homeProductListModel.overdueInfo.repayAmount + "元"
        rightMoneyLabel.textColor = UI_MAIN_COLOR
        rightMoneyLabel.font = UIFont.systemFont(ofSize: 25)
        rightMoneyLabel.textAlignment = .center
        moneyView.addSubview(rightMoneyLabel)
        rightMoneyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(equalLabel.snp.right).offset(20)
            make.centerY.equalTo(moneyView.snp.centerY)
        }
        
        let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(rightMoneyLabel.text)!)
        attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: TITLE_COLOR, range: NSMakeRange(attrstr.length-1,1))
        attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 17), range: NSMakeRange(attrstr.length-1,1))
        rightMoneyLabel.attributedText = attrstr
        
        
        let overdueView = UIView()
        overdueView.backgroundColor = UIColor.clear
        view.addSubview(overdueView)
        overdueView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(moneyView.snp.bottom).offset(23)
            make.height.equalTo(20)
            make.width.equalTo(80)
        }
        
        
        let overdueLabel = UILabel()
        overdueLabel.textAlignment = .center
        overdueLabel.textColor = RedPacketBottomBtn_COLOR
        overdueLabel.text = "逾期罚金"
        overdueLabel.font = UIFont.systemFont(ofSize: 15)
        overdueView.addSubview(overdueLabel)
        overdueLabel.snp.makeConstraints { (make) in
            make.left.equalTo(overdueView.snp.left).offset(0)
            make.centerY.equalTo(overdueView.snp.centerY)
        }
        
        let questionDescBtn = UIButton()
        questionDescBtn.setImage(UIImage(named:"home_03"), for: .normal)
        questionDescBtn.addTarget(self, action: #selector(questionDescBtnClick), for: .touchUpInside)
        overdueView.addSubview(questionDescBtn)
        questionDescBtn.snp.makeConstraints { (make) in
            make.left.equalTo(overdueLabel.snp.right).offset(2)
            make.centerY.equalTo(overdueView.snp.centerY)
        }
        
        let leftDescLabel = UILabel()
        leftDescLabel.text = "期供金额"
        leftDescLabel.textColor = RedPacketBottomBtn_COLOR
        leftDescLabel.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(leftDescLabel)
        leftDescLabel.snp.makeConstraints { (make) in
            make.right.equalTo(overdueView.snp.left).offset(-40)
            make.top.equalTo(overdueView.snp.top)
        }
        
        let rightDescLabel = UILabel()
        rightDescLabel.textColor = RedPacketBottomBtn_COLOR
        rightDescLabel.text = "待还金额"
        rightDescLabel.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(rightDescLabel)
        rightDescLabel.snp.makeConstraints { (make) in
            make.left.equalTo(overdueView.snp.right).offset(40)
            make.top.equalTo(overdueView.snp.top)
        }
        
        if UI_IS_IPONE5 {
            
            timeView.snp.updateConstraints({ (make) in
                make.top.equalTo(view).offset(7)
            })
            
            lineView.snp.updateConstraints { (make) in
                make.top.equalTo(timeView.snp.bottom).offset(8)
            }
            
//            overdueMoneyLabel.snp.updateConstraints({ (make) in
//                make.top.equalTo(lineView.snp.bottom).offset(13)
//            })
//
//            overdueView.snp.updateConstraints { (make) in
//                make.top.equalTo(overdueMoneyLabel.snp.bottom).offset(12)
//            }
            
        }
        return view
    }
    
}

//MARK:各种点击事件
extension HomePageCell{
    //MARK:UISlider滑动事件
    @objc func changed(slider:UISlider){
        //        print("slider.value = %d",slider.value)
        let tag = slider.tag
        let num = Int(slider.value)
        switch tag {
        case 101:
            
            defaultMoneyLabel?.text = NSString(format: "%d元", (num/1000)*1000) as String
            
        case 102:
            
            defaultTimeLabel?.text = NSString(format: "%d元", (num/30)*30) as String
            
        default:
            break
        }
        
        //        print("整除后的数字=%d",(money/500)*500)
//        defaultHeadLabel?.text = NSString(format: "%d元", (money/500)*500) as String
        
        //        print("整除后的数字=%d",(money/100)*100)
        //        defaultHeadLabel?.text = NSString(format: "%d元", (money/100)*100) as String
        
    }
    
    //立即申请
    @objc func applyBtnClick(){
        
        if delegate != nil {
            
            let moneyStr = NSString(format: "%@", (defaultMoneyLabel?.text)!) as String
            let index = moneyStr.index(moneyStr.endIndex, offsetBy: -1)
            let money = moneyStr[..<index]
            let timeStr = NSString(format: "%@", (defaultTimeLabel?.text)!) as String
            let index1 = timeStr.index(timeStr.endIndex, offsetBy: -1)
            let time = timeStr[..<index1]
            
            delegate?.applyImmediatelyBtnClick(String(money), String(time))
        }
    }
    //帮助中心
    @objc func helpBtnClick(){
        
        if delegate != nil {
            
            delegate?.helpBtnClick()
        }
    }
    
    //量子互助
    @objc func bottomClick(){
        
        if delegate != nil {
            delegate?.daoliuBtnClick()
        }
    }
    //我要借款
    @objc func loanBtnClick(){
        if delegate != nil {
            delegate?.loanBtnClick()
        }
    }
    //拒绝导流
    @objc func clickFirstView(_ tapGes : UITapGestureRecognizer){
        
        let tag = tapGes.view?.tag
        
        let thirdProduct = homeProductListModel.testFailInfo.thirdProductList[tag! - 104] as! ThirdProductListModel
        
        let path = thirdProduct.extAttr.path_
        let productId = thirdProduct.id_
        let isOverLimit = thirdProduct.isOverLimit
        
        if delegate != nil {
            
            delegate?.productListClick(productId! ,isOverLimit: isOverLimit! ,amount: "amount",Path:path!)
            
        }
        print("点击产品列表")
        
    }
    
    //拒绝导流更多按钮
    @objc func moreBtnClick(){
        
        if delegate != nil {
            delegate?.moreBtnClick()
        }
    }
    
    //立即还款按钮
    @objc func repayImmediatelyBtnClick(){
        
        if delegate != nil {
            delegate?.repayImmediatelyBtnClick((checkBoxBtn?.isSelected)!)
        }
    }
    
    //帮助图标
    @objc func questionDescBtnClick(){
        
        if delegate != nil {
            delegate?.questionDescBtnClick()
        }
    }
    
    //勾选协议的复选框按钮
    @objc func checkBoxBtnClick(_ sender : UIButton){
        
        if sender.isSelected {
            sender.setImage(UIImage(named:"checkBox"), for: .normal)
        }else{
            sender.setImage(UIImage(named:"checkBox_normal"), for: .normal)
        }
        sender.isSelected = !sender.isSelected
    }
    
    //立即提款按钮
    @objc func withdrawMoneyImmediatelyBtnClick(){
        if delegate != nil {
            delegate?.withdrawMoneyImmediatelyBtnClick()
        }
    }
    
    //银行自动转账授权书
    
    @objc func bankProtocolClick(){
        if delegate != nil {
            delegate?.bankProtocolClick()
        }
    }
    //三方借款协议
    
    @objc func loanProtocolClick(){
        if delegate != nil {
            delegate?.loanProtocolClick()
        }
    }
}

