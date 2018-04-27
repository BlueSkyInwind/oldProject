//
//  SortView.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc protocol SortViewDelegate: NSObjectProtocol {
    
    //排序
    func sortTabSelected(_ index : NSInteger)
}

class SortView: UIView,UITableViewDelegate,UITableViewDataSource {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @objc weak var delegate: SortViewDelegate?
    var titleArray = ["默认排序","最高额度由高到低","利率由低到高","借款周期由短到长"]
    @objc var index : NSInteger = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    convenience init(_ frame: CGRect) {
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SortView{
    fileprivate func setupUI(){
        
        let line = UIView()
        line.backgroundColor = UIColor.black
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(1)
        }
        
        let tabView = UITableView()
        tabView.backgroundColor = UIColor.white
        tabView.delegate = self
        tabView.dataSource = self
        tabView.separatorStyle = .none
        self.addSubview(tabView)
        tabView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(1)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(160)
        }
    }
    
//    override var  frame:(CGRect){
//
//        didSet{
//
//            let newFrame = CGRect(x:0,y:360,width:_k_w,height:_k_h - 360)
//            super.frame = newFrame
//
//        }
//    }
}


extension SortView{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:SortCell! = tableView.dequeueReusableCell(withIdentifier:"CellId") as? SortCell
        if cell == nil {
            cell = SortCell.init(style: .default, reuseIdentifier: "CellId")
        }
        cell.selectionStyle = .none
        
        cell.leftNameLabel?.text = titleArray[indexPath.row]
        cell.lineView?.isHidden = false
        
        if indexPath.row == titleArray.count - 1 {
            cell.lineView?.isHidden = true
        }
        
        cell.rightImageView?.isHidden = true
        cell.leftNameLabel?.textColor = QUTOA_COLOR
    
        if index == indexPath.row {
            
            cell.rightImageView?.isHidden = false
            cell.leftNameLabel?.textColor = UI_MAIN_COLOR
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if delegate != nil{
            delegate?.sortTabSelected(indexPath.row)
        }
    }
}
