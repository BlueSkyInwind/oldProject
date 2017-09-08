//
//  CheckingViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/9/8.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class CheckingViewController: UIViewController {

    var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "测评中"
        let checkingView = CheckViewIng()
        self.view.addSubview(checkingView)
        
    }

    

    override func loadView() {
        super.loadView()
        let view = UIScrollView.init(frame: UIScreen.main.bounds)
        view.contentSize = CGSize(width:_k_w,height:_k_h)
        view.backgroundColor = UIColor.white
        view.showsVerticalScrollIndicator = false
        
//        view.mj_header = MJRefreshNormalHeader(refreshingBlock: {
//            print("下拉刷新.")
//
//            //结束刷新
//        })
        
        self.view = view;
        self.scrollView = view;
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
