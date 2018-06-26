//
//  TestTableViewController.swift
//  fxdProduct
//
//  Created by admin on 2018/6/19.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class TestTableViewController: BaseViewController{
    

    var tableview:UITableView?
    var tableViewMaker:YXTableViewMaker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "测试"
        self.addBackItem()
        // Do any additional setup after loading the view.
        
         tableViewMaker = UITableView.yx_maker(CGRect.init(x: 0, y: 0, width: _k_w, height: _k_h - 100), UITableViewStyle.plain) { (make) in
            make.bgColor(UIColor.white).yx_delegate().yx_dataSource().superView(self.view).numberOfSections({ () -> Int in
                return 1
            }).numberOfRowsInSection({ (section) -> Int in
                return 2
            }).heightForRow({ (tableView, indexPath) -> CGFloat in
                return 150
            }).cellForRowAt({ (tableView, indexPath) -> UITableViewCell in
               let cellStr = "cell"
                var cell = tableView.dequeueReusableCell(withIdentifier: cellStr)
                if cell == nil {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellStr)
                }
                cell?.selectionStyle = .none
                cell?.textLabel?.text = "1231545"
                return cell!
            }).didSelectRow({ (tableview, indexpath) in
                
                print("点我呀   再点我呀")

            })
        }
        
        print(tableViewMaker)
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
