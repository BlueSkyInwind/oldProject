//
//  YXRecordView.swift
//  ShortVideoRecording
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 WangYongxin. All rights reserved.
//

import UIKit

typealias RecordButtonClick = () -> Void
typealias StopRecordButtonClick = () -> Void
typealias AfreshButtonClick = () -> Void
typealias EnsureButtonClick = () -> Void
typealias PlayButtonClick = () -> Void
typealias BackButtonClick = () -> Void


let Click_CenterPoint = CGPoint.init(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height / 2 - 100)

class YXRecordView: UIView {

    var afreshBtn:UIButton?
    var ensureBtn:UIButton?
    var startRecordBtn:UIButton?
    var maskBackView:UIView?
    var timingLabel:UILabel?
    var displayLabel:UILabel?
    var playView:UIView?
    var displayContent:String{
        didSet{
            displayLabel?.text = displayContent
        }
    }

//    var centerRoundView:UIView?
//    var bgView:YXRoundProgressView?
    
    var recordButtonClick:RecordButtonClick?
    var stopRecordButtonClick:StopRecordButtonClick?
    var afreshButtonClick:AfreshButtonClick?
    var ensureButtonClick:EnsureButtonClick?
    var playButtonClick:PlayButtonClick?
    var backButtonClick:BackButtonClick?


    //最大的时间值
    var timeMax:Double{
        didSet {
            let str1 = " 录制中..."
            let str = String.init(format: "%.0lf", timeMax) + str1
            let range = (str as NSString).range(of: str1, options: NSString.CompareOptions.backwards)
            let attri = NSMutableAttributedString.init(string: str)
            attri.addAttributes([NSAttributedStringKey.foregroundColor:UIColor.red], range: NSMakeRange(range.location + 1, 6))
            self.timingLabel?.attributedText = attri
        }
    }

    override init(frame: CGRect) {
        self.timeMax = 0.0
        self.displayContent = ""
         super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8);
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == centerRoundView {
            print("开始录制")
            if recordButtonClick != nil {
                self.recordButtonClick!()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == centerRoundView {
            print("结束录制")
            if stopRecordButtonClick != nil {
                self.stopRecordButtonClick!()
            }
        }
    }
    */
    
    func isRecordingAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
//            self.bgView?.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
//            self.centerRoundView?.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        }) { (isCom) in
        }
    }
    
    func startRecordingAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.afreshBtn?.isHidden = false
            self.ensureBtn?.isHidden = false
            self.timingLabel?.isHidden = false
            self.startRecordBtn?.isHidden = true
            self.playView?.isHidden = true
            self.afreshBtn?.center = CGPoint.init(x: Click_CenterPoint.x - 100, y: Click_CenterPoint.y)
            self.ensureBtn?.center = CGPoint.init(x: Click_CenterPoint.x + 100, y: Click_CenterPoint.y)
            self.ensureBtn?.setTitle("完成录制", for: UIControlState.normal)
        }) { (isCom) in
            
        }
    }
    
    func endRecordingAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.timingLabel?.isHidden = true
            self.afreshBtn?.isHidden = false
            self.ensureBtn?.isHidden = false
            self.playView?.isHidden = false
            self.afreshBtn?.center = CGPoint.init(x: Click_CenterPoint.x - 100, y: Click_CenterPoint.y)
            self.ensureBtn?.center = CGPoint.init(x: Click_CenterPoint.x + 100, y: Click_CenterPoint.y)
            self.ensureBtn?.setTitle("确认提交", for: UIControlState.normal)
        }) { (isCom) in
            
        }
    }
    
    func addRecordView()  {

        
    }
    
    @objc func startRecordBtnClick() {
        if recordButtonClick != nil {
            startRecordingAnimation()
            self.recordButtonClick!()
        }
    }
    
    @objc func afreshBtnClick() {
        if (afreshButtonClick != nil) {
            afreshButtonClick!()
        }
    }
    
    @objc func ensureBtnClick() {
        if  (ensureButtonClick != nil){
            ensureButtonClick!()
        }
    }
    
    @objc func playBtnClick() {
        if  (playButtonClick != nil){
            playButtonClick!()
        }
    }
    

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
}

extension YXRecordView {
    
