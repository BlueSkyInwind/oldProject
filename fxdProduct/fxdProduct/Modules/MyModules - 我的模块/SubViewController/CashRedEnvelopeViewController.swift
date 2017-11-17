//
//  CashRedEnvelopeViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/17.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class CashRedEnvelopeViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "现金红包"
        addBackItemRoot()
        setNavRightBar()
        // Do any additional setup after loading the view.
        configureView()
        
    }

    func setNavRightBar(){
        
        let aBarbi = UIBarButtonItem.init(title: "收提明细", style: .plain, target: self, action: #selector(rightClick))
        aBarbi.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:RedPacket_COLOR,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        self.navigationItem.rightBarButtonItem = aBarbi
       
        
    }
   
    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        let headerView = RedPacketHeaderView()
        headerView.moneyLabel?.text = "¥180.50"
        tableView?.tableHeaderView = headerView
    }

    @objc func rightClick(){
        MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "收提明细")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 15
        }
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var messageCell:MessageCell! = tableView.dequeueReusableCell(withIdentifier:"MessageCell") as? MessageCell
        if messageCell == nil {
            messageCell = MessageCell.init(style: .default, reuseIdentifier: "MessageCell")
        }
        if indexPath.row == 0 {
            
            messageCell.cellType = MessageCellType(cellType: .Header)
            return messageCell
        }
        
        messageCell.cellType = MessageCellType(cellType: .Default)
        messageCell.selectionStyle = .none
        
        return messageCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
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
