//
//  BankListViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/7.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

typealias selectedBankClosure = (_ bankModel: BankListModel, _ selectedTag: NSInteger)->Void

class BankListViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView : UITableView?
    var bankListArray : NSArray?
    var selectedTag : Int = -1
    var selectedBankClosure : selectedBankClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "银行卡列表"
        configureView()
        addBackItem()
        // Do any additional setup after loading the view.
    }

    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = LINE_COLOR
        tableView?.isScrollEnabled = false
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        if #available(iOS 11.0, *){
            tableView?.contentInsetAdjustmentBehavior = .never;
            tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }else if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = true;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (bankListArray?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if UI_IS_IPONE6P {
            return 60
        }
        return 46
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = LINE_COLOR
        
        return headerView
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:HGBankListCell! = tableView.dequeueReusableCell(withIdentifier:"CellId") as? HGBankListCell
        if cell == nil {
            cell = HGBankListCell.init(style: .default, reuseIdentifier: "CellId")
        }
        cell.selectionStyle = .none
        let model = bankListArray?[indexPath.row] as! BankListModel
        
        cell.bankNameLabel?.text = model.bankName
        let url = URL(string: model.imgUrl)
//        let url = URL(string: "http://192.168.5.26/fxd/M00/09/F7/wKgFGlowglSER8BxAAAAAOVyU4Y166.png")
        
        cell.bankImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholderImage_Icon"), options: .refreshCached, completed: { (uiimage, erroe, cachType, url) in
        
        })

        if selectedTag == indexPath.row {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = bankListArray![indexPath.row] as! BankListModel
        
        self.selectedTag = indexPath.row
        self.tableView?.reloadData()
        if selectedBankClosure != nil {
            
            selectedBankClosure!(model,indexPath.row)
        }
        self.navigationController?.popViewController(animated: true)

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
