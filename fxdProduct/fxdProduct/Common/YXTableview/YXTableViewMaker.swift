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


public class  YXTableViewMaker:NSObject, UITableViewDataSource,UITableViewDelegate{

    var yxTableview:UITableView?
    var rowOfSection:yx_rowOfSection?
    var sectionNum:yx_sectionNum?
    var selectRow:yx_didSelectRow?
    var cellForRow:yx_cellForRow?
    var rowHeight:yx_heightForRow?


    func bgColor(_ color:UIColor) -> YXTableViewMaker{
        self.yxTableview?.backgroundColor = color
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
    
    func yx_delegate(_ delegate:UITableViewDelegate) ->  YXTableViewMaker {
        self.yxTableview?.delegate = delegate
        return self;
    }
    
    func yx_dataSource(_ dataSource:UITableViewDataSource) ->  YXTableViewMaker {
        self.yxTableview?.dataSource = dataSource
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

//    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//
//    }
//
//    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//
//    }
//
//    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//
//    }
//
//    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//    }
    
    
}


