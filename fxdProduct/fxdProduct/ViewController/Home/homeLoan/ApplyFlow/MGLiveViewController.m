//
//  MGLiveViewController.m
//  fxdProduct
//
//  Created by dd on 2017/3/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "MGLiveViewController.h"
#import "MyBottomView.h"

@interface MGLiveViewController ()

@end

@implementation MGLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = UI_MAIN_COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}

- (void)defaultSetting{
    if (self.liveManager == nil && self.self.videoManager == nil) {
        
        MGLiveActionManager *ActionManager = [MGLiveActionManager LiveActionRandom:YES
                                                                       actionArray:nil
                                                                       actionCount:3];
        MGLiveErrorManager *errorManager = [[MGLiveErrorManager alloc] initWithFaceCenter:CGPointMake(0.5, 0.4)];
        
        MGVideoManager *videoManager = [MGVideoManager videoPreset:AVCaptureSessionPreset640x480
                                                    devicePosition:AVCaptureDevicePositionFront
                                                       videoRecord:NO
                                                        videoSound:NO];
        
        MGLiveDetectionManager *liveManager = [[MGLiveDetectionManager alloc]initWithActionTime:8
                                                                                  actionManager:ActionManager
                                                                                   errorManager:errorManager];
        
        [self setLiveManager:liveManager];
        [self setVideoManager:videoManager];
    }
    [self addBackItem];
}

- (void)addBackItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    UIImage *img = [[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 45, 44);
    [btn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    //    修改距离,距离边缘的
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    
    self.navigationItem.leftBarButtonItems = @[spaceItem,item];
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
}

- (void)popBack
{
    [self dismissViewControllerAnimated:true completion:nil];
}

//创建界面
-(void)creatView{
    self.title = @"活体检测";
    
    self.headerView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.headerView setImage:[MGLiveBundle LiveImageWithName:@"header_bg_img"]];
    [self.headerView setContentMode:UIViewContentModeScaleAspectFill];
    [self.headerView setFrame:CGRectMake(0, self.topViewHeight, MG_WIN_WIDTH, MG_WIN_WIDTH)];
    
    self.bottomView = [[MyBottomView alloc] initWithFrame:CGRectMake(0, MG_WIN_WIDTH+self.topViewHeight, MG_WIN_WIDTH, MG_WIN_HEIGHT-MG_WIN_WIDTH-self.topViewHeight)
                                         andCountDownType:MGCountDownTypeRing];
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.bottomView];
}

//活体检测结束处理
- (void)liveDetectionFinish:(MGLivenessDetectionFailedType)type checkOK:(BOOL)check liveDetectionType:(MGLiveDetectionType)detectionType{
    [super liveDetectionFinish:type checkOK:check liveDetectionType:detectionType];
    
    if (check == YES) {
        FaceIDData *faceData = [self.liveManager getFaceIDData];
        [self.delagate liveDateSuccess:faceData];
        [self dismissViewControllerAnimated:true completion:nil];
//        [finishVC setFaceData: faceData];
    }else {
        [self dismissViewControllerAnimated:true completion:nil];
        [self.delagate liveDateFaile:type];
    }
    
//    [self.navigationController pushViewController:finishVC animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
