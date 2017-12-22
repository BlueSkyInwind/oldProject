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
    
}

class HomePageCell: UITableViewCell {
    
    @objc weak var delegate: HomePageCellDelegate?
    
    //滑动标识的钱
    @objc var defaultMoneyLabel : UILabel?
    //滑动标识的时间
    @objc var defaultTimeLabel : UILabel?
    //中间状态第一条状态标题
    @objc var loanTopLabel : UILabel?
    //中间状态第一条状态内容
    @objc var loanTopContentLabel : UILabel?
    //中间状态第二条状态标题
    @objc var loanBottomLabel : UILabel?
    //中间状态时间
    @objc var loanTimeLabel : UILabel?
    //量子互助导流View
    @objc var loanBottomBgView : UIView?
    //可借额度
    @objc var quotaLabel : UILabel?
    
    @objc var payTipLabel : UILabel?
    //还款的月份
    @objc var monthLabel : UILabel?
    //还款的日期
    @objc var dayLabel : UILabel?
    //还款的money
    @objc var payMoneyLabel : UILabel?
    //逾期money
    @objc var overdueMoneyLabel : UILabel?
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
        
        repayImmediatelyView()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomePageCell {
    
//    //默认的cell
//    fileprivate func setCellType(CellType : HomePageCellType){
//
//        for view in self.subviews {
//            view.removeFromSuperview()
//        }
//
//        let type = CellType.cellType
//        switch type! {
//        case .Default:
//            defaultCell()
//        case .Quota:
//            quotaCell()
//        case .LoanProcessCell:
//            loanProcessCell()
//        }
//    }
}

extension HomePageCell {
    
    //默认的
    fileprivate func defaultCell(){
        
        defaultMoneyLabel = UILabel()
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
        slider.value = 1000
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
        sliderTime.value = 30
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
        applayBtn.setTitle("立即申请", for: .normal)
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
        
        loanTopLabel = UILabel()
        loanTopLabel?.textColor = UI_MAIN_COLOR
        loanTopLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(loanTopLabel!)
        loanTopLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(topImageView.snp.top).offset(0)
            make.left.equalTo(topImageView.snp.right).offset(20)
            make.height.equalTo(14)
        })
        
        loanTopContentLabel = UILabel()
        loanTopContentLabel?.textColor = MIDDLE_LINE_COLOR
        loanTopContentLabel?.numberOfLines = 0
        loanTopContentLabel?.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(loanTopContentLabel!)
        loanTopContentLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((loanTopLabel?.snp.bottom)!).offset(10)
            make.left.equalTo(lineView.snp.right).offset(25)
            make.height.equalTo(60)
            make.right.equalTo(-22)
        })
        
        loanBottomLabel = UILabel()
        loanBottomLabel?.textColor = RedPacketBottomBtn_COLOR
        loanBottomLabel?.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(loanBottomLabel!)
        loanBottomLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(bottomImageView.snp.top).offset(0)
            make.left.equalTo(bottomImageView.snp.right).offset(20)
            make.height.equalTo(20)
        })
        
        loanTimeLabel = UILabel()
        loanTimeLabel?.textColor = MIDDLE_LINE_COLOR
        loanTimeLabel?.font = UIFont.systemFont(ofSize: 12)
        loanTimeLabel?.textAlignment = .right
        self.addSubview(loanTimeLabel!)
        loanTimeLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((loanBottomLabel?.snp.top)!).offset(0)
            make.right.equalTo(self).offset(-22)
            make.height.equalTo(20)
        })
        
        loanBottomBgView = UIView()
        self.addSubview(loanBottomBgView!)
        loanBottomBgView?.snp.makeConstraints({ (make) in
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
        loanBottomBgView?.addSubview(bottomDesclabel)
        bottomDesclabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo((loanBottomBgView?.snp.top)!).offset(10)
            make.height.equalTo(20)
        }
        
        let bottomBtn = UIButton()
        bottomBtn.setTitle("点击立即领取", for: .normal)
        bottomBtn.setTitleColor(UIColor.white, for: .normal)
        bottomBtn.setBackgroundImage(UIImage(named:"liangzihuzhu"), for: .normal)
        bottomBtn.addTarget(self, action: #selector(bottomClick), for: .touchUpInside)
        loanBottomBgView?.addSubview(bottomBtn)
        bottomBtn.snp.makeConstraints { (make) in
            make.top.equalTo(bottomDesclabel.snp.bottom).offset(14)
            make.width.equalTo(205)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        if UI_IS_IPONE6 {
            loanBottomBgView?.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self).offset(-10)
            })
        }
        
        if UI_IS_IPONE5 {
            
            loanBottomBgView?.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self).offset(-15)
            })
            
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
        
        quotaLabel = UILabel()
        quotaLabel?.textColor = LOAN_QUOTA_COLOR
        quotaLabel?.font = UIFont.systemFont(ofSize: 25)
        quotaLabel?.textAlignment = .center
        bgView.addSubview(quotaLabel!)
        quotaLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(41)
            make.centerX.equalTo(bgView.snp.centerX)
