//
//  MessageCell.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/14.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

//MARK: 当前期cell
struct MessageCellType {

    enum Cell_Type {
        case Default    //默认的
        case Header    //头部空白的
    }

    let cellType : Cell_Type?
}


class MessageCell: UITableViewCell {

    var cellType : MessageCellType?{
        didSet(newValue){
            setCellType(CellType: cellType!)
        }
    }
    
    var titleLabel : UILabel?
    var contentLabel : UILabel?
    var timeLabel : UILabel?
    var leftImageView : UIImageView?
    var arrowImageView : UIImageView?
    
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
        cellType = MessageCellType(cellType: .Header)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MessageCell{
    
    fileprivate func setCellType(CellType : MessageCellType){

        for view in self.subviews {
            view.removeFromSuperview()
        }

        let type = CellType.cellType
        switch type! {
        case .Default:

            defaultCell()
        case .Header:

            headerCell()
        }
    }
    
}

extension MessageCell{
    
    
    /// 默认cell
    fileprivate func defaultCell(){
        
        leftImageView = UIImageView()
        leftImageView?.image = UIImage(named:"speaker")
        self.addSubview(leftImageView!)
        leftImageView?.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(16)
            make.width.equalTo(8)
            make.height.equalTo(8)
        }
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
        titleLabel?.textColor = MESSAGE_TITLE_COLOR
        titleLabel?.textAlignment = .left
        titleLabel?.numberOfLines = 0
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((leftImageView?.snp.right)!).offset(30)
            make.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-40)
        })
        
        contentLabel = UILabel()
        contentLabel?.font = UIFont.systemFont(ofSize: 11)
        contentLabel?.textColor = RedPacketBottomBtn_COLOR
        contentLabel?.textAlignment = .left
        self.addSubview(contentLabel!)
        contentLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((leftImageView?.snp.right)!).offset(30)
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(10)
            make.right.equalTo(self).offset(-40)
        })
        
        timeLabel = UILabel()
        timeLabel?.font = UIFont.systemFont(ofSize: 11)
        timeLabel?.textColor = RedPacketBottomBtn_COLOR
        timeLabel?.textAlignment = .left
        self.addSubview(timeLabel!)
        timeLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((contentLabel?.snp.left)!).offset(0)
            make.top.equalTo((contentLabel?.snp.bottom)!).offset(3)
        })
        
        arrowImageView = UIImageView()
        arrowImageView?.image = UIImage.init(named: "arrow_nor_icon")
        self.addSubview(arrowImageView!)
        arrowImageView?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self.snp.centerY)
        })
        
        let bottomLineView = UIView()
        bottomLineView.backgroundColor = LINE_COLOR
        self.addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self).offset(-0.5)
            make.height.equalTo(0.5)
        }
    }
    
    /// 头部空白cell
    fileprivate func headerCell(){
        
        let headerView = UIView()
        headerView.backgroundColor = LINE_COLOR
        self.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
}
