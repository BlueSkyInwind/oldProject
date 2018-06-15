//
//  HotRecommendationViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/4/26.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class HotRecommendationViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource,SuperLoanCellDelegate,SuperLoanHeaderCellDelegate,SortViewDelegate,FilterViewDelegate{
    
    var tableView : UITableView?
    //数据数组
    @objc var dataArray : NSMutableArray?
    //内容cell
    var superLoanCell : SuperLoanCell?
    //头部cell
    var superLoanHeaderCell : SuperLoanHeaderCell?
    //页数
//    var pages : Int?
    //排序view
    var _sortView : SortView?
    //筛选view
    var _filterView : FilterView?
    //选中排序view的第几个
    var _index : NSInteger?
    //平台类型， 贷款、游戏、旅游
    var type : String?
    //最大借款金额
    var maxAmount : String?
    //最大周期
    var maxDays : String?
    //最小借款金额
    var minAmount : String?
    //最小周期
    var minDays : String?
    //是否第一次进来 借款金额周期没有值，为收藏做处理
    var isFirst : Bool?
    //排序方式
    var order : String?
    //查询位置
    var location : String?
//    var row : Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        isFirst = true
        self.title = "热门推荐"
        type = "1"
        _index = 0
        dataArray = NSMutableArray.init(capacity: 100)
//        pages = 0
        order = "ASC"
        location = "7"
//        row = -1
        addBackItem()
        configureView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        pages = 0;
