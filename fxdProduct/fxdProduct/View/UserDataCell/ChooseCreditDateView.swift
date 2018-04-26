//
//  ChooseCreditDateView.swift
//  fxdProduct
//
//  Created by admin on 2018/4/26.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

typealias SureChooseDate = (_ chooseStr:String) -> Void
typealias CancelChooseDate = () -> Void

let view_Height:CGFloat = 300

class ChooseCreditDateView: UIView,UIPickerViewDataSource,UIPickerViewDelegate {

    var yearPickerView:UIPickerView?
    var mounthPickerView:UIPickerView?
    var displayChooseView:UILabel?
    var sureBtn:UIButton?
    var cancelBtn:UIButton?
    var yearArr:[String]?
    let mounthsArr = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    @objc var sureChooseDate:SureChooseDate?
    @objc var cancelChooseDate:CancelChooseDate?
    var superV:UIView?
    var yearSelectRow : NSInteger?
    var mounthSelectRow : NSInteger?
    var chooseResultStr:String?{
        didSet {
            displayChooseView?.text = chooseResultStr
        }
    }
    var backView:UIView?
    
   @objc convenience init(_ superView:UIView){
        self.init(frame: CGRect.init(x: 0, y: _k_h, width: _k_w, height: view_Height))
        self.superV = superView
        generateYearArr()
        yearSelectRow = 0
        mounthSelectRow = 0
        chooseResultStr = "\(yearArr![0])年\(mounthsArr[0])月"
        displayChooseView?.text = chooseResultStr
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor =  UIColor.white
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func sureBtnClick(){
        if sureChooseDate != nil {
            sureChooseDate!(chooseResultStr!)
        }
    }
    
    @objc func cancelBtnClick() {
        if cancelChooseDate != nil {
            cancelChooseDate!()
        }
    }
    
    @objc func show() {
        backView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: _k_w, height: _k_h))
        backView?.backgroundColor = UIColor.black
        backView?.alpha = 0
        superV?.addSubview(backView!)
        superV?.addSubview(self)
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = CGRect.init(x: 0, y: _k_h - view_Height, width: _k_w, height: view_Height)
            self.backView?.alpha = 0.8
        }, completion: nil)
    }
    
    @objc func dismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = CGRect.init(x: 0, y: _k_h , width: _k_w, height: view_Height)
            self.backView?.alpha = 0
        }) { (status) in
            self.backView?.removeFromSuperview()
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
    
    func generateYearArr()  {
       let nowDate = Date()
       let formatter = DateFormatter.init()
       formatter.dateFormat  = "yyyy"
        let startYearNum = Int(formatter.string(from: nowDate))
        yearArr = ["\(startYearNum ?? 1999)"]
        let endYearNum = startYearNum! + 50
        let yearSet = (startYearNum! + 1)...endYearNum
        for i in yearSet {
            yearArr?.append("\(i)")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 37
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var num:Int = 1
        if pickerView == yearPickerView  {
            num = (yearArr?.count)!
        }else{
            num = mounthsArr.count
        }
        return num
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
        var content = mounthsArr[row]
        if pickerView == yearPickerView  {
            content = (yearArr?[row])!
        }
        let attrstr : NSMutableAttributedString = NSMutableAttributedString(string:content)
        attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: "808080".uiColor(), range: NSMakeRange(0,attrstr.length))
        attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(0, attrstr.length))
        if row == yearSelectRow  && pickerView == yearPickerView{
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(0,attrstr.length))
            attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 17), range: NSMakeRange(0, attrstr.length))
        }
        if row == mounthSelectRow  && pickerView == mounthPickerView{
            attrstr.addAttribute(NSAttributedStringKey.foregroundColor, value: UI_MAIN_COLOR, range: NSMakeRange(0,attrstr.length))
            attrstr.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 17), range: NSMakeRange(0, attrstr.length))
        }
        return attrstr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var year:String?
        var mounth:String?
        if pickerView == yearPickerView  {
            yearSelectRow = row
        }else{
            mounthSelectRow = row
        }
        year = yearArr?[yearSelectRow!]
        mounth = mounthsArr[mounthSelectRow!]
        chooseResultStr = "\(year ?? "")年\(mounth ?? "")月"
        pickerView.reloadAllComponents()

    }
}

extension ChooseCreditDateView {
    
    func setUpUI()  {
        
        displayChooseView = UILabel.init()
        displayChooseView?.backgroundColor = "E6E6E6".uiColor()
        displayChooseView?.textColor = UIColor.black
        displayChooseView?.textAlignment = NSTextAlignment.center
        displayChooseView?.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(displayChooseView!);
        displayChooseView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.height.equalTo(45)
        })
        
        let view = UIView.init()
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(self.snp.bottom).offset(-28)
            make.height.equalTo(40)
        }
        
        sureBtn = UIButton.init(type: UIButtonType.custom)
        sureBtn?.setTitle("确定", for: UIControlState.normal)
        sureBtn?.setTitleColor(UIColor.white, for: UIControlState.normal)
        sureBtn?.setBackgroundImage(UIImage.init(named: "sureChoose_Icon_Image"), for: UIControlState.normal)
        sureBtn?.addTarget(self, action: #selector(sureBtnClick), for: UIControlEvents.touchUpInside)
        view.addSubview(sureBtn!)
        sureBtn?.snp.makeConstraints({ (make) in
             make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(_k_w * 3 / 4)
        })
        
        cancelBtn = UIButton.init(type: UIButtonType.custom)
        cancelBtn?.setTitle("取消", for: UIControlState.normal)
        cancelBtn?.setBackgroundImage(UIImage.init(named: "cancelChoose_Icon_Image"), for: UIControlState.normal)
        cancelBtn?.setTitleColor(UI_MAIN_COLOR, for: UIControlState.normal)
        cancelBtn?.addTarget(self, action: #selector(cancelBtnClick), for: UIControlEvents.touchUpInside)
        view.addSubview(cancelBtn!)
        cancelBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(_k_w  / 4)
        })
        
        yearPickerView = UIPickerView.init()
        yearPickerView?.delegate = self
        yearPickerView?.dataSource = self
        yearPickerView?.backgroundColor = UIColor.white
        self.addSubview(yearPickerView!)
        yearPickerView?.snp.makeConstraints({ (make) in
            make.top.equalTo((displayChooseView?.snp.bottom)!).offset(5)
            make.left.equalTo(self.snp.left).offset(0)
            make.width.equalTo(_k_w / 2)
            make.height.equalTo(160)
        })
        
        mounthPickerView = UIPickerView.init()
        mounthPickerView?.delegate = self
        mounthPickerView?.dataSource = self
        mounthPickerView?.backgroundColor = UIColor.white
        self.addSubview(mounthPickerView!)
        mounthPickerView?.snp.makeConstraints({ (make) in
            make.top.equalTo((displayChooseView?.snp.bottom)!).offset(5)
            make.right.equalTo(self.snp.right).offset(0)
            make.width.equalTo(_k_w / 2)
            make.height.equalTo(160)
        })
    }
    
}


