//
//  RecentCell.swift
//  fxdProduct
//
//  Created by sxp on 2018/4/24.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
import SnapKit

class RecentCell: UITableViewCell ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //产品数据
    @objc var homeProductListModel = FXD_HomeProductListModel()
    @objc var collectionView : UICollectionView?
    
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
            make.height.equalTo(60)
        }
        
        let leftImageView = UIImageView()
        leftImageView.image = UIImage.init(named: "tuoyuan_icon")
        tipView.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { (make) in
            make.left.equalTo(tipView.snp.left).offset(15)
            make.centerY.equalTo(tipView.snp.centerY)
        }
        
        let tipTitleLabel = UILabel()
        tipTitleLabel.text = "热门贷款推荐"
        tipTitleLabel.font = UIFont.yx_systemFont(ofSize: 17)
        tipTitleLabel.textColor = TIP_TITLE_COLOR
        tipView.addSubview(tipTitleLabel)
        tipTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftImageView.snp.right).offset(10)
            make.centerY.equalTo(tipView.snp.centerY)
        }

        let layout = UICollectionViewFlowLayout()
        //列间距,行间距,偏移
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0)
        
        collectionView = UICollectionView.init(frame: CGRect(x:20,y:60,width:Int(_k_w - 40),height:Int(self.frame.size.height)), collectionViewLayout: layout)
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
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:(_k_w)/4 ,height:103)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = homeProductListModel.hotRecommend[indexPath.row] as! HomeHotRecommendModel
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