//            make.centerY.equalTo(bgView.snp.centerY)
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
        titleLabel.text = "信用评分不足"
        titleLabel.textColor = UI_MAIN_COLOR
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self).offset(20)
            make.height.equalTo(20)
        }
        
        let firstLabel = UILabel()
        firstLabel.textColor = RedPacket_COLOR
        firstLabel.text = "方法一: 添加提额资料,重新测评"
        firstLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.left.equalTo(self).offset(55)
            make.height.equalTo(20)
        }
        
        let secondLabel = UILabel()
        secondLabel.textColor = RedPacket_COLOR
        secondLabel.text = "方法二: 30天后更新基础资料,重新测评"
        secondLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { (make) in
            make.top.equalTo(firstLabel.snp.bottom).offset(12)
            make.left.equalTo(self).offset(55)
            make.height.equalTo(20)
        }
        
        let thirdLabel = UILabel()
        thirdLabel.text = "方法三: 试试以下推荐平台"
        thirdLabel.textColor = RedPacket_COLOR
        thirdLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(thirdLabel)
        thirdLabel.snp.makeConstraints { (make) in
            make.top.equalTo(secondLabel.snp.bottom).offset(12)
            make.left.equalTo(self).offset(55)
            make.height.equalTo(20)
        }
        
        let bgView = UIView()
        bgView.backgroundColor = LINE_COLOR
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
//            thirdRefuseView.backgroundColor = UIColor.white
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
            
            let url = URL(string: "http://192.168.6.137/fxd/M00/00/00/wKgGiVlxnkGEOlsJAAAAADqL7FU975.png")
            thirdRefuseView.leftImageView?.sd_setImage(with: url)

            thirdRefuseView.titleLabel?.text = "贷嘛"
            thirdRefuseView.qutaLabel?.text = "额度:最高5000元"
//            thirdRefuseView.termLabel?.text = ""
            thirdRefuseView.termLabel?.text = "期限:"+"1"+"-"+"60"+"天"
            thirdRefuseView.feeLabel?.text = "费用：" + "0.3%/日"
            let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(thirdRefuseView.termLabel?.text)!)
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr.length-4))
            thirdRefuseView.termLabel?.attributedText = attrstr
            let attrstr1 : NSMutableAttributedString = NSMutableAttributedString(string:(thirdRefuseView.feeLabel?.text)!)
            attrstr1.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr1.length-5))
            thirdRefuseView.feeLabel?.attributedText = attrstr1
            thirdRefuseView.descBtn?.setTitle("30家借款机构,0抵押当天放款", for: .normal)
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
        
        payTipLabel = UILabel()
        payTipLabel?.text = "借款到账: 2017-12-12,建设银行尾号5439,成功借款3000元"
        payTipLabel?.textColor = UI_MAIN_COLOR
        payTipLabel?.font = UIFont.systemFont(ofSize: 12)
        tipImageView.addSubview(payTipLabel!)
        payTipLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(tipImageView.snp.left).offset(22)
            make.centerY.equalTo(tipImageView.snp.centerY)
            make.right.equalTo(tipImageView.snp.right).offset(-22)
        })
        
        let titleLabel = UILabel()
        titleLabel.textColor = RedPacketBottomBtn_COLOR
        titleLabel.text = "下一期还款日期"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tipImageView.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        let middleView = setOverdueView()
        self.addSubview(middleView)
        middleView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.height.equalTo(170)
        }
        
        
        
