//
//  CheckingViewController.swift
//  fxdProduct
//
//  Created by sxp on 2017/9/8.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

class CheckingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "测评中"
        let checkingView = CheckViewIng()
        self.view.addSubview(checkingView)
        
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
