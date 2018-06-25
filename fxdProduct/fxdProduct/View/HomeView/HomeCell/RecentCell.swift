//
//  RecentCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/4/24.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc protocol RecentCellDelegate: NSObjectProtocol {
    
    func recentMoreBtnClick()
    func collectionBtnClick(_ sender: UIButton)
}

//,UITableViewDelegate,UITableViewDataSource
class RecentCell: UITableViewCell ,SuperLoanCellDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
//    @objc var type : String?{
//        didSet(newValue){
//
//            setCellType(type: type!)
//        }
//    }
    
    //产品数据
    @objc var homeProductListModel = FXD_HomeProductListModel()
    @objc var tableView : UITableView?
    
    @objc var collectionView : UICollectionView?
    
    //SuperLoanCellDelegate  点击收藏按钮的代理方法
    func collectionBtn(_ sender: UIButton) {

        if delegate != nil {
            delegate?.collectionBtnClick(sender)
        }
    }
    

    var superLoanCell : SuperLoanCell?
    @objc var delegate : RecentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        type = "0"
        setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecentCell{
    fileprivate func setUpUI(){
       
        let tipView = UIView()
        tipView.backgroundColor = UIColor.clear
        self.addSubview(tipView)
        tipView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(30)
        }
        let lineView = UIView()
        lineView.backgroundColor = UI_MAIN_COLOR
        tipView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(tipView.snp.left).offset(20)
            make.top.equalTo(tipView.snp.top).offset(9)
            make.width.equalTo(3)
            make.height.equalTo(14)
        }
        
        let tipTitleLabel = UILabel()
        tipTitleLabel.text = "热门推荐"
        tipTitleLabel.font = UIFont.yx_systemFont(ofSize: 14)
        tipTitleLabel.textColor = TIP_TITLE_COLOR
        tipView.addSubview(tipTitleLabel)
        tipTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineView.snp.right).offset(5)
            make.top.equalTo(tipView.snp.top).offset(8)
        }
        
//        let arrowBtn = UIButton()
//        arrowBtn.setImage(UIImage.init(named: "arrow_icon"), for: .normal)
//        arrowBtn.addTarget(self, action: #selector(moreBtnClick), for: .touchUpInside)
//        tipView.addSubview(arrowBtn)
//        arrowBtn.snp.makeConstraints { (make) in
//            make.right.equalTo(tipView.snp.right).offset(-20)
//            make.centerY.equalTo(tipView.snp.centerY)
//        }
        
        let bottomLineView = UIView()
        bottomLineView.backgroundColor = TIP_LINE_COLOR
        tipView.addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints { (make) in
            make.left.equalTo(tipView.snp.left).offset(0)
            make.right.equalTo(tipView.snp.right).offset(0)
            make.bottom.equalTo(tipView.snp.bottom).offset(-1)
            make.height.equalTo(1)
        }
        
        
//        let moreBtn = UIButton()
//        moreBtn.setTitle("查看更多", for: .normal)
//        moreBtn.setTitleColor(MIDDLE_LINE_COLOR, for: .normal)
//        moreBtn.titleLabel?.font = UIFont.yx_systemFont(ofSize: 12)
//        moreBtn.addTarget(self, action: #selector(moreBtnClick), for: .touchUpInside)
//        tipView.addSubview(moreBtn)
//        moreBtn.snp.makeConstraints { (make) in
//            make.right.equalTo(arrowBtn.snp.left).offset(-8)
//            make.centerY.equalTo(tipView.snp.centerY)
//        }
//

        let layout = UICollectionViewFlowLayout()
        //列间距,行间距,偏移
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0)
        
        collectionView = UICollectionView.init(frame: CGRect(x:20,y:30,width:Int(_k_w - 40),height:Int(self.frame.size.height)), collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self;
        //注册一个cell
        collectionView!.register(HomeHotCell.self, forCellWithReuseIdentifier:"HomeHotCell")
        collectionView?.backgroundColor = PayPasswordBackColor_COLOR
        collectionView?.isScrollEnabled = false
        self.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.top.equalTo(tipView.snp.bottom).offset(0)
            make.bottom.equalTo(self).offset(0)
        })
//        tableView = UITableView()
//        tableView?.isScrollEnabled = false
//        tableView?.delegate = self
//        tableView?.dataSource = self
//        self.addSubview(tableView!)
//        tableView?.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(0)
//            make.right.equalTo(self).offset(0)
//            make.top.equalTo(tipView.snp.bottom).offset(0)
//            make.bottom.equalTo(self).offset(0)
//        }
    }
}



extension RecentCell{
    
    
    // MARK: 代理
    //每个区的item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if homeProductListModel.hotRecommend != nil {
            
