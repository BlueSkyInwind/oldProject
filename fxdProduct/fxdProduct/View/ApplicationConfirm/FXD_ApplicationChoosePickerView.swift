//
//  FXD_ApplicationChoosePickerView.swift
//  fxdProduct
//
//  Created by admin on 2017/12/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit

@objc protocol ApplicationChoosePickViewDelegate: NSObjectProtocol {
    
    //取消按钮的代理方法
    func chooseCancelBtn()
    //确认按钮的代理方法
    func chooseSureBtn(_ content: String , row:NSInteger)->Void
    
}
class FXD_ApplicationChoosePickerView: UIView ,UIPickerViewDelegate,UIPickerViewDataSource{

    var dataArray = [String]()
    weak var delegate: ApplicationChoosePickViewDelegate?
    var selectRow : NSInteger?
    var VC:UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        selectRow = 0
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func cancelBtnClick() {
        if self.delegate != nil {
            self.delegate?.chooseCancelBtn()
            dismiss()
        }
    }
    
    @objc func sureBtnClick() {
        if self.delegate != nil {
            let content = dataArray[selectRow!]
            self.delegate?.chooseSureBtn(content ,row: selectRow!)
            dismiss()
        }
    }
    
    convenience init (vc:UIViewController,dataArr:[String]) {
        self.init(frame: CGRect.init(x: 0, y: _k_h, width: _k_w, height: 200))
        VC = vc
        dataArray = dataArr 
    }
    
    //MARK: 弹窗动画
    @objc func show()  {
        VC?.view.addSubview(self)
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.frame = CGRect.init(x: 0, y: _k_h - 200, width: _k_w, height: 200)
        }) { (complication) in
            
        }
    }
    
    @objc  func dismiss()  {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.frame = CGRect.init(x: 0, y: _k_h, width: _k_w, height: 200)
        }) { (complication) in
            self.removeFromSuperview()
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

extension  FXD_ApplicationChoosePickerView {
    
    func setUpUI()  {
        let btnView = UIView()
        btnView.backgroundColor = LINE_COLOR
        self.addSubview(btnView)
        btnView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-185)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(40)
        }
        
        let cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UI_MAIN_COLOR, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        btnView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(btnView.snp.left).offset(23)
            make.centerY.equalTo(btnView.snp.centerY)
            make.height.equalTo(40)
        }
        
        let sureBtn = UIButton()
        sureBtn.setTitle("确认", for: .normal)
        sureBtn.setTitleColor(UI_MAIN_COLOR, for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        btnView.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { (make) in
            make.right.equalTo(btnView.snp.right).offset(-23)
            make.centerY.equalTo(btnView.snp.centerY)
            make.height.equalTo(40)
        }
        
        
        let pickView = UIPickerView()
        pickView.delegate = self
        pickView.dataSource = self
        pickView.backgroundColor = UIColor.white
        self.addSubview(pickView)
        pickView.snp.makeConstraints { (make) in
            make.top.equalTo(btnView.snp.bottom).offset(0)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(185)
        }
    }
}

//UIPickerView代理方法
extension FXD_ApplicationChoosePickerView{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (dataArray.count)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let contentStr = dataArray[row] as? String
        return contentStr
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 37
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let contentStr = dataArray[row] as? String
        selectRow = row
        pickerView.reloadAllComponents()
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel
        if (pickerLabel == nil){
            pickerLabel = UILabel()
            pickerLabel?.adjustsFontSizeToFitWidth = true
            pickerLabel?.textAlignment = .center
            pickerLabel?.backgroundColor = UIColor.clear
        }
        pickerLabel?.attributedText = self.pickerView(pickerView, attributedTitleForRow: row, forComponent: component)
        return pickerLabel!
    }
    
    //自定义选中的字体样式和颜色
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let content = dataArray[row]
        let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:content)
        attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: QUTOA_COLOR, range: NSMakeRange(0,attrstr.length))
        attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(0, attrstr.length))
        if row == selectRow{
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(0,attrstr.length))
            attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 23), range: NSMakeRange(0, attrstr.length))
        }
        return attrstr
    }
}

