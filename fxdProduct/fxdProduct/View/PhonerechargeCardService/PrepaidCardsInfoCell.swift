//
//  PrepaidCardsInfoCell.swift
//  fxdProduct
//
//  Created by admin on 2018/6/7.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class PrepaidCardsInfoCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource {
    
    var isHiddenPassword:Bool = true
    
    var cardTableView:UITableView?
     override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func copyBtnClick() {
        
    }
    
    @objc func isHiddenBtnClick(sender:UIButton) {
        if isHiddenPassword {
            sender.setTitle("隐藏密码", for: UIControlState.normal)
        }else{
            sender.setTitle("显示密码", for: UIControlState.normal)
        }
        isHiddenPassword = !isHiddenPassword

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardNumAndPasswordCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 53
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return setHeaderView()
    }
    
}

extension PrepaidCardsInfoCell {
    
    func  setUpUI()  {
        
        cardTableView = UITableView()
        cardTableView?.delegate = self;
        cardTableView?.dataSource = self;
        cardTableView?.separatorStyle = .none
        self.addSubview(cardTableView!)
        cardTableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        cardTableView?.register(UINib.init(nibName: "CardNumAndPasswordCell", bundle: nil), forCellReuseIdentifier: "CardNumAndPasswordCell")
    }
    
    
    func setHeaderView() -> UIView {
        
        let backView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 50))
        
        let titleLabel = UILabel()
        titleLabel.text = "充值卡卡密"
        titleLabel.textColor = UI_MAIN_COLOR
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(backView.snp.centerY)
            make.left.equalTo(backView.snp.left).offset(20)
        }

        let copyBtn = UIButton.init(type: UIButtonType.custom)
        copyBtn.setTitle("批量复制", for: UIControlState.normal)
        copyBtn.backgroundColor = UI_MAIN_COLOR
        copyBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        copyBtn.layer.cornerRadius = 12
        copyBtn.clipsToBounds = true
        copyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        copyBtn.addTarget(self, action: #selector(copyBtnClick), for: UIControlEvents.touchUpInside)
        backView.addSubview(copyBtn)
        copyBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(backView.snp.centerY)
            make.right.equalTo(backView.snp.right).offset(-20)
            make.width.equalTo(76)
            make.height.equalTo(24)
        }

        let isHiddenBtn = UIButton.init(type: UIButtonType.custom)
        isHiddenBtn.setTitle("显示密码", for: UIControlState.normal)
        isHiddenBtn.backgroundColor = UI_MAIN_COLOR
        isHiddenBtn.layer.cornerRadius = 12
        isHiddenBtn.clipsToBounds = true
        isHiddenBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        isHiddenBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        isHiddenBtn.addTarget(self, action: #selector(isHiddenBtnClick(sender:)), for: UIControlEvents.touchUpInside)
        backView.addSubview(isHiddenBtn)
        isHiddenBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(backView.snp.centerY)
            make.right.equalTo(copyBtn.snp.left).offset(-8)
            make.width.equalTo(76)
            make.height.equalTo(24)
        }
        
        return backView
    }
    
    
}




