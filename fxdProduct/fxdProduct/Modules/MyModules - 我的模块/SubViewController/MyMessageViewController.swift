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
 
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的消息"
        addBackItemRoot()
        //随机生成一些初始化数据
        configureView()
        createNoneView()
        setNavQRRightBar()
     
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.page = 0
        getData(isHeaderFresh: true)
    }
    
    func setNavQRRightBar(){
        
        let clearBtn = UIButton.init(frame: CGRect(x:0,y:0,width:23,height:18))
        clearBtn.setTitle("清空", for: .normal)
        clearBtn.setTitleColor(UIColor.white, for: .normal)
        clearBtn.addTarget(self, action: #selector(clearBtnClick), for: .touchUpInside)
        let aBarbi = UIBarButtonItem.init(customView: clearBtn)
        let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spaceItem.width = 8
        self.navigationItem.rightBarButtonItems = [spaceItem,aBarbi]
        
    }
    
    @objc func clearBtnClick(){
        
    }

    
    func createNoneView(){
        
        noneView = NonePageView()
        noneView?.DefaultUI()
        noneView?.backgroundColor = LINE_COLOR
        noneView?.isHidden = false
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
        if #available(iOS 11.0, *){
            tableView?.contentInsetAdjustmentBehavior = .never;
            tableView?.contentInset = UIEdgeInsetsMake(CGFloat(obtainBarHeight_New(vc: self)), 0, 0, 0)
        }else if #available(iOS 9.0, *){
            self.automaticallyAdjustsScrollViewInsets = true;
        }else{
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        //下拉刷新相关设置,使用闭包Block
        tableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {

            self.headerRefresh()

        })


//        //上拉加载相关设置,使用闭包Block
//        tableView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
//
//            self.footerLoad()
//
//        })
//        tableView?.mj_footer.isAutomaticallyHidden = true
    
        // 底部加载
        let footer = MJRefreshAutoNormalFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerLoad))
        //是否自动加载（默认为true，即表格滑到底部就自动加载）
        footer.isAutomaticallyRefresh = false
         self.tableView!.mj_footer = footer
    }
    
    //MARK: 刷新
    /// 下拉刷新
    @objc func headerRefresh(){

        self.page = 0
        getData(isHeaderFresh: true)

    }
    
    /// 上拉加载
    @objc func footerLoad(){
       
        self.page = (self.page)! + 15
        
        if (self.messageModel?.operUserMassge.count)! < 15 {
            self.tableView?.mj_footer.endRefreshingWithNoMoreData()

        }else{
    
            getData(isHeaderFresh: false)
           
        }
    }

    func getData(isHeaderFresh : Bool){
        
        let pageStr = String.init(format: "%d", self.page!)
        
        let messageVM = MessageViewModel()
        messageVM.setBlockWithReturn({ [weak self](returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0" {
                if isHeaderFresh{
                    
                    self?.items.removeAll()
                }
            
                self?.messageModel = try! ShowMsgPreviewModel.init(dictionary: baseResult.data as! [AnyHashable : Any]?)
                if self?.messageModel?.operUserMassge.count != 0{
                    
                    for index in 0 ..< (self?.messageModel?.operUserMassge.count)!{
                        
                        let model = self?.messageModel?.operUserMassge[index] as? OperUserMassgeModel
                        self?.items.append(model!)
                    }
                    if (self?.messageModel?.operUserMassge.count)! < 15 {
                        self?.tableView?.mj_footer.isHidden = true
                    }else{
                        self?.tableView?.mj_footer.isHidden = false
                    }
                    self?.tableView?.isHidden = false
                    self?.noneView?.isHidden = true
                    self?.tableView?.reloadData()
                    self?.tableView?.mj_header.endRefreshing()
                    self?.tableView?.mj_footer.endRefreshing()
                    
                }else if(isHeaderFresh){
                    self?.tableView?.isHidden = true
                    self?.noneView?.isHidden = false
                    self?.tableView?.mj_header.endRefreshing()
                    self?.tableView?.mj_footer.endRefreshing()
                }else{
                    
                    self?.tableView?.isHidden = false
                    self?.noneView?.isHidden = true
                    self?.tableView?.mj_footer.endRefreshingWithNoMoreData()
                }
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self?.view, message: baseResult.friendErrMsg)
            }
            
//            self?.tableView?.mj_header.endRefreshing()
//            self?.tableView?.mj_footer.endRefreshing()
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
        messageCell.titleLabel?.text = items[indexPath.row - 1].msgName
        messageCell.timeLabel?.text = items[indexPath.row - 1].createDate
        messageCell.contentLabel?.text = items[indexPath.row - 1].msgText
        messageCell.leftImageView?.image = UIImage(named:"speaker")
        messageCell.titleLabel?.textColor = TITLE_COLOR

        if items[indexPath.row - 1].isRead == "2" {

            messageCell.leftImageView?.image = UIImage(named:"speaker_select")
            messageCell.titleLabel?.textColor = QUTOA_COLOR;
        }
        
        return messageCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webView = FXDWebViewController()
        webView.urlStr = (messageModel?.requestUrl)! + items[indexPath.row - 1].id_
        self.navigationController?.pushViewController(webView, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        delMessage(delType: "1", operUserMassgeId: items[indexPath.row - 1].id_)

    }
    
    
    func delMessage(delType:String,operUserMassgeId:String){
        let messageVM = MessageViewModel()
        messageVM .setBlockWithReturn({ (returnValue) in
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
                
                self.getData(isHeaderFresh: true)
                
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) {

        }
        
        messageVM.delMsgDelType(delType, operUserMassgeId: operUserMassgeId)
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
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