//        let offset = String(format:"%d",pages!)
        
        getData(maxAmount: "", maxDays: "", minAmount: "", minDays: "", offset: "0", order: order!, sort: "0")
        
    }
    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.delegate = self
        tableView?.dataSource = self
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
        //        //下拉刷新相关设置,使用闭包Block
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
//        getData(maxAmount: xAmount!, maxDays: xDays!, minAmount: iAmount!, minDays: iDays!, offset: "0", order: order!, sort: sortIndex)
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
//            getData(maxAmount: xAmount!, maxDays: xDays!, minAmount: iAmount!, minDays: iDays!, offset: pageIndex, order: order!, sort: sortIndex)
//
//        }
//    }
    
    
    func getData(maxAmount:String,maxDays:String,minAmount:String,minDays:String,offset:String,order:String,sort:String){
        
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
                self?.tableView?.reloadData()
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
        viewModel.compQueryLimit("100", maxAmount: maxAmount, maxDays: maxDays, minAmount: minAmount, minDays: minDays, offset: offset, order: order, sort: sort, moduleType: type, location: location)
    
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (dataArray?.count)! + 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && type == "1"  {
            return 97
        }
        if indexPath.row == 0 && type != "1" {
            return 60
        }
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            superLoanHeaderCell = tableView.dequeueReusableCell(withIdentifier:"SuperLoanHeaderCell") as? SuperLoanHeaderCell
            if superLoanHeaderCell == nil {
                superLoanHeaderCell = SuperLoanHeaderCell.init(style: .default, reuseIdentifier: "SuperLoanHeaderCell")
            }

            superLoanHeaderCell?.isSelected = false
            superLoanHeaderCell?.selectionStyle = .none
            superLoanHeaderCell?.backgroundColor = LINE_COLOR
//            _superLoanHeaderCell.status = "1";
            if type == "1"{
                superLoanHeaderCell?.type = "1"
            }else{
                superLoanHeaderCell?.type = "3"
            }
            superLoanHeaderCell?.delegate = self
            superLoanHeaderCell?.index = type
            tabBtn(tag: Int(type!)!)
            return superLoanHeaderCell!
        }
        superLoanCell = tableView.dequeueReusableCell(withIdentifier:"SuperLoanCell") as? SuperLoanCell
        if superLoanCell == nil {
            superLoanCell = SuperLoanCell.init(style: .default, reuseIdentifier: "SuperLoanCell")
        }
        
        superLoanCell?.delegate = self
        superLoanCell?.selectionStyle = .none
        superLoanCell?.type = type
        superLoanCell?.collectionBtn?.tag = indexPath.row
        let model = dataArray![indexPath.row - 1] as! RowsModel
        
        let url = URL(string: model.plantLogo)
        superLoanCell?.leftImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholderImage_Icon"), options: .retryFailed, completed: { (uiImage, error, cachType, url) in
            
        })
        superLoanCell?.titleLabel?.text = model.plantName
        superLoanCell?.descLabel?.text = model.applicantsCount
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
        
        if (indexPath.row == 0) {
            return;
        }
        
        let model = dataArray![indexPath.row - 1] as! RowsModel
        getCompLink(thirdPlatformId: model.id_)
        
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
        viewModel.getCompLinkThirdPlatformId(thirdPlatformId, location: "7")
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:SuperLoanHeaderCellDelegate

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HotRecommendationViewController{
    
    func sortBtnClick(_ sender: UIButton) {
        
        if (_filterView != nil) {
            _filterView?.removeFromSuperview()
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
                self._sortView = SortView.init(frame: CGRect(x:0,y:163,width:_k_w,height:_k_h-163))
                self._sortView?.delegate = self
                self._sortView?.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.7)
                self._sortView?.index = self._index!
                self.view.addSubview(self._sortView!)
            }
            
        }else{
            
            superLoanHeaderCell?.sortBtn?.setTitleColor(TITLE_COLOR, for: .normal)
            superLoanHeaderCell?.sortImageBtn?.setImage(UIImage.init(named: "sort_icon"), for: .normal)
            UIView.animate(withDuration: 1) {
                self._sortView?.removeFromSuperview()
            }
        }
        
    }
    
    func filterBtnClick(_ sender: UIButton) {
        
        
        if (_sortView != nil) {
            _sortView?.removeFromSuperview()
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
                self._filterView = FilterView.init(frame: CGRect(x:0,y:163,width:_k_w,height:_k_h-163))
                self._filterView?.delegate = self
                self._filterView?.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.7)
                self.view.addSubview(self._filterView!)
            }
            
        }else{
            
            superLoanHeaderCell?.filterBtn?.setTitleColor(TITLE_COLOR, for: .normal)
            superLoanHeaderCell?.filterImageBtn?.setImage(UIImage.init(named: "filter_icon"), for: .normal)
            UIView.animate(withDuration: 1) {
                self._filterView?.removeFromSuperview()
            }
        }
        
    }
    
    func tabBtnClick(_ sender: UIButton) {
        
        order = "ASC"
        let tag = sender.tag

//        pages = 0
        type = String(format:"%ld",tag - 100)
        let sortIndex = String(format:"%ld",self._index!)
        let xAmount = maxAmount == nil ? "" : maxAmount
        let iAmount = minAmount == nil ? "" : minAmount
        let xDays = maxDays == nil ? "" : maxDays
        let iDays = minDays == nil ? "" : minDays
        if type == "1" {
            location = "7"
            getData(maxAmount: xAmount!, maxDays: xDays!, minAmount: iAmount!, minDays: iDays!, offset: "0", order: order!, sort: sortIndex)
        }else{
            location = ""
            getData(maxAmount: "", maxDays: "", minAmount: "", minDays: "", offset: "0", order: order!, sort: "0")
        }

    }
    
    func tabBtn(tag : Int){
        switch tag {
        case 1:
            superLoanHeaderCell?.loanBtn?.setTitleColor(UI_MAIN_COLOR, for: .normal)
            superLoanHeaderCell?.gameBtn?.setTitleColor(UIColor.init(red: 25.5/255, green: 25.5/255, blue: 25.5/255, alpha: 1.0), for: .normal)
            superLoanHeaderCell?.tourismBtn?.setTitleColor(UIColor.init(red: 25.5/255, green: 25.5/255, blue: 25.5/255, alpha: 1.0), for: .normal)
        case 2:
            superLoanHeaderCell?.loanBtn?.setTitleColor(UIColor.init(red: 25.5/255, green: 25.5/255, blue: 25.5/255, alpha: 1.0), for: .normal)
            superLoanHeaderCell?.gameBtn?.setTitleColor(UI_MAIN_COLOR, for: .normal)
            superLoanHeaderCell?.tourismBtn?.setTitleColor(UIColor.init(red: 25.5/255, green: 25.5/255, blue: 25.5/255, alpha: 1.0), for: .normal)
        case 3:
            superLoanHeaderCell?.loanBtn?.setTitleColor(UIColor.init(red: 25.5/255, green: 25.5/255, blue: 25.5/255, alpha: 1.0), for: .normal)
            superLoanHeaderCell?.gameBtn?.setTitleColor(UIColor.init(red: 25.5/255, green: 25.5/255, blue: 25.5/255, alpha: 1.0), for: .normal)
            superLoanHeaderCell?.tourismBtn?.setTitleColor(UI_MAIN_COLOR, for: .normal)
        default:
            break;
        }
    }
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
        let sortIndex = String(format:"%ld",index)
