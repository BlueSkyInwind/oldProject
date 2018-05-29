//
//  LoanListViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/4/27.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class LoanListViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource,SuperLoanCellDelegate,SuperLoanHeaderCellDelegate,SortViewDelegate,FilterViewDelegate{
    
    @objc var titleStr : String?
    var tableView : UITableView?
    var dataArray : NSMutableArray?
    var superLoanCell : SuperLoanCell?
    //头部cell
    var superLoanHeaderCell : SuperLoanHeaderCell?
//    var pages : Int?
    @objc var moduleType : String?
    //是否第一次进来 借款金额周期没有值，为收藏做处理
    var isFirst : Bool?
    //选中排序view的第几个
    var _index : NSInteger?
    //排序view
    var sortView : SortView?
    //筛选view
    var filterView : FilterView?
    //最大借款金额
    var maxAmount : String?
    //最大周期
    var maxDays : String?
    //最小借款金额
    var minAmount : String?
    //最小周期
    var minDays : String?
    //排序方式
    var order : String?
    //查询位置
    @objc var location : String?
//    //是否点击收藏
//    var isCollection : Bool?
//
//    var row : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataArray = NSMutableArray.init(capacity: 100)
        _index = 0
//        pages = 0
        isFirst = true
        order = "ASC"
        self.title = titleStr
//        isCollection = false
        addBackItem()
        configureView()
        // Do any additional setup after loading the view.
    }

    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.isScrollEnabled = true
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = PayPasswordBackColor_COLOR
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
        
////        //下拉刷新相关设置,使用闭包Block
//        tableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
//
//            self.headerRefresh()
//
//        })
//
//        // 底部加载
//        let footer = MJRefreshAutoNormalFooter()
//        footer.setRefreshingTarget(self, refreshingAction: #selector(footerLoad))
//        //是否自动加载（默认为true，即表格滑到底部就自动加载）
//        footer.isAutomaticallyRefresh = false
//        self.tableView!.mj_footer = footer
    }
    
