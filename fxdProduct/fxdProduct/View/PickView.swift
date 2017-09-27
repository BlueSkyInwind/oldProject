//
//  PickView.swift
//  fxdProduct
//
//  Created by sxp on 2017/9/22.
//  Copyright © 2017年 dd. All rights reserved.
//

import UIKit


@objc protocol PickViewDelegate: NSObjectProtocol {
    
    func cancelBtn()
    func sureBtn(_ capitalListModel: CapitalListModel)->Void
    
}

class PickView: UIView ,UIPickerViewDelegate,UIPickerViewDataSource{
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var dataArray  = [AnyObject]()
    var model : CapitalListModel?
    weak var delegate: PickViewDelegate?
    var selectRow : NSInteger?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        selectRow = 0
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PickView{
    
    fileprivate func setupUI(){
        
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
    
    override var  frame:(CGRect){
        didSet{

            
            let newFrame = CGRect(x:0,y:0,width:_k_w,height:_k_h)

            super.frame = newFrame
        }
    }
}

extension PickView{
    
    @objc fileprivate func cancelBtnClick(){
        
        if delegate != nil {
            delegate?.cancelBtn()
        }
    }
    
    @objc fileprivate func sureBtnClick(){
        
        if delegate != nil {
            if model == nil
            {

                model = dataArray[0] as? CapitalListModel

            }
            delegate?.sureBtn(model!)
        }
    }
}

extension PickView{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (dataArray.count)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let model = dataArray[row] as? CapitalListModel
        return model?.platformName
    
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 37
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
          model = dataArray[row] as? CapitalListModel
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
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        let model = dataArray[row] as? CapitalListModel
        let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:(model?.platformName)!)
        attrstr.addAttribute(NSForegroundColorAttributeName, value: QUTOA_COLOR, range: NSMakeRange(0,attrstr.length))
        attrstr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(0, attrstr.length))
        if row == selectRow{
            attrstr.addAttribute(NSForegroundColorAttributeName, value: UI_MAIN_COLOR, range: NSMakeRange(0,attrstr.length))
            attrstr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 23), range: NSMakeRange(0, attrstr.length))
        }
        
        return attrstr

    }
}
