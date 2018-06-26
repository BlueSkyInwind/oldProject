//
//  CreaditCardHeaderCell.swift
//  fxdProduct
//
//  Created by admin on 2018/6/20.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

typealias CollectionViewDidSelect = (_ row:Int,_ isMore:Bool) -> Void

class CreaditCardHeaderCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {

    var didSelect:CollectionViewDidSelect?
    var collectionView:UICollectionView?
    
    var dataArr:Array<CreaditCardBanksListModel> = []{
        didSet{
            collectionView?.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    func configureView()  {
        
        // 1. 定义collectionView的布局类型，流布局
        let layout = UICollectionViewFlowLayout()
        // 2. 设置cell的大小
        layout.itemSize = CGSize(width: _k_w/4, height: 195/2)
        // 3. 滑动方向
        layout.scrollDirection = .vertical
        // 4. 每个item之间最小的间距
        layout.minimumInteritemSpacing = 0
        // 5. 每行之间最小的间距
        layout.minimumLineSpacing = 0
        // 6. 定义一个UICollectionView
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.white
        // 7. 设置collectionView的代理和数据源
        collectionView?.delegate = self
        collectionView?.dataSource = self;
        collectionView?.isScrollEnabled = false
        // 8. collectionViewCell的注册
        collectionView?.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        self.addSubview(collectionView!)
        collectionView?.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension CreaditCardHeaderCell {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return obtainCollectionNum();
    }
    
    func obtainCollectionNum() -> Int {
        return (dataArr.count) > 0 ? (dataArr.count > 7 ? 8 : (dataArr.count) + 1 )  : 1;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        let index = obtainCollectionNum() - 1
        if indexPath.row ==  index{
            cell.cardNameLabel.text = "全部"
            cell.cradIconView.image = UIImage.init(named: "More_card");
        }else{
            let model = dataArr[indexPath.row]
            cell.setDataSource(model)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if didSelect != nil {
            let index = obtainCollectionNum() - 1
            if indexPath.row ==  index{
                didSelect!(indexPath.row,true)
            }else{
                didSelect!(indexPath.row,false)
            }
        }
    }
}


