//
//  CheckingViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/9/8.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit
import MJRefresh

class CheckingViewController: BaseViewController {

    var scrollView : UIScrollView?
    var refreshTimer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "测评中"
        self.navigationController?.navigationBar.titleTextAttributes = {[
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 19)
            ]}()
        
        let checkingView = Bundle.main.loadNibNamed("CheckViewIng", owner: nil, options: nil)?.first as? CheckViewIng
        checkingView?.frame = CGRect(x:0, y:0, width:_k_w, height:_k_h-64);
        checkingView?.receiveImmediatelyBtn.addTarget(self, action: #selector(applyImmediatelyBtnClick), for: .touchUpInside)
        self.view.addSubview(checkingView!)
        
        addBackItemRoot()
        startReresh()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        refreshTimer?.invalidate()
        refreshTimer = nil
    }
    
    func startReresh()  {
        refreshTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
    }
    
    //MARK:量子互助
    @objc func applyImmediatelyBtnClick(){
    
        let webView = FXDWebViewController()
        webView.urlStr = "http://www.liangzihuzhu.com.cn/xwh5/pages/plan/quotaRecharge.html?id=222767"
        self.navigationController?.pushViewController(webView, animated: true)
   
    }
    
    
    override func loadView() {
        super.loadView()
        let view = UIScrollView.init(frame: UIScreen.main.bounds)
        view.contentSize = CGSize(width:_k_w,height:_k_h)
        view.backgroundColor = UIColor.white
        view.showsVerticalScrollIndicator = false
        
        view.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            print("下拉刷新.")
            self.refresh()
            //结束刷新
        })
        self.view = view;
        self.scrollView = view;
    }
    
    //MARK:刷新
    @objc func refresh(){
    
        let userDataMV = UserDataViewModel()
        userDataMV.setBlockWithReturn({ (returnValue) in
            
            self.scrollView?.mj_header.endRefreshing()
            let baseResult = try! BaseResultModel.init(dictionary: returnValue as! [AnyHashable : Any])
            if baseResult.errCode == "0"{
            
                let userDataModel = try! UserDataResult.init(dictionary: baseResult.data as! [AnyHashable : Any])
                let str = NSString(string:userDataModel.rc_status!)
                switch str.intValue{
                
                case 10:
                    break
                case 00,20:
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        MBPAlertView.sharedMBPText().showTextOnly(UIApplication.shared.keyWindow, message: "资料测评失败")
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    self.tabBarController?.selectedIndex = 0;
                    break
                case 30:
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        MBPAlertView.sharedMBPText().showTextOnly(UIApplication.shared.keyWindow, message: "资料测评通过啦")
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    self.tabBarController?.selectedIndex = 0;
                    break
                default:
                    break
                }
            }else{
                MBPAlertView.sharedMBPText().showTextOnly(self.view, message: baseResult.friendErrMsg)
            }
        }) { 
            
            self.scrollView?.mj_header.endRefreshing()
        }
        userDataMV.userDataCertificationResult()
        
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
