//
//  CreaditCardBottomCell.swift
//  fxdProduct
//
//  Created by admin on 2018/6/20.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class CreaditCardBottomCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate {

    var tableView:UITableView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    func configureView()  {
        
        tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.bounces = false
        self.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        tableView?.registerCell([CreaditCardTableViewCell.self], true)
        tableView?.tableHeaderView = getTableviewHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CreaditCardBottomCell {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = 95
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CreaditCardTableViewCell", for: indexPath) as! CreaditCardTableViewCell
        cell.selectionStyle = .none
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    func getTableviewHeader() -> UIView  {
    
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 31))
        view.backgroundColor = UIColor.white
        
        let iconView = UIView()
        iconView.backgroundColor = UI_MAIN_COLOR
        view.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(21)
            make.top.equalTo(view.snp.top).offset(7)
            make.bottom.equalTo(view.snp.bottom).offset(-7)
            make.width.equalTo(3)
        }
        
        let explainLabel = UILabel()
        explainLabel.font = UIFont.systemFont(ofSize: 16)
        explainLabel.textColor = "333333".uiColor()
        explainLabel.text = "热门信用卡"
        view.addSubview(explainLabel)
        explainLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        let sepView = UIView()
        sepView.backgroundColor = "f2f2f2".uiColor()
        view.addSubview(sepView)
        sepView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        
        return view
    }
}


