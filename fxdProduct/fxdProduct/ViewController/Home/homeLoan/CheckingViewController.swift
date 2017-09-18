//
//  CheckingViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/9/8.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit
import MJRefresh

class CheckingViewController: UIViewController {

    var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "测评中"
        self.navigationController?.navigationBar.titleTextAttributes = {[
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.systemFont(ofSize: 19)
            ]}()
        
        let checkingView = Bundle.main.loadNibNamed("CheckViewIng", owner: nil, options: nil)?.first as? CheckViewIng
        checkingView?.frame = CGRect(x:0, y:0, width:_k_w, height:_k_h-64);
        self.view.addSubview(checkingView!)
        
        addBackItemroot()
    }

    func addBackItemroot(){
    
        let btn = UIButton.init(type: .system)
        let img = UIImage(named:"return")?.withRenderingMode(.alwaysOriginal)
        btn.setImage(img, for: .normal)
        btn.frame = CGRect(x:0,y:0,width:45,height:44)
        btn.addTarget(self, action: #selector(popBack), for: .touchUpInside)
        let item = UIBarButtonItem.init(customView: btn)
        let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spaceItem.width = -15
        self.navigationItem.leftBarButtonItems = [spaceItem,item]
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
    }
    func popBack(){

        self.navigationController?.popViewController(animated: true)
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
    
    
    func refresh(){
    
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
                case 00,20,30:
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        print("延时提交的任务")
                        self.navigationController?.popToRootViewController(animated: true)
                        
                    }
                    self.tabBarController?.selectedIndex = 0;

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
