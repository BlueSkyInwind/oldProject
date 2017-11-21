//
//  SetIdentitiesOfTradeView.swift
//  fxdProduct
//
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

typealias NextBottonClick = () -> Void
class SetIdentitiesOfTradeView: UIView,UITableViewDelegate,UITableViewDataSource{

    var contentTableView:UITableView?
    var nextButton:UIButton?
    var identitiesOfTradeCell:IdentitiesOfTradeTableViewCell?
    var nextClick:NextBottonClick?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension SetIdentitiesOfTradeView {
    
    func setUpUI() -> Void {
        contentTableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        contentTableView?.delegate = self
        contentTableView?.dataSource = self
        self.addSubview(contentTableView!)
        contentTableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        contentTableView?.register(IdentitiesOfTradeTableViewCell.self, forCellReuseIdentifier: "IdentitiesOfTradeTableViewCell")
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerLabel = UILabel()
        headerLabel.font = UIFont.yx_systemFont(ofSize: 16)
        let str = "填写您的身份证号码，验证身份"
        let attati : NSMutableAttributedString = NSMutableAttributedString.init(string: str, attributes: [:])
        attati.addAttributes([NSAttributedStringKey.foregroundColor:UI_MAIN_COLOR], range: NSMakeRange(4, 5))
        headerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.center.equalTo(headerView.snp.center)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        identitiesOfTradeCell = tableView.dequeueReusableCell(withIdentifier:  "IdentitiesOfTradeTableViewCell", for: indexPath) as? IdentitiesOfTradeTableViewCell
        
        return identitiesOfTradeCell!
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        nextButton = UIButton.init(type: UIButtonType.custom)
        nextButton?.layer.cornerRadius = 5
        nextButton?.clipsToBounds = true
        nextButton?.backgroundColor = UI_MAIN_COLOR
        nextButton?.titleLabel?.font = UIFont.yx_systemFont(ofSize: 18)
        nextButton?.addTarget(self, action: #selector(nextBtnClick), for: UIControlEvents.touchUpInside)
        footerView.addSubview(nextButton!)
        nextButton?.snp.makeConstraints({ (make) in
            make.top.equalTo(footerView.snp.top).offset(95)
            make.left.equalTo(footerView.snp.left).offset(15)
            make.right.equalTo(footerView.snp.right).offset(-15)
            make.height.equalTo(45)
        })
        return footerView
    }
    
    @objc func nextBtnClick()  {
        if (self.nextClick != nil) {
            self.nextClick!()
        }
    }
}

