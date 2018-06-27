//
//  CollectionViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/4/10.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class CollectionViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView : UITableView?
    var dataArray : NSMutableArray?
//    @objc var type : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "收藏"
    
        dataArray = NSMutableArray.init(capacity: 100)
        addBackItem()
        configureView()
        getMyCollectionList()
        // Do any additional setup after loading the view.
    }
    
    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = LINE_COLOR
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
//        //下拉刷新相关设置,使用闭包Block
//        tableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
//            
//            self.headerRefresh()
//            
//        })
//        
//        
//        //        //上拉加载相关设置,使用闭包Block
//        //        tableView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
//        //
//        //            self.footerLoad()
//        //
//        //        })
//        //        tableView?.mj_footer.isAutomaticallyHidden = true
//        
//        // 底部加载
//        let footer = MJRefreshAutoNormalFooter()
//        footer.setRefreshingTarget(self, refreshingAction: #selector(footerLoad))
//        //是否自动加载（默认为true，即表格滑到底部就自动加载）
//        footer.isAutomaticallyRefresh = false
//        self.tableView!.mj_footer = footer
    }

    
    func getMyCollectionList(){
        
        let collectionVM = CollectionViewModel()
        collectionVM.setBlockWithReturn({ (returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
               
                self.dataArray?.removeAllObjects()
                let collectionListModel = try! CollectionListModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                
                for index in 0 ..< collectionListModel.rows.count{
                    
                    let model = collectionListModel.rows[index] as! CollectionListRowsModel
                    self.dataArray?.add(model)
                }
//                if collectionListModel.rows != nil{
//
//
//                }
    
                self.tableView?.reloadData()
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        
        collectionVM.getMyCollectionListLimit("15", offset: "0", order: "ASC", sort: "0")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return (dataArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = LINE_COLOR
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = self.dataArray![indexPath.section] as! CollectionListRowsModel
        if model.moduletype == "1" {
            return 90
        }
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var superLoanCell:SuperLoanCell! = tableView.dequeueReusableCell(withIdentifier:"SuperLoanCell") as? SuperLoanCell
        if superLoanCell == nil {
            superLoanCell = SuperLoanCell.init(style: .default, reuseIdentifier: "SuperLoanCell")
        }
        superLoanCell.selectionStyle = .none
        superLoanCell.backgroundColor = UIColor.white
        superLoanCell.isSelected = false
//        superLoanCell.delegate = self;
        
        let model = self.dataArray![indexPath.section] as! CollectionListRowsModel
        superLoanCell.type = model.moduletype
        let url = URL(string: model.plantLogo)
        superLoanCell?.leftImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholderImage_Icon"), options: .retryFailed, completed: { (uiImage, error, cachType, url) in
            
        })
        
        superLoanCell?.titleLabel?.text = model.plantName
        let maximumAmount = model.maximumAmount != nil ? model.maximumAmount : ""
        let maximumAmountUnit = model.maximumAmountUnit != nil ? model.maximumAmountUnit : ""
        superLoanCell?.qutaLabel?.text = "额度:最高" + maximumAmount! + maximumAmountUnit!
        let term = model.unitStr != nil ? model.unitStr : ""
        superLoanCell?.termLabel?.text = "期限:" + term!
        if term != "" {
            
            let attrstr1 : NSMutableAttributedString = NSMutableAttributedString(string:(superLoanCell?.termLabel?.text)!)
            attrstr1.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr1.length-4))
            superLoanCell?.termLabel?.attributedText = attrstr1
        }
        let referenceRate = model.referenceRate != nil ? model.referenceRate : ""
        if model.referenceMode == nil {
            
            superLoanCell?.feeLabel?.text = "费用:%" + referenceRate!
        }else{
            superLoanCell?.feeLabel?.text = "费用:%" + referenceRate! + "/" + (rateUnit(referenceMode: model.referenceMode! as NSString) as String)
        }
        
        
        if referenceRate != nil && model.referenceMode != nil {
            
            let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(superLoanCell?.feeLabel?.text)!)
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr.length-4))
            superLoanCell?.feeLabel?.attributedText = attrstr
        }
        
        superLoanCell?.descBtn?.setTitle(model.platformIntroduction, for: .normal)
        superLoanCell?.descBtn?.setTitleColor(UIColor.purple, for: .normal)
        superLoanCell?.descBtn?.layer.borderColor = UIColor.purple.cgColor
        
        if indexPath.section % 2 == 0 {
            superLoanCell?.descBtn?.setTitleColor(UIColor.blue, for: .normal)
            superLoanCell?.descBtn?.layer.borderColor = UIColor.blue.cgColor
        }
        
        superLoanCell?.lineView?.isHidden = true
        let str : NSString = model.platformIntroduction! as NSString
        let dic = NSDictionary(object: UIFont.yx_systemFont(ofSize: 12) as Any, forKey: NSAttributedStringKey.font as NSCopying)
        let width = str.boundingRect(with: CGSize(width:_k_w,height:20), options: .usesLineFragmentOrigin, attributes:(dic as! [NSAttributedStringKey : Any]), context: nil).size.width + 20
        
        superLoanCell.descBtn?.snp.remakeConstraints({ (make) in
            make.width.equalTo(width)
            make.left.equalTo(superLoanCell.snp.left).offset(100)
            make.bottom.equalTo(superLoanCell.snp.bottom).offset(-10)
            make.height.equalTo(20)
        })

        superLoanCell.collectionBtn?.setImage(UIImage.init(named: "arrow_icon"), for: .normal)
        superLoanCell.collectionBtn?.snp.remakeConstraints { (make) in
            make.centerY.equalTo(superLoanCell.snp.centerY)
            make.right.equalTo(superLoanCell.snp.right).offset(-20)
        }

        return superLoanCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = dataArray![indexPath.section] as! CollectionListRowsModel
        getCompLink(thirdPlatformId: model.id_)
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }
    
    
//    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
//        let model = self.dataArray![indexPath.section] as! CollectionListRowsModel
//
//        let collectionVM = CollectionViewModel()
//    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let model = self.dataArray![indexPath.section] as! CollectionListRowsModel
        
        let collectionVM = CollectionViewModel()
        collectionVM.setBlockWithReturn({ (returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                
                tableView.beginUpdates()
                self.dataArray?.removeObject(at: indexPath.section)
                let indexSet = NSIndexSet(index: indexPath.section)
                tableView.deleteSections(indexSet as IndexSet, with: .none)
                tableView.endUpdates()

            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {
            
        }
        collectionVM.addMyCollectionInfocollectionType(model.moduletype, platformId: model.id_)
//        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
        
    }
    
    func rateUnit(referenceMode : NSString) -> (NSString){
        switch referenceMode.integerValue {
        case 1:
            return "日"
        case 2:
            return "月"
        case 3:
            return "年"
        default:
            break
        }
        
        return ""
    }
    
    func getCompLink(thirdPlatformId : String){
        let viewModel = CompQueryViewModel()
        viewModel.setBlockWithReturn({ [weak self](returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                
                let dic = baseResult.data as! NSDictionary
                if dic["url"] != nil {
                    let webView = FXDWebViewController()
                    webView.urlStr = dic["url"]  as! String
                    self?.navigationController?.pushViewController(webView, animated: true)
                }
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
            
        }) {
            
        }
        viewModel.getCompLinkThirdPlatformId(thirdPlatformId, location: "")
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