//        let sortIndex = "4"
        if isFirst! {
            getData(maxAmount: "", maxDays: "", minAmount: "", minDays: "", offset: "0", order: order!, sort: sortIndex)
        }else{
            
            getData(maxAmount: maxAmount!, maxDays: maxDays!, minAmount: minAmount!, minDays: minDays!, offset: "0", order: order!, sort: sortIndex)
        }
        
        UIView.animate(withDuration: 1) {
            self._sortView?.removeFromSuperview()
        }
    }
    
    func sureBtnClick(_ minLoanMoney: String, maxLoanMoney: String, minLoanPeriod: String, maxLoanPeriod: String) {
        order = "ASC"
        isFirst = false
//        pages = 0
        let sortIndex = String(format:"%ld",self._index!)
        
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
        
        getData(maxAmount: maxLoanMoney, maxDays: maxLoanPeriod, minAmount: minLoanMoney, minDays: minLoanPeriod, offset: "0", order: "ASC", sort: sortIndex)
        
        UIView.animate(withDuration: 1) {
            self._filterView?.removeFromSuperview()
        }
        
    }
    
    func collectionBtn(_ sender: UIButton) {
        
        let model = dataArray![sender.tag - 1] as! RowsModel
//        var isCancel = false
//
//        if self.row == sender.tag || model.isCollect == "0"{
//            isCancel = true
//        }
        
        let collectionVM = CollectionViewModel()
        collectionVM.setBlockWithReturn({ [weak self](retrunValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: retrunValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                
//                self?.row = sender.tag
//                model.isCollect = "0"
//                if isCancel{
//                    model.isCollect = "1"
//                }
//                self?.dataArray?.replaceObject(at: sender.tag - 1, with: model)
//                var tag = sender.tag - 1
//                if self?.type == "1"{
//                    tag = sender.tag
//                    
//                }
//                let indexPath: IndexPath = IndexPath.init(row: tag, section: 0)
//                self?.tableView?.reloadRows(at: [indexPath], with: .fade)
                
                let sortIndex = String(format:"%ld",(self?._index!)!)
                if (self?.isFirst!)!{
                    
                    self?.getData(maxAmount: "", maxDays: "", minAmount: "", minDays: "", offset: "0", order: (self?.order!)!, sort: sortIndex)
                }else{
                    self?.getData(maxAmount: (self?.maxAmount!)!, maxDays: (self?.maxDays!)!, minAmount: (self?.minAmount!)!, minDays: (self?.minDays!)!, offset: "0", order: (self?.order!)!, sort: sortIndex)
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
        collectionVM.addMyCollectionInfocollectionType(type, platformId: model.id_)
        
    }
}
