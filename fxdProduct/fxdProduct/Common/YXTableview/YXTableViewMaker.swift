//
//  YXTableViewMaker.swift
//  fxdProduct
//
//  Created by admin on 2018/6/14.
//  Copyright © 2018年 dd. All rights reserved.
//

import Foundation


typealias yx_sectionNum = () -> Int
typealias yx_rowOfSection = (_ section:Int) -> Int
typealias yx_didSelectRow = (_ tableView: UITableView, _ indexPath:IndexPath) -> Void
typealias yx_cellForRow = (_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell
typealias yx_heightForRow = (_ tableView: UITableView, _ indexPath: IndexPath) -> CGFloat
typealias yx_heightForHeaderSection = (_ tableView: UITableView, _ section: Int) -> CGFloat
typealias yx_heightForFooterSection = (_ tableView: UITableView, _ section: Int) -> CGFloat
typealias yx_viewForFooterSection = (_ tableView: UITableView, _ section: Int) -> UIView
typealias yx_viewForHeaderSection = (_ tableView: UITableView, _ section: Int) -> UIView

public class  YXTableViewMaker:NSObject, UITableViewDataSource,UITableViewDelegate{

    var yxTableview:UITableView?
    
   private var rowOfSection:yx_rowOfSection?
   private var sectionNum:yx_sectionNum?
   private var selectRow:yx_didSelectRow?
   private var cellForRow:yx_cellForRow?
   private var rowHeight:yx_heightForRow?
   private var heightForHeaderSection:yx_heightForHeaderSection?
   private var heightForFooterSection:yx_heightForFooterSection?
   private var viewForHeaderSection:yx_viewForHeaderSection?
   private var viewForFooterSection:yx_viewForFooterSection?

    func bgColor(_ color:UIColor) -> YXTableViewMaker{
        self.yxTableview?.backgroundColor = color
        return self
    }
    func superView(_ view:UIView) -> YXTableViewMaker{
        view.addSubview(self.yxTableview!)
        return self
    }
    
    func registerCell(_ cellClassArr:Array<AnyClass>,_ isNib:Bool) -> YXTableViewMaker {
        for cellClass in cellClassArr {
            if isNib {
                self.yxTableview?.loadCellNib(cellClass)
            }else{
                self.yxTableview?.loadCellClass(cellClass)
            }
        }
        return self
    }
    
    func yx_delegate() ->  YXTableViewMaker {
        self.yxTableview?.delegate = self
        return self;
    }
    
    func yx_dataSource() ->  YXTableViewMaker {
        self.yxTableview?.dataSource = self
        return self;
    }
    
    func separatorStyle(_ style:UITableViewCellSeparatorStyle) -> YXTableViewMaker {
        self.yxTableview?.separatorStyle = style
        return self
    }
    
    func numberOfSections(_ number:@escaping yx_sectionNum) -> YXTableViewMaker {
        self.sectionNum = number
        return self
    }
    
    func numberOfRowsInSection(_ rowSection:@escaping yx_rowOfSection) -> YXTableViewMaker {
        self.rowOfSection = rowSection;
        return self
    }
    
    func cellForRowAt(_ cell:@escaping yx_cellForRow) -> YXTableViewMaker {
        self.cellForRow = cell
        return self
    }
    
    func didSelectRow(_ didSelectCellRow:@escaping yx_didSelectRow) -> YXTableViewMaker {
        self.selectRow = didSelectCellRow
        return self
    }
    
    func heightForRow(_ height:@escaping yx_heightForRow) -> YXTableViewMaker {
        self.rowHeight = height
        return self
    }
    
    func heightForHeaderSection(_ height:@escaping yx_heightForHeaderSection) -> YXTableViewMaker {
        self.heightForHeaderSection = height
        return self
    }
    
    func heightForFooterSection(_ height:@escaping yx_heightForFooterSection) -> YXTableViewMaker {
        self.heightForFooterSection = height
        return self
    }
    
    func viewForHeaderSection(_ view:@escaping yx_viewForHeaderSection) -> YXTableViewMaker {
        self.viewForHeaderSection = view
        return self
    }
    
    func viewForFooterSection(_ view:@escaping yx_viewForFooterSection) -> YXTableViewMaker {
        self.viewForFooterSection = view
        return self
    }
    
    
}

extension YXTableViewMaker {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionNum!()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowOfSection!(section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRow!(tableView,indexPath)
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return selectRow!(tableView,indexPath)
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight!(tableView,indexPath)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeaderSection?(tableView,section) == nil ? 0 : heightForHeaderSection!(tableView,section);
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return heightForFooterSection?(tableView,section) == nil ? 0 : heightForFooterSection!(tableView,section);
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return viewForFooterSection!(tableView,section)
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewForHeaderSection!(tableView,section)
    }
}





