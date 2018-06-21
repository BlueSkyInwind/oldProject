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
    var creaditCardModel:CreaditCardModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "全部信用卡";
        obtainDataSource()
    }
    
    override func loadFailureLoadRefreshButtonClick()  {
        obtainDataSource()
    }
    
    func obtainDataSource()  {
        obtainCreaditCardList{[weak self] (isSuccess) in
            if(isSuccess) {
                self?.removeFailView()
                self?.configureView()
            }else{
                self?.setFailView()
            }
        }
    }
    
    func configureView()  {
        contentTableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        contentTableView?.delegate = self;
        contentTableView?.dataSource = self;
        contentTableView?.separatorStyle = .none
        contentTableView?.backgroundColor = "f2f2f2".uiColor()
         contentTableView?.sectionFooterHeight = 0
        self.view.addSubview(contentTableView!)
        contentTableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        contentTableView?.registerCell([CreaditCardHeaderCell.self,CreaditCardBottomCell.self], false)
        let bottomView = CreaditCardBottomView.init(CGRect.init(x: 0, y: 0, width: _k_w, height: 60)) { [weak self]  in
            self?.pushMoreCardVC(-1)
        }
        contentTableView?.tableFooterView = bottomView
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
            height = Int(obtainHeaderHeight())
            break
        case 1:
            height = Int(obtainBottomCellHeight())
            break
        default:
            break
        }
        return CGFloat(height)
    }
    
    func obtainHeaderHeight() -> CGFloat  {
        let arr = creaditCardModel?.banks
        let lines = ((arr?.count)! + 1) / 4
        return CGFloat(lines) * 97.5
    }
    
    func obtainBottomCellHeight() -> CGFloat  {
        let arr = creaditCardModel?.cards
        if (arr?.count)! > 3 {
            return 325
        }
        let num = (arr?.count)! * 95 + 40
        return CGFloat(num)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreaditCardHeaderCell", for: indexPath) as! CreaditCardHeaderCell
            cell.selectionStyle = .none
            cell.dataArr = creaditCardModel?.banks as! Array<CreaditCardBanksListModel>
            cell.didSelect = { [weak self] (index,isMore) in
                if isMore{
                    self?.pushMoreCardVC(-1)
                }else{
                    self?.pushMoreCardVC(index)
                }
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreaditCardBottomCell", for: indexPath) as! CreaditCardBottomCell
            cell.selectionStyle = .none
            cell.dataArr = creaditCardModel?.cards as! Array<CreaditCardListModel>
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pushMoreCardVC(_ index:Int)  {
        let allCreaditCardVC = AllCreaditCardViewController()
        allCreaditCardVC.creaditCardModel = creaditCardModel
        allCreaditCardVC.bankIndex = index
        self.navigationController?.pushViewController(allCreaditCardVC, animated: true)
    }
    
    func pushWebVC(_ cardListModel:CreaditCardListModel)  {
        uploadRecordReaditCard(cardListModel._id) { (success) in
        }
        let webView = FXDWebViewController()
        webView.urlStr = cardListModel.linkAddress
        self.navigationController?.pushViewController(webView, animated: true)
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

extension CreaditCardViewController {
    
    func obtainCreaditCardList(_ complication:@escaping (_ isSuccess:Bool) -> Void)  {
        
        let creaditVM = CreaditCardViewModel.init()
        creaditVM.setBlockWithReturn({[weak self] (resultModel) in
            let baseModel =  resultModel as! BaseResultModel
            if baseModel.errCode == "0"{
                self?.creaditCardModel = try! CreaditCardModel.init(dictionary: baseModel.data as! [AnyHashable : Any]?)
                complication(true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseModel.friendErrMsg)
                complication(false)
            }
        }) {
            complication(false)
        }
        creaditVM.obtainCreaditCardListInfoRequest()
    }
    
    func uploadRecordReaditCard(_ thirdID:String,_ complication:@escaping (_ isSuccess:Bool) -> Void)  {
        
        let creaditVM = CreaditCardViewModel.init()
        creaditVM.setBlockWithReturn({[weak self] (resultModel) in
            let baseModel =  resultModel as! BaseResultModel
            if baseModel.errCode == "0"{
                self?.creaditCardModel = try! CreaditCardModel.init(dictionary: baseModel.data as! [AnyHashable : Any]?)
                complication(true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseModel.friendErrMsg)
                complication(false)
            }
        }) {
            complication(false)
        }
        creaditVM.submitReaditCardRecord(thirdID)
    }
}

