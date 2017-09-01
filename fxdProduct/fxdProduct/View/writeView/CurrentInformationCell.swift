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
        case Default
        case Renewal
        case Payment
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
    
        let type = CellType.cellType
        
        switch type! {
            
        case .Default:
        
            defaultCell()
            
        case .Payment:
            renewalCell()
        case .Renewal:
            renewalCell()
        
        }
    }
    
    //MARK: 默认的cell
    fileprivate func defaultCell(){
    
        leftLabel = UILabel()
        leftLabel?.textColor = UIColor.black
        leftLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(leftLabel!)
        leftLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        rightLabel = UILabel()
        rightLabel?.font = UIFont.systemFont(ofSize: 15)
        rightLabel?.textAlignment = .right
        self.addSubview(rightLabel!)
        rightLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.gray
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-0.5)
            make.height.equalTo(0.5)
        }
    }
    
    fileprivate func renewalCell(){
    
        let rightImageBtn = UIButton()
        rightImageBtn.setBackgroundImage(UIImage(named:""), for: .normal)
        rightImageBtn.addTarget(self, action: #selector(renewalBtnClick), for: .touchUpInside)
        self.addSubview(rightImageBtn)
        rightImageBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        let renewalBtn = UIButton()
        renewalBtn.setTitle("了解续期规则", for: .normal)
        renewalBtn.setTitleColor(UI_MAIN_COLOR, for: .normal)
        renewalBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        renewalBtn.addTarget(self, action: #selector(renewalBtnClick), for: .touchUpInside)
        self.addSubview(renewalBtn)
        renewalBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(rightImageBtn.snp.left).offset(-10)
        }
    }
}

extension CurrentInformationCell{

    func renewalBtnClick(){
    
    }
}