            return homeProductListModel.hotRecommend.count
        }
        
        return 0

    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHotCell", for: indexPath) as! HomeHotCell
        cell.backgroundColor = UIColor.white
        let model = homeProductListModel.hotRecommend[indexPath.row] as! HomeHotRecommendModel
        let url = URL(string: model.plantLogo)
    
        cell.nameImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholderImage_Icon"), options: .retryFailed, completed: { (uiImage, error, cachType, url) in
            
        })
        cell.nameLabel?.text = model.plantName
        cell.descLabel?.text = model.applicantsCount
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:(_k_w)/4 ,height:103)
//        if UI_IS_IPONE6 {
//
//            return CGSize(width:(_k_w)/4 ,height:103)
//        }
//        return CGSize(width:(_k_w - 40)/4 + 10,height:103)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = homeProductListModel.hotRecommend[indexPath.row] as! HomeHotRecommendModel
        getCompLink(thirdPlatformId: model.id_)
        
    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        if homeProductListModel.hotRecommend != nil {
//
//            return homeProductListModel.hotRecommend.count
//        }
//
//        return 0
//    }
//
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 85
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        superLoanCell = tableView.dequeueReusableCell(withIdentifier:"SuperLoanCell") as? SuperLoanCell
//        if superLoanCell == nil {
//            superLoanCell = SuperLoanCell.init(style: .default, reuseIdentifier: "SuperLoanCell")
//        }
//
//        superLoanCell?.delegate = self
//        superLoanCell?.selectionStyle = .none
//
//        if homeProductListModel.hotRecommend.count <= 0 {
//            return superLoanCell!
//        }
//
//
//        let model = homeProductListModel.hotRecommend[indexPath.row] as! HomeHotRecommendModel
//        superLoanCell?.type = model.moduletype
//        let url = URL(string: model.plantLogo)
//        superLoanCell?.leftImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholderImage_Icon"), options: .retryFailed, completed: { (uiImage, error, cachType, url) in
//
//        })
//        superLoanCell?.titleLabel?.text = model.plantName
//        let maximumAmount = model.maximumAmount != nil ? model.maximumAmount : ""
//        let maximumAmountUnit = model.maximumAmountUnit != nil ? model.maximumAmountUnit : ""
//        superLoanCell?.qutaLabel?.text = "额度:最高" + maximumAmount! + maximumAmountUnit!
//        let term = model.unitStr != nil ? model.unitStr : ""
//        superLoanCell?.termLabel?.text = "期限:" + term!
//        if term != "" {
//
//            let attrstr1 : NSMutableAttributedString = NSMutableAttributedString(string:(superLoanCell?.termLabel?.text)!)
//            attrstr1.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr1.length-4))
//            superLoanCell?.termLabel?.attributedText = attrstr1
//        }
//        let referenceRate = model.referenceRate != nil ? model.referenceRate : ""
//        if model.referenceMode == nil {
//
//            superLoanCell?.feeLabel?.text = "费用:" + referenceRate! + "%"
//        }else{
//            superLoanCell?.feeLabel?.text = "费用:" + referenceRate! + "%/" + (rateUnit(referenceMode: model.referenceMode! as NSString) as String)
//        }
//
//
//        if referenceRate != nil && model.referenceMode != nil {
//
//            let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(superLoanCell?.feeLabel?.text)!)
//            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(3,attrstr.length-4))
//            superLoanCell?.feeLabel?.attributedText = attrstr
//        }
//
//        superLoanCell?.descBtn?.setTitle(model.platformIntroduction, for: .normal)
//        superLoanCell?.descBtn?.setTitleColor(UIColor.purple, for: .normal)
//        superLoanCell?.descBtn?.layer.borderColor = UIColor.purple.cgColor
//
//        if indexPath.section % 2 == 0 {
//            superLoanCell?.descBtn?.setTitleColor(UIColor.blue, for: .normal)
//            superLoanCell?.descBtn?.layer.borderColor = UIColor.blue.cgColor
//        }
//
//        superLoanCell?.lineView?.isHidden = true
//        let str : NSString = model.platformIntroduction! as NSString
//        let dic = NSDictionary(object: UIFont.yx_systemFont(ofSize: 12) as Any, forKey: NSAttributedStringKey.font as NSCopying)
//        let width = str.boundingRect(with: CGSize(width:_k_w,height:20), options: .usesLineFragmentOrigin, attributes:(dic as! [NSAttributedStringKey : Any]), context: nil).size.width + 20
//
//        superLoanCell?.descBtn?.snp.remakeConstraints({ (make) in
//            make.width.equalTo(width)
//        })
//
//        superLoanCell?.collectionBtn?.tag = indexPath.row
//        superLoanCell?.collectionBtn?.setImage(UIImage.init(named: "collection_icon"), for: .normal)
//        if model.isCollect == "0" {
//            superLoanCell?.collectionBtn?.setImage(UIImage.init(named: "collection_selected_icon"), for: .normal)
//        }
//
//        return superLoanCell!
//
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let model = homeProductListModel.hotRecommend[indexPath.row] as! HomeHotRecommendModel
//        getCompLink(thirdPlatformId: model.id_)
//
//    }
    
    func getCompLink(thirdPlatformId : String){
        let viewModel = CompQueryViewModel()
        viewModel.setBlockWithReturn({ [weak self](returnValue) in
            
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                
                let dic = baseResult.data as! NSDictionary
                if dic["url"] != nil {
                    let webView = FXDWebViewController()
                    webView.urlStr = dic["url"]  as! String
                    self?.viewController?.navigationController?.pushViewController(webView, animated: true)
                }
                
            }else{

                MBPAlertView.sharedMBPText().showTextOnly(self, message: baseResult.friendErrMsg)
            }
            
        }) {
            
        }
        viewModel.getCompLinkThirdPlatformId(thirdPlatformId, location: "1")
    }
}

extension RecentCell{
    @objc fileprivate func moreBtnClick(){
        
        if delegate != nil {
            delegate?.recentMoreBtnClick()
        }
    }
    
//    fileprivate func setCellType(type : String){
//
//        if homeProductListModel.hotRecommend.count > 0 {
////            tableView?.reloadData()
//
//            var height = 0
//            if homeProductListModel.hotRecommend != nil {
//
//                let count = (homeProductListModel.hotRecommend.count / 4)
//                if (homeProductListModel.hotRecommend.count % 4) == 0{
//                    height = count * 103
//                }else{
//                    height = (count + 1) * 103
//                }
//
//
//    //            height = (homeProductListModel.hotRecommend.count / 4)*103
//            }
//            let frame = CGRect(x:0,y:30,width:Int(_k_w),height:height)
//            collectionView?.frame = frame
//            collectionView?.reloadData()
//        }
//    }
    
    fileprivate func rateUnit(referenceMode : NSString) -> (NSString){
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
    
}
