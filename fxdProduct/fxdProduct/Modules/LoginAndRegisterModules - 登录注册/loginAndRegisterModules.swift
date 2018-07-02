//
//  loginAndRegisterModules.swift
//  fxdProduct
//
//  Created by admin on 2018/6/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class loginAndRegisterModules: BaseViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "登录"
        self.addBackItem()
        configureView()
        
    }
    
    func configureView()  {
        let contentView = LoginAndRegisterSlideView.init(CGRect.init(x: 0, y: CGFloat(obtainBarHeight_New(vc: self)), width: _k_w, height: _k_h - CGFloat(obtainBarHeight_New(vc: self)) )) { (loginView, registerView) in
            
        }
        self.view.addSubview(contentView)

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
