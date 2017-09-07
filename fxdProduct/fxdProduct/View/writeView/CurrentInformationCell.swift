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
        lineView.backgroundColor = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-0.5)
            make.height.equalTo(0.5)
        }
    }
    
    fileprivate func renewalCell(){
        
        let rightImage = UIImageView()
        rightImage.image = UIImage(named:"icon_gengduo")
        self.addSubview(rightImage)
        rightImage.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        let renewalLabel = UILabel()
        renewalLabel.text = "了解续期规则"
        renewalLabel.textColor = UI_MAIN_COLOR
        renewalLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(renewalLabel)
        renewalLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(rightImage.snp.left).offset(-10)
        }
        
    }
}

extension CurrentInformationCell{

}
