//
//  CurrentInformationCell.swift
//  fxdProduct
//
//  Created by sxp on 2017/8/31.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

//MARK: 当前期cell
struct CurrentInfoCellType {
    
    enum Cell_Type {
        case Default    //默认的
        case Renewal    //续期的
        case Payment    //支付的
    }
    
    let cellType : Cell_Type?
}

class CurrentInformationCell: UITableViewCell {

    var cellType : CurrentInfoCellType?{
        didSet(newValue){
            setCellType(CellType: cellType!)
        }
    }
    
    var leftLabel : UILabel?
    var rightLabel : UILabel?
    
    
    
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
        
        cellType = CurrentInfoCellType(cellType: .Default)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CurrentInformationCell{

    fileprivate func setCellType(CellType : CurrentInfoCellType){
        
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let type = CellType.cellType
        switch type! {
        case .Default:
            defaultCell()
        case .Payment:
            paymentCell()
        case .Renewal:
            renewalCell()
        }
    }
    
    //MARK: 默认的cell
    fileprivate func defaultCell(){
    
        //左边的标题label
        leftLabel = UILabel()
        leftLabel?.textColor = UIColor.black
        leftLabel?.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(leftLabel!)
        leftLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(22)
            make.centerY.equalTo(self.snp.centerY)
        })
        //右边的内容label
        rightLabel = UILabel()
        rightLabel?.font = UIFont.systemFont(ofSize: 15)
        rightLabel?.textAlignment = .right
        self.contentView.addSubview(rightLabel!)
        rightLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self.snp.centerY)
        })
        //底部的线
        let lineView = UIView()
        lineView.backgroundColor = LINE_COLOR
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-0.5)
            make.height.equalTo(0.5)
        }
    }
    
    //MARK: 续期的cell
    fileprivate func renewalCell(){
        
        //右边的图片
        let rightImage = UIImageView()
        rightImage.image = UIImage(named:"icon_gengduo")
        self.contentView.addSubview(rightImage)
        rightImage.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        let renewalLabel = UILabel()
        renewalLabel.text = "了解续期规则"
        renewalLabel.textColor = UI_MAIN_COLOR
        renewalLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(renewalLabel)
        renewalLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(rightImage.snp.left).offset(-10)
        }
        
    }
    //MARK: 支付的cell
    fileprivate func paymentCell(){
        
        leftLabel = UILabel()
        leftLabel?.textColor = UIColor.black
        leftLabel?.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(leftLabel!)
        leftLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(22)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        let arrowImage = UIImageView()
        arrowImage.image = UIImage(named:"icon_arrowRight")
        self.contentView.addSubview(arrowImage)
        arrowImage.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-13)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        rightLabel = UILabel()
        rightLabel?.textColor = UI_MAIN_COLOR
        rightLabel?.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(rightLabel!)
        rightLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(arrowImage.snp.left).offset(-18)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        let lineView = UIView()
        lineView.backgroundColor = LINE_COLOR
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.right.equalTo(self)
            make.height.equalTo(1)
        }
        
    }
}

