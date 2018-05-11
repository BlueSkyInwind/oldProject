//
//  RecentViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/4/10.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class RecentViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource,SuperLoanCellDelegate{

    var tableView : UITableView?
    @objc var dataArray : NSMutableArray?
    var superLoanCell : SuperLoanCell?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "最近使用"
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

//    func getRecentData(){
//        let findVM = FindViewModel()
//        findVM.setBlockWithReturn({ (returnValue) in
//
//        }) {
//
//        }
//
//    }
//    #pragma mark 最流浏览数据
//    -(void)getRecentData{
//
//    FindViewModel *findVM = [[FindViewModel alloc]init];
//    [findVM setBlockWithReturnBlock:^(id returnValue) {
//
//    BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
//    if ([baseResultM.errCode isEqualToString:@"0"]) {
//    [_recentDataArray removeAllObjects];
//    NSArray * array = (NSArray *)baseResultM.data;
//    for (int  i = 0; i < array.count; i++) {
//    NSDictionary *dic = array[i];
//    HotRecommendModel * model = [[HotRecommendModel alloc]initWithDictionary:dic error:nil];
//    [_recentDataArray addObject:model];
//    }
//
//    _headerView.recentImageNameArray = _recentDataArray;
//    }else{
//    [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
//    }
//    } WithFaileBlock:^{
//
//    }];
//
//    [findVM recent];
//    }
    
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
    
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        superLoanCell = tableView.dequeueReusableCell(withIdentifier:"SuperLoanCell") as? SuperLoanCell
        if superLoanCell == nil {
            superLoanCell = SuperLoanCell.init(style: .default, reuseIdentifier: "SuperLoanCell")
        }
    
        superLoanCell?.delegate = self
        superLoanCell?.selectionStyle = .none
        superLoanCell?.isSelected = false
        superLoanCell?.collectionBtn?.tag = indexPath.section
        let model = dataArray![indexPath.section] as! HotRecommendModel
        
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
        
        
    }
    
    func collectionBtn(_ sender: UIButton) {
        
        let model = dataArray![sender.tag] as! HotRecommendModel
        let collectionVM = CollectionViewModel()
        collectionVM.setBlockWithReturn({ [weak self](retrunValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: retrunValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                
//                if (model.isCollect == "0"){
//                    model.isCollect = "1"
//                }else{
//                    model.isCollect = "0"
//                }
                
                model.isCollect = model.isCollect == "0" ? "1" : "0"
//                model.isCollect = "0"
                self?.dataArray?.replaceObject(at: sender.tag, with: model)
                self?.tableView?.reloadData()
            }
            
        }) {
            
        }
        collectionVM.addMyCollectionInfocollectionType(model.moduletype, platformId: model.id_)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
