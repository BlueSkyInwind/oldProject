//
//  HomeBetweenCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc protocol HomeBetweenCellDelegate: NSObjectProtocol {

    func imageViewBtnClick(_ sender: UIButton)

}

class HomeBetweenCell: UITableViewCell {

    //产品数据
    @objc var homeProductListModel = FXD_HomeProductListModel()
    @objc weak var delegate: HomeBetweenCellDelegate?
    var titleImageViewBtn : UIButton?
    var titleLabel : UILabel?
    @objc var dataArray : NSArray?{
        didSet(newValue){

            setupUI()
        }
    }
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
        
//        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HomeBetweenCell{
    fileprivate func setupUI(){
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage.init(named: "between_bg_icon")
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        if homeProductListModel.indexMenu == nil {
            return
        }
        
        for index in 0..<homeProductListModel.indexMenu.count {
            if index > 3{
                return
            }
            let view = setView()
            bgImageView.addSubview(view)
            let i = CGFloat.init(index)
            
            let x = (_k_w / 4) * i
            titleImageViewBtn?.tag = 101 + index
            
            let model = homeProductListModel.indexMenu[index] as! IndexMenuModel
            
            let url = URL(string: model.image)
            
            titleImageViewBtn?.sd_setImage(with: url, for: .normal, completed: nil)
            titleLabel?.text = model.title
            view.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(x)
                make.top.equalTo(self).offset(0)
                make.bottom.equalTo(self).offset(0)
                make.width.equalTo(_k_w / 4)
            }
        }
    }
    
    fileprivate func setView() -> UIView{
        
        let view = UIView()
        view.isUserInteractionEnabled = true
        titleImageViewBtn = UIButton()
        titleImageViewBtn?.addTarget(self, action: #selector(imageViewBtnClick(_:)), for: .touchUpInside)
        view.addSubview(titleImageViewBtn!)
        titleImageViewBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo(view.snp.top).offset(18)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(32)
            make.height.equalTo(32)
        })
        
        titleLabel = UILabel()
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((titleImageViewBtn?.snp.bottom)!).offset(15)
            make.centerX.equalTo(view.snp.centerX)
        })
        return view
        
    }
    
    @objc func imageViewBtnClick(_ sender : UIButton){
        if delegate != nil {
            delegate?.imageViewBtnClick(sender)
        }
    }
}
