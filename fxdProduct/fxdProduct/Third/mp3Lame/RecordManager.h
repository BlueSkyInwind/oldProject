//
//  RecordManager.h
//  RecordDemo
//
//  Created by zy on 16/1/15.
//  Copyright © 2016年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@protocol VoiceDelegate
-(void)VoiceDelegate:(double)lowPassResults;//检测麦克风
-(void)RecordSuccess:(int)time;//录音成功
-(void)RecordFail;//录音失败
-(void)RecordSuccess;

@end
@interface RecordManager : NSObject<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    AVAudioRecorder *recorder;
    int  timeCount;
    int  playCount;
    NSString* VoiceTime;
    int cTime;
    
    NSString *strUrl;//录音路径
    
    NSTimer *voiceTimer;
    NSTimer *playTimer;
    
    
    double lowPassResults;
  
}
@property (retain, nonatomic) AVAudioPlayer *avPlay;//播放器
@property (nonatomic,strong) NSURL *urlPlay;//路径地址
@property (nonatomic,strong) NSString *mp3FilePath;//mp3路径
@property id<VoiceDelegate>delegate;

+(RecordManager *)shareRecordManager;
- (void)ReadyRecord;
- (void)FinishRecord;
- (void)cancelRecord;
- (void)audio;
-(void)recordPlay;//播放录音
@end
