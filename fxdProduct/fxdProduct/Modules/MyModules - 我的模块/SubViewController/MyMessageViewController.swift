//
//  MyMessageViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/11/14.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit
import MJRefresh

class MyMessageViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView : UITableView?
    var page : Int?
    var noneView : NonePageView?
    var items:[OperUserMassgeModel] = []
    var messageModel : ShowMsgPreviewModel?
//    var headView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的消息"
        addBackItemRoot()
        //随机生成一些初始化数据
        configureView()
        createNoneView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.page = 0
        getData()
    }
    
    func createNoneView(){
        
        noneView = NonePageView()
        noneView?.backgroundColor = LINE_COLOR
        self.view.addSubview(noneView!)
    }
    func configureView()  {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        self.view.addSubview(tableView!)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        //下拉刷新相关设置,使用闭包Block
        tableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {

            self.headerRefresh()

        })


        //上拉加载相关设置,使用闭包Block
        tableView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {

            self.footerLoad()

        })
        
//        headView = UIView()
//        headView?.backgroundColor = UIColor.blue
//        self.view.addSubview(headView!)
//        headView?.snp.makeConstraints({ (make) in
//            make.left.equalTo(self.view).offset(0)
//            make.right.equalTo(self.view).offset(0)
//            make.top.equalTo(self.view).offset(64)
//            make.height.equalTo(15)
//        })
    }
    
    //MARK: 刷新
    /// 下拉刷新
    @objc func headerRefresh(){

        self.items.removeAll()
        self.page = 0
        getData()

//        //重现加载表格数据
//        self.tableView?.reloadData()
//        //结束刷新
//        self.tableView?.mj_header.endRefreshing()
    }
    
    /// 上拉加载
    @objc func footerLoad(){
       
        let offset = Int((self.messageModel?.offset)!)
        
        self.page = offset! + 1
        getData()
        
//        //重现加载表格数据
//        self.tableView?.reloadData()
//        //结束刷新
//        self.tableView?.mj_footer.endRefreshing()
        
    }

    func getData(){
        
        let pageStr = String.init(format: "%d", self.page!)
        
        let messageVM = MessageViewModel()
        messageVM.setBlockWithReturn({ [weak self](returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                self?.page = 1
                self?.messageModel = try! ShowMsgPreviewModel.init(dictionary: baseResult.data as! [AnyHashable : Any]!)
                if self?.messageModel?.operUserMassge.count != 0{
                    
                    for index in 0 ..< (self?.messageModel?.operUserMassge.count)!{
                        
                        let model = self?.messageModel?.operUserMassge[index] as? OperUserMassgeModel
                        self?.items.append(model!)
                    }
                    self?.tableView?.isHidden = false
                    self?.noneView?.isHidden = true
                    self?.tableView?.reloadData()
                    
                }else{
                    self?.tableView?.isHidden = true
                    self?.noneView?.isHidden = false

                }
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
            
            self?.tableView?.mj_header.endRefreshing()
            self?.tableView?.mj_footer.endRefreshing()
        }) {
            
            self.tableView?.mj_header.endRefreshing()
            self.tableView?.mj_footer.endRefreshing()
        }
        messageVM.showMsgPreviewPageNum(pageStr, pageSize: "15")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count + 1
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 15
        }
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var messageCell:MessageCell! = tableView.dequeueReusableCell(withIdentifier:"MessageCell") as? MessageCell
        if messageCell == nil {
            messageCell = MessageCell.init(style: .default, reuseIdentifier: "MessageCell")
        }
        if indexPath.row == 0 {

            messageCell.cellType = MessageCellType(cellType: .Header)
            return messageCell
        }
        
        messageCell.cellType = MessageCellType(cellType: .Default)
        messageCell.selectionStyle = .none
//        let model = self.messageModel?.operUserMassge[indexPath.row - 1 ] as? OperUserMassgeModel
        messageCell.titleLabel?.text = items[indexPath.row - 1].msgName
        messageCell.timeLabel?.text = items[indexPath.row - 1].createDate
        messageCell.contentLabel?.text = items[indexPath.row - 1].msgText
        messageCell.leftImageView?.isHidden = false

        if items[indexPath.row - 1].isRead == "1" {
            messageCell.leftImageView?.isHidden = true
        }
        
        return messageCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webView = FXDWebViewController()
        webView.urlStr = _H5_url+_aboutus_url;
        self.navigationController?.pushViewController(webView, animated: true)
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
