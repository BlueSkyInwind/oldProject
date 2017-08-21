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
    
    var leftImageView : UIImageView?
    var titleLabel: UILabel?
    var qutaLabel: UILabel?
    var thirdTitleArray = [""]
    
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
    
        // 定义
        let slider = UISlider()
        // 位置
        slider.frame = CGRect(x: 50, y: 100, width: 200, height: 50)
        //slider.value = 1
        // 设置最小值
        slider.minimumValue = 500
        // 设置最大值
        slider.maximumValue = 3000
        // 设置按钮最小端图片
        slider.minimumValueImage = UIImage.init(named: "2.png")
        // 设置按钮最大端图片
        slider.maximumValueImage = UIImage.init(named: "1.png")
        // 设置圆点图片
        slider.setThumbImage(UIImage.init(named: "yuan.png"), for: UIControlState.normal)
        // 设置圆点颜色
        slider.thumbTintColor = UIColor.red
        // 设置滑动过的颜色
        slider.minimumTrackTintColor = UIColor.green
        // 设置未滑动过的颜色
        slider.maximumTrackTintColor = UIColor.blue
        
        // 添加事件
        slider.addTarget(self, action: #selector(changed(slider:)), for: UIControlEvents.valueChanged)
        self.addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(30)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
        }
        
        let leftLabel = UILabel()
        leftLabel.text = "500元"
        leftLabel.font = UIFont.systemFont(ofSize: 16)
        leftLabel.textColor = UIColor.black
        self.addSubview(leftLabel)
    
        leftLabel.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom).offset(10)
            make.left.equalTo(self).offset(15)
            make.height.equalTo(20)
        }
        
        let rightLabel = UILabel()
        rightLabel.textColor = UIColor.black
        rightLabel.text = "3000元"
        rightLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom).offset(10)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(20)
        }
        
        let applyBtn = UIButton()
        applyBtn.setTitle("立即申请", for: .normal)
        applyBtn.setTitleColor(UIColor.white, for: .normal)
        applyBtn.backgroundColor = UIColor.red
//        APPTool.shareInstance.setCornerBorder(view: applyBtn, borderColor: UIColor.red)
        applyBtn.addTarget(self, action: #selector(applyBtnClick), for: .touchUpInside)
        self.addSubview(applyBtn)
        applyBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-20)
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(44)
        }
    }
    //不满60天被拒，升级高级认证
     func setupRefuseUI(){
    
        let titleLabel = UILabel()
        titleLabel.text = "您目前的信用评分不足，以下途径可提高评分："
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.black
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(20)
        }
        
        let firstLabel = UILabel()
        firstLabel.text = "一、60天后，更新基础资料"
        firstLabel.font = UIFont.systemFont(ofSize: 16)
        firstLabel.textColor = UIColor.black
        self.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(self).offset(15)
            make.height.equalTo(20)
        }
        
        let secondLabel = UILabel()
        secondLabel.textColor = UIColor.black
        secondLabel.text = "二、添加高级认证"
        secondLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { (make) in
            make.top.equalTo(firstLabel.snp.bottom).offset(20)
            make.left.equalTo(self).offset(15)
            make.height.equalTo(20)
        }
    
        let advancedCertificationBtn = UIButton()
        advancedCertificationBtn.setTitle("立即添加高级认证", for: .normal)
        advancedCertificationBtn.setTitleColor(UIColor.black, for: .normal)
        advancedCertificationBtn.addTarget(self, action: #selector(advancedCertificationClick), for: .touchUpInside)
        self.addSubview(advancedCertificationBtn)
        advancedCertificationBtn.snp.makeConstraints { (make) in
            make.top.equalTo(secondLabel.snp.bottom).offset(30)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(44)
        }
    }
    
    //信用评分不足，导流其他平台
    func setupOtherPlatformsUI(){
    
        let titleLabel = UILabel()
        titleLabel.text = "您的信用评分不足，更新资料可提升(需60天后)"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
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
        label.text = "先试试以下平台"
        label.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(self).offset(15)
            make.height.equalTo(20)
        }
        
        
    }
    
    //进件带提款
    func setupDrawingUI(){
    
        let bgView = UIView()
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo((leftTitleArray.count*30)+80)
        }
        
        for index in 0..<leftTitleArray.count {
            let indexView = setView()
            bgView.addSubview(indexView)
            indexView.snp.makeConstraints({ (make) in
                make.top.equalTo(bgView.snp.top).offset(index*30)
                make.left.equalTo(bgView.snp.left).offset(0)
                make.right.equalTo(bgView.snp.right).offset(0)
                make.height.equalTo(30)
            })
            leftLabel?.text = leftTitleArray[index]
            rightLabel?.text = rightContentArray[index]
        }
        
        let bottomBtn = UIButton()
        bottomBtn.setTitle("点击提款", for: .normal)
        bottomBtn.setTitleColor(UIColor.black, for: .normal)
        bottomBtn.backgroundColor = UIColor.red
//        APPTool.shareInstance.setCornerBorder(view: bottomBtn, borderColor: UIColor.red)
        bottomBtn.addTarget(self, action: #selector(bottomBtnClick), for: .touchUpInside)
        self.addSubview(bottomBtn)
        bottomBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(bgView.snp.bottom).offset(-20)
            make.left.equalTo(bgView.snp.left).offset(15)
            make.right.equalTo(bgView.snp.right).offset(-15)
            make.height.equalTo(44)
        }
    }
}


extension HomeDefaultCell{

    //提款的View
    func setView()->UIView{
    
        let view = UIView()
        self.addSubview(view)
        
        leftLabel = UILabel()
        leftLabel?.font = UIFont.systemFont(ofSize: 16)
        leftLabel?.textColor = UIColor.black
        view.addSubview(leftLabel!)
        leftLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(view.snp.top).offset(0)
            make.left.equalTo(view.snp.left).offset(15)
            make.bottom.equalTo(view.snp.bottom).offset(0)
        })
        
        rightLabel = UILabel()
        rightLabel?.font = UIFont.systemFont(ofSize: 16)
        rightLabel?.textColor = UIColor.black
        rightLabel?.textAlignment = .left
        view.addSubview(rightLabel!)
        rightLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(view.snp.top).offset(0)
            make.right.equalTo(view.snp.right).offset(-15)
            make.bottom.equalTo(view.snp.bottom).offset(0)
        })
        return view
    }
    
    //第三平台的View
    func setThirdView()->UIView{
    
        let view = UIView()
        self.addSubview(view)
        leftImageView = UIImageView()
        view.addSubview(leftImageView!)
        leftImageView?.snp.makeConstraints({ (make) in
            make.top.equalTo(view.snp.top).offset(10)
            make.left.equalTo(view.snp.left).offset(15)
        })
        
        titleLabel = UILabel()
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(view.snp.top).offset(10)
            make.left.equalTo((leftImageView?.snp.right)!).offset(8)
            make.height.equalTo(20)
        })
        qutaLabel = UILabel()
        qutaLabel?.textColor = UIColor.black
        qutaLabel?.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(qutaLabel!)
        qutaLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(view.snp.top).offset(10)
            make.left.equalTo((titleLabel?.snp.right)!).offset(8)
            make.height.equalTo(20)
        })
        return view
    }
}
//点击事件
extension HomeDefaultCell{

    func advancedCertificationClick(){
    
    }
    
    func bottomBtnClick(){
    
    }
    
    func changed(slider:UISlider){
        print("slider.value = %d",slider.value)
    }
    
    func applyBtnClick(){
    
    }
}