//        let middleView = setNormalView()()
//        self.addSubview(middleView)
//        middleView.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(0)
//            make.right.equalTo(self).offset(0)
//            make.top.equalTo(titleLabel.snp.bottom).offset(14)
//            make.height.equalTo(170)
//        }
        
        let repayImmediatelyBtn = UIButton()
        repayImmediatelyBtn.setTitle("立即还款", for: .normal)
        repayImmediatelyBtn.setBackgroundImage(UIImage(named:"applayBtnImage"), for: .normal)
        repayImmediatelyBtn.setTitleColor(UIColor.white, for: .normal)
        repayImmediatelyBtn.addTarget(self, action: #selector(repayImmediatelyBtnClick), for: .touchUpInside)
        self.addSubview(repayImmediatelyBtn)
        repayImmediatelyBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(25)
            make.right.equalTo(self).offset(-25)
            make.top.equalTo(middleView.snp.bottom).offset(38)
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
        protocolLabel.text = "我已阅读并认可发薪贷《银行走动转账授权书》、《三方借款协议》"
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
        
        if UI_IS_IPONE5 {
            
            titleLabel.snp.updateConstraints({ (make) in
                
                make.top.equalTo(tipImageView.snp.bottom).offset(5)
            })
            
            middleView.snp.updateConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(0)
                make.height.equalTo(140)
            }
            
            repayImmediatelyBtn.snp.updateConstraints { (make) in
                make.top.equalTo(middleView.snp.bottom).offset(5)
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
        tipLabel.text = "温馨提示: 您当前有一笔借款可以立即提款"
        tipLabel.font = UIFont.systemFont(ofSize: 12)
        tipLabel.textColor = UI_MAIN_COLOR
        tipLabel.textAlignment = .center
        self.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self).offset(18)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "借款金额(元)"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UI_MAIN_COLOR
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(tipLabel.snp.bottom).offset(47)
        }
        
        quotaLabel = UILabel()
        quotaLabel?.textAlignment = .center
        quotaLabel?.textColor = UIColor.black
        quotaLabel?.font = UIFont.systemFont(ofSize: 25)
        self.addSubview(quotaLabel!)
        quotaLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
        })
        
        let withdrawMoneyImmediatelyBtn = UIButton()
        withdrawMoneyImmediatelyBtn.setTitle("立即提款", for: .normal)
        withdrawMoneyImmediatelyBtn.setTitleColor(UIColor.white, for: .normal)
        withdrawMoneyImmediatelyBtn.setBackgroundImage(UIImage(named:"applayBtnImage"), for: .normal)
        withdrawMoneyImmediatelyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        withdrawMoneyImmediatelyBtn.addTarget(self, action: #selector(withdrawMoneyImmediatelyBtnClick), for: .touchUpInside)
        self.addSubview(withdrawMoneyImmediatelyBtn)
        withdrawMoneyImmediatelyBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(28)
            make.right.equalTo(self).offset(-28)
            make.top.equalTo((quotaLabel?.snp.bottom)!).offset(47)
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
        
        monthLabel = UILabel()
        monthLabel?.text = "1"
        monthLabel?.textColor = UI_MAIN_COLOR
        monthLabel?.font = UIFont.systemFont(ofSize: 20)
        monthImageView.addSubview(monthLabel!)
        monthLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(monthImageView.snp.centerX)
            make.top.equalTo(monthImageView.snp.top).offset(21)
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
        
        dayLabel = UILabel()
        dayLabel?.textColor = UI_MAIN_COLOR
        dayLabel?.text = "13"
        dayLabel?.font = UIFont.systemFont(ofSize: 20)
        dayImageView.addSubview(dayLabel!)
        dayLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(dayImageView.snp.centerX)
            make.top.equalTo(dayImageView.snp.top).offset(21)
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
        
        payMoneyLabel = UILabel()
        payMoneyLabel?.text = "700元"
        payMoneyLabel?.textColor = UI_MAIN_COLOR
        payMoneyLabel?.font = UIFont.systemFont(ofSize: 25)
        payMoneyLabel?.textAlignment = .center
        view.addSubview(payMoneyLabel!)
        payMoneyLabel?.snp.makeConstraints({ (make) in
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
            make.top.equalTo((payMoneyLabel?.snp.bottom)!).offset(14)
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
        
        dayLabel = UILabel()
        dayLabel?.textColor = UI_MAIN_COLOR
        dayLabel?.text = "13"
        dayLabel?.font = UIFont.systemFont(ofSize: 20)
        dayImageView.addSubview(dayLabel!)
        dayLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(dayImageView.snp.centerX)
            make.top.equalTo(dayImageView.snp.top).offset(21)
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
        
        overdueMoneyLabel = UILabel()
        overdueMoneyLabel?.text = "700 + 35.55 = 735.5元"
        overdueMoneyLabel?.textColor = UIColor.black
        overdueMoneyLabel?.font = UIFont.systemFont(ofSize: 17)
        overdueMoneyLabel?.textAlignment = .center
        view.addSubview(overdueMoneyLabel!)
        overdueMoneyLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(lineView.snp.bottom).offset(26)
        })
        
        
        let overdueView = UIView()
        overdueView.backgroundColor = UIColor.clear
        view.addSubview(overdueView)
        overdueView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo((overdueMoneyLabel?.snp.bottom)!).offset(23)
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
            
            overdueMoneyLabel?.snp.updateConstraints({ (make) in
                make.top.equalTo(lineView.snp.bottom).offset(13)
            })
            
            overdueView.snp.updateConstraints { (make) in
                make.top.equalTo((overdueMoneyLabel?.snp.bottom)!).offset(12)
            }
            
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
//        switch tag! {
//        case 104:
//            path = homeProductData.data.thirdProductList[0].extAttr.path_
//            productId = homeProductData.data.thirdProductList[0].id_
//        case 105:
//            path = homeProductData.data.thirdProductList[1].extAttr.path_
//            productId = homeProductData.data.thirdProductList[1].id_
//        case 106:
//            path = homeProductData.data.thirdProductList[2].extAttr.path_
//            productId = homeProductData.data.thirdProductList[2].id_
//        default:
//            break
//        }
        
        if delegate != nil {
            
            delegate?.productListClick("productId" ,isOverLimit: "isOverLimit" ,amount: "amount",Path:"path")
            
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
}

