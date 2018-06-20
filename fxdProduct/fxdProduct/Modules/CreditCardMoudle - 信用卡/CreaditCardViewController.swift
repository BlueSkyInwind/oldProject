//
//  CreaditCardViewController.swift
//  fxdProduct
//
//  Created by admin on 2018/6/20.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit


class CreaditCardViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    var contentTableView:UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "全部信用卡";
        configureView()
    }
    
    func configureView()  {
        
        contentTableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        contentTableView?.delegate = self;
        contentTableView?.dataSource = self;
        contentTableView?.separatorStyle = .none
        contentTableView?.backgroundColor = "f2f2f2".uiColor()
        self.view.addSubview(contentTableView!)
        contentTableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        contentTableView?.registerCell([CreaditCardHeaderCell.self,CreaditCardBottomCell.self], false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 0
        switch indexPath.section{
        case 0:
             height = 195
            break
        case 1:
            height = 330
            break
        default:
            break
        }
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "CreaditCardHeaderCell", for: indexPath) as! CreaditCardHeaderCell
            cell.selectionStyle = .none
            cell.didSelect = {[weak self] (index) in
                let allVc  = AllCreaditCardViewController()
                self?.navigationController?.pushViewController(allVc, animated: true)
            }
            return cell
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "CreaditCardBottomCell", for: indexPath) as! CreaditCardBottomCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.init()
        header.backgroundColor = UIColor.clear
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
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



