//
//  RepaymentResultViewController.swift
//  fxdProduct
//
//  Created by sxp on 2018/6/5.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@objc enum Enum_Result:Int{
    
    case intermediate
    case failure
    case success
    
}

class RepaymentResultViewController: BaseViewController {

    var state:Enum_Result?
    override func viewDidLoad() {
        super.viewDidLoad()

        addBackItem()
        switch state {
        case .intermediate?:
            self.title = "还款确认中"
        case .failure?:
            self.title = "还款失败"
        case .success?:
            self.title = "还款成功"
        default:
            break
        }

        resultView()
        // Do any additional setup after loading the view.
    }

    fileprivate func resultView(){
        
        var imageStr = ""
        var tipStr = ""
        switch state {
        case .intermediate?:
            imageStr = "success"
            tipStr = "还款结果确认中"
        case .failure?:
            imageStr = "fail"
            tipStr = "还款失败"
        case .success?:
            imageStr = "success"
            tipStr = "还款成功"
        default:
            break
        }
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: imageStr)
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(110)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        let tipLabel = UILabel()
        tipLabel.textColor = RedPacketBottomBtn_COLOR
        tipLabel.text = tipStr
        tipLabel.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(45)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        let backBtn = UIButton()
        backBtn.setTitle("返回", for: .normal)
        backBtn.setTitleColor(UIColor.white, for: .normal)
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        backBtn.setBackgroundImage(UIImage.init(named: "applayBtnImage"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.view.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(30)
            make.top.equalTo(self.view).offset(340)
            make.right.equalTo(self.view).offset(-30)
            make.height.equalTo(45)
        }
    }
    
    @objc fileprivate func backBtnClick(){
        
        self.navigationController?.popViewController(animated: true)
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
