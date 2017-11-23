//
//  WithdrawDetailsViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class WithdrawDetailsViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView : UITableView?
    var leftTitleArray : NSArray?
    var rightTitleArray : NSArray?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "提现详情"
        addBackItem()
        configureView()
        leftTitleArray = ["提现金额","银行卡","预计到账时间"]
        rightTitleArray = ["¥180.50","中国银行(9267)","2017-11-15 14：39"]
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
        
        let headerView = WithdrawHeaderView()
        tableView?.tableHeaderView = headerView
        
        let withdrawBtn = UIButton()
        withdrawBtn.setTitle("完成", for: .normal)
        withdrawBtn.setTitleColor(UIColor.white, for: .normal)
        withdrawBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        withdrawBtn.backgroundColor = UI_MAIN_COLOR
        withdrawBtn.layer.cornerRadius = 5.0
        withdrawBtn.addTarget(self, action: #selector(withdrawBtnClick), for: .touchUpInside)
        self.view.addSubview(withdrawBtn)
        withdrawBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(18)
            make.right.equalTo(self.view).offset(-18)
            make.top.equalTo(self.view).offset(520)
            make.height.equalTo(50)
        }
        
    }

    @objc func withdrawBtnClick(){
        
        MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "提现按钮点击")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:CurrentInformationCell! = tableView.dequeueReusableCell(withIdentifier:"CellId") as? CurrentInformationCell
        if cell == nil {
            cell = CurrentInformationCell.init(style: .default, reuseIdentifier: "CellId")
        }
        cell.selectionStyle = .none
        cell.cellType = CurrentInfoCellType(cellType: .Default)
        cell.leftLabel?.text = leftTitleArray?[indexPath.row] as? String
        cell.rightLabel?.text = rightTitleArray?[indexPath.row] as? String
        cell.rightLabel?.textColor = UI_MAIN_COLOR
        if indexPath.row == 0 {
            let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(cell.rightLabel?.text)!)
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(1,attrstr.length-1))
            attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 35), range: NSMakeRange(1,attrstr.length-1))
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: RedPacketMoney_COLOR, range: NSMakeRange(0,1))
            attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 25), range: NSMakeRange(0,1))
            cell.rightLabel?.attributedText = attrstr
        }
        return cell
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
