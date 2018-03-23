//
//  YXAVPlayer.swift
//  ShortVideoRecording
//
//  Created by admin on 2017/12/19.
//  Copyright © 2017年 WangYongxin. All rights reserved.
//

import UIKit
import AVFoundation

enum VideoPlayStatus {
    case isPlaying
    case playCompletion
}

typealias VideoPlaycompletion = (_ status:VideoPlayStatus) -> Void


class YXAVPlayer: UIView {

    var videoPlaycompletion:VideoPlaycompletion?
    var videoPlayStatus:VideoPlayStatus = .playCompletion

    var videoURL:URL?{
        didSet{
            self.replacePlaybackResources()
        }
    }
        
    lazy var player:AVPlayer = {
        let player = AVPlayer.init(playerItem: AVPlayerItem.init(url: videoURL!))
        return player
    }()
    
    var playerLayer:AVPlayerLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame:CGRect,bgview:UIView,url:URL){
        self.init(frame: frame)
        self.videoURL = url
        playerLayer = AVPlayerLayer.init(player: self.player)
        playerLayer?.frame = frame
        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill;
        self.layer.addSublayer(playerLayer!)
//        self.replacePlaybackResources()
        bgview.addSubview(self)
    }

    //MARK:取消上次的播放源
   @objc func replacePlaybackResources() {
        self.removeAvPlayerNtf()
        nextPlayer()
    }
    
    func nextPlayer()  {
        self.player.replaceCurrentItem(with: AVPlayerItem.init(url: videoURL!))
        self.addAVPlayerNtf(playerItem: self.player.currentItem!)
    }
    
    func startPlay()  {
        if self.player.rate == 0 {
            self.player.play()
            if videoPlaycompletion != nil{
                videoPlaycompletion!(.isPlaying)
            }
        }
    }
    
    func stopPlaye()  {
        self.player.pause()
        self.player.rate = 0
//        if self.player.rate == 1{
//            self.player.pause()
//        }
    }
    
    func addAVPlayerNtf(playerItem:AVPlayerItem)  {
        
        NotificationCenter.default.addObserver(self, selector: #selector(playbackFinished), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player.currentItem)
    }
    
    @objc func playbackFinished(ntf:Notification){
        if videoPlaycompletion != nil{
            videoPlaycompletion!(.playCompletion)
        }
        self.player.seek(to: CMTime.init(value: 0, timescale: 1))
//        self.player.play()
    }
    
    func removeAvPlayerNtf()  {
        NotificationCenter.default.removeObserver(self)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
