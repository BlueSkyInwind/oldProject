//
//  RecordManager.m
//  RecordDemo
//
//  Created by zy on 16/1/15.
//  Copyright © 2016年 zy. All rights reserved.
//

#import "RecordManager.h"
#import "lame.h"
@implementation RecordManager
-(id)init
{
    if(self=[super init])
    {
        [self setGet];
    }
    return self;
}
-(void)setGet
{

}
+(RecordManager *)shareRecordManager
{
    static RecordManager *shareRecord=nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        shareRecord=[[self alloc]init];
    });
    return shareRecord;
}
#pragma mark 录音
- (void)ReadyRecord
{
    //创建录音文件，准备录音
    [self audio];
    if ([recorder prepareToRecord]) {
        //开始
        [recorder record];
        
    }
    timeCount=0;
    //设置定时检测
    voiceTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
}
- (void)FinishRecord
{
    [voiceTimer invalidate];
    cTime = recorder.currentTime;
    if (cTime>=1) {//如果录制时间<1 不发送
        VoiceTime=[NSString stringWithFormat:@"%d",cTime];
        [self audio_PCMtoMP3];
        [self.delegate RecordSuccess:cTime];
        NSLog(@"发出去");
    }else {
        //删除记录的文件
        [recorder deleteRecording];
        [self.delegate RecordFail];
        //删除存储的
    }
    [recorder stop];
}
- (void)cancelRecord
{
    //删除录制文件
    [recorder deleteRecording];
    [recorder stop];
    [voiceTimer invalidate];
    [self.delegate RecordFail];
    NSLog(@"取消录制");
}
- (void)audio
{
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init] ;
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];

    strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    self.urlPlay= [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/temporary",strUrl]];
    
    NSError *error;
    //初始化
    recorder = [[AVAudioRecorder alloc]initWithURL:self.urlPlay settings:recordSetting error:&error];
    //开启音量检测
        recorder.meteringEnabled = YES;
        recorder.delegate = self;
    AVAudioSession * session = [AVAudioSession sharedInstance];
    NSError * sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
}
-(void)recordPlay//播放录音
{
    timeCount=0;
    
    if (self.avPlay.playing) {
        [self.avPlay stop];
        return;
    }
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:self.urlPlay error:nil];
    //设置从扬声器播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    self.avPlay = player;
    self.avPlay.delegate = self;
    [self.avPlay play];
    playCount=cTime;
}
//检测音量
- (void)detectionVoice
{
    [recorder updateMeters];//刷新音量数据
    //获取音量的平均值  [recorder averagePowerForChannel:0];
    //音量的最大值  [recorder peakPowerForChannel:0];
         double lowPassResults = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
        [self.delegate VoiceDelegate:lowPassResults];
}
/** 转换mp3  */
- (void)audio_PCMtoMP3
{
    NSString *cafFilePath = [NSString stringWithFormat:@"%@/temporary",strUrl];//caf文件路径
    
    self.mp3FilePath = [NSString stringWithFormat:@"%@/voice.mp3",strUrl];//存储mp3文件的路径
    
    
    NSLog(@"%@ %@",cafFilePath,self.mp3FilePath);
    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        
        if(pcm == NULL)
            
        {
            NSLog(@"file not found");
        }
        
        else
            
        {
            
            fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
            
            FILE *mp3 = fopen([self.mp3FilePath cStringUsingEncoding:1],"wb");  //output 输出生成的Mp3文件位置
            
            
            
            const int PCM_SIZE = 8192;
            
            const int MP3_SIZE = 8192;
            
            short int pcm_buffer[PCM_SIZE*2];
            
            unsigned char mp3_buffer[MP3_SIZE];
            
            
            
            lame_t lame = lame_init();
            
            lame_set_num_channels(lame,1);//设置1为单通道，默认为2双通道
            
            lame_set_in_samplerate(lame, 8000.0);//11025.0
            
            //lame_set_VBR(lame, vbr_default);
            
            lame_set_brate(lame,8);
            
            lame_set_mode(lame,3);
            
            lame_set_quality(lame,2); /* 2=high 5 = medium 7=low 音质*/
            
            lame_init_params(lame);
            
            
            
            do {
                read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
                
                if (read == 0)
                    
                    write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
                
                else
                    
                    write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
                
                
                
                fwrite(mp3_buffer, write, 1, mp3);
                
            } while (read != 0);
            
            
            
            lame_close(lame);
            
            fclose(mp3);
            
            fclose(pcm);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        NSLog(@"执行完成");
      self.urlPlay=[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@",self.mp3FilePath]];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"flag = %d",flag);
    [self.delegate RecordSuccess];
}
@end
