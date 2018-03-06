//
//  BankCardViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/3/6.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class BankCardViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView : UITableView?
    var titleArray : NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "更换绑卡-解卡"
        configureView()
        addBackItem()
        titleArray = ["预留手机号:","验证码:"]
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
            tableView?.contentInset = UIEdgeInsetsMake(CGFloat(obtainBarHeight_New(vc: self)), 0, 0, 0)
        }else if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = true;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        
        let withdrawBtn = UIButton()
        withdrawBtn.setTitle("下一步", for: .normal)
        withdrawBtn.setTitleColor(UIColor.white, for: .normal)
        withdrawBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        withdrawBtn.setBackgroundImage(UIImage(named:"applayBtnImage"), for: .normal)
        //        withdrawBtn.addTarget(self, action: #selector(withdrawBtnClick), for: .touchUpInside)
        self.view.addSubview(withdrawBtn)
        withdrawBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(18)
            make.right.equalTo(self.view).offset(-18)
            make.top.equalTo(self.view).offset(520)
            make.height.equalTo(50)
        }
        
        if UI_IS_IPONE5 {
            withdrawBtn.snp.updateConstraints({ (make) in
                make.top.equalTo(self.view).offset(480)
            })
        }
        if UI_IS_IPONE6P {
            withdrawBtn.snp.updateConstraints({ (make) in
                make.top.equalTo(self.view).offset(570)
            })
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 110
        }
        
        return 47
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = LINE_COLOR
        
        return headerView
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            var cell:BankCardCell! = tableView.dequeueReusableCell(withIdentifier:"BankCardCellId") as? BankCardCell
            if cell == nil {
                cell = BankCardCell.init(style: .default, reuseIdentifier: "BankCardCellId")
            }
            cell.selectionStyle = .none
            cell.cardImageView?.image = UIImage.init(named: "<#T##String#>")
            cell.cardNameLabel?.text = "工商银行"
            cell.cardSpeciesLabel?.text = "储蓄卡"
            cell.cardNumLabel?.text = "6*************8490"
            return cell
        }else{
            
            var cell:OpenAccountCell! = tableView.dequeueReusableCell(withIdentifier:"CellId") as? OpenAccountCell
            if cell == nil {
                cell = OpenAccountCell.init(style: .default, reuseIdentifier: "CellId")
            }
            cell.selectionStyle = .none
            
            cell.titleLabel?.text = titleArray?[indexPath.row] as? String
//            cell.contentTextField?.text = cntentArray?[indexPath.row] as? String
            cell.contentTextField?.tag = indexPath.row + 1
            cell.contentTextField?.isEnabled = true
            cell.contentTextField?.addTarget(self, action: #selector(contentTextFieldEdit(textField:)), for: .editingChanged)

            if indexPath.row == 1 {
                cell.verificationCodeBtn?.isHidden = false
            }
            if indexPath.row == (titleArray?.count)! - 1 {
                cell.lineView?.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @objc fileprivate func contentTextFieldEdit(textField:UITextField){
        
        let tag = textField.tag
        
        switch tag {
        case 3:
            print("开户银行")
        case 4:
            print("银行卡号")
        case 5:
            if (textField.text?.count)! > 11
            {
                let str1 = textField.text?.prefix(11)
                textField.text = String(str1!)
            }
            
        case 6:
            if (textField.text?.count)! > 6
            {
                
                let str1 = textField.text?.prefix(6)
                textField.text = String(str1!)
                
            }
            
        default:
            break
        }
        
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
