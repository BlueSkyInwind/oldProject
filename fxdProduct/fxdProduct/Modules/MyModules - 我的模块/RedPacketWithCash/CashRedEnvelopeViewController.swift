//
//  CashRedEnvelopeViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/17.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class CashRedEnvelopeViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource,RedPacketHeaderViewDelegate,RedPacketCellDelegate{

    var tableView : UITableView?
    @objc var isWithdraw = false
    override func viewDidLoad() {
        super.viewDidLoad()

        
        addBackItemRoot()
        setNavRightBar()
        // Do any additional setup after loading the view.
        configureView()
        
    }

    //MARK:设置右上角按钮
    func setNavRightBar(){
        
        let aBarbi = UIBarButtonItem.init(title: "收提明细", style: .plain, target: self, action: #selector(rightClick))
        self.navigationItem.rightBarButtonItem = aBarbi
        aBarbi.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:RedPacket_COLOR,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        aBarbi.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:RedPacket_COLOR,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], for: .selected)
       
    }
   
    
    //MARK:设置tableview
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
        if isWithdraw {
            self.title = "现金红包"
            headerView.moneyLabel?.text = "¥180.50"
            headerView.headerImage?.image = UIImage(named:"packet")
            headerView.titleLabel?.text = "我的现金"
        }else{
            
            self.title = "账户余额"
            headerView.moneyLabel?.text = "¥360.50"
            headerView.headerImage?.image = UIImage(named:"account")
            headerView.titleLabel?.text = "我的余额"
        }
        
        headerView.delegate = self
        let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(headerView.moneyLabel?.text)!)
        attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(1,attrstr.length-1))
        attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 35), range: NSMakeRange(1,attrstr.length-1))
        headerView.moneyLabel?.attributedText = attrstr
        tableView?.tableHeaderView = headerView
    }

    
    func setAlertView(){
        let alertController = UIAlertController(title: "设置密码提示", message: "为了您的资金安全，提现前请先设置交易密码", preferredStyle: .alert)
    
        alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (cancelAction) in
            
        }))
        
        alertController.addAction(UIAlertAction.init(title: "去设置", style: .default, handler: { (action) in
            
            let controller = CashWithdrawViewController()
            self.navigationController?.pushViewController(controller, animated:true)
        }))

        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func rightClick(){
        
        let controller = ReminderDetailsViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if UI_IS_IPONE5 {
            return _k_h-285-74
        }
        return _k_h-335-74
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = LINE_COLOR
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var redPacketCell:RedPacketCell! = tableView.dequeueReusableCell(withIdentifier:"RedPacketCell") as? RedPacketCell
        if redPacketCell == nil {
            redPacketCell = RedPacketCell.init(style: .default, reuseIdentifier: "RedPacketCell")
        }

        if isWithdraw {
            redPacketCell.bottomBtn?.setTitle("关于现金红包", for: .normal)
        }else{
            redPacketCell.bottomBtn?.setTitle("关于账户余额", for: .normal)
        }
        redPacketCell.delegate = self
        redPacketCell.selectionStyle = .none
        return redPacketCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    //MARK:点击提现
    func withdrawBtnClick(){
        
        setAlertView()
//        let controller = WithdrawViewController()
//        self.navigationController?.pushViewController(controller, animated:true)

    }
    
    //MARK:底部按钮点击
    func bottomBtnClick(){
        
        let webView = FXDWebViewController()
    
        if isWithdraw {
            webView.urlStr = "https://www.baidu.com"
//            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "关于现金红包")
        }else{
            webView.urlStr = "https://www.taobao.com"
//            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "关于账户余额")
        }
        self.navigationController?.pushViewController(webView, animated: true)
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
