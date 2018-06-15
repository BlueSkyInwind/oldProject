//
//  YXTableViewExtention.swift
//  fxdProduct
//
//  Created by admin on 2018/6/14.
//  Copyright © 2018年 dd. All rights reserved.
//

import Foundation

extension UITableView {
    
    func yx_maker(_ frame:CGRect,_ style:UITableViewStyle,_ maker:(_ make:YXTableViewMaker) -> Void) -> UITableView {
        let make = YXTableViewMaker()
        make.yxTableview = UITableView.init(frame: frame, style: style)
        maker(make)
        return make.yxTableview!
    }
}

extension UITableView {
    
    func registerCell(_ cellClassArr:Array<AnyClass>,_ isNib:Bool)  {
        for cellClass in cellClassArr {
            if isNib {
                self.loadCellNib(cellClass)
            }else{
                self.loadCellClass(cellClass)
            }
        }
    }
    
    func loadCellNib(_ cellClass:AnyClass? = nil){
        let cellName = NSStringFromClass(cellClass!)
        let cellNib = UINib.init(nibName: cellName, bundle: nil)
        self.register(cellNib, forCellReuseIdentifier: cellName)
    }
    
    func loadCellClass(_ cellClass:AnyClass? = nil){
        let cellName = NSStringFromClass(cellClass!)
        self.register(cellClass.self, forCellReuseIdentifier: cellName)
    }
    
    func yx_dequeueReusableCell<T>(_ cellClass:T,_ indexPath: IndexPath,_ isXib:Bool) -> T {
        let cellName = NSStringFromClass(cellClass as! AnyClass)
        let cell = self.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! T
        if !isXib {
            
        }
        return cell
    }
}

