//
//  HomeBetweenCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class HomeBetweenCell: UITableViewCell {

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
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HomeBetweenCell{
    fileprivate func setupUI(){
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage.init(named: "between_bg_icon")
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        for index in 0..<4 {
            let view = setView()
            bgImageView.addSubview(view)
            let i = CGFloat.init(index)
            
            let x = (_k_w / 4) * i
            titleImageViewBtn?.tag = 101 + index
            titleImageViewBtn?.setImage(UIImage.init(named: dataArray![index] as! String), for: .normal)
            titleLabel?.text = "不查征信"
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
    
    @objc fileprivate func imageViewBtnClick(_ sender : UIButton){
        
    }
}
