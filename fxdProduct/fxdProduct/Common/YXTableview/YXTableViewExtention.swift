//
//  YXTableViewExtention.swift
//  fxdProduct
//
//  Created by admin on 2018/6/14.
//  Copyright © 2018年 dd. All rights reserved.
//

import Foundation
private var YXTableViewKey: String = ""
extension UITableView {
    
    /// header
    var tableViewMaker: YXTableViewMaker {
        get {
            return (objc_getAssociatedObject(self, &YXTableViewKey) as? YXTableViewMaker)!
        }
        set(newValue) {
            objc_setAssociatedObject(self, &YXTableViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
   class func yx_maker(_ frame:CGRect,_ style:UITableViewStyle,_ maker:(_ make:YXTableViewMaker) -> Void) -> UITableView {
        let tableViewmake = YXTableViewMaker()
        tableViewmake.yxTableview = UITableView.init(frame: frame, style: style)
        maker(tableViewmake)
        return tableViewmake.yxTableview!
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
        let cellName = NSStringFromClass(cellClass!).components(separatedBy: ".").last
        let cellNib = UINib.init(nibName: cellName!, bundle: nil)
        self.register(cellNib, forCellReuseIdentifier: cellName!)
    }
    
    func loadCellClass(_ cellClass:AnyClass? = nil){
        let cellName = NSStringFromClass(cellClass!).components(separatedBy: ".").last
        self.register(cellClass.self, forCellReuseIdentifier: cellName!)
    }
    
    func yx_dequeueReusableCell<T>(_ cellClass:T,_ indexPath: IndexPath,_ isXib:Bool) -> T {
        let cellName = NSStringFromClass(cellClass as! AnyClass)
        var cell = self.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! T
        if !isXib {
//            cell = .init(style: UITableViewCellStyle.default, reuseIdentifier: cellName)
        }
        return cell
    }
}

