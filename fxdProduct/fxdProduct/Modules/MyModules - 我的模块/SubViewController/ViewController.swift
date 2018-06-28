//
//  ViewController.swift
//  TableViewDele
//
//  Created by sxp on 2018/6/28.
//  Copyright © 2018年 sxp. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var table : UITableView?
    var dataArray = ["第一行","第二行","第三行","第四行","第五行","第六行","第七行","第八行","第九行","第十行","第十一行","第十二行","第十三行",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let rect = self.view.frame
        table = UITableView(frame: rect)
        self.table?.backgroundColor = UIColor.blue
        
        //设置数据源
        self.table?.dataSource = self
        //设置代理
        self.table?.delegate = self
        self.view.addSubview(table!)
        //注册UITableView，cellID为重复使用cell的Identifier
        self.table?.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath))
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        dataArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .none)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

