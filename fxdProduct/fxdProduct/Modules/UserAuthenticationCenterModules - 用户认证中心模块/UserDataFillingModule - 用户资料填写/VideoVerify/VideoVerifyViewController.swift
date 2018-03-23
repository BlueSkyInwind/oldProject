//
//  VideoVerifyViewController.swift
//  ShortVideoRecording
//
//  Created by admin on 2017/12/6.
//  Copyright © 2017年 WangYongxin. All rights reserved.
//

import UIKit
import AVFoundation

class VideoVerifyViewController: UIViewController {
    
    let RecordsTimeMax = 6   //录制最大时间
    let RecordsTimeMin = 0  //录制最小时间
    var keepTime:Int = 0
    var isVideoRecording:Bool = false
    
    var recordView:YXRecordView?
    var recordManager:YXMoviesRecordManager?
    var previewLayer:AVCaptureVideoPreviewLayer?
    var player:YXAVPlayer?
    @objc var displaystr:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        recordManager = YXMoviesRecordManager.init()

        //MARK:视图逻辑
        recordView = YXRecordView.init(frame: UIScreen.main.bounds)
        recordView?.displayContent = displaystr!
        self.view.insertSubview(recordView!, at: 0)

        let backBtn = UIButton.init(type: UIButtonType.custom)
        backBtn.frame = CGRect.init(x: 20, y:40, width: 40, height: 40)
        backBtn.setImage(UIImage.init(named: "return_white"), for: UIControlState.normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(backBtn)
        
        //点击录制
        recordView?.recordButtonClick = {[weak self] in
            self?.recordManager?.startRecordingToOutputFileURL()
        }
        //点击离开时 停止录制
        recordView?.stopRecordButtonClick = {[weak self] in
            self?.stopOutputRecording()
        }
        //重新录制
        recordView?.afreshButtonClick = {
            self.player?.isHidden = true
            self.player?.stopPlaye()
            self.recordView?.startRecordingAnimation()
            self.recordManager?.startRecordingToOutputFileURL()
        }
        //上传录制信息
        recordView?.ensureButtonClick = {
            if self.isVideoRecording {
                self.stopOutputRecording()
                return
            }
            
            print("开始上传")
            let base64Str = self.convertBasr64()
            self.uploadVideo(content: base64Str, finish: { (isSuccess) in
                
            })
        }
        
        //点击播放视频
        recordView?.playButtonClick = {
            self.player?.replacePlaybackResources()
            self.player?.startPlay()
        }
        
        //MARK:视频录制
        if (recordManager?.configureSession())!{
            previewLayer = AVCaptureVideoPreviewLayer.init(session: (self.recordManager?.captureSession)!)
            previewLayer?.frame = UIScreen.main.bounds
            previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.recordManager?.videoConnection?.videoOrientation = (previewLayer?.connection?.videoOrientation)!
            recordView?.layer.insertSublayer(previewLayer!, at: 0)
            self.recordManager?.startSession()
        }
        
        //MARK:开始写入录制
        recordManager?.startRecordConnections = {[weak self](captureOutput) in
            self?.keepTime = (self?.RecordsTimeMax)!;
            self?.perform(#selector(self?.onStartTranscribe(output:)), with: captureOutput, afterDelay: 0)
        }
        
        //MARK:拍摄完成是调用  结束写入录制
        recordManager?.endRecordConnecions = {[weak self](captureOutput,outputFileURL) in
            self?.endRecordChange()
            //增加录制播放预览层
            if self?.player == nil {
                self?.player = YXAVPlayer.init(frame: (UIScreen.main.bounds), bgview: (self?.recordView)!, url: outputFileURL as URL)
                self?.recordView?.bringSubview(toFront: (self?.recordView?.maskBackView)!)
                self?.recordView?.bringSubview(toFront: (self?.recordView?.playView)!)
            }else{
                self?.player?.videoURL = outputFileURL as URL
                self?.player?.isHidden = false
            }
            
            //视频的状态
            self?.player?.videoPlaycompletion = { (status) in
                switch status {
                case .playCompletion:
                     self?.recordView?.playView?.isHidden = false
                    break;
                case .isPlaying:
                    self?.recordView?.playView?.isHidden = true
                    break;
                }
            }
        }
    }
    
    @objc func backBtnClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:录制计时
    @objc func onStartTranscribe(output: AVCaptureFileOutput)  {
        if output.isKind(of:  AVCaptureMovieFileOutput.self) {
            if keepTime > 0 {
                if RecordsTimeMax - keepTime >= RecordsTimeMin {
                    isVideoRecording = true
                    self.recordView?.timeMax = Double(keepTime)
                    keepTime -= 1
                }
                self.perform(#selector(onStartTranscribe(output:)), with: output, afterDelay: 1)
            }
            else{
                //计时结束时 停止录制
                if output.isRecording{
                    stopOutputRecording()
                }
            }
        }
    }
    
    //结束录制时状态改变
    func endRecordChange()  {
//        self.recordView?.bgView?.clearProgress()
        self.recordView?.endRecordingAnimation()
    }
    
    //结束录制
    func stopOutputRecording()  {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        isVideoRecording = false
        recordManager?.stopRecordingToOutputFileURL()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:视频上传处理
    func convertBasr64() -> String {
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/abc.mp4"
        if FileManager.default.fileExists(atPath: filePath) {
            let data = NSData.init(contentsOfFile: filePath)
            let str = data?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            return str!
        }
        return ""
    }
    
    func uploadVideo(content:String,finish:(_ isSuccess:Bool) -> Void)  {
        
        FXD_AlertViewCust.sharedHHAlertView().showFXDAlertViewTitle("视频认证", content: "视频信息正在上传中,请稍后", attributeDic: nil, textAlignment: NSTextAlignment.center, cancelTitle: nil, sureTitle: nil, compleBlock: nil)
        
        let  userDataVM = UserDataViewModel.init()
        userDataVM.setBlockWithReturn({[weak self] (result) in
            let baseResult = result as? BaseResultModel
            if baseResult?.errCode == "0"{
                self?.dismiss(animated: true, completion: nil)
            }else{
                FXD_AlertViewCust.sharedHHAlertView().dismissFXDAlertView()
                FXD_AlertViewCust.sharedHHAlertView().showFXDAlertViewTitle("视频认证", content: baseResult?.friendErrMsg, attributeDic: nil, textAlignment: NSTextAlignment.center, cancelTitle: nil, sureTitle: "确认", compleBlock: { (index) in
                })
            }
        }) {
            FXD_AlertViewCust.sharedHHAlertView().dismissFXDAlertView()
        }
        userDataVM.uploadVerifyVideo(content)
    }
}

