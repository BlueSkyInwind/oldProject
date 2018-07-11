//
//  AllCreaditCardViewController.swift
//  fxdProduct
//
//  Created by admin on 2018/6/20.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class AllCreaditCardViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var contentTableView:UITableView?
    var headerView:AllCardHeaderView?
    var creaditCardModel:CreaditCardModel?
    var dataArr:Array<CreaditCardListModel> = []
    
    var bankIndex:Int = -1;
    var levelIndex:Int = -1;
    var sort:Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "全部信用卡";
        self.view.backgroundColor = UIColor.white
        self.addBackItem()
        if creaditCardModel?.cards  != nil {
            dataArr = creaditCardModel?.cards as! Array<CreaditCardListModel>
        }
        configureView()
        obtainCreaditCardConditionsList({[weak self] (isSuccess) in
            if isSuccess {
                self?.contentTableView?.reloadData()
            }
        })
    }

    func configureView()  {
        
        contentTableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        contentTableView?.delegate = self;
        contentTableView?.dataSource = self;
        contentTableView?.separatorStyle = .none
        contentTableView?.backgroundColor = "f2f2f2".uiColor()
        self.view.addSubview(contentTableView!)
        contentTableView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view.snp.top).offset(55)
            make.left.right.bottom.equalTo(0)
        })
        contentTableView?.registerCell([CreaditCardTableViewCell.self],true)
        contentTableView?.tableFooterView = getBottomView()
        headerView = AllCardHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: Int(_k_w), height: 55),  self.view, {[weak self] (bank, level, sorts) in
            self?.bankIndex = bank - 1
            self?.levelIndex = level - 1
            self?.sort = sorts
            self?.obtainCreaditCardConditionsList({ (isSuccess) in
                if isSuccess {
                    self?.contentTableView?.reloadData()
                }
            })
        })
        
        if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        headerView?.currentBank = bankIndex + 1
        headerView?.bankDataArr = creaditCardModel?.banks as! Array<CreaditCardBanksListModel>
        headerView?.levelDataArr = creaditCardModel?.levelDic as! Array<CreaditCardLevelModel>
        headerView?.addConditonView()
        self.view.addSubview(headerView!)
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataArr.count)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = 95
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreaditCardTableViewCell", for: indexPath) as! CreaditCardTableViewCell
        cell.selectionStyle = .none
        let model = dataArr[indexPath.row]
        cell.setDataSource(model,false)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = dataArr[indexPath.row]
        pushWebVC(model)
    }
    
    func pushWebVC(_ cardListModel:CreaditCardListModel)  {
        uploadRecordReaditCard(cardListModel._id) { (success) in
        }
        let webView = FXDWebViewController()
        webView.urlStr = cardListModel.linkAddress
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getBottomView()  -> UIView{
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: 60))
        let label = UILabel()
        label.text = "没有更多数据"
        label.textColor = "808080".uiColor()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalTo(view.snp.center)
        }
        return view
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
extension AllCreaditCardViewController {
    
    func obtainCreaditCardConditionsList(_ complication:@escaping (_ isSuccess:Bool) -> Void)  {
        let creaditVM = CreaditCardViewModel.init()
        creaditVM.setBlockWithReturn({[weak self] (resultModel) in
            let baseModel =  resultModel as! BaseResultModel
            if baseModel.errCode == "0"{
                self?.dataArr.removeAll()
                let arr = baseModel.data as! Array<[AnyHashable : Any]>
                for dic in arr {
                    let creaditCardListModel = try! CreaditCardListModel.init(dictionary: dic as [AnyHashable : Any]?)
                    self?.dataArr.append(creaditCardListModel)
                }
                complication(true)
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseModel.friendErrMsg)
                complication(false)
            }
        }) {
            complication(false)
        }
        
        let arrBack = creaditCardModel?.banks as! Array<CreaditCardBanksListModel>
        let bankId =  bankIndex >= 0 ? arrBack[bankIndex]._id : "\(bankIndex)"
        
        let arrLevel = creaditCardModel?.levelDic as! Array<CreaditCardLevelModel>
        let levelValue =  levelIndex >= 0 ? arrLevel[levelIndex].value : "\(levelIndex)"
  
        creaditVM.obtainCreaditCardListConditionRequest("\(bankId ?? "-1")", cardType: "\(levelValue ?? "-1")", sort: sort)
    }
    
    func uploadRecordReaditCard(_ thirdID:String,_ complication:@escaping (_ isSuccess:Bool) -> Void)  {
        
        let creaditVM = CreaditCardViewModel.init()
        creaditVM.setBlockWithReturn({[weak self] (resultModel) in
            let baseModel =  resultModel as! BaseResultModel
            if baseModel.errCode == "0"{
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

