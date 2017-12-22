//
//  FXD_LoanApplicationDisplayTableViewCell.swift
//  fxdProduct
//
//  Created by admin on 2017/12/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

typealias ExplainBtnClick = () -> Void
class FXD_LoanApplicationDisplayTableViewCell: UITableViewCell {

    var viewOne:UIView?
    var viewTwo:UIView?
    var viewThree:UIView?
    
    var  lineOne:UIView?
    var  lineTwo:UIView?
    
    var amountLabel:UILabel?
    var everyAmountLabel:UILabel?
    var dateLabel:UILabel?
    
    var explainBtn:UIButton?
    
    var explainButtonClick:ExplainBtnClick?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func explainBtnClick() {
        if explainButtonClick != nil{
            explainButtonClick!()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FXD_LoanApplicationDisplayTableViewCell {
    
    func setUpUI()  {
        
        viewOne = UIView()
        self.addSubview(viewOne!)
        viewOne?.snp.makeConstraints({ (make) in
            make.height.equalTo(self.snp.height)
            make.width.equalTo(_k_w/3 + 4)
            make.center.equalTo(self.snp.center)
        })
        
        lineOne = UIView()
        lineOne?.backgroundColor = LOAN_APPLICATION_COLOR
        viewOne?.addSubview(lineOne!)
        lineOne?.snp.makeConstraints({ (make) in
            make.width.equalTo(2)
            make.top.equalTo((viewOne?.snp.top)!).offset(10)
            make.bottom.equalTo((viewOne?.snp.bottom)!).offset(-10)
            make.left.equalTo((viewOne?.snp.left)!).offset(0)
        })
        
        lineTwo = UIView()
        lineTwo?.backgroundColor = LOAN_APPLICATION_COLOR
        viewOne?.addSubview(lineTwo!)
        lineTwo?.snp.makeConstraints({ (make) in
            make.width.equalTo(2)
            make.top.equalTo((viewOne?.snp.top)!).offset(10)
            make.bottom.equalTo((viewOne?.snp.bottom)!).offset(-10)
            make.right.equalTo((viewOne?.snp.right)!).offset(0)
        })
        
        viewTwo = UIView()
        self.addSubview(viewTwo!)
        viewTwo?.snp.makeConstraints({ (make) in
            make.height.equalTo(self.snp.height)
            make.right.equalTo((viewOne?.snp.left)!)
            make.left.equalTo(self.snp.left)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        viewThree = UIView()
        self.addSubview(viewThree!)
        viewThree?.snp.makeConstraints({ (make) in
            make.height.equalTo(self.snp.height)
            make.left.equalTo((viewOne?.snp.right)!)
            make.right.equalTo(self.snp.right)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        let amountTitleLabel = UILabel()
        amountTitleLabel.textColor = UIColor.init(red: 77/255.0, green: 77/255.0, blue: 77/255.0, alpha: 1)
        amountTitleLabel.textAlignment = NSTextAlignment.center
        amountTitleLabel.font = UIFont.yx_systemFont(ofSize: 15)
        amountTitleLabel.text = "实际到账"
        viewTwo?.addSubview(amountTitleLabel)
        amountTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo((viewTwo?.snp.centerX)!)
            make.centerY.equalTo((viewTwo?.snp.centerY)!).offset(-15)
        }
        
        let everyAmountTitleLabel = UILabel()
        everyAmountTitleLabel.textColor = UIColor.init(red: 77/255.0, green: 77/255.0, blue: 77/255.0, alpha: 1)
        everyAmountTitleLabel.textAlignment = NSTextAlignment.center
        everyAmountTitleLabel.font = UIFont.yx_systemFont(ofSize: 15)
        everyAmountTitleLabel.text = "每期还款"
        viewOne?.addSubview(everyAmountTitleLabel)
        everyAmountTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo((viewOne?.snp.centerX)!)
            make.centerY.equalTo((viewOne?.snp.centerY)!).offset(-15)
        }
        
        let dateTitleLabel = UILabel()
        dateTitleLabel.textColor = UIColor.init(red: 77/255.0, green: 77/255.0, blue: 77/255.0, alpha: 1)
        dateTitleLabel.textAlignment = NSTextAlignment.center
        dateTitleLabel.font = UIFont.yx_systemFont(ofSize: 15)
        dateTitleLabel.text = "每期时长"
        viewThree?.addSubview(dateTitleLabel)
        dateTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo((viewThree?.snp.centerX)!)
            make.centerY.equalTo((viewThree?.snp.centerY)!).offset(-15)
        }
        
        amountLabel = UILabel()
        amountLabel?.textColor = UI_MAIN_COLOR
        amountLabel?.textAlignment = NSTextAlignment.center
        amountLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        viewTwo?.addSubview(amountLabel!)
        amountLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((viewTwo?.snp.centerX)!)
            make.centerY.equalTo((viewTwo?.snp.centerY)!).offset(15)
        })
        
        everyAmountLabel = UILabel()
        everyAmountLabel?.textColor = UI_MAIN_COLOR
        everyAmountLabel?.textAlignment = NSTextAlignment.center
        everyAmountLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        viewOne?.addSubview(everyAmountLabel!)
        everyAmountLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((viewOne?.snp.centerX)!)
            make.centerY.equalTo((viewOne?.snp.centerY)!).offset(15)
        })
        
        dateLabel = UILabel()
        dateLabel?.textColor = UI_MAIN_COLOR
        dateLabel?.textAlignment = NSTextAlignment.center
        dateLabel?.font = UIFont.yx_systemFont(ofSize: 14)
        viewThree?.addSubview(dateLabel!)
        dateLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((viewThree?.snp.centerX)!)
            make.centerY.equalTo((viewThree?.snp.centerY)!).offset(15)
        })
        
        explainBtn = UIButton.init(type: UIButtonType.custom)
        explainBtn?.setBackgroundImage(UIImage.init(named: "application_Explication_Image"), for: UIControlState.normal)
        explainBtn?.addTarget(self, action: #selector(explainBtnClick), for: UIControlEvents.touchUpInside)
        viewThree?.addSubview(explainBtn!)
        explainBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((dateTitleLabel.snp.right)).offset(3)
            make.width.height.equalTo(20)
            make.centerY.equalTo((dateTitleLabel.snp.centerY)).offset(0)
        })
    }
}


