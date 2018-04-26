//
//  RecentCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/4/24.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc protocol RecentCellDelegate: NSObjectProtocol {
    
    func recentMoreBtnClick()
}

class RecentCell: UITableViewCell ,UITableViewDelegate,UITableViewDataSource,SuperLoanCellDelegate{
    //SuperLoanCellDelegate  点击收藏按钮的代理方法
    func collectionBtn(_ sender: UIButton) {

    }
    

    var superLoanCell : SuperLoanCell?
    @objc var delegate : RecentCellDelegate?
    
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
        
        setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecentCell{
    fileprivate func setUpUI(){
       
        let tipView = UIView()
        tipView.backgroundColor = UIColor.clear
        self.addSubview(tipView)
        tipView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(30)
        }
        let lineView = UIView()
        lineView.backgroundColor = UI_MAIN_COLOR
        tipView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(tipView.snp.left).offset(20)
            make.top.equalTo(tipView.snp.top).offset(9)
            make.width.equalTo(3)
            make.height.equalTo(14)
        }
        
        let tipTitleLabel = UILabel()
        tipTitleLabel.text = "热门推荐"
        tipTitleLabel.font = UIFont.yx_systemFont(ofSize: 14)
        tipTitleLabel.textColor = TIP_TITLE_COLOR
        tipView.addSubview(tipTitleLabel)
        tipTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineView.snp.right).offset(5)
            make.top.equalTo(tipView.snp.top).offset(8)
        }
        
        let arrowBtn = UIButton()
        arrowBtn.setImage(UIImage.init(named: "arrow_icon"), for: .normal)
        arrowBtn.addTarget(self, action: #selector(moreBtnClick), for: .touchUpInside)
        tipView.addSubview(arrowBtn)
        arrowBtn.snp.makeConstraints { (make) in
            make.right.equalTo(tipView.snp.right).offset(-20)
            make.centerY.equalTo(tipView.snp.centerY)
        }
        
        let bottomLineView = UIView()
        bottomLineView.backgroundColor = TIP_LINE_COLOR
        tipView.addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints { (make) in
            make.left.equalTo(tipView.snp.left).offset(0)
            make.right.equalTo(tipView.snp.right).offset(0)
            make.bottom.equalTo(tipView.snp.bottom).offset(-1)
            make.height.equalTo(1)
        }
        
        
        let moreBtn = UIButton()
        moreBtn.setTitle("查看更多", for: .normal)
        moreBtn.setTitleColor(MIDDLE_LINE_COLOR, for: .normal)
        moreBtn.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
        moreBtn.addTarget(self, action: #selector(moreBtnClick), for: .touchUpInside)
        tipView.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(arrowBtn.snp.left).offset(-8)
            make.centerY.equalTo(tipView.snp.centerY)
        }
        let tabView = UITableView()
        tabView.isScrollEnabled = false
        tabView.delegate = self
        tabView.dataSource = self
        self.addSubview(tabView)
        tabView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(tipView.snp.bottom).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
    }
}

extension RecentCell{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        superLoanCell = tableView.dequeueReusableCell(withIdentifier:"SuperLoanCell") as? SuperLoanCell
        if superLoanCell == nil {
            superLoanCell = SuperLoanCell.init(style: .default, reuseIdentifier: "SuperLoanCell")
        }
        
        superLoanCell?.delegate = self
        superLoanCell?.isSelected = false
        superLoanCell?.collectionBtn?.tag = indexPath.section
        
        
        let url = URL(string: "placeholderImage_Icon")
        superLoanCell?.leftImageView?.sd_setImage(with: url, placeholderImage: UIImage.init(named: "placeholderImage_Icon"), options: .refreshCached, completed: { (uiImage, error, cachType, url) in
            
        })
        superLoanCell?.titleLabel?.text = "贷嘛"
        superLoanCell?.qutaLabel?.text = "额度:最高500元"
        superLoanCell?.termLabel?.text = "期限:1-60月"
//        if term != "" {
        
            let attrstr1 : NSMutableAttributedString = NSMutableAttributedString(string:(superLoanCell?.termLabel?.text)!)
            attrstr1.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr1.length-4))
            superLoanCell?.termLabel?.attributedText = attrstr1
//        }
//        let referenceRate = model.referenceRate != nil ? model.referenceRate : ""
//        if model.referenceMode == nil {
        
//            superLoanCell?.feeLabel?.text = "费用:%" + referenceRate!
//        }else{
            superLoanCell?.feeLabel?.text = "费用:0.3%/日"
//        }
        
        
//        if referenceRate != nil && model.referenceMode != nil {
        
            let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(superLoanCell?.feeLabel?.text)!)
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr.length-4))
            superLoanCell?.feeLabel?.attributedText = attrstr
//        }
        
        superLoanCell?.descBtn?.setTitle("30家借款机构，0抵押当天放款", for: .normal)
        superLoanCell?.descBtn?.setTitleColor(UIColor.purple, for: .normal)
        superLoanCell?.descBtn?.layer.borderColor = UIColor.purple.cgColor
        
        if indexPath.section % 2 == 0 {
            superLoanCell?.descBtn?.setTitleColor(UIColor.blue, for: .normal)
            superLoanCell?.descBtn?.layer.borderColor = UIColor.blue.cgColor
        }
        
        superLoanCell?.lineView?.isHidden = true
//        let str : NSString = model.platformIntroduction! as NSString
        let str : NSString = (superLoanCell?.descBtn?.titleLabel?.text)! as NSString
        let dic = NSDictionary(object: UIFont.yx_systemFont(ofSize: 12) as Any, forKey: NSAttributedStringKey.font as NSCopying)
        let width = str.boundingRect(with: CGSize(width:_k_w,height:20), options: .usesLineFragmentOrigin, attributes:(dic as! [NSAttributedStringKey : Any]), context: nil).size.width + 20
        
        superLoanCell?.descBtn?.snp.updateConstraints({ (make) in
            make.width.equalTo(width)
        })
        
        superLoanCell?.collectionBtn?.setImage(UIImage.init(named: "collection_icon"), for: .normal)
//        if model.isCollect == "0" {
//            superLoanCell?.collectionBtn?.setImage(UIImage.init(named: "collection_selected_icon"), for: .normal)
//        }
        return superLoanCell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension RecentCell{
    @objc fileprivate func moreBtnClick(){
        
        if delegate != nil {
            delegate?.recentMoreBtnClick()
        }
    }
}
