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

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
        
        var superLoanCell:SuperLoanCell! = tableView.dequeueReusableCell(withIdentifier:"SuperLoanCell") as? SuperLoanCell
        if superLoanCell == nil {
            superLoanCell = SuperLoanCell.init(style: .default, reuseIdentifier: "SuperLoanCell")
        }
        superLoanCell.delegate = self
        superLoanCell.leftImageView?.image = UIImage.init(named: "btn_image_icon")
        superLoanCell.titleLabel?.text = "贷嘛"
        superLoanCell.qutaLabel?.text = "额度:最高5000元"
        superLoanCell.termLabel?.text = "期限:1-60月"
        superLoanCell.feeLabel?.text = "费用:0.3%/日"
        superLoanCell.descBtn?.setTitle("30家借款机构,0抵押方天放款", for: .normal)
        superLoanCell.lineView?.isHidden = true
        let str : NSString = "30家借款机构,0抵押方天放款"
        let dic = NSDictionary(object: UIFont.yx_systemFont(ofSize: 12) as Any, forKey: NSAttributedStringKey.font as NSCopying)
        let width = str.boundingRect(with: CGSize(width:_k_w,height:20), options: .usesLineFragmentOrigin, attributes:(dic as! [NSAttributedStringKey : Any]), context: nil).size.width + 20
        
        superLoanCell.descBtn?.snp.updateConstraints({ (make) in
            make.width.equalTo(width)
        })
        return superLoanCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    func collectionBtn(_ sender: UIButton) {
        
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