//    //MARK: 刷新
//    /// 下拉刷新
//    @objc func headerRefresh(){
//
//        pages = 0
//        let sortIndex = String(format:"%ld",_index!)
//        let xAmount = maxAmount == nil ? "" : maxAmount
//        let iAmount = minAmount == nil ? "" : minAmount
//        let xDays = maxDays == nil ? "" : maxDays
//        let iDays = minDays == nil ? "" : minDays
//
//        getData(maxAmount: xAmount!, maxDays: xDays!, minAmount: iAmount!, minDays: iDays!, offset: "", order: order!, sort: sortIndex, moduleType: moduleType!)
//
//    }
//
//    /// 上拉加载
//    @objc func footerLoad(){
//        pages = pages! + 1
//        let pageIndex = String(format:"%d",pages!)
//        let sortIndex = String(format:"%ld",_index!)
//        let totalMessage = pages! * 15
//
//        if (dataArray?.count)! < totalMessage {
//            self.tableView?.mj_footer.endRefreshingWithNoMoreData()
//        }else{
//
//            let xAmount = maxAmount == nil ? "" : maxAmount
//            let iAmount = minAmount == nil ? "" : minAmount
//            let xDays = maxDays == nil ? "" : maxDays
//            let iDays = minDays == nil ? "" : minDays
//
//            getData(maxAmount: xAmount!, maxDays: xDays!, minAmount: iAmount!, minDays: iDays!, offset: pageIndex, order: order!, sort: sortIndex, moduleType: moduleType!)
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let pageIndex = String(format:"%d",pages!)
        getData(maxAmount: "", maxDays: "", minAmount: "", minDays: "", offset: "0", order: order!, sort: "0", moduleType: moduleType!)
    }

    
    fileprivate func getData(maxAmount:String,maxDays:String,minAmount:String,minDays:String,offset:String,order:String,sort:String ,moduleType:String){
        
        let viewModel = CompQueryViewModel()
        viewModel.setBlockWithReturn({ [weak self] (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                
                self?.dataArray?.removeAllObjects()
//                if self?.pages == 0{
//                    self?.dataArray?.removeAllObjects()
//                }
                
                let compQueryModel = try! CompQueryModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                for index in 0 ..< compQueryModel.rows.count{
                    
                    let model = compQueryModel.rows[index] as! RowsModel
                    self?.dataArray?.add(model)
                }
                self?.tableView?.isScrollEnabled = true
//                self?.tableView?.mj_header.endRefreshing()
//                self?.tableView?.mj_footer.endRefreshing()
//                if (self?.isCollection!)!{
//
//                    let indexPath: IndexPath = IndexPath.init(row: (self?.row)!, section: 0)
//                    self?.tableView?.reloadRows(at: [indexPath], with: .fade)
//                    self?.isCollection = false
//                }else{
                
                self?.tableView?.reloadData()
//                }
                
//                if ((self?.dataArray?.count)! < 15) && self?.pages == 0 {
//                    self?.tableView?.mj_footer.endRefreshingWithNoMoreData()
//                }
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
//                self?.tableView?.mj_header.endRefreshing()
//                self?.tableView?.mj_footer.endRefreshing()
            }
            
        }) {
//            self.tableView?.mj_header.endRefreshing()
//            self.tableView?.mj_footer.endRefreshing()
        }
        viewModel.compQueryLimit("100", maxAmount: maxAmount, maxDays: maxDays, minAmount: minAmount, minDays: minDays, offset: offset, order: order, sort: sort, moduleType: moduleType, location: location)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if moduleType == "1" {
            
            return (dataArray?.count)! + 1
        }
        return (dataArray?.count)!
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && moduleType == "1"{
            return 48
        }
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 && moduleType == "1"{
            superLoanHeaderCell = tableView.dequeueReusableCell(withIdentifier:"SuperLoanHeaderCell") as? SuperLoanHeaderCell
            if superLoanHeaderCell == nil {
                superLoanHeaderCell = SuperLoanHeaderCell.init(style: .default, reuseIdentifier: "SuperLoanHeaderCell")
            }
            
            superLoanHeaderCell?.isSelected = false
            superLoanHeaderCell?.selectionStyle = .none
            superLoanHeaderCell?.backgroundColor = LINE_COLOR
            superLoanHeaderCell?.type = "2"
            superLoanHeaderCell?.delegate = self
            return superLoanHeaderCell!
        }
        
        superLoanCell = tableView.dequeueReusableCell(withIdentifier:"SuperLoanCell") as? SuperLoanCell
        if superLoanCell == nil {
            superLoanCell = SuperLoanCell.init(style: .default, reuseIdentifier: "SuperLoanCell")
        }
        
        superLoanCell?.delegate = self
        superLoanCell?.selectionStyle = .none
        superLoanCell?.type = moduleType
        
        var model : RowsModel
        if moduleType == "1" {
            superLoanCell?.collectionBtn?.tag = indexPath.row
            model = dataArray![indexPath.row - 1] as! RowsModel
        }else{
            superLoanCell?.collectionBtn?.tag = indexPath.row + 1
            model = dataArray![indexPath.row] as! RowsModel
        }
//        let model = dataArray![indexPath.row - 1] as! RowsModel
        
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
            
            superLoanCell?.feeLabel?.text = "费用:" + referenceRate! + "%"
        }else{
            superLoanCell?.feeLabel?.text = "费用:" + referenceRate! + "%/" + (rateUnit(referenceMode: model.referenceMode! as NSString) as String)
        }
        
        
        if referenceRate != nil && model.referenceMode != nil {
            
            let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(superLoanCell?.feeLabel?.text)!)
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr.length-4))
            superLoanCell?.feeLabel?.attributedText = attrstr
        }
        
        superLoanCell?.descBtn?.setTitle(model.platformIntroduction, for: .normal)
        superLoanCell?.descBtn?.setTitleColor(UIColor.purple, for: .normal)
        superLoanCell?.descBtn?.layer.borderColor = UIColor.purple.cgColor
        
        if indexPath.row % 2 == 0 {
            superLoanCell?.descBtn?.setTitleColor(UIColor.blue, for: .normal)
            superLoanCell?.descBtn?.layer.borderColor = UIColor.blue.cgColor
        }
        
        let str : NSString = model.platformIntroduction! as NSString
        let dic = NSDictionary(object: UIFont.yx_systemFont(ofSize: 12) as Any, forKey: NSAttributedStringKey.font as NSCopying)
        let width = str.boundingRect(with: CGSize(width:_k_w,height:20), options: .usesLineFragmentOrigin, attributes:(dic as! [NSAttributedStringKey : Any]), context: nil).size.width + 20
        
        superLoanCell?.descBtn?.snp.updateConstraints({ (make) in
            make.width.equalTo(width)
        })
        
        superLoanCell?.collectionBtn?.setImage(UIImage.init(named: "collection_icon"), for: .normal)
        if model.isCollect == "0" {
            superLoanCell?.collectionBtn?.setImage(UIImage.init(named: "collection_selected_icon"), for: .normal)
        }
        return superLoanCell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 && moduleType == "1"{
            return
        }
        if moduleType == "1"{
            
            let model = dataArray![indexPath.row - 1] as! RowsModel
            getCompLink(thirdPlatformId: model.id_)
        }else{
            
            let model = dataArray![indexPath.row] as! RowsModel
            getCompLink(thirdPlatformId: model.id_)
        }
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
        viewModel.getCompLinkThirdPlatformId(thirdPlatformId, location: "1")
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK : delegate
extension LoanListViewController{
    
