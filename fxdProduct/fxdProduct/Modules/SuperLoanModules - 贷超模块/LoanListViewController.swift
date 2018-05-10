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
    var pages : Int?
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataArray = NSMutableArray.init(capacity: 100)
        _index = 0
        pages = 0
        isFirst = true
        self.title = titleStr
        addBackItem()
        configureView()
        // Do any additional setup after loading the view.
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
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData(maxAmount: "", maxDays: "", minAmount: "", minDays: "", offset: "0", order: "ASC", sort: "0", moduleType: moduleType!)
    }

    
    fileprivate func getData(maxAmount:String,maxDays:String,minAmount:String,minDays:String,offset:String,order:String,sort:String ,moduleType:String){
        
        let viewModel = CompQueryViewModel()
        viewModel.setBlockWithReturn({ [weak self] (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                
                if self?.pages == 0{
                    self?.dataArray?.removeAllObjects()
                }
                
                let compQueryModel = try! CompQueryModel.init(dictionary: baseResult.data as! [AnyHashable : Any])
                for index in 0 ..< compQueryModel.rows.count{
                    
                    let model = compQueryModel.rows[index] as! RowsModel
                    self?.dataArray?.add(model)
                }
                self?.tableView?.reloadData()
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
            
        }) {
            
        }
        viewModel.compQueryLimit("15", maxAmount: maxAmount, maxDays: maxDays, minAmount: minAmount, minDays: minDays, offset: offset, order: order, sort: sort, moduleType: moduleType)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (dataArray?.count)! + 1
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 48
        }
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
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
        superLoanCell?.collectionBtn?.tag = indexPath.row
        let model = dataArray![indexPath.row - 1] as! RowsModel
        
        let url = URL(string: model.plantLogo)
        superLoanCell?.leftImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholderImage_Icon"), options: .refreshCached, completed: { (uiImage, error, cachType, url) in
            
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
        
        if indexPath.row == 0{
            return
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
        viewModel.getCompLinkThirdPlatformId(thirdPlatformId)
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
    
    func tabBtnClick(_ sender: UIButton) {
        
    }
    
    func sortTabSelected(_ index: NSInteger) {
        _index = index
        superLoanHeaderCell?.sortBtn?.setTitleColor(TITLE_COLOR, for: .normal)
        superLoanHeaderCell?.sortImageBtn?.setImage(UIImage.init(named: "sort_icon"), for: .normal)
        superLoanHeaderCell?.sortBtn?.isSelected = false
        superLoanHeaderCell?.sortImageBtn?.isSelected = false
        let sortIndex = String(format:"%ld",index)
        
        if isFirst! {
            getData(maxAmount: "", maxDays: "", minAmount: "", minDays: "", offset: "0", order: "ASC", sort: sortIndex, moduleType: moduleType!)
        }else{
            
            getData(maxAmount: maxAmount!, maxDays: maxDays!, minAmount: minAmount!, minDays: minDays!, offset: "0", order: "ASC", sort: sortIndex, moduleType: moduleType!)
        }
        
        
        UIView.animate(withDuration: 1) {
            self.sortView?.removeFromSuperview()
        }
    }
    
    func sureBtnClick(_ minLoanMoney: String, maxLoanMoney: String, minLoanPeriod: String, maxLoanPeriod: String) {
        isFirst = false
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
        
        getData(maxAmount: maxLoanMoney, maxDays: maxLoanPeriod, minAmount: minLoanMoney, minDays: minLoanPeriod, offset: "0", order: "ASC", sort: sortIndex, moduleType: moduleType!)
        
        UIView.animate(withDuration: 1) {
            self.filterView?.removeFromSuperview()
        }
    }
    
    func collectionBtn(_ sender: UIButton) {
        let model = dataArray![sender.tag - 1] as! RowsModel
        let collectionVM = CollectionViewModel()
        collectionVM.setBlockWithReturn({ [weak self](retrunValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: retrunValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                
                let sortIndex = String(format:"%ld",(self?._index!)!)
                
                if (self?.isFirst!)!{
                    
                    self?.getData(maxAmount: "", maxDays: "", minAmount: "", minDays: "", offset: "0", order: "ASC", sort: sortIndex, moduleType:(self?.moduleType)! )
                }else{
                    self?.getData(maxAmount: (self?.maxAmount!)!, maxDays: (self?.maxDays!)!, minAmount: (self?.minAmount!)!, minDays: (self?.minDays!)!, offset: "0", order: "ASC", sort: sortIndex, moduleType: (self?.moduleType)!)
                }
                
            }
            
        }) {
            
        }
        collectionVM.addMyCollectionInfocollectionType(moduleType, platformId: model.id_)
    }
}