    func setUpUI()  {
        
        maskBackView = UIView.init(frame: CGRect.init(x: 0, y: _k_h / 2, width: _k_w, height: _k_h / 2))
        maskBackView?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.addSubview(maskBackView!)

        afreshBtn = UIButton.init(type: UIButtonType.custom)
        afreshBtn?.frame = CGRect.init(x: 0, y: 0, width: 100, height: 40)
        afreshBtn?.backgroundColor = UIColor.white
        afreshBtn?.center = Click_CenterPoint
        FXD_Tool.setCorner(afreshBtn, borderColor: UIColor.clear)
        afreshBtn?.setTitle("重新录制", for: UIControlState.normal)
        afreshBtn?.setTitleColor(UIColor.black, for: UIControlState.normal)
        afreshBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        afreshBtn?.isHidden = true
        afreshBtn?.addTarget(self, action: #selector(afreshBtnClick), for: UIControlEvents.touchUpInside)
        maskBackView?.addSubview(afreshBtn!)
        
        ensureBtn = UIButton.init(type: UIButtonType.custom)
        ensureBtn?.frame = CGRect.init(x: 0, y: 0, width: 100, height: 40)
        ensureBtn?.center = Click_CenterPoint
        ensureBtn?.backgroundColor = UI_MAIN_COLOR
        FXD_Tool.setCorner(ensureBtn, borderColor: UIColor.clear)
        ensureBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        ensureBtn?.isHidden = true
        ensureBtn?.setTitle("完成录制", for: UIControlState.normal)
        ensureBtn?.addTarget(self, action: #selector(ensureBtnClick), for: UIControlEvents.touchUpInside)
        maskBackView?.addSubview(ensureBtn!)
    
        startRecordBtn = UIButton.init(type: UIButtonType.custom)
        startRecordBtn?.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        startRecordBtn?.center = Click_CenterPoint
        startRecordBtn?.setBackgroundImage(UIImage.init(named: "recordBtn_Icon"), for: UIControlState.normal)
        startRecordBtn?.setTitle("开始录制", for: UIControlState.normal)
        startRecordBtn?.setTitleColor(UIColor.white, for: UIControlState.normal)
        startRecordBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        startRecordBtn?.addTarget(self, action: #selector(startRecordBtnClick), for: UIControlEvents.touchUpInside)
        maskBackView?.addSubview(startRecordBtn!)
    
        timingLabel = UILabel()
        timingLabel?.font = UIFont.yx_systemFont(ofSize: 15)
        timingLabel?.isHidden = true
        timingLabel?.textColor = UIColor.white
        maskBackView?.addSubview(timingLabel!)
        timingLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo((startRecordBtn?.snp.top)!).offset(-40)
            make.centerX.equalTo((maskBackView?.snp.centerX)!)
        })
        
        let promptLabel = UILabel()
        promptLabel.font = UIFont.yx_systemFont(ofSize: 15)
        promptLabel.text = "请将正脸至于拍摄框内，并阅读下方文字"
        promptLabel.textColor = UI_MAIN_COLOR
        maskBackView?.addSubview(promptLabel)
        promptLabel.snp.makeConstraints({ (make) in
            make.top.equalTo((maskBackView?.snp.top)!).offset(15)
            make.centerX.equalTo((maskBackView?.snp.centerX)!)
        })
        
        let dispalyView = UIView()
        dispalyView.backgroundColor = UIColor.white
        maskBackView?.addSubview(dispalyView)
        dispalyView.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(promptLabel.snp.bottom).offset(15)
            make.height.equalTo(90)
        })
        
        displayLabel = UILabel()
        displayLabel?.font = UIFont.systemFont(ofSize: 16)
        displayLabel?.textColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
        displayLabel?.text = "身份证号345678093456879097，自愿借款并承诺及时还款。"
        displayLabel?.numberOfLines = 0
        dispalyView.addSubview(displayLabel!)
        displayLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(dispalyView.snp.left).offset(13)
            make.right.equalTo(dispalyView.snp.right).offset(-13)
            make.top.equalTo(dispalyView.snp.top).offset(0)
            make.bottom.equalTo(dispalyView.snp.bottom).offset(0)
        })
        
        //MARK: 视频播放
        playView = UIView()
        playView?.isHidden = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(playBtnClick))
        playView?.addGestureRecognizer(tap)
        self.addSubview(playView!)
        playView?.snp.makeConstraints({ (make) in
            make.bottom.equalTo((maskBackView?.snp.top)!).offset(-_k_h / 4)
            make.centerX.equalTo((maskBackView?.snp.centerX)!)
            make.width.height.equalTo(80)
        })
        
        let palyImage = UIImageView()
        palyImage.isUserInteractionEnabled = true
        palyImage.image = UIImage.init(named: "playBtn_Icon")
        playView?.addSubview(palyImage)
        palyImage.snp.makeConstraints { (make) in
            make.centerX.equalTo((playView?.snp.centerX)!)
            make.top.equalTo((playView?.snp.top)!).offset(3)
            make.width.height.equalTo(50)
        }
        
        let playPromptLabel = UILabel()
        playPromptLabel.font = UIFont.yx_systemFont(ofSize: 14)
        playPromptLabel.isUserInteractionEnabled = true
        playPromptLabel.text = "再看一遍"
        playPromptLabel.textColor = UIColor.white
        playView?.addSubview(playPromptLabel)
        playPromptLabel.snp.makeConstraints({ (make) in
            make.centerX.equalTo((playView?.snp.centerX)!)
            make.bottom.equalTo((playView?.snp.bottom)!).offset(-3)
        })
    }
}