    //MARK : 弹出排序view
    func sortBtnClick(_ sender: UIButton) {
        
        if (filterView != nil) {
            filterView?.removeFromSuperview()
        }
        
        
        if ((superLoanHeaderCell?.filterBtn?.isSelected)! || (superLoanHeaderCell?.filterImageBtn?.isSelected)!) {
            
            superLoanHeaderCell?.filterBtn?.isSelected = false
            superLoanHeaderCell?.filterImageBtn?.isSelected = false
            superLoanHeaderCell?.filterBtn?.setTitleColor(TITLE_COLOR, for: .normal)
            superLoanHeaderCell?.filterImageBtn?.setImage(UIImage.init(named: "filter_icon"), for: .normal)
            
        }
        
        superLoanHeaderCell?.sortBtn?.isSelected = !(superLoanHeaderCell?.sortBtn?.isSelected)!
        superLoanHeaderCell?.sortImageBtn?.isSelected = !(superLoanHeaderCell?.sortImageBtn?.isSelected)!
        
        if ((superLoanHeaderCell?.sortBtn?.isSelected)! || (superLoanHeaderCell?.sortImageBtn?.isSelected)!) {
            
            superLoanHeaderCell?.sortBtn?.setTitleColor(UI_MAIN_COLOR, for: .normal)
            superLoanHeaderCell?.sortImageBtn?.setImage(UIImage.init(named: "sort_selected_icon"), for: .normal)
            
            UIView.animate(withDuration: 1) {
                self.sortView = SortView.init(frame: CGRect(x:0,y:108,width:_k_w,height:_k_h-108))
                self.sortView?.delegate = self
                self.sortView?.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.7)
                self.sortView?.index = self._index!
                self.view.addSubview(self.sortView!)
                self.tableView?.isScrollEnabled = false
            }
            
        }else{
            
            superLoanHeaderCell?.sortBtn?.setTitleColor(TITLE_COLOR, for: .normal)
            superLoanHeaderCell?.sortImageBtn?.setImage(UIImage.init(named: "sort_icon"), for: .normal)
            UIView.animate(withDuration: 1) {
                self.sortView?.removeFromSuperview()
                self.tableView?.isScrollEnabled = true
            }
        }
    }
    
    //MARK : 弹出筛选view
    func filterBtnClick(_ sender: UIButton) {
        
        if (sortView != nil) {
            sortView?.removeFromSuperview()
        }
        
        
        if ((superLoanHeaderCell?.sortBtn?.isSelected)! || (superLoanHeaderCell?.sortImageBtn?.isSelected)!) {
            
            superLoanHeaderCell?.sortBtn?.isSelected = false
            superLoanHeaderCell?.sortImageBtn?.isSelected = false
            superLoanHeaderCell?.sortBtn?.setTitleColor(TITLE_COLOR, for: .normal)
            superLoanHeaderCell?.sortImageBtn?.setImage(UIImage.init(named: "sort_icon"), for: .normal)
            
        }
        
        superLoanHeaderCell?.filterBtn?.isSelected = !(superLoanHeaderCell?.filterBtn?.isSelected)!
        superLoanHeaderCell?.filterImageBtn?.isSelected = !(superLoanHeaderCell?.filterImageBtn?.isSelected)!
        
        if ((superLoanHeaderCell?.filterBtn?.isSelected)! || (superLoanHeaderCell?.filterImageBtn?.isSelected)!) {
            
            superLoanHeaderCell?.filterBtn?.setTitleColor(UI_MAIN_COLOR, for: .normal)
            superLoanHeaderCell?.filterImageBtn?.setImage(UIImage.init(named: "filter_selected_icon"), for: .normal)
            
            UIView.animate(withDuration: 1) {
                self.filterView = FilterView.init(frame: CGRect(x:0,y:108,width:_k_w,height:_k_h-108))
                self.filterView?.delegate = self
                self.filterView?.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.7)
                self.view.addSubview(self.filterView!)
                self.tableView?.isScrollEnabled = false
            }
            
        }else{
            
            superLoanHeaderCell?.filterBtn?.setTitleColor(TITLE_COLOR, for: .normal)
            superLoanHeaderCell?.filterImageBtn?.setImage(UIImage.init(named: "filter_icon"), for: .normal)
            UIView.animate(withDuration: 1) {
                self.filterView?.removeFromSuperview()
                self.tableView?.isScrollEnabled = true
            }
        }
        
    }
    
    //MARK : 切换贷款、游戏、旅游按钮
    func tabBtnClick(_ sender: UIButton) {
        
    }
    
    //MARK : 选择排序
    func sortTabSelected(_ index: NSInteger) {
        _index = index
//        pages = 0
        switch _index {
        case 0:
            order = "ASC"
        case 1:
            order = "DESC"
        case 2:
            order = "ASC"
        case 3:
            order = "ASC"
        default:
            break;
        }
        superLoanHeaderCell?.sortBtn?.setTitleColor(TITLE_COLOR, for: .normal)
        superLoanHeaderCell?.sortImageBtn?.setImage(UIImage.init(named: "sort_icon"), for: .normal)
        superLoanHeaderCell?.sortBtn?.isSelected = false
        superLoanHeaderCell?.sortImageBtn?.isSelected = false
        let sortIndex = String(format:"%ld",_index!)
        
        if isFirst! {
            getData(maxAmount: "", maxDays: "", minAmount: "", minDays: "", offset: "0", order: order!, sort: sortIndex, moduleType: moduleType!)
        }else{
            
            getData(maxAmount: maxAmount!, maxDays: maxDays!, minAmount: minAmount!, minDays: minDays!, offset: "0", order: order!, sort: sortIndex, moduleType: moduleType!)
        }
        
        
        UIView.animate(withDuration: 1) {
            self.sortView?.removeFromSuperview()
        }
    }
    
    
    //MARK : 筛选确认按钮
    func sureBtnClick(_ minLoanMoney: String, maxLoanMoney: String, minLoanPeriod: String, maxLoanPeriod: String) {
        isFirst = false
        let sortIndex = String(format:"%ld",self._index!)
        order = "ASC"
//        pages = 0
        if maxLoanMoney == "" || minLoanMoney == "" {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请输入借款金额")
            return
        }
        
        if maxLoanPeriod == "" || minLoanPeriod == "" {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "请输入借款周期")
            return
        }
        
        if Int(maxLoanMoney)! < Int(minLoanMoney)! {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "借款金额输入不合法")
            return
        }
        
        if Int(maxLoanPeriod)! < Int(minLoanPeriod)! {
            MBPAlertView.sharedMBPText().showTextOnly(self.view, message: "借款周期输入不合法")
            return
        }
        
        superLoanHeaderCell?.filterBtn?.setTitleColor(TITLE_COLOR, for: .normal)
        superLoanHeaderCell?.filterImageBtn?.setImage(UIImage.init(named: "filter_icon"), for: .normal)
        superLoanHeaderCell?.filterBtn?.isSelected = false
        superLoanHeaderCell?.filterImageBtn?.isSelected = false
        maxAmount = maxLoanMoney;
        maxDays = maxLoanPeriod;
        minAmount = minLoanMoney;
        minDays = minLoanPeriod;
        
        getData(maxAmount: maxLoanMoney, maxDays: maxLoanPeriod, minAmount: minLoanMoney, minDays: minLoanPeriod, offset: "0", order: order!, sort: sortIndex, moduleType: moduleType!)
        
        UIView.animate(withDuration: 1) {
            self.filterView?.removeFromSuperview()
        }
    }
    
    //MARK : 收藏
    func collectionBtn(_ sender: UIButton) {
        let model = dataArray![sender.tag - 1] as! RowsModel
        
        let collectionVM = CollectionViewModel()
        collectionVM.setBlockWithReturn({ [weak self](retrunValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: retrunValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                

                let sortIndex = String(format:"%ld",(self?._index!)!)
                if (self?.isFirst!)!{

                    self?.getData(maxAmount: "", maxDays: "", minAmount: "", minDays: "", offset: "0", order: (self?.order!)!, sort: sortIndex, moduleType:(self?.moduleType)! )
                }else{
                    self?.getData(maxAmount: (self?.maxAmount!)!, maxDays: (self?.maxDays!)!, minAmount: (self?.minAmount!)!, minDays: (self?.minDays!)!, offset: "0", order: (self?.order!)!, sort: sortIndex, moduleType: (self?.moduleType)!)
                }
//                model.isCollect = model.isCollect == "0" ? "1" : "0"
//                //                model.isCollect = "0"
//                self?.dataArray?.replaceObject(at: sender.tag, with: model)
//                self?.tableView?.reloadData()
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
            
        }) {
            
        }
        collectionVM.addMyCollectionInfocollectionType(moduleType, platformId: model.id_)
    }
}
