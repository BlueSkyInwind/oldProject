//
//  WriteInfoViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/20.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "WriteInfoViewController.h"
#import "LabelCell.h"
#import "BtnCell.h"
#import "TelSecoryCell.h"
#import "ApproveCell.h"
#import "ColledgeView.h"
#import "telphoneView.h"
#import "HomeDailViewController.h"
#import "CheckViewController.h"
#import "ContactList.h"
#import "ReturnMsgBaseClass.h"
#import "TelPhoneCompanyCell.h"
#import "testView.h"
#import "NSString+Validate.h"
#import "ContactViewController.h"
#import "CustomerCareerBaseClass.h"
#import "CustomerBaseInfoBaseClass.h"
#import "RegionBaseClass.h"
#import "ProductListBaseClass.h"
#import "LivenessBaseClass.h"
#import "ReturnMsgBaseClass.h"
#import "RegionCodeBaseClass.h"
#import "GetCareerInfoViewModel.h"
#import "GetCustomerBaseViewModel.h"
#import "SaveCustomerCarrerViewModel.h"
#import "SaveCustomBaseViewModel.h"
#import "testView.h"
#import "LunchViewController.h"
#import "LewPopupViewController.h"
#import "PhotoDetailViewController.h"
#import "GTMBase64.h"
#import "MoxieSDK.h"
#import "UserDefaulInfo.h"
#import "LoanSureFirstViewController.h"
#import "CareerParse.h"


#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2
#define UI_MAIN_COLOR rgb(0, 170, 238)
#define redColor rgb(252, 0, 6)



@interface WriteInfoViewController ()<UITableViewDataSource,UITableViewDelegate,
UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,
ColledgeViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ContactViewControllerDelegate>
{
    ReturnMsgBaseClass *_saveFaceParse;
    
    RegionCodeBaseClass *_regionCodeParse;
    RegionCodeResult *_cityCode;
    RegionCodeResult *_city1Code;
    ReturnMsgBaseClass *_returnPare;
    ReturnMsgBaseClass *_mobileParse;
    
    CustomerCareerBaseClass *_carrerInfoModel;
    CustomerBaseInfoBaseClass *_customerBaseInfoModel;
    CustomerBaseInfoExt *_TelPhoneExt;
    RegionBaseClass *_reginBase;
    RegionSub *_regionSub;
    RegionResult *_regionResult;
    ProductListResult *_proResult;
    
    testView *_alertView;
    NSArray *eduLevelArray;//学历数组
    //存储数据
    NSMutableArray *dataListAll;
    NSMutableArray *dataListAll1;
    NSMutableArray *dataListAll2;
    NSMutableArray *dataListAll3;
    NSMutableArray *dataColor;
    NSMutableArray *datacolor1;
    NSMutableArray *datacolor3;
    //描述提示文字
    NSArray *placeArray;
    NSArray *placeArray00;
    NSArray *placeArray1;
    NSArray *placeArray3;
    //判断用那一套文字
    NSInteger flagPlace;
    //存储图片
    NSArray *_titleArray;
    NSArray *_imageArray;
    //判断下一步能否可用
    BOOL _selectBtn1;
    BOOL _selectBtn3;
    
    //picview数据存储
    NSDictionary *_dict;
    NSMutableArray *_pickerArray;
    NSMutableArray *_subPickerArray;
    NSMutableArray *_thirdPickerArray;
    NSArray *_selectArray;
    NSInteger _pickerTag;
    NSArray *_contact1;
    NSArray *_contact2;
    NSArray *_professionArray;//行业职业
    //学历
    //    NSArray *_schoolArray;
    ColledgeView *_colledgeView;
    
    //颜色
    UIColor *_color;
    NSString *_imageString;
    //手机验证码
    UIView *viewSecory1;
    UIView *jindongSecory;
    //跑马灯view
    UIView *viewLableBg;
    UIView *vMarqueeContainer;
    UILabel *lblContent;
    //    UIView *viewMarqueeContainer;
    //认证token
    NSString *_certificationToken;
    
    //认证返回码
    NSInteger _certificationCode;
    NSString *_cerWebsite;
    
    //京东认证
    NSInteger _jingdongCode;
    
    CaydType _photoType;
    
    /**
     *  @author dd
     *
     *  用户照片路径
     */
    ///身份证正面照片
    NSString *_identityPositivePath;
    ///身份证反面照片
    NSString *_identityCounterPath;
    ///手持身份证照
    NSString *_holdIdentityPhonePath;
    //多线程
    NSThread *thread;
    
    //身份认证
    LivenessBaseClass *_livenessParse;
    
    NSInteger index;
    
    UInt64 _beginTime;
    UInt64 _endTime;
    int _backCount;
    NSInteger _lastInputTag;
    
    UIImage *userIDImage;
    
    NSString *_telNum;
    
    NSDictionary *_checkMobileDic;
    
    //职业信息返回信息
    CareerParse *_careerParse;
}
//创建tableview
@property (nonatomic, strong) UITableView *tableView0;
@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) UITableView *tableView3;

//创建scrollview
@property (nonatomic, strong) UIScrollView *scrollView0;
@property (nonatomic, strong) UIScrollView *scrollView1;
@property (nonatomic, strong) UIScrollView *scrollView2;
@property (nonatomic, strong) UIScrollView *taobaoscrollview;
@property (nonatomic, strong) UIScrollView *jdongscrollview;

//手机确认按钮
@property (nonatomic, strong) UIButton *telBtn;
@property (nonatomic, strong) UIButton *taobaoBtn;
@property (nonatomic, strong) UIButton *taobaoBtnSure;
@property (nonatomic, strong) UIButton *jdongBtnSure;
@property (nonatomic, strong) UIButton *PhotoIDBtnSure;

//UIPickerView 1.loacl 所在地
@property (nonatomic, strong) UIPickerView *localPicker;
//@property (nonatomic, strong) UIPickerView *schoolPicker;

//图片照片
@property (nonatomic, strong) UIImageView *imageviewPhoto1;
@property (nonatomic, strong) UIImageView *imageviewPhoto2;
@property (nonatomic, strong) UIImageView *imageviewPhoto3;

//协议勾选
@property (nonatomic, assign) BOOL btnStatus;

@property (nonatomic, strong) UIView *viewMarqueeContainer;

@property (nonatomic, strong) testView *testViewAlert;

@property (nonatomic, strong) MoxieSDK *moxieSDK;

@end

@implementation WriteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addBackItem];
    
    self.navigationItem.title = @"资料填写";
    _beginTime = 0;
    _endTime = 0;
    _backCount = 0;
    _lastInputTag = 0;
    dataListAll = [NSMutableArray array];
    dataListAll1 = [NSMutableArray array];
    dataListAll2 = [NSMutableArray array];
    dataListAll3 = [NSMutableArray array];
    dataColor = [NSMutableArray array];
    datacolor1 = [NSMutableArray array];
    datacolor3 = [NSMutableArray array];
    _pickerArray = [NSMutableArray array];
    _subPickerArray = [NSMutableArray array];
    _thirdPickerArray = [NSMutableArray array];
    flagPlace = 1;
    
    for (int i=0; i<15; i++) {
        [dataListAll addObject:@""];
        [dataListAll1 addObject:@""];
        [dataListAll2 addObject:@""];
        //        [dataListAll3 addObject:@""];
        [dataColor addObject:UI_MAIN_COLOR];
        [datacolor1 addObject:UI_MAIN_COLOR];
        [datacolor3 addObject:UI_MAIN_COLOR];
    }
    
    index = 0;
    eduLevelArray = @[@"博士及以上",@"硕士",@"本科",@"大专",
                      @"高中",@"其他"];
    placeArray = @[@"真实姓名",@"身份证号",@"学历",@"现居地址",
                   @"居住地详址",@""];
    placeArray00 = @[@"真实姓名",@"身份证号",@"学历",@"现居地址",
                     @"居住地详址",@"联系人1",@"联系人姓名",@"联系人手机号",
                     @"联系人2",@"联系人姓名",@"联系人手机号",@""];
    placeArray1 = @[@"单位名称",@"单位电话",@"行业/职业",@"单位所在地",@"单位详址",@""];
    _contact1 = @[@"父母",@"配偶"];
    _contact2 = @[@"同事",@"朋友"];
    //    placeArray3 = @[@"信用卡",@"卡号",@"接受放款的银行卡",@"卡号",@"预留手机号",@"验证码",@""];
    placeArray3 = @[@"信用卡",@"卡号",@""];
    _titleArray = @[@"手机认证",@"证件上传"];
    _professionArray = @[@"生活/服务业",@"人力/行政/管理",@"销售/客服/采购/淘宝",
                         @"市场/媒介/广告/设计",@"生产/物流/质控/汽车",
                         @"网络/通信/电子",@"法律/教育/翻译/出版",@"财会/金融/保险",
                         @"医疗/制药/环保",@"其他"];
    //前6张是 认证部分图片 11 与12 分别是下一步的灰色与正常色
    _imageArray = @[@"4_lc_chahua_04",@"4_lc_chahua_06",@"4_lc_chahua_08",
                    @"4_lc_chahua_05",@"4_lc_chahua_07",@"4_lc_chahua_09",
                    @"9_but_01",@"9_but_02",@"9_but_03",
                    @"9_but_04",@"9_but_05",@"8_but_10",
                    @"8_but_03"];
    _imageString = _imageArray[7];
    _selectBtn1 = NO;
    _selectBtn3 = NO;
    _btnStatus = NO;
    
    if ([Utility sharedUtility].userInfo.userInfoModel.result.holdIdentityPhonePath != nil) {
        [dataListAll2 replaceObjectAtIndex:8 withObject:@"10"];
    }else{
        [dataListAll2 replaceObjectAtIndex:8 withObject:@""];
    }
    
    _certificationCode = 1;
    
    
    [self createUIWith:_segment.selectedSegmentIndex];
    
    _toolbarCancelDone.hidden = YES;
    _color = UI_MAIN_COLOR;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self loadViewa];
}



-(void)buttonClick
{
    //    [self loadViewa];
    
}
//跑马灯
- (void)loadViewa
{
    //marqueenbar背景，位置高度等控制
    if(viewLableBg)
    {
        [viewLableBg removeFromSuperview];
        //        [vMarqueeContainer removeFromSuperview];
        [_viewMarqueeContainer removeFromSuperview];
    }
    
    viewLableBg = [[UIView alloc]initWithFrame:CGRectMake(0, 64, _k_w, 50)];
    _viewMarqueeContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 18, 414-56, 20)];
    
    viewLableBg.backgroundColor = rgb(254, 247, 207);
    
    //滚动容器，显示滚动范围
    
    [_viewMarqueeContainer setBackgroundColor:[UIColor clearColor]];
    [_viewMarqueeContainer setClipsToBounds:YES];
    [_viewMarqueeContainer setOpaque:YES];
    
    //内容
    if (lblContent) {
        [lblContent removeFromSuperview];
    }
    lblContent = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 414-56,15)];
    [lblContent setText:@"请务必填写您个人真实有效信息,否则将会影响申请审核。"];
    [lblContent setTextColor:[UIColor blackColor]];
    [lblContent setBackgroundColor:[UIColor clearColor]];
    lblContent.font = [UIFont systemFontOfSize:14];
    [lblContent setOpaque:YES];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(_k_w-48, 2, 48, 50-2);
    btn.backgroundColor = rgb(254, 247, 207);
    btn.tag = 1;
    //    [btn setBackgroundImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //    vMarqueeContainer = viewMarqueeContainer;
    [self.view addSubview:viewLableBg];
    [viewLableBg addSubview:_viewMarqueeContainer];
    [_viewMarqueeContainer addSubview:lblContent];
    [viewLableBg addSubview:btn];
    //    [self marqueeView];
    CGRect frame = _viewMarqueeContainer.frame;
    frame.origin.x = _k_w-48;
    _viewMarqueeContainer.frame = frame;
    
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:8.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    
    //    frame = label.frame;
    frame.origin.x = -frame.size.width;
    _viewMarqueeContainer.frame = frame;
    [UIView commitAnimations];
}


#pragma mark -segment事件
- (IBAction)segment:(UISegmentedControl *)sender {
    
    [self createUIWith:sender.selectedSegmentIndex];
}

-(void)createUIWith:(NSInteger)tag{
    
    if (tag == 0) {
        
        [self reomveTableView];
        _tableView0=[[UITableView alloc] initWithFrame:CGRectMake(0, 180, _k_w, _k_h-180) style:UITableViewStylePlain];
        _tableView0.delegate = self;
        _tableView0.dataSource = self;
        _tableView0.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView0];
        [self.view bringSubviewToFront:_tableView0];
        if (![self isCanSelectBtn]) {
            [self PostPersonInfoMessage];
        }
    }
    
    if (tag == 1) {
        [self reomveTableView];
        
        _tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 180, _k_w, _k_h-180) style:UITableViewStylePlain];
        _tableView1.delegate = self;
        _tableView1.dataSource = self;
        _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView1];
        [self.view bringSubviewToFront:_tableView1];
        if (![self isCanSelectBtn1]) {
            [self PostgetCustomerCarrer_jhtml];
        }
        if (!_proResult.resultIdentifier) {
            [self PostGetProductID:2];
        }
        
    }
    if (tag == 2) {
        [self reomveTableView];
        _tableView2=[[UITableView alloc] initWithFrame:CGRectMake(0, 190, _k_w, _k_h-190) style:UITableViewStylePlain];
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (_checkMobileDic == nil) {
            [self PostTelGetUrl];
        }
        [self.view addSubview:_tableView2];
        [self.view bringSubviewToFront:_tableView2];
        //        if (![self isTelScory]) {
        //            [self PostTelGetUrl];
        //        }
    }
}

-(void)isSetEnableSegment
{
    if ([self isCanSelectBtn]) {
        [_segment setEnabled:YES forSegmentAtIndex:1];
        [_segment setEnabled:YES forSegmentAtIndex:2];
        //        [_segment setEnabled:YES forSegmentAtIndex:3];
        
    }else{
        [_segment setEnabled:NO forSegmentAtIndex:1];
        [_segment setEnabled:NO forSegmentAtIndex:2];
        //        [_segment setEnabled:NO forSegmentAtIndex:3];
    }
    
}
//移除talbeview
-(void)reomveTableView
{
    [self isSetEnableSegment];
    [_tableView0 removeFromSuperview];
    [_tableView1 removeFromSuperview];
    [_tableView2 removeFromSuperview];
    [_tableView3 removeFromSuperview];
    [_scrollView0 removeFromSuperview];
    [_scrollView1 removeFromSuperview];
    [_scrollView2 removeFromSuperview];
    [_taobaoscrollview removeFromSuperview];
    [_jdongscrollview removeFromSuperview];
    self.localPicker.hidden = YES;
    self.toolbarCancelDone.hidden = YES;
}

-(void)approveUIWith:(NSInteger)tag
{
    
    if (tag == 0) {//手机验证
        
        //        [self telPhoneUI];
        DLog(@"手机验证");
        if ([[dataListAll2 objectAtIndex:13] isEqualToString:@"2"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"已认证成功"];
        } else {
            [self reomveTableView];
            //            [self mobileCheck];
            [self telPhoneUI];
        }
    }
    if (tag == 1) {
        DLog(@"身份认证");
        //        [self bodyApproveUI];
        
        if([[dataListAll2 objectAtIndex:13] isEqualToString:@"2"])
        {
            [self reomveTableView];
            [self idPhotoUI];
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请先进行手机认证"];
        }
    }
}

- (void)mobileCheck
{
    _moxieSDK = [[MoxieSDK shared] initWithUserID:[Utility sharedUtility].userInfo.juid mApikey:theMoxieApiKey controller:self];
    //修改内部参数
    [self editSDKInfo];
    //添加结果回调
    [self listenForResult];
    [_moxieSDK startFunction:MXSDKFunctioncarrier];
}

-(void)editSDKInfo{
    _moxieSDK.mxNavigationController.navigationBar.translucent = YES;
    _moxieSDK.mxNavigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    [_moxieSDK.mxNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation"] forBarMetrics:UIBarMetricsDefault];
    _moxieSDK.backImage = [[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _moxieSDK.textfield_editable = NO;
    _moxieSDK.carrier_phone = _telNum;
    _moxieSDK.carrier_name = dataListAll[0];
    _moxieSDK.carrier_idcard = dataListAll[1];
}

#pragma mark 手机认证SDK回调
-(void)listenForResult{
    __weak WriteInfoViewController *weakself = self;
    _moxieSDK.resultBlock=^(int code,MXSDKFunction funciton,NSString *taskid,NSString *searchid){
        DLog(@"get import result---statusCode:%d,function:%d,taskid:%@,searchid:%@",code,funciton,taskid,searchid);
        if(funciton == MXSDKFunctioncarrier){
            if(code == 1){
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                        [blockData2 replaceObjectAtIndex:13 withObject:@"2"];
                        //                        weakself.segment.selectedSegmentIndex = 1;
                        //                        [weakself createUIWith:weakself.segment.selectedSegmentIndex];
                        [weakself saveMobileAuth:[NSString stringWithFormat:@"%d",code]];
                    });
                });
            }else {
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                        weakself.segment.selectedSegmentIndex = 1;
                        //                        [blockData2 replaceObjectAtIndex:13 withObject:@""];
                        //                        [weakself createUIWith:weakself.segment.selectedSegmentIndex];
                        [weakself saveMobileAuth:[NSString stringWithFormat:@"%d",code]];
                    });
                });
            }
            
        }
    };
}

- (void)saveMobileAuth:(NSString *)authCode
{
    NSDictionary *dic = @{@"code":authCode};
    __weak WriteInfoViewController *weakself = self;
    __block NSMutableArray * blockDataList = dataListAll2;
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_authMobilePhone_url] parameters:dic finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass *returnParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
        if ([returnParse.flag isEqualToString:@"0000"]) {
            [blockDataList replaceObjectAtIndex:13 withObject:@"2"];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:returnParse.msg];
        }
        
        if ([authCode isEqualToString:@"1"]) {
            [blockDataList replaceObjectAtIndex:13 withObject:@"2"];
        } else {
            [blockDataList replaceObjectAtIndex:13 withObject:@""];
        }
        weakself.segment.selectedSegmentIndex = 2;
        [weakself createUIWith:weakself.segment.selectedSegmentIndex];
    } failure:^(EnumServerStatus status, id object) {
        weakself.segment.selectedSegmentIndex = 2;
        [weakself createUIWith:weakself.segment.selectedSegmentIndex];
    }];
}

-(void)taobaoViewModel:(CGRect)rect and:(NSInteger)tag and:(NSString *)textfiledText andplaceholder:(NSString *)placeText andScrollView:(UIScrollView *)scroll
{
    //验证码CGRectMake(18, 150, _k_w-36, 55) 1120
    UIView *viewSecory11 = [[UIView alloc] initWithFrame:rect];
    [Tool setCorner:viewSecory11 borderColor:rgb(0, 170, 238)];
    
    UITextField *textFieldSecoy1 = [[UITextField alloc] initWithFrame:CGRectMake(8, 0,rect.size.width- 8, 55)];
    textFieldSecoy1.placeholder = placeText;
    textFieldSecoy1.tag = tag;
    if (tag ==1124) {
        textFieldSecoy1.secureTextEntry = YES;
    }
    textFieldSecoy1.delegate = self;
    textFieldSecoy1.text = textfiledText;
    [viewSecory11 addSubview:textFieldSecoy1];
    
    [scroll addSubview:viewSecory11];
}

#pragma mark -> 认证UI页面
//身份认证
-(void)idPhotoUI
{
    _scrollView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 180, _k_w, _k_h-180)];
    _scrollView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView1];
    
    //    _imageviewPhoto1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, _k_w/2.0-30, _k_w/2.0-30-30)];
    //    if ([Utility sharedUtility].userInfo.userInfoModel.result.identityPositivePath != nil) {
    //        _identityPositivePath = [Utility sharedUtility].userInfo.userInfoModel.result.identityPositivePath;
    //        [_imageviewPhoto1 sd_setImageWithURL:[NSURL URLWithString:[Utility sharedUtility].userInfo.userInfoModel.result.identityPositivePath]];
    //        [dataListAll2 replaceObjectAtIndex:8 withObject:@"10"];
    //    } else {
    //        _imageviewPhoto1.image = [UIImage imageNamed:@"4_lc_chahua_01"];
    //        [dataListAll2 replaceObjectAtIndex:8 withObject:@""];
    //    }
    //
    //
    //    [_scrollView1 addSubview:_imageviewPhoto1];
    
    UIImage *imagPhoto = [UIImage imageNamed:@"3_lc_icon_08"];
    CGFloat hei = imagPhoto.size.width;
    //    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn1.frame = CGRectMake(20+(_k_w/2.0-30)/2-hei/2.f, 10+(_k_w/2.0-30-30)-hei/2.f, hei, hei);
    //    [btn1 setImage:imagPhoto forState:UIControlStateNormal];
    //    [_scrollView1 addSubview:btn1];
    //    CGRect rect10 = CGRectMake(20+(_k_w/2.0-30)/2-hei/2.f, 10+(_k_w/2.0-30-30)-hei/2.f, hei, hei);
    //    [self createButton:rect10 andScroll:_scrollView1 andImage:imagPhoto andtag:2210];
    
    //    CGRect rect1 = CGRectMake(0, 10 +_k_w/2.0-30-30+hei/2.f+5, _k_w/2.0, 20);
    //    [self createLabel:rect1 andScroll:_scrollView1 andTitle:@"身份证正面"];
    //3_lc_icon_08 照相
    //    _imageviewPhoto2 = [[UIImageView alloc] initWithFrame:CGRectMake(10+_k_w/2.f, 10, _k_w/2.0-30,_k_w/2.0-30-30)];
    //    if ([Utility sharedUtility].userInfo.userInfoModel.result.identityCounterPath != nil) {
    //        _identityCounterPath = [Utility sharedUtility].userInfo.userInfoModel.result.identityCounterPath;
    //        [_imageviewPhoto2 sd_setImageWithURL:[NSURL URLWithString:[Utility sharedUtility].userInfo.userInfoModel.result.identityCounterPath ]];
    //        [dataListAll2 replaceObjectAtIndex:9 withObject:@"10"];
    //    } else {
    //        _imageviewPhoto2.image = [UIImage imageNamed:@"4_lc_chahua_02"];
    //        [dataListAll2 replaceObjectAtIndex:9 withObject:@""];
    //    }
    //
    //    [_scrollView1 addSubview:_imageviewPhoto2];
    //
    //
    //    CGRect rect20 = CGRectMake(_k_w/2.f+10+(_k_w/2.0-30)/2.f-hei/2.f, 10+(_k_w/2.0-30-30)-hei/2.f, hei, hei);
    //    [self createButton:rect20 andScroll:_scrollView1 andImage:imagPhoto andtag:2211];
    //
    //    CGRect rect2 = CGRectMake(_k_w/2.f, 10 +_k_w/2.0-30-30+hei/2.f+5, _k_w/2.0,20);
    //    [self createLabel:rect2 andScroll:_scrollView1 andTitle:@"身份证反面"];
    
    _imageviewPhoto3 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 50,  _k_w-60, _k_w-150)];
    if ([Utility sharedUtility].userInfo.userInfoModel.result.holdIdentityPhonePath != nil) {
        _holdIdentityPhonePath = [Utility sharedUtility].userInfo.userInfoModel.result.holdIdentityPhonePath;
        [_imageviewPhoto3 sd_setImageWithURL:[NSURL URLWithString:[Utility sharedUtility].userInfo.userInfoModel.result.holdIdentityPhonePath]];
        [dataListAll2 replaceObjectAtIndex:10 withObject:@"10"];
    } else {
        _imageviewPhoto3.image = [UIImage imageNamed:@"4_lc_chahua_03"];
        [dataListAll2 replaceObjectAtIndex:10 withObject:@""];
    }
    [_scrollView1 addSubview:_imageviewPhoto3];
    
    
    CGRect rect30 = CGRectMake(_k_w/2.f-hei/2.f,_k_w/2.0-30-30+hei/2.f+_k_w-120-100-hei/2.f, hei, hei);
    [self createButton:rect30 andScroll:_scrollView1 andImage:imagPhoto andtag:2212];
    CGRect rect21 = CGRectMake(0, _k_w/2.0-30-30+hei/2.f+_k_w-120-100+hei/2.f+5, _k_w, 20);
    [self createLabel:rect21 andScroll:_scrollView1 andTitle:@"持证自拍"];
    
    CGRect rect22 = CGRectMake(0, _k_w/2.0-30-30+hei/2.f+_k_w-120-100+hei/2.f+5+20+3, _k_w, 20);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect22;
    [btn setTitle:@"自拍详细说明" forState:UIControlStateNormal];
    [btn setTitleColor:redColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag =2213;
    [_scrollView1 addSubview:btn];
    
    UIImage *imageshure = [UIImage imageNamed:@"8_but_11"];
    CGFloat heiShare = imageshure.size.height;
    CGRect rect3 = CGRectMake(0, 10 +_k_w/2.0-30-30+hei/2.f+5+20+5+_k_w-120-100+hei/2.f+5+20+3+20+10, _k_w, heiShare);
    
    _PhotoIDBtnSure = [UIButton buttonWithType:UIButtonTypeCustom];
    _PhotoIDBtnSure.frame = rect3;
    [_PhotoIDBtnSure addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
    _PhotoIDBtnSure.tag = 2214;
    [_PhotoIDBtnSure setImage:[UIImage imageNamed:@"8_but_04"] forState:UIControlStateNormal];
    [_scrollView1 addSubview:_PhotoIDBtnSure];
}

//创建button
-(void)createButton:(CGRect)rect andScroll:(UIScrollView *)scroll andImage:(UIImage *)image andtag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [scroll addSubview:btn];
}

//创建label
-(void)createLabel:(CGRect)rect andScroll:(UIScrollView *)scroll andTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = rgb(165, 165, 165);
    [scroll addSubview:label];
}


//手机认证
-(void)telPhoneUI
{
    
    _scrollView0 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 190, _k_w, _k_h-190)];
    [self.view addSubview:_scrollView0];
    //手机号
    UILabel *telLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 97, 20)];
    telLabel.text = @"您的手机号:";
    telLabel.textColor = rgb(165, 165, 165);
    [_scrollView0 addSubview:telLabel];
    
    UILabel *telLabel0 = [[UILabel alloc] initWithFrame:CGRectMake(115, 0, 130, 20)];
    //    telLabel0.text =[self formatString:dataListAll2[11]];
    telLabel0.textColor = rgb(0, 170, 238);
    [_scrollView0 addSubview:telLabel0];
    // 运营商
    UILabel *blevelabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 28, 97, 20)];
    blevelabel.text = @"所属运营商:";
    blevelabel.textColor = rgb(165, 165, 165);
    [_scrollView0 addSubview:blevelabel];
    
    UILabel *bleveLabel0 = [[UILabel alloc] initWithFrame:CGRectMake(115, 28, 180, 20)];
    
    bleveLabel0.textColor = rgb(0, 170, 238);
    [_scrollView0 addSubview:bleveLabel0];
    //获取手机运营商
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getMobileOpera_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
                NSString *telNum = [[object objectForKey:@"ext"] objectForKey:@"mobile_phone_"];
                [dataListAll2 replaceObjectAtIndex:11 withObject:telNum];
                telLabel0.text =[self formatString:telNum];
                NSString *result = [object objectForKey:@"result"];
                bleveLabel0.text = result;
            }else{
                DLog(@"获取失败");
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"运营商信息获取失败"];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
    
    
    // 密码
    UIView *viewSecory = [[UIView alloc] initWithFrame:CGRectMake(18, 80, _k_w-36, 55)];
    [Tool setCorner:viewSecory borderColor:rgb(0, 170, 238)];
    
    UITextField *textFieldSecoy = [[UITextField alloc] initWithFrame:CGRectMake(8, 0, 200, 55)];
    textFieldSecoy.placeholder = @"运营商服务密码";
    textFieldSecoy.tag = 1100;
    textFieldSecoy.secureTextEntry = YES;
    textFieldSecoy.delegate = self;
    textFieldSecoy.text = dataListAll2[0];
    [viewSecory addSubview:textFieldSecoy];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat wid = viewSecory.frame.size.width;
    button.frame = CGRectMake(wid-55, 0, 55, 55);
    [button setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_27"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 2200;
    [viewSecory addSubview:button];
    
    [_scrollView0 addSubview:viewSecory];
    
    
    viewSecory1 = [[UIView alloc] initWithFrame:CGRectMake(18, 150, _k_w-36, 55)];
    [Tool setCorner:viewSecory1 borderColor:rgb(0, 170, 238)];
    
    UITextField *textFieldSecoy1 = [[UITextField alloc] initWithFrame:CGRectMake(8, 0, wid-8, 55)];
    textFieldSecoy1.placeholder = @"验证码";
    textFieldSecoy1.tag = 1101;
    textFieldSecoy1.delegate = self;
    textFieldSecoy1.text = dataListAll2[1];
    [viewSecory1 addSubview:textFieldSecoy1];
    
    [_scrollView0 addSubview:viewSecory1];
    
    viewSecory1.hidden = YES;
    
    
    //确定按钮
    _telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *iamge = [UIImage imageNamed:@"8_but_04"];
    //    CGFloat wb = iamge.size.width;
    CGFloat he = iamge.size.height;
    _telBtn.frame = CGRectMake(18, _k_h-190-50-he, _k_w-36, he);
    [_telBtn setBackgroundImage:iamge forState:UIControlStateNormal];
    [_telBtn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
    if ([self isCanSelectBtn2]) {
        [_telBtn setEnabled:YES];
    }else{
        [_telBtn setEnabled:NO];
    }
    _telBtn.tag = 2201;
    if (UI_IS_IPHONE5) {
        _scrollView0.contentSize = CGSizeMake(_k_w, _k_h);
    }
    
    [_scrollView0 addSubview:_telBtn];
}

#pragma mark - 照片选择
- (void)clickHeadImage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 判断是否支持相机
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *takeCameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self popImagePickerView:UIImagePickerControllerSourceTypeCamera];
        }];
        UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self popImagePickerView:UIImagePickerControllerSourceTypePhotoLibrary];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:takeCameraAction];
        [alertController addAction:libraryAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        alertController = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self popImagePickerView:UIImagePickerControllerSourceTypePhotoLibrary];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:libraryAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


- (void)popImagePickerView:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}



#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    switch (_photoType) {
        case Card_Font:
        {
            _imageviewPhoto1.image = [info objectForKey:UIImagePickerControllerEditedImage];
            [self updateUserPhoto:_imageviewPhoto1.image finshed:^(NSString *photoPath) {
                _identityPositivePath = photoPath;
            }];
        }
            break;
        case Card_Back:
        {
            _imageviewPhoto2.image = [info objectForKey:UIImagePickerControllerEditedImage];
            [self updateUserPhoto:_imageviewPhoto2.image finshed:^(NSString *photoPath) {
                _identityCounterPath = photoPath;
            }];
        }
            break;
        case Card_Self:
        {
            userIDImage = [info objectForKey:UIImagePickerControllerEditedImage];
            _imageviewPhoto3.image = [info objectForKey:UIImagePickerControllerEditedImage];
        }
            break;
        default:
            break;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateUserPhoto:(UIImage *)photo finshed:(void(^)(NSString *photoPath))path
{
    NSData *data=UIImageJPEGRepresentation(photo,0.2);
    NSDictionary *paramDic = @{@"idCardSelf":[GTMBase64 stringByEncodingData:data]};
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_updateAvatar_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        _returnPare = [ReturnMsgBaseClass modelObjectWithDictionary:object];
        if ([_returnPare.flag isEqualToString:@"0000"]) {
            path(_returnPare.result);
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:_returnPare.msg];
            [dataListAll2 replaceObjectAtIndex:14 withObject:@"1"];
            [self createUIWith:2];
            
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:_returnPare.msg];
            [self createUIWith:2];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

#pragma mark -UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tableView0 == tableView) {
        if (flagPlace == 1) {
            return placeArray.count;
        }
        return placeArray00.count;
    }
    if (_tableView1 == tableView) {
        return placeArray1.count;
    }
    if (_tableView2 == tableView) {
        return 3;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView0) {//个人信息
        if (flagPlace == 1) {
            if (indexPath.row == 5) {
                BtnCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"approve%ld",indexPath.row]];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"BtnCell" owner:self options:nil] lastObject];
                }
                cell.btn.tag = indexPath.row + 200;
                [cell.btn setEnabled:NO];
                [cell.btn setBackgroundImage:[UIImage imageNamed:_imageArray[11]] forState:UIControlStateNormal];
                
                [cell.btn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;
                return cell;
                
            }else{
                LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"abcde%ld",indexPath.row]];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"LabelCell" owner:self options:nil] lastObject];
                }
                
                
                cell.textField.placeholder = placeArray[indexPath.row];
                cell.textField.tag = indexPath.row +100;
                cell.textField.delegate = self;
                cell.textField.text = dataListAll[indexPath.row];
                if (indexPath.row ==0 || indexPath.row == 1 ||indexPath.row ==4 || indexPath.row ==6) {
                    cell.btn.hidden = YES;
                }else{
                    cell.btn.hidden = NO;
                    cell.btn.tag = indexPath.row + 200;
                    [cell.btn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_25"] forState:UIControlStateNormal];
                }
                cell.btnSecory.hidden =YES;
                [Tool setCorner:cell.bgView borderColor:dataColor[indexPath.row]];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
        if (flagPlace == 2) {
            if (indexPath.row == 11) {
                BtnCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"approve%ld",indexPath.row]];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"BtnCell" owner:self options:nil] lastObject];
                }
                cell.btn.tag = indexPath.row + 200;
                if ([self isCanSelectBtn]) {
                    [cell.btn setEnabled:YES];
                    [cell.btn setBackgroundImage:[UIImage imageNamed:_imageArray[12]] forState:UIControlStateNormal];
                }else{
                    [cell.btn setEnabled:NO];
                    [cell.btn setBackgroundImage:[UIImage imageNamed:_imageArray[11]] forState:UIControlStateNormal];
                }
                [cell.btn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;
                return cell;
                
            }else{
                LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"abcde%ld",indexPath.row]];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"LabelCell" owner:self options:nil] lastObject];
                }
                if(indexPath.row == 7 || indexPath.row == 10)
                {
                    cell.textField.keyboardType =UIKeyboardTypePhonePad;
                }
                cell.textField.placeholder = placeArray00[indexPath.row];
                cell.textField.tag = indexPath.row +100;
                cell.textField.delegate = self;
                cell.textField.text = dataListAll[indexPath.row];
                if (indexPath.row ==0 || indexPath.row == 1 ||indexPath.row ==4 || indexPath.row ==7
                    || indexPath.row ==10 ) {
                    cell.btn.hidden = YES;
                }else{
                    cell.btn.hidden = NO;
                    cell.btn.tag = indexPath.row + 200;
                    [cell.btn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_25"] forState:UIControlStateNormal];
                }
                cell.btnSecory.hidden =YES;
                [Tool setCorner:cell.bgView borderColor:dataColor[indexPath.row]];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
    }
    if (tableView == _tableView1) {//职业信息
        if (indexPath.row == 5) {
            TelSecoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"btnc%ld",indexPath.row]];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TelSecoryCell" owner:self options:nil] lastObject];
            }
            cell.detailLabel.hidden = YES;
            cell.nextBtn.tag = 2306;
            if ([self isCanSelectBtn1]) {
                [cell.nextBtn setEnabled:YES];
                [cell.nextBtn setBackgroundImage:[UIImage imageNamed:_imageArray[6]] forState:UIControlStateNormal];
            }else{
                [cell.nextBtn setEnabled:NO];
                [cell.nextBtn setBackgroundImage:[UIImage imageNamed:_imageArray[7]] forState:UIControlStateNormal];
            }
            [cell.nextBtn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.forwardBtn.tag = 2004;
            [cell.forwardBtn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.dealBtn.tag = 2308;
            [cell.dealBtn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.seleBtn.tag = 2309;
            if (_btnStatus) {
                [cell.seleBtn setBackgroundImage:[UIImage imageNamed:@"tricked"] forState:UIControlStateNormal];
            }else{
                [cell.seleBtn setBackgroundImage:[UIImage imageNamed:@"trick"] forState:UIControlStateNormal];
            }
            [cell.seleBtn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return cell;
            
        } if (indexPath.row == 1){
            TelPhoneCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TelPhoneCompanyCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TelPhoneCompanyCell" owner:self options:nil] lastObject];
            }
            cell.textfiledCode.text = dataListAll1[5];
            cell.textfiledCode.tag = 1005;
            cell.textfiledCode.delegate = self;
            cell.textfiledCode.keyboardType = UIKeyboardTypePhonePad;
            
            cell.textfiledTel.text = dataListAll1[indexPath.row];
            cell.textfiledTel.delegate = self;
            cell.textfiledTel.tag = indexPath.row + 1000;
            cell.textfiledTel.keyboardType = UIKeyboardTypePhonePad;
            [Tool setCorner:cell.viewCode borderColor:datacolor1[5]];
            [Tool setCorner:cell.viewTel borderColor:datacolor1[indexPath.row]];
            return cell;
        }else{
            LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"abc%ld",indexPath.row]];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"LabelCell" owner:self options:nil] lastObject];
            }
            
            cell.textField.placeholder = [placeArray1 objectAtIndex:indexPath.row];
            cell.textField.tag = indexPath.row +1000;
            cell.textField.delegate = self;
            cell.textField.text = dataListAll1[indexPath.row];
            
            if (indexPath.row ==0 || indexPath.row ==4) {
                cell.btn.hidden = YES;
            }else{
                cell.btn.hidden = NO;
                cell.btn.tag = indexPath.row + 2000;
                [cell.btn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
                [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_25"] forState:UIControlStateNormal];
            }
            cell.btnSecory.hidden = YES;
            [Tool setCorner:cell.bgView borderColor:datacolor1[indexPath.row]];
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    if (tableView == _tableView2) {//认证
        if (indexPath.row == 2) {
            TelSecoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"btncel%ld",indexPath.row]];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TelSecoryCell" owner:self options:nil] lastObject];
            }
            cell.detaillLabel.hidden = YES;
            cell.seleBtn.hidden = YES;
            cell.dealBtn.hidden = YES;
            cell.detailLabel.hidden = YES;
            cell.nextBtn.tag = indexPath.row +2200;
            if ([self isTelScory] && [self isFaceProcess]) {
                [cell.nextBtn setEnabled:YES];
                [cell.nextBtn setBackgroundImage:[UIImage imageNamed:_imageArray[6]] forState:UIControlStateNormal];
            }else{
                [cell.nextBtn setEnabled:NO];
                [cell.nextBtn setBackgroundImage:[UIImage imageNamed:_imageArray[7]] forState:UIControlStateNormal];
            }
            [cell.nextBtn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.forwardBtn.tag = 2206;
            [cell.forwardBtn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else{
            ApproveCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"approveCell%ld",indexPath.row]];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ApproveCell" owner:self options:nil] lastObject];
            }
            if (indexPath.row == 0) {
                if ([self isTelScory]) {
                    cell.photoimageView.image = [UIImage imageNamed:_imageArray[3]];
                    cell.shareLabel.text = @"100%";
                }else{
                    cell.photoimageView.image = [UIImage imageNamed:_imageArray[0]];
                    cell.shareLabel.text = @"30%";
                }
            }
            else if(indexPath.row == 1){
                if ([self isFaceProcess]) {
                    cell.photoimageView.image = [UIImage imageNamed:_imageArray[4]];
                    cell.shareLabel.text = @"100%";
                    cell.shareLabel.textColor = rgb(0, 170, 238);
                }else{
                    cell.photoimageView.image = [UIImage imageNamed:_imageArray[1]];
                    cell.shareLabel.text = @"0%";
                    cell.shareLabel.textColor = rgb(165, 165, 165);
                }
            }
            
            cell.titleLabel.text = _titleArray[indexPath.row];
            if (indexPath.row == 1 ) {
                cell.titleLabel.textColor = [UIColor grayColor];
            }
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_tableView1 == tableView) {
        if (indexPath.row == 9) {
            _segment.selectedSegmentIndex =2;
            [self createUIWith:_segment.selectedSegmentIndex];
        }
    }
    if (_tableView2 == tableView) {
        if (indexPath.row == 2) {
            
        }else{
            [self approveUIWith:indexPath.row];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableView0 == tableView) {
        if (flagPlace == 1) {
            if (indexPath.row == 5) {
                return 127.0f;
            }
        }
        if (flagPlace == 2) {
            if (indexPath.row == 11) {
                return 127.0f;
            }
        }
        
    }
    if (_tableView1 == tableView) {
        if (indexPath.row == 5) {
            return 100.0f;
        }
    }
    if (_tableView2 == tableView) {
        if (indexPath.row == 2) {
            return 160.f;
        }
        return 100.0f;
    }
    return 70.0f;
}

#pragma mark - 创建PIckView --UIPickerViewDelegate
-(void)createPickViewShowWithTag:(NSInteger)tag
{
    [self.view endEditing:YES];
    [self setRomovePickView];
    switch (tag) {
        case 2002://行业
        {
            _pickerTag = tag;
            _localPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183, _k_w, 183)];
            _localPicker.backgroundColor = [UIColor whiteColor];
            _localPicker.dataSource = self;
            _localPicker.delegate = self;
            [self.view addSubview:_localPicker];
        }
            break;
        case 2003://单位地址
        {
            _pickerTag = tag;
            _localPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183, _k_w, 183)];
            _localPicker.backgroundColor = [UIColor whiteColor];
            _localPicker.dataSource = self;
            _localPicker.delegate = self;
            [self.view addSubview:_localPicker];
            
        }
            break;
        case 203://现在居住地址
        {
            _pickerTag = tag;
            _localPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183, _k_w, 183)];
            _localPicker.backgroundColor = [UIColor whiteColor];
            _localPicker.dataSource = self;
            _localPicker.delegate = self;
            [self.view addSubview:_localPicker];
            
        }
            break;
        case 205://现在居住地址
        {
            _pickerTag = tag;
            _localPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183, _k_w, 183)];
            _localPicker.backgroundColor = [UIColor whiteColor];
            _localPicker.dataSource = self;
            _localPicker.delegate = self;
            [self.view addSubview:_localPicker];
        }
            break;
        case 208://现在居住地址
        {
            _pickerTag = tag;
            _localPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _k_h-183, _k_w, 183)];
            _localPicker.backgroundColor = [UIColor whiteColor];
            _localPicker.dataSource = self;
            _localPicker.delegate = self;
            [self.view addSubview:_localPicker];
        }
            break;
        default:
            break;
    }
}

-(void)setRomovePickView
{
    _toolbarCancelDone.hidden = NO;
    [self.view bringSubviewToFront:_toolbarCancelDone];
    _toolbarCancelDone.backgroundColor =  rgb(241, 241, 241);
    [_localPicker removeFromSuperview];
}

#pragma mark -> BankTableViewSelectDelegate
-(void)BankTableViewSelect:(NSString *)CurrentRow andBankInfoList:(NSString *)bankNum andSectionRow:(NSInteger)SectionRow
{
    [dataListAll3 replaceObjectAtIndex:0 withObject:CurrentRow];//银行中文名字
    [dataListAll3 replaceObjectAtIndex:2 withObject:bankNum];//编码
    [dataListAll3 replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%ld",SectionRow]];
    [datacolor3 replaceObjectAtIndex:0 withObject:UI_MAIN_COLOR];
    [_tableView3 reloadData];
}

#pragma mark--UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_pickerTag == 205 || _pickerTag == 208 || _pickerTag == 2002) {
        return 1;
    }
    return 3;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if (_pickerTag == 205 || _pickerTag == 208) {
        return 60.0;
    }
    return 30.0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_pickerTag == 205 || _pickerTag == 208) {
        return _contact2.count;
    }else if (_pickerTag == 2002)
    {
        return _professionArray.count;
    }else{
        
        if (component==FirstComponent) {
            return [_pickerArray count];
        }
        if (component==SubComponent) {
            return [_subPickerArray count];
        }
        if (component==ThirdComponent) {
            return [_thirdPickerArray count];
        }
        
    }
    return 0;
}

#pragma mark--UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_pickerTag == 205) {
        return [_contact1 objectAtIndex:row];
    }else if (_pickerTag == 208) {
        return [_contact2 objectAtIndex:row];
    }else if (_pickerTag == 2002)
    {
        return [_professionArray objectAtIndex:row];
    }else{
        
        if (component==FirstComponent) {
            return [_pickerArray objectAtIndex:row];
        }
        if (component==SubComponent) {
            if (_subPickerArray.count - 1 < row) {
                return _subPickerArray[0];
            }
            return [_subPickerArray objectAtIndex:row];
        }
        if (component==ThirdComponent) {
            if (_thirdPickerArray.count - 1 < row) {
                return _thirdPickerArray[0];
            }
            return [_thirdPickerArray objectAtIndex:row];
        }
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    NSLog(@"row is %ld,Component is %ld",row,component);
    if (_pickerTag == 205) {
        [dataListAll replaceObjectAtIndex:5 withObject:_contact1[row]];
    }else if(_pickerTag == 208){
        [dataListAll replaceObjectAtIndex:8 withObject:_contact2[row]];
    }else if (_pickerTag == 2002)
    {
        [dataListAll1 replaceObjectAtIndex:2 withObject:_professionArray[row]];
    }else{
        if (component == 0) {
            //第一个省的所有区
            index = row;
            [_subPickerArray removeAllObjects];
            _regionSub = _reginBase.result[row];
            
            for (int j = 0; j < _regionSub.sub.count; j++) {
                RegionResult *regionResultModel = _regionSub.sub[j];
                [_subPickerArray addObject:regionResultModel.name];
            }
            
            //第一个区的县的所有县
            [_thirdPickerArray removeAllObjects];
            RegionResult *regionResultModel = _regionSub.sub[0];
            for (int j = 0; j < regionResultModel.sub.count; j++) {
                //取出市
                [_thirdPickerArray addObject:[regionResultModel.sub[j] objectForKey:@"name"]];
                
            }
            
            [pickerView selectedRowInComponent:1];
            [pickerView reloadComponent:0];
            [pickerView reloadComponent:1];
            [pickerView selectedRowInComponent:2];
        }
        if (component==1) {
            
            [_subPickerArray removeAllObjects];
            _regionSub = _reginBase.result[index];
            for (int j = 0; j < _regionSub.sub.count; j++) {
                RegionResult *regionResultModel = _regionSub.sub[j];
                [_subPickerArray addObject:regionResultModel.name];
            }
            //第一个区的县的所有县
            [_thirdPickerArray removeAllObjects];
            RegionResult *regionResultModel = [[RegionResult alloc] init];
            if (row > _regionSub.sub.count - 1) {
                regionResultModel = _regionSub.sub[0];
            }else{
                regionResultModel = _regionSub.sub[row];
            }
            
            for (int j = 0; j < regionResultModel.sub.count; j++) {
                //取出市
                [_thirdPickerArray addObject:[regionResultModel.sub[j] objectForKey:@"name"]];
                
            }
            
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
        
        [pickerView reloadComponent:2];
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (_pickerTag == 205 || _pickerTag == 208 || _pickerTag == 2002) {
        return 300.;
    }else{
        if (component==FirstComponent) {
            return 90.0;
        }
        if (component==SubComponent) {
            return 120.0;
        }
        if (component==ThirdComponent) {
            return 100.0;
        }
    }
    return 0;
}



#pragma mark - action 事件
//取消
- (IBAction)cancelAction:(id)sender {
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.localPicker.hidden = YES;
                         self.toolbarCancelDone.hidden = YES;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
}

//确定
- (IBAction)doneAction:(id)sender {
    
    if (_pickerTag == 203) {
        NSString *localString = @"";
        NSString *loString = @"";
        if (_pickerArray.count > 0 && _subPickerArray.count > 0 && _thirdPickerArray.count > 0) {
            if ([[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]] isEqualToString:[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]]]) {
                localString = [NSString stringWithFormat:@"%@/%@",[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
                
                loString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
            }else if ([[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]] isEqualToString:[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]]){
                localString = [NSString stringWithFormat:@"%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]]];
                loString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
            } else if ([_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]] &&[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]] &&[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]){
                localString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
                loString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
            }
            
        }
        [dataListAll1 replaceObjectAtIndex:6 withObject:loString];
        [dataListAll replaceObjectAtIndex:3 withObject:localString];
        [dataColor replaceObjectAtIndex:3 withObject:UI_MAIN_COLOR];
        //第一个省的所有区
        [_subPickerArray removeAllObjects];
        RegionSub *regisonSubModel = _reginBase.result[0];
        for (int j = 0; j < regisonSubModel.sub.count; j++) {
            RegionResult *regionResultModel = regisonSubModel.sub[j];
            [_subPickerArray addObject:regionResultModel.name];
        }
        
        //第一个区的县的所有县
        [_thirdPickerArray removeAllObjects];
        RegionResult *regionResultModel = regisonSubModel.sub[0];
        for (int j = 0; j < regionResultModel.sub.count; j++) {
            //取出市
            [_thirdPickerArray addObject:[regionResultModel.sub[j] objectForKey:@"name"]];
            
        }
        
    }
    if (_pickerTag == 2003) {
        NSString *localString = @"";
        NSString *loString = @"";
        if (_pickerArray.count > 0 && _subPickerArray.count > 0 && _thirdPickerArray.count > 0) {
            if ([[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]] isEqualToString:[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]]]) {
                localString = [NSString stringWithFormat:@"%@/%@",[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
                
                loString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
            }else if ([[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]] isEqualToString:[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]]){
                localString = [NSString stringWithFormat:@"%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]]];
                loString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
            } else if ([_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]] &&[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]] &&[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]){
                localString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
                loString = [NSString stringWithFormat:@"%@/%@/%@",[_pickerArray objectAtIndex:[self.localPicker selectedRowInComponent:0]],[_subPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:1]],[_thirdPickerArray objectAtIndex:[self.localPicker selectedRowInComponent:2]]];
            }
            
        }
        [dataListAll1 replaceObjectAtIndex:7 withObject:loString];
        [dataListAll1 replaceObjectAtIndex:3 withObject:localString];
        [datacolor1 replaceObjectAtIndex:3 withObject:UI_MAIN_COLOR];
        //第一个省的所有区
        [_subPickerArray removeAllObjects];
        RegionSub *regisonSubModel = _reginBase.result[0];
        for (int j = 0; j < regisonSubModel.sub.count; j++) {
            RegionResult *regionResultModel = regisonSubModel.sub[j];
            [_subPickerArray addObject:regionResultModel.name];
        }
        
        //第一个区的县的所有县
        [_thirdPickerArray removeAllObjects];
        RegionResult *regionResultModel = regisonSubModel.sub[0];
        for (int j = 0; j < regionResultModel.sub.count; j++) {
            //取出市
            [_thirdPickerArray addObject:[regionResultModel.sub[j] objectForKey:@"name"]];
            
        }
    }
    if (_pickerTag == 205) {
        if([dataListAll[5] isEqualToString:@""])
        {
            [dataListAll replaceObjectAtIndex:5 withObject:@"父母"];
        }
        [dataColor replaceObjectAtIndex:5 withObject:UI_MAIN_COLOR];
    }
    if (_pickerTag == 208) {
        if([dataListAll[8] isEqualToString:@""])
        {
            [dataListAll replaceObjectAtIndex:8 withObject:@"同事"];
        }
        [dataColor replaceObjectAtIndex:8 withObject:UI_MAIN_COLOR];
    }
    if (_pickerTag == 2002) {
        if ([dataListAll1[2] isEqualToString:@""]) {
            [dataListAll1 replaceObjectAtIndex:2 withObject:_professionArray[0]];
        }
        [datacolor1 replaceObjectAtIndex:2 withObject:UI_MAIN_COLOR];
    }
    if ([self iscanFlagBtn]) {
        flagPlace =2;
    }else{
        flagPlace = 1;
    }
    
    [_tableView1 reloadData];
    [_tableView0 reloadData];
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.localPicker.hidden = YES;
                         self.toolbarCancelDone.hidden = YES;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(void)senderBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            DLog(@"点击");
            viewLableBg.hidden = YES;
        }
            break;
        case 202:
        {
            DLog(@"学历");
            [self.view endEditing:YES];
            _colledgeView = [[[NSBundle mainBundle] loadNibNamed:@"ColledgeView" owner:self options:nil] lastObject];
            _colledgeView.frame = CGRectMake(0, 0, _k_w, _k_h);
            _colledgeView.delegate = self;
            [_colledgeView show];
        }
            break;
        case 203:
            DLog(@"现居地址");
            if (_pickerArray.count != 34) {
                [self PostGetCity];
            }
            [self createPickViewShowWithTag:203];
            break;
        case 205:
            DLog(@"联系人");
            [self createPickViewShowWithTag:205];
            break;
        case 206:
        {
            ContactViewController *conVC = [ContactViewController new];
            conVC.upload = true;
            conVC.delegate = self;
            conVC.tagFlage = 207;
            [self.navigationController pushViewController:conVC animated:YES];
        }
            break;
        case 209:
        {
            ContactViewController *conVC = [ContactViewController new];
            conVC.upload = false;
            conVC.delegate = self;
            conVC.tagFlage = 210;
            [self.navigationController pushViewController:conVC animated:YES];
        }
            break;
        case 208:
        {
            DLog(@"联系人2");
            [self createPickViewShowWithTag:208];
        }
            break;
        case 211://下个segment
        {
            //保存个人信息
            [self PostGetCityCode:dataListAll1[6] Tag:203];
        }
            break;
            //第三页
        case 2002:
            DLog(@"行业/职业");
            [self createPickViewShowWithTag:2002];
            break;
        case 2003:
            DLog(@"单位所在地");
            if (_pickerArray.count != 34) {
                [self PostGetCity];
            }
            [self createPickViewShowWithTag:2003];
            break;
        case 2004:
            _segment.selectedSegmentIndex = 0;
            [self createUIWith:_segment.selectedSegmentIndex];
            break;
            //第二页
        case 2203:
        {
            _segment.selectedSegmentIndex = 2;
            [self createUIWith:_segment.selectedSegmentIndex];
        }
            break;
        case 2206:
        {
            _segment.selectedSegmentIndex = 1;
            [self createUIWith:_segment.selectedSegmentIndex];
        }
            break;
        case 2200:
        {
            DLog(@"运营商");
            telphoneView *telview = [[[NSBundle mainBundle] loadNibNamed:@"telphoneView" owner:self options:nil] lastObject];
            telview.frame = CGRectMake(0, 0, _k_w, _k_h);
        }
            break;
        case 2202:
        {
            DLog(@"忘记手机服务密码");
            //            _segment.selectedSegmentIndex =2;
            //            [self createUIWith:_segment.selectedSegmentIndex];
            [self popViewFamily];
            
        }
            break;
            
        case 2201:
        {
            
            //手机服务密码
            
            NSDictionary *dicParam = @{@"mobile_phone_":dataListAll2[11],
                                       @"service_password_":dataListAll2[0]
                                       };
            NSDictionary *dicParma2 = @{@"mobile_phone_":dataListAll2[11],
                                        @"service_password_":dataListAll2[0],
                                        @"verify_code_":dataListAll2[1]
                                        };
            if ([dataListAll2[12] isEqualToString:@""]) {
                [self PostTelSecory:dicParam];
            }else if ([dataListAll2[12] isEqualToString:@"flag"]){
                [self PostTelSecory:dicParma2];
            }
            
        }
            break;
        case 2212:
            DLog(@"拍照");
            _photoType = Card_Self;
            [self clickHeadImage];
            break;
        case 2213:
        {
            DLog(@"自拍说明");
            PhotoDetailViewController *photoVC = [PhotoDetailViewController new];
            [self.navigationController pushViewController:photoVC animated:YES];
        }
            break;
        case 2214:
        {
            DLog(@"确定上传图片");
            if (userIDImage != nil) {
                [self updateUserPhoto:userIDImage finshed:^(NSString *photoPath) {
                    
                }];
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择待认证照片"];
            }
        }
            break;
        case 2306://职业信息保存
        {
            
            if (![self isCanSelectBtn1]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"职业信息未填写正确"];
            }else{
                //调取职业信息
                [self PostGetCityCode:dataListAll1[7] Tag:2003];
                
            }
            //            else if(![self isTelScory]){
            //                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"手机未认证"];
            //            }
            //            else if(![self isFaceProcess]){
            //                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请上传身份证图片"];
            //            }
            
        }
            break;
        case 2307:
        {
            DLog(@"上一步");
            _segment.selectedSegmentIndex =2;
            [self createUIWith:_segment.selectedSegmentIndex];
        }
            break;
            //        case 2308:
            //        {
            //            DLog(@"三方借款协议");
            //
            //            HomeDailViewController *homeDailVC = [HomeDailViewController new];
            //            homeDailVC.personInfo = [self getInfoMsg];
            //            homeDailVC.organization_address = dataListAll1[4];
            //            [self.navigationController pushViewController:homeDailVC animated:YES];
            //        }
            //            break;
        case 2309:
        {
            _btnStatus = !_btnStatus;
            [_tableView1 reloadData];
        }
            break;
        case 2500://否
        {
            
            //产品id检测
            if (!_proResult.resultIdentifier) {
                [self PostGetProductID:1];
            }else{
                //进件
                //                [self PostGetcreateApplication:@"1"];
                LoanSureFirstViewController *loanFirstVC = [[LoanSureFirstViewController alloc] init];
                loanFirstVC.productId = [Utility sharedUtility].userInfo.pruductId;
                loanFirstVC.if_family_know = @"1";
                DLog(@"%@-------%@",_careerParse.result.resultcode,_careerParse.result.rulesid);
                loanFirstVC.resultCode = _careerParse.result.resultcode;
                loanFirstVC.rulesId = _careerParse.result.rulesid;
                if ([[Utility sharedUtility].userInfo.pruductId isEqualToString:@"P001004"]) {
                    loanFirstVC.req_loan_amt = _req_loan_amt;
                }
                [self.navigationController pushViewController:loanFirstVC animated:true];
            }
        }
            break;
        case 2501:// 是
        {
            [_alertView hide];
            
            //产品id检测
            if (!_proResult.resultIdentifier) {
                [self PostGetProductID:0];
            }else{
                //进件
                //                [self PostGetcreateApplication:@"0"];
                LoanSureFirstViewController *loanFirstVC = [[LoanSureFirstViewController alloc] init];
                loanFirstVC.productId = [Utility sharedUtility].userInfo.pruductId;
                loanFirstVC.if_family_know = @"0";
                DLog(@"%@-------%@",_careerParse.result.resultcode,_careerParse.result.rulesid);
                loanFirstVC.resultCode = _careerParse.result.resultcode;
                loanFirstVC.rulesId = _careerParse.result.rulesid;
                if ([[Utility sharedUtility].userInfo.pruductId isEqualToString:@"P001004"]) {
                    loanFirstVC.req_loan_amt = _req_loan_amt;
                }
                [self.navigationController pushViewController:loanFirstVC animated:true];
            }
            
        }
            break;
        default:
            break;
    }
}

- (void)popViewFamily
{
    _alertView = [[[NSBundle mainBundle] loadNibNamed:@"testView" owner:self options:nil] lastObject];
    _alertView.frame = CGRectMake(0, 0, _k_w, _k_h);
    _alertView.lbltitle.text = @"\n是否愿意家人知晓";
    _alertView.lbltitle.textColor = rgb(95, 95, 95);
    [_alertView.DisSureBtn setTitleColor:rgb(142, 142, 142) forState:UIControlStateNormal];
    [_alertView.sureBtn setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
    _alertView.DisSureBtn.tag = 2500;
    _alertView.sureBtn.tag = 2501;
    [_alertView.DisSureBtn setTitle:@"否" forState:UIControlStateNormal];
    [_alertView.sureBtn setTitle:@"是" forState:UIControlStateNormal];
    [_alertView.DisSureBtn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView.sureBtn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView show];
}

#pragma mark->colledgeViewDelegate
-(void)ColledgeDelegateNString:(NSString *)CollString andIndex:(NSIndexPath *)indexPath
{
    [dataListAll replaceObjectAtIndex:2 withObject:CollString];
    [dataColor replaceObjectAtIndex:2 withObject:UI_MAIN_COLOR];
    [_tableView0 reloadData];
}

#pragma mark ->读取通讯录ContactViewControllerDelegate

-(void)GetContactName:(NSString *)name TelPhone:(NSString *)telph andFlagTure:(NSInteger)flagInteger
{
    if ([CheckUtils checkTelNumber:telph] && ![telph isEqualToString:_TelPhoneExt.mobilePhone]) {
        if (flagInteger == 207) {
            if ([CheckUtils checkUserName:name] ) {
                [dataListAll replaceObjectAtIndex:6 withObject:name];
                [dataColor replaceObjectAtIndex:6 withObject:UI_MAIN_COLOR];
            }else{
                NSString *na = @"";
                if (name) {
                    na = name;
                }
                [dataListAll replaceObjectAtIndex:6 withObject:na];
                [dataColor replaceObjectAtIndex:6 withObject:redColor];
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人姓名"];
            }
            
            [dataListAll replaceObjectAtIndex:7 withObject:[self formatString:telph]];
            [dataColor replaceObjectAtIndex:7 withObject:UI_MAIN_COLOR];
        }
        if (flagInteger == 210) {
            if ([CheckUtils checkUserName:name]) {
                [dataColor replaceObjectAtIndex:9 withObject:UI_MAIN_COLOR];
                [dataListAll replaceObjectAtIndex:9 withObject:name];
            }else{
                NSString *na = @"";
                if (name) {
                    na = name;
                }
                [dataColor replaceObjectAtIndex:9 withObject:redColor];
                [dataListAll replaceObjectAtIndex:9 withObject:na];
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人姓名"];
            }
            
            [dataListAll replaceObjectAtIndex:10 withObject:[self formatString:telph]];
            [dataColor replaceObjectAtIndex:10 withObject:UI_MAIN_COLOR];
        }
        [_tableView0 reloadData];
    }else{
        NSString *na = @"";
        if (name) {
            na = name;
        }
        
        NSString *tel = @"";
        if (telph) {
            tel = telph;
        }
        
        if (flagInteger == 207) {
            [dataListAll replaceObjectAtIndex:6 withObject:na];
            [dataListAll replaceObjectAtIndex:7 withObject:tel];
            [dataColor replaceObjectAtIndex:6 withObject:redColor];
            [dataColor replaceObjectAtIndex:7 withObject:redColor];
        }
        if (flagInteger == 210) {
            [dataColor replaceObjectAtIndex:9 withObject:redColor];
            [dataColor replaceObjectAtIndex:10 withObject:redColor];
            [dataListAll replaceObjectAtIndex:9 withObject:na];
            [dataListAll replaceObjectAtIndex:10 withObject:tel];
        }
        [_tableView0 reloadData];
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选取通讯录中的手机号"];
    }
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self emptyTime];
    
    if (_lastInputTag == textField.tag) {
        _backCount++;
    }else {
        _backCount = 0;
    }
    
    //居住地详址
    if (textField.tag == 104 || textField.tag == 106 || textField.tag == 107 || textField.tag == 109 || textField.tag == 110 || textField.tag == 1000 || textField.tag == 10004) {
        
        _beginTime = [Tool getNowTimeMS];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    
    if (textField.tag == 102 || textField.tag == 103 || textField.tag == 105 || textField.tag == 108 || textField.tag == 1002|| textField.tag == 1003 || textField.tag == 1300) {
        return NO;
    }
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1301) {
        NSString *text = [textField text];
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        if (newString.length >= 24) {
            return NO;
        }
        
        [dataListAll3 replaceObjectAtIndex:1 withObject:newString];
        [textField setText:newString];
        return NO;
        
    }
    NSString *stringLength=[NSString stringWithFormat:@"%@%@",textField.text,string];
    if(textField.tag == 101)
    {
        if ([stringLength length]>18) {
            return NO;
        }
    }
    if (textField.tag == 107 || textField.tag ==110){
        NSString* text = textField.text;
        //删除
        if([string isEqualToString:@""]){
            //删除一位
            if(range.length == 1){
                //最后一位,遇到空格则多删除一次
                if (range.location == text.length-1 ) {
                    if ([text characterAtIndex:text.length-1] == ' ') {
                        [textField deleteBackward];
                    }
                    return YES;
                }
                //从中间删除
                else{
                    NSInteger offset = range.location;
                    if (range.location < text.length && [text characterAtIndex:range.location] == ' ' && [textField.selectedTextRange isEmpty]) {
                        [textField deleteBackward];
                        offset --;
                    }
                    [textField deleteBackward];
                    textField.text = [self parseString:textField.text];
                    UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                    textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                    return NO;
                }
            } else if (range.length > 1) {
                BOOL isLast = NO;
                //如果是从最后一位开始
                if(range.location + range.length == textField.text.length ){
                    isLast = YES;
                }
                [textField deleteBackward];
                textField.text = [self parseString:textField.text];
                NSInteger offset = range.location;
                if (range.location == 3 || range.location == 8) {
                    offset ++;
                } if (isLast) {
                    //光标直接在最后一位了
                }else{
                    UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                    textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                }
                return NO;
            } else{
                return YES;
            }
        } else if(string.length >0){
            //限制输入字符个数
            if (([self noneSpaseString:textField.text].length + string.length - range.length > 11) ) {
                return NO;
            }
            [textField insertText:string];
            textField.text = [self parseString:textField.text];
            NSInteger offset = range.location + string.length;
            if (range.location == 3 || range.location == 8) {
                offset ++;
            }
            UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
            textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
            return NO;
        }else{
            return YES;
        }
        
    }
    if (textField.tag == 1005) {
        if ([stringLength length]>4) {
            return NO;
        }
    }
    if (textField.tag == 1001) {
        if ([stringLength length]>8) {
            return NO;
        }
    }
    return YES;
}

-(NSString*)noneSpaseString:(NSString*)string {
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}


- (NSString*)parseString:(NSString*)string {
    if (!string) {
        return nil;
    }
    NSMutableString* mStr = [NSMutableString stringWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
    if (mStr.length >3) {
        [mStr insertString:@" " atIndex:3];
    }if(mStr.length > 8) {
        [mStr insertString:@" " atIndex:8];
    }
    return mStr;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //    if (textField.tag == 104 || textField.tag == 106 || textField.tag == 107 || textField.tag == 109 || textField.tag == 110) {
    //        _endTime = [Tool getNowTimeMS];
    //        NSDictionary *paramDic = @{@"input_back_count_":@(_backCount),
    //                                   @"input_time_"};
    //    }
    _lastInputTag = textField.tag;
    NSDictionary *paramDic;
    
    if (textField.tag == 104 || textField.tag == 106 || textField.tag == 107 || textField.tag == 109 || textField.tag == 110 || textField.tag == 1000 || textField.tag == 10004) {
        //居住地详址
        if (textField.tag == 104) {
            _endTime = [Tool getNowTimeMS];
            
            paramDic = @{@"input_back_count_":@(_backCount),
                         @"input_time_":@(_endTime - _beginTime),
                         @"input_type_":@"3",
                         @"juid":[Utility sharedUtility].userInfo.juid};
        }
        //联系人1名字
        if (textField.tag == 106) {
            _endTime = [Tool getNowTimeMS];
            paramDic = @{@"input_back_count_":@(_backCount),
                         @"input_time_":@(_endTime - _beginTime),
                         @"input_type_":@"4",
                         @"juid":[Utility sharedUtility].userInfo.juid};
        }
        //联系人1电话
        if (textField.tag == 107) {
            _endTime = [Tool getNowTimeMS];
            paramDic = @{@"input_back_count_":@(_backCount),
                         @"input_time_":@(_endTime - _beginTime),
                         @"input_type_":@"5",
                         @"juid":[Utility sharedUtility].userInfo.juid};
        }
        //联系人2名字
        if (textField.tag == 109) {
            _endTime = [Tool getNowTimeMS];
            paramDic = @{@"input_back_count_":@(_backCount),
                         @"input_time_":@(_endTime - _beginTime),
                         @"input_type_":@"6",
                         @"juid":[Utility sharedUtility].userInfo.juid};
        }
        //联系人2电话
        if (textField.tag == 110) {
            _endTime = [Tool getNowTimeMS];
            paramDic = @{@"input_back_count_":@(_backCount),
                         @"input_time_":@(_endTime - _beginTime),
                         @"input_type_":@"7",
                         @"juid":[Utility sharedUtility].userInfo.juid};
        }
        //单位名称
        if (textField.tag == 1000) {
            _endTime = [Tool getNowTimeMS];
            paramDic = @{@"input_back_count_":@(_backCount),
                         @"input_time_":@(_endTime - _beginTime),
                         @"input_type_":@"10",
                         @"juid":[Utility sharedUtility].userInfo.juid};
        }
        
        if (textField.tag == 1004) {
            _endTime = [Tool getNowTimeMS];
            paramDic = @{@"input_back_count_":@(_backCount),
                         @"input_time_":@(_endTime - _beginTime),
                         @"input_type_":@"12",
                         @"juid":[Utility sharedUtility].userInfo.juid};
        }
        [[FXDNetWorkManager sharedNetWorkManager] POSTHideHUD:[NSString stringWithFormat:@"%@%@",_main_url,_saveInputBackInfo_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
            DLog(@"%@",object);
        } failure:^(EnumServerStatus status, id object) {
            
        }];
    }
    if (textField.tag == 100) {
        if (![CheckUtils checkUserNameHanzi:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的姓名"];
            [dataColor replaceObjectAtIndex:0 withObject:redColor];
            //            [dataListAll replaceObjectAtIndex:0 withObject:@""];
        }else{
            [dataListAll replaceObjectAtIndex:0 withObject:textField.text];
            [dataColor replaceObjectAtIndex:0 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 101) {
        if (![CheckUtils checkUserIdCard:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的身份证号"];
            [dataColor replaceObjectAtIndex:1 withObject:redColor];
            //            [dataListAll replaceObjectAtIndex:1 withObject:@""];
        }else{
            [dataListAll replaceObjectAtIndex:1 withObject:textField.text];
            [dataColor replaceObjectAtIndex:1 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 102) {
        if (textField.text.length <1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的学历"];
            [dataColor replaceObjectAtIndex:2 withObject:redColor];
        }else{
            [dataListAll replaceObjectAtIndex:2 withObject:textField.text];
            [dataColor replaceObjectAtIndex:2 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 103) {
        if (textField.text.length <2) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的现居住地"];
            [dataColor replaceObjectAtIndex:3 withObject:redColor];
        }else{
            [dataListAll replaceObjectAtIndex:3 withObject:textField.text];
            [dataColor replaceObjectAtIndex:3 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 104) {
        NSString *deta = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![CheckUtils checkUserDetail:deta] || [CheckUtils checkNumber1_30wei:deta]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的居住地详址"];
            [dataColor replaceObjectAtIndex:4 withObject:redColor];
        }else{
            [dataListAll replaceObjectAtIndex:4 withObject:textField.text];
            [dataColor replaceObjectAtIndex:4 withObject:UI_MAIN_COLOR];
            flagPlace = 2;
        }
    }
    if (textField.tag == 105) {
        if (![CheckUtils checkUserName:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人关系"];
            [dataColor replaceObjectAtIndex:5 withObject:redColor];
        }else{
            [dataListAll replaceObjectAtIndex:5 withObject:textField.text];
            [dataColor replaceObjectAtIndex:5 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 106) {
        if (![CheckUtils checkUserNameHanzi:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人姓名"];
            [dataColor replaceObjectAtIndex:6 withObject:redColor];
            
        }else if ([dataListAll[0] isEqualToString:textField.text]){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"联系人名称不能与本人一致"];
            [dataColor replaceObjectAtIndex:6 withObject:redColor];
        }else{
            [dataListAll replaceObjectAtIndex:6 withObject:textField.text];
            [dataColor replaceObjectAtIndex:6 withObject:UI_MAIN_COLOR];
            
        }
    }
    if (textField.tag == 107) {
        NSString *telString = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![CheckUtils checkTelNumber:telString]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人手机号"];
            [dataColor replaceObjectAtIndex:7 withObject:redColor];
            
        }else if ([telString isEqualToString:_TelPhoneExt.mobilePhone]){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"联系人号码不能与本人一致"];
            [dataColor replaceObjectAtIndex:7 withObject:redColor];
        } else{
            [dataListAll replaceObjectAtIndex:7 withObject:textField.text];
            [dataColor replaceObjectAtIndex:7 withObject:UI_MAIN_COLOR];
            
        }
    }
    if (textField.tag == 108) {
        if (![CheckUtils checkUserName:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人关系"];
            [dataColor replaceObjectAtIndex:8 withObject:redColor];
        }else{
            [dataListAll replaceObjectAtIndex:8 withObject:textField.text];
            [dataColor replaceObjectAtIndex:8 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 109) {
        if (![CheckUtils checkUserNameHanzi:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人姓名"];
            [dataColor replaceObjectAtIndex:9 withObject:redColor];
            
        }else if ([dataListAll[0] isEqualToString:textField.text]){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"联系人名称不能与本人一致"];
            [dataColor replaceObjectAtIndex:9 withObject:redColor];
        }else if ([dataListAll[6] isEqualToString:textField.text]){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"两个联系人名称不能一致"];
            [dataColor replaceObjectAtIndex:9 withObject:redColor];
        }else{
            [dataListAll replaceObjectAtIndex:9 withObject:textField.text];
            [dataColor replaceObjectAtIndex:9 withObject:UI_MAIN_COLOR];
            
        }
    }
    if (textField.tag == 110) {
        NSString *telString = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![CheckUtils checkTelNumber:telString] ) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的联系人手机号"];
            [dataColor replaceObjectAtIndex:10 withObject:redColor];
            
        }else{
            if ([telString isEqualToString:_TelPhoneExt.mobilePhone]){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"联系人号码不能与本人一致"];
                [dataColor replaceObjectAtIndex:10 withObject:redColor];
            }else if ([textField.text isEqualToString:dataListAll[7]]){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"两个联系人号码不能一致"];
                [dataColor replaceObjectAtIndex:10 withObject:redColor];
            }else{
                [dataListAll replaceObjectAtIndex:10 withObject:textField.text];
                [dataColor replaceObjectAtIndex:10 withObject:UI_MAIN_COLOR];
            }
        }
    }
    
    //第三页的部分
    if (textField.tag == 1000) {
        if (![CheckUtils checkUserName:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的单位名称"];
            [datacolor1 replaceObjectAtIndex:0 withObject:redColor];
        }else{
            [dataListAll1 replaceObjectAtIndex:0 withObject:textField.text];
            [datacolor1 replaceObjectAtIndex:0 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 1001) {
        if (![self isCommonString:textField.text]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的单位电话"];
            [datacolor1 replaceObjectAtIndex:1 withObject:redColor];
        }else{
            [dataListAll1 replaceObjectAtIndex:1 withObject:textField.text];
            [datacolor1 replaceObjectAtIndex:1 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 1002) {
        if (textField.text.length < 5) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的行业/职业"];
            [datacolor1 replaceObjectAtIndex:2 withObject:redColor];
        }else{
            [dataListAll1 replaceObjectAtIndex:2 withObject:textField.text];
            [datacolor1 replaceObjectAtIndex:2 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 1003) {
        if (textField.text.length < 5) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的单位所在地"];
            [datacolor1 replaceObjectAtIndex:3 withObject:redColor];
        }else{
            [dataListAll1 replaceObjectAtIndex:3 withObject:textField.text];
            [datacolor1 replaceObjectAtIndex:3 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 1004) {
        NSString *detain = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![CheckUtils checkUserDetail:detain] || [CheckUtils checkNumber1_30wei:detain]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的单位详址"];
            [datacolor1 replaceObjectAtIndex:4 withObject:redColor];
        }else{
            [dataListAll1 replaceObjectAtIndex:4 withObject:textField.text];
            [datacolor1 replaceObjectAtIndex:4 withObject:UI_MAIN_COLOR];
        }
    }
    if (textField.tag == 1005) {
        if (![textField.text isAreaCode]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的区号"];
            [datacolor1 replaceObjectAtIndex:5 withObject:redColor];
        }else{
            [dataListAll1 replaceObjectAtIndex:5 withObject:textField.text];
            [datacolor1 replaceObjectAtIndex:5 withObject:UI_MAIN_COLOR];
        }
    }
    //第三页部分
    if (textField.tag == 1100) {
        if (textField.text.length < 6) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的运营商服务密码"];
        }else{
            [dataListAll2 replaceObjectAtIndex:0 withObject:textField.text];
            [self approveUIWith:0];
        }
    }
    if (textField.tag == 1101) {
        if (textField.text.length < 3) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的验证码"];
        }else{
            [dataListAll2 replaceObjectAtIndex:1 withObject:textField.text];
        }
    }
    if (textField.tag < 111 && textField.tag > 10) {
        if ([self isCanSelectBtn]) {
            flagPlace = 2;
            NSIndexPath *indexPat=[NSIndexPath indexPathForRow:textField.tag -100 inSection:0];
            NSArray *indexArray=[NSArray arrayWithObject:indexPat];
            [_tableView0 reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
        }else{
            if ([self iscanFlagBtn]) {
                [_tableView0 reloadData];
            }else{
                flagPlace = 1;
                NSIndexPath *indexPath_1=[NSIndexPath indexPathForRow:textField.tag -100 inSection:0];
                NSArray *indexArray=[NSArray arrayWithObject:indexPath_1];
                [_tableView0 reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
    }
    
    [self isTureOrErrorTextField];
}

#pragma mark ->is 判断真假
//判断所有条件为真为假
-(void)isTureOrErrorTextField
{
    //假如第二页为真
    if ([self isCanSelectBtn1]) {
        _selectBtn1 = YES;
    }else{
        _selectBtn1 = NO;
    }
    
    //第3页手机号
    if ([self isCanSelectBtn2]) {
        [_telBtn setEnabled:YES];
    }else{
        [_telBtn setEnabled:NO];
    }
    
    [self RefrenchUIBtn];
    
    
}

//判断是否全部相等
-(BOOL)isCommonString:(NSString *)str{
    if (str.length <7 || str.length >8) {
        return NO;
    }
    char firstChar = [str characterAtIndex:0];
    for (int i = 1; i< str.length; i++) {
        if (firstChar != [str characterAtIndex:i]) {
            return YES;
        }
    }
    return NO;
}

//判断第一页的参数 给人信息
-(BOOL)iscanFlagBtn
{
    if ([CheckUtils checkUserName:[dataListAll objectAtIndex:0]] && [CheckUtils checkUserIdCard:[dataListAll objectAtIndex:1]] && [[dataListAll objectAtIndex:2] length] >1 && [[dataListAll objectAtIndex:3] length] >= 1 && [[dataListAll objectAtIndex:4] length] >1) {
        flagPlace = 2;
        return YES;
    }else {
        flagPlace = 1;
        return NO;
    }
}
-(BOOL)isCanSelectBtn{
    
    NSString *tel1 = [dataListAll[7] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *tel2 = [dataListAll[10] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([CheckUtils checkUserNameHanzi:[dataListAll objectAtIndex:0]] && [CheckUtils checkUserIdCard:[dataListAll objectAtIndex:1]] && [[dataListAll objectAtIndex:2] length] >1 && [[dataListAll objectAtIndex:3] length] >1 && [[dataListAll objectAtIndex:4] length] >1 && [CheckUtils checkUserName:[dataListAll objectAtIndex:5]] && [[dataListAll objectAtIndex:6] length] >=1 && [CheckUtils checkTelNumber:tel1] && [CheckUtils checkUserName:[dataListAll objectAtIndex:8]] && [[dataListAll objectAtIndex:9] length] >=1 && [CheckUtils checkTelNumber:tel2] && ![dataListAll[0] isEqualToString:dataListAll[6]] && ![dataListAll[6] isEqualToString:dataListAll[9]] && ![dataListAll[7] isEqualToString:dataListAll[10]] && ![tel1 isEqualToString:_TelPhoneExt.mobilePhone]) {
        for (int i=0; i<15; i++) {
            
            [dataColor replaceObjectAtIndex:i withObject:UI_MAIN_COLOR];
            
        }
        
        return YES;
    }else {
        
        return NO;
    }
}
//职业信息
-(BOOL)isCanSelectBtn1
{
    if ([CheckUtils checkUserName:dataListAll1[0]] && [dataListAll1[2] length]>=2 && [dataListAll1[3] length]>1 && [dataListAll1[4] length]>2 && [dataListAll1[5] isAreaCode] && [self isCommonString:dataListAll1[1]]) {
        
        return YES;
    }else {
        return NO;
    }
}
//手机密码 确认按钮
-(BOOL)isCanSelectBtn2
{
    if ([dataListAll2[0] length] >5) {
        return YES;
    }else{
        return NO;
    }
}
//手机密码认证进度
-(BOOL)isTelScory
{
    if ([dataListAll2[13] isEqualToString:@"2"]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isFaceProcess
{
    if ([dataListAll2[14] isEqualToString:@"1"]) {
        return YES;
    } else {
        return NO;
    }
}

//银行卡
-(BOOL)isCanSelectBtn3
{
    if ([dataListAll3[0] length] > 2 && [dataListAll3[1] length]>15) {
        return YES;
    }else{
        return NO;
    }
}

-(void)RefrenchUIBtn
{
    [self iscanFlagBtn];
    [_tableView0 reloadData];
    [_tableView1 reloadData];
    [_tableView3 reloadData];
}
#pragma mark -> 网络请求参数与模型数据
- (NSDictionary *)getInfoMsg
{
    
    NSString *degree = @"";
    for (int i = 0; i < eduLevelArray.count; i++) {
        if ([eduLevelArray[i] isEqualToString:dataListAll[2]]) {
            degree = [NSString stringWithFormat:@"%d",i+1];
        }
    }
    NSString *contactShip =@"";
    if ([dataListAll[5] isEqualToString:@"父母"]) {
        contactShip = @"1";
    }else if ([dataListAll[5] isEqualToString:@"配偶"]){
        contactShip = @"2";
    }
    NSString *contactShip1 = @"";
    if ([dataListAll[8] isEqualToString:@"朋友"]) {
        contactShip1 = @"8";
    }else if ([dataListAll[8] isEqualToString:@"同事"]){
        contactShip1 = @"4";
    }
    NSString *addressDetail = [dataListAll[4] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *tel1 = [dataListAll[7] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *tel2 = [dataListAll[10] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return @{@"customer_name_":[dataListAll objectAtIndex:0],
             @"id_type_":@"1",
             @"id_code_":[dataListAll objectAtIndex:1],
             @"education_level_":degree,
             @"province_":_cityCode.provinceCode,
             @"city_":_cityCode.cityCode,
             @"county_":_cityCode.districtCode,
             @"home_address_":addressDetail,
             @"relationship_":contactShip,
             @"contact_name_":[dataListAll objectAtIndex:6],
             @"contact_phone_":tel1,
             @"relationship1_":contactShip1,
             @"contact_name1_":[dataListAll objectAtIndex:9],
             @"contact_phone1_":tel2
             };
    
}

//获取职业
- (NSDictionary *)getProfessionInfo
{
    
    NSString *telString =[NSString stringWithFormat:@"%@-%@",dataListAll1[5],dataListAll1[1]];
    NSString *profefssiontag = @"";
    for (int i = 0; i < _professionArray.count; i++) {
        if ([dataListAll1[2] isEqualToString:_professionArray[i]]) {
            profefssiontag =[NSString stringWithFormat:@"%d",i+1];
        }
    }
    NSString *cityDetail = [dataListAll1[4] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *companyString  = [dataListAll1[0] stringByReplacingOccurrencesOfString:@" " withString:@""];
    return @{@"organization_name_":companyString,
             @"organization_telephone_":telString,
             @"industry_":profefssiontag,
             @"province_":_city1Code.provinceCode,
             @"city_":_city1Code.cityCode,
             @"country_":_city1Code.districtCode,
             @"organization_address_":cityDetail,
             @"product_id_":[Utility sharedUtility].userInfo.pruductId};
}



//个人基本信息
- (void)setValueOfDataArr
{
    if (_customerBaseInfoModel.result.customerName) {
        [dataListAll replaceObjectAtIndex:0 withObject:_customerBaseInfoModel.result.customerName];
    }
    if (_customerBaseInfoModel.result.idCode) {
        [dataListAll replaceObjectAtIndex:1 withObject:_customerBaseInfoModel.result.idCode];
    }
    //学历
    NSInteger eduLevel = [_customerBaseInfoModel.result.educationLevel floatValue];
    for (int i = 1; i<7; i++) {
        if (i == eduLevel) {
            [dataListAll replaceObjectAtIndex:2 withObject:eduLevelArray[i-1]];
        }
    }
    //现居地址
    if (_customerBaseInfoModel.result.provinceName && _customerBaseInfoModel.result.cityName && _customerBaseInfoModel.result.countyName){
        NSString *proviece_city = @"";
        NSString *poro = [NSString stringWithFormat:@"%@/%@/%@",_customerBaseInfoModel.result.provinceName,_customerBaseInfoModel.result.cityName,_customerBaseInfoModel.result.countyName];;
        
        if ([_customerBaseInfoModel.result.provinceName isEqualToString: _customerBaseInfoModel.result.cityName]) {
            proviece_city = [NSString stringWithFormat:@"%@/%@",_customerBaseInfoModel.result.cityName,_customerBaseInfoModel.result.countyName];
        }else if ([_customerBaseInfoModel.result.countyName isEqualToString: _customerBaseInfoModel.result.cityName]){
            proviece_city = [NSString stringWithFormat:@"%@/%@",_customerBaseInfoModel.result.provinceName,_customerBaseInfoModel.result.cityName];
        }else{
            proviece_city = [NSString stringWithFormat:@"%@/%@/%@",_customerBaseInfoModel.result.provinceName,_customerBaseInfoModel.result.cityName,_customerBaseInfoModel.result.countyName];
        }
        [dataListAll1 replaceObjectAtIndex:6 withObject:poro];
        [dataListAll replaceObjectAtIndex:3 withObject:proviece_city];
    }else{
        if (_customerBaseInfoModel.result.province && _customerBaseInfoModel.result.city && _customerBaseInfoModel.result.county) {
            NSString *proviece_city = [NSString stringWithFormat:@"%@/%@/%@",_customerBaseInfoModel.result.province,_customerBaseInfoModel.result.city,_customerBaseInfoModel.result.county];
            [dataListAll1 replaceObjectAtIndex:6 withObject:proviece_city];
            [dataListAll replaceObjectAtIndex:3 withObject:proviece_city];
        }
    }
    
    //详细
    if (_customerBaseInfoModel.result.homeAddress) {
        
        [dataListAll replaceObjectAtIndex:4 withObject:_customerBaseInfoModel.result.homeAddress];
    }
    if (_customerBaseInfoModel.result.contactBean.count >= 2) {
        CustomerBaseInfoContactBean *contactBeanModel= _customerBaseInfoModel.result.contactBean[0];
        CustomerBaseInfoContactBean *contactBeanModel1= _customerBaseInfoModel.result.contactBean[1];
        if ([contactBeanModel.relationship isEqualToString:@"1"] || [contactBeanModel.relationship isEqualToString:@"2"]) {
            if (contactBeanModel.relationship) {
                if ([contactBeanModel.relationship isEqualToString:@"1"]) {
                    [dataListAll replaceObjectAtIndex:5 withObject:@"父母"];
                }
                if ([contactBeanModel.relationship isEqualToString:@"2"]) {
                    [dataListAll replaceObjectAtIndex:5 withObject:@"配偶"];
                }
            }
            //姓名
            if (contactBeanModel.contactName && ![contactBeanModel.contactName isEqualToString:_customerBaseInfoModel.result.customerName]) {
                [dataListAll replaceObjectAtIndex:6 withObject:contactBeanModel.contactName];
            }
            //电话
            if (contactBeanModel.contactPhone && ![_TelPhoneExt.mobilePhone isEqualToString:contactBeanModel.contactPhone]) {
                [dataListAll replaceObjectAtIndex:7 withObject:[self formatString:contactBeanModel.contactPhone]];
            }
            
            
            if (contactBeanModel1.relationship) {
                if ([contactBeanModel1.relationship isEqualToString:@"4"]) {
                    [dataListAll replaceObjectAtIndex:8 withObject:@"同事"];
                }
                if ([contactBeanModel1.relationship isEqualToString:@"8"]) {
                    [dataListAll replaceObjectAtIndex:8 withObject:@"朋友"];
                }
            }
            //姓名
            if (contactBeanModel1.contactName && ![contactBeanModel.contactName isEqualToString:_customerBaseInfoModel.result.customerName] && ![contactBeanModel.contactName isEqualToString:contactBeanModel1.contactName]) {
                [dataListAll replaceObjectAtIndex:9 withObject:contactBeanModel1.contactName];
            }
            //电话
            if (contactBeanModel1.contactPhone && ![contactBeanModel1.contactPhone isEqualToString:contactBeanModel.contactPhone] && ![_TelPhoneExt.mobilePhone isEqualToString:contactBeanModel1.contactPhone]) {
                [dataListAll replaceObjectAtIndex:10 withObject:[self formatString: contactBeanModel1.contactPhone]];
            }
            
        }else{
            if (contactBeanModel1.relationship) {
                if ([contactBeanModel1.relationship isEqualToString:@"1"]) {
                    [dataListAll replaceObjectAtIndex:5 withObject:@"父母"];
                }
                if ([contactBeanModel1.relationship isEqualToString:@"2"]) {
                    [dataListAll replaceObjectAtIndex:5 withObject:@"配偶"];
                }
                
            }
            //姓名
            if (contactBeanModel1.contactName && ![contactBeanModel1.contactName isEqualToString:_customerBaseInfoModel.result.customerName]) {
                [dataListAll replaceObjectAtIndex:6 withObject:contactBeanModel1.contactName];
            }
            //电话
            if (contactBeanModel1.contactPhone && ![_TelPhoneExt.mobilePhone isEqualToString:contactBeanModel1.contactPhone]) {
                [dataListAll replaceObjectAtIndex:7 withObject:[self formatString:contactBeanModel1.contactPhone]];
            }
            
            
            if (contactBeanModel.relationship) {
                if ([contactBeanModel.relationship isEqualToString:@"4"]) {
                    [dataListAll replaceObjectAtIndex:8 withObject:@"同事"];
                }
                if ([contactBeanModel.relationship isEqualToString:@"8"]) {
                    [dataListAll replaceObjectAtIndex:8 withObject:@"朋友"];
                }
            }
            //姓名
            if (contactBeanModel.contactName && ![contactBeanModel.contactName isEqualToString:_customerBaseInfoModel.result.customerName] && ![contactBeanModel.contactName isEqualToString:contactBeanModel1.contactName]) {
                [dataListAll replaceObjectAtIndex:9 withObject:contactBeanModel.contactName];
            }
            //电话
            if (contactBeanModel.contactPhone && ![_TelPhoneExt.mobilePhone isEqualToString:contactBeanModel.contactPhone] && ![contactBeanModel1.contactPhone isEqualToString:contactBeanModel.contactPhone]) {
                [dataListAll replaceObjectAtIndex:10 withObject:[self formatString: contactBeanModel.contactPhone]];
            }
        }
    }
}

- (NSString *)formatString:(NSString *)str
{
    NSMutableString *returnStr = [NSMutableString stringWithString:str];
    
    NSMutableString *zbc = [NSMutableString string];
    for (NSInteger i = 0; i < returnStr.length; i++) {
        unichar c = [returnStr characterAtIndex:i];
        if (i > 0) {
            if (i == 2) {
                [zbc appendFormat:@"%C ",c];
                
            }else if (i == 6){
                [zbc appendFormat:@"%C ",c];
            }else {
                [zbc appendFormat:@"%C",c];
            }
        } else {
            [zbc appendFormat:@"%C",c];
        }
    }
    
    return zbc;
}

//获取职业信息
- (void)setValueOfProArr
{
    //    dataListAll1
    
    if (_carrerInfoModel.result.organizationName) {
        [dataListAll1 replaceObjectAtIndex:0 withObject:_carrerInfoModel.result.organizationName];
    }
    if (_carrerInfoModel.result.organizationTelephone) {
        if ([_carrerInfoModel.result.organizationTelephone length]>9) {
            NSString *telString= _carrerInfoModel.result.organizationTelephone;
            NSArray *telArray = [telString componentsSeparatedByString:@"-"];
            if (telArray.count >1) {
                if ([telArray[0] isAreaCode]) {
                    [dataListAll1 replaceObjectAtIndex:5 withObject:telArray[0]];
                }
                if ([self isCommonString:telArray[1]]) {
                    [dataListAll1 replaceObjectAtIndex:1 withObject:telArray[1]];
                }
                
            }else{
                telString = [_carrerInfoModel.result.organizationTelephone areaCodeFormat];
                NSArray *telArray1 = [telString componentsSeparatedByString:@"-"];
                if ([telArray1[0] isAreaCode]) {
                    [dataListAll1 replaceObjectAtIndex:5 withObject:telArray1[0]];
                }
                if ([self isCommonString:telArray1[1]]) {
                    [dataListAll1 replaceObjectAtIndex:1 withObject:telArray1[1]];
                }
            }
            
        }else{
            
            if ([self isCommonString:_carrerInfoModel.result.organizationTelephone]) {
                [dataListAll1 replaceObjectAtIndex:1 withObject:_carrerInfoModel.result.organizationTelephone];
            }
        }
    }
    //行业
    if (_carrerInfoModel.result.industry) {
        NSInteger tagflag = [_carrerInfoModel.result.industry integerValue];
        for (int i = 1; i< 11; i++) {
            if (i == tagflag) {
                [dataListAll1 replaceObjectAtIndex:2 withObject:_professionArray[i-1]];
            }
        }
    }
    if (_carrerInfoModel.result.cityName && _carrerInfoModel.result.provinceName && _carrerInfoModel.result.countryName){
        NSString *addree = @"";
        NSString *add = [NSString stringWithFormat:@"%@/%@/%@",_carrerInfoModel.result.provinceName,
                         _carrerInfoModel.result.cityName,_carrerInfoModel.result.countryName];
        if ([_carrerInfoModel.result.cityName isEqualToString: _carrerInfoModel.result.provinceName]) {
            addree = [NSString stringWithFormat:@"%@/%@",
                      _carrerInfoModel.result.cityName,_carrerInfoModel.result.countryName];
        }else if ([_carrerInfoModel.result.cityName isEqualToString: _carrerInfoModel.result.countryName]){
            addree = [NSString stringWithFormat:@"%@/%@",_carrerInfoModel.result.provinceName,
                      _carrerInfoModel.result.cityName];
        }else{
            addree = [NSString stringWithFormat:@"%@/%@/%@",_carrerInfoModel.result.provinceName,
                      _carrerInfoModel.result.cityName,_carrerInfoModel.result.countryName];
        }
        [dataListAll1 replaceObjectAtIndex:7 withObject:add];
        [dataListAll1 replaceObjectAtIndex:3 withObject:addree];
    }else{
        if(_carrerInfoModel.result.city && _carrerInfoModel.result.province && _carrerInfoModel.result.country)
        {
            NSString *addree = [NSString stringWithFormat:@"%@/%@/%@",_carrerInfoModel.result.province,
                                _carrerInfoModel.result.city,_carrerInfoModel.result.country];
            [dataListAll1 replaceObjectAtIndex:3 withObject:addree];
        }
    }
    if (_carrerInfoModel.result.organizationAddress) {
        [dataListAll1 replaceObjectAtIndex:4 withObject:_carrerInfoModel.result.organizationAddress];
    }
}

- (void)setValueOfCreditArr
{
    if (![[Utility sharedUtility].userInfo.userInfoModel.result.realName isEqualToString:@""] && [Utility sharedUtility].userInfo.userInfoModel.result.realName != nil && [Utility sharedUtility].userInfo.userInfoModel.result.creditBankName != nil ) {
        if ([Utility sharedUtility].userInfo.userInfoModel.result.creditBankName) {
            [dataListAll3 insertObject:[Utility sharedUtility].userInfo.userInfoModel.result.creditBankName atIndex:0];
        }else{
            [dataListAll3 insertObject:@"" atIndex:0];
        }
        if ([Utility sharedUtility].userInfo.userInfoModel.result.creditCardNo) {
            [dataListAll3 insertObject:[Utility sharedUtility].userInfo.userInfoModel.result.creditCardNo atIndex:1];
        }else{
            [dataListAll3 insertObject:@"" atIndex:1];
        }
        if ([Utility sharedUtility].userInfo.userInfoModel.result.creditBankNo) {
            [dataListAll3 insertObject:[Utility sharedUtility].userInfo.userInfoModel.result.creditBankNo atIndex:2];
        }else{
            [dataListAll3 insertObject:@"" atIndex:2];
        }
        
        [dataListAll3 insertObject:@"100" atIndex:3];
    } else {
        for (int i = 0; i < 10; i++) {
            [dataListAll3 addObject:@""];
        }
        [dataListAll3 insertObject:@"100" atIndex:3];
    }
}




#pragma mark -> 职业信息保存
-(void) postSaveCustomerCarrer
{
    if (![_city1Code.provinceCode isEqualToString:@""] && ![_city1Code.cityCode isEqualToString:@""] && ![_city1Code.districtCode isEqualToString:@""]) {
        //职业信息保存
        NSDictionary *dictry = [self getProfessionInfo];
        
        SaveCustomerCarrerViewModel *saveCustomerCarrerViewModel = [[SaveCustomerCarrerViewModel alloc] init];
        [saveCustomerCarrerViewModel setBlockWithReturnBlock:^(id returnValue) {
            _careerParse = [CareerParse yy_modelWithJSON:returnValue];
            if ([_careerParse.flag isEqualToString:@"0000"]) {
                _segment.selectedSegmentIndex =2;
                [self createUIWith:_segment.selectedSegmentIndex];
                
            }else{
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[returnValue objectForKey:@"msg"]];
            }
        } WithFaileBlock:^{
            
        }];
        [saveCustomerCarrerViewModel saveCustomCarrer:dictry];
    }else{
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择单位所在地"];
    }
}

#pragma mark-> PostgetCustomerCarrer_jhtml 获取职业信息

-(void)PostgetCustomerCarrer_jhtml
{
    GetCareerInfoViewModel *getCareerInfoViewModel = [[GetCareerInfoViewModel alloc] init];
    [getCareerInfoViewModel setBlockWithReturnBlock:^(id returnValue) {
        _carrerInfoModel = returnValue;
        if ([_carrerInfoModel.flag isEqualToString:@"0000"]) {
            //给职业信息赋值
            [self setValueOfProArr];
            [_tableView1 reloadData];
        }
    } WithFaileBlock:^{
        
    }];
    [getCareerInfoViewModel fatchCareerInfo:nil];
}

#pragma mark -> 个人信息保存接口
-(void)PostCustomerInfoSaveBase
{
    DLog(@"%@---%@",dataListAll[3],dataListAll1[6]);
    if (![_cityCode.provinceCode isEqualToString:@""] && ![_cityCode.cityCode isEqualToString:@""] && ![_cityCode.districtCode isEqualToString:@""]) {
        NSDictionary *dicParam = [self getInfoMsg];
        SaveCustomBaseViewModel *saveCustomBaseViewModel = [[SaveCustomBaseViewModel alloc] init];
        [saveCustomBaseViewModel setBlockWithReturnBlock:^(id returnValue) {
            if ([[returnValue objectForKey:@"flag"]isEqualToString:@"0000"]) {
                [UserDefaulInfo getUserInfoData];
                _segment.selectedSegmentIndex =1;
                [dataListAll1 replaceObjectAtIndex:3 withObject:dataListAll[3]];
                [dataListAll1 replaceObjectAtIndex:7 withObject:dataListAll1[6]];
                [self createUIWith:_segment.selectedSegmentIndex];
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[returnValue objectForKey:@"msg"]];
            }
        } WithFaileBlock:^{
            
        }];
        [saveCustomBaseViewModel saveCustomBaseInfo:dicParam];
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择现居地址"];
    }
}

#pragma mark->获取个人信息
-(void)PostPersonInfoMessage
{
    GetCustomerBaseViewModel *getCustomerBaseViewModel = [[GetCustomerBaseViewModel alloc] init];
    [getCustomerBaseViewModel setBlockWithReturnBlock:^(id returnValue) {
        _customerBaseInfoModel = returnValue;
        
        if ([_customerBaseInfoModel.flag isEqualToString:@"0000"]) {
            _TelPhoneExt = _customerBaseInfoModel.ext;
            [self setValueOfDataArr];
            [self iscanFlagBtn];
            [self isSetEnableSegment];
            [_tableView0 reloadData];
        } else {
            flagPlace = 1;
        }
    } WithFaileBlock:^{
        
    }];
    [getCustomerBaseViewModel fatchCustomBaseInfo:nil];
    
}

#pragma mark ->手机认证
-(void)PostTelSecory:(NSDictionary *)dicParam{
    
    
    if ([_careerParse.result.resultcode isEqualToString:@"0"]) {
        [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_Certification_url] parameters:dicParam finished:^(EnumServerStatus status, id object) {
            if (status == Enum_SUCCESS) {
                _mobileParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
                if ([_mobileParse.flag isEqualToString:@"0000"])
                {
                    //                [dataListAll2 replaceObjectAtIndex:13 withObject:@"2"];
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_mobileParse.msg];
                    //                _segment.selectedSegmentIndex = 1;
                    //                [self createUIWith:_segment.selectedSegmentIndex];
                    [self saveMobileAuth:@"1"];
                }else if ([_mobileParse.flag isEqualToString:@"0006"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_mobileParse.msg];
                    [dataListAll2 replaceObjectAtIndex:12 withObject:@"flag"];
                    viewSecory1.hidden =NO;//错误时 验证码显示
                }else{
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_mobileParse.msg];
                    [self saveMobileAuth:@"-1"];
                }
            }
        } failure:^(EnumServerStatus status, id object) {
            
        }];
    } else {
        [self saveMobileAuth:@"1"];
    }
}

#pragma mark ->手机认证获取接口
-(void)PostTelGetUrl
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_checkMobilePhoneAuth_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            _checkMobileDic = object;
            _telNum = [[object objectForKey:@"ext"] objectForKey:@"mobile_phone_"];
            if ([[object objectForKey:@"flag"]isEqualToString:@"0000"])
            {
                if ([[object objectForKey:@"result"] isEqualToString:@"1"]) {
                    [dataListAll2 replaceObjectAtIndex:13 withObject:@"2"];
                }else {
                    [dataListAll2 replaceObjectAtIndex:13 withObject:@"0"];
                }
                [_tableView2 reloadData];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
    
}

#pragma mark->获取省市区

-(void)PostGetCity
{
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getAllRegionList_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"]isEqualToString:@"0000"])
            {
                _reginBase = [RegionBaseClass modelObjectWithDictionary:object];
                for (int i = 0; i < _reginBase.result.count; i++) {
                    //取出省
                    _regionSub = _reginBase.result[i];
                    [_pickerArray addObject:_regionSub.name];
                }
                
                //第一个省的所有区
                RegionSub *regisonSubModel = _reginBase.result[0];
                for (int j = 0; j < regisonSubModel.sub.count; j++) {
                    RegionResult *regionResultModel = regisonSubModel.sub[j];
                    [_subPickerArray addObject:regionResultModel.name];
                }
                
                //第一个区的县的所有县
                RegionResult *regionResultModel = regisonSubModel.sub[0];
                for (int j = 0; j < regionResultModel.sub.count; j++) {
                    //取出市
                    [_thirdPickerArray addObject:[regionResultModel.sub[j] objectForKey:@"name"]];
                    
                }
                
                [_localPicker reloadAllComponents];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请求失败"];
    }];
}

#pragma mark -> 获取产品id
-(void)PostGetProductID:(NSInteger)tag
{
    
    if (tag == 1 || tag == 0) {
        //进件
        LoanSureFirstViewController *loanFirstVC = [[LoanSureFirstViewController alloc] init];
        loanFirstVC.productId = [Utility sharedUtility].userInfo.pruductId;
        loanFirstVC.if_family_know = [NSString stringWithFormat:@"%ld",tag];
        DLog(@"%@-------%@",_careerParse.result.resultcode,_careerParse.result.rulesid);
        loanFirstVC.resultCode = _careerParse.result.resultcode;
        loanFirstVC.rulesId = _careerParse.result.rulesid;
        if ([[Utility sharedUtility].userInfo.pruductId isEqualToString:@"P001004"]) {
            loanFirstVC.req_loan_amt = _req_loan_amt;
        }
        [self.navigationController pushViewController:loanFirstVC animated:true];
    }
    //    //获取产品id
    //    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getProductList_jhtml] parameters:nil finished:^(EnumServerStatus status, id object) {
    //        if (status == Enum_SUCCESS) {
    //            if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
    //                ProductListBaseClass *proList = [ProductListBaseClass modelObjectWithDictionary:object];
    //                _proResult = proList.result[0];
    //
    //
    //            } else {
    //            }
    //        }
    //    } failure:^(EnumServerStatus status, id object) {
    //        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请求失败"];
    //    }];
}


#pragma mark ->获取省市区代码
-(void)PostGetCityCode:(NSString *)datalisCity Tag:(NSInteger)tag
{
    //获取省市区代码
    NSArray *cityArray = [datalisCity componentsSeparatedByString:@"/"];
    NSString *city0 = @"";
    NSString *city1 = @"";
    NSString *city2 = @"";
    if (cityArray.count > 2) {
        city0 = cityArray[0];
        city1 = cityArray[1];
        city2 = cityArray[2];
    }
    
    NSDictionary *dict = @{@"provinceName":city0,
                           @"cityName":city1,
                           @"districtName":city2
                           };
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getRegionCodeByName_jhtml] parameters:dict finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
                _regionCodeParse = [RegionCodeBaseClass modelObjectWithDictionary:object];
                if (tag == 203) {
                    _cityCode = _regionCodeParse.result;
                    [self PostCustomerInfoSaveBase];
                }else if(tag == 2003){
                    _city1Code = _regionCodeParse.result;
                    [self postSaveCustomerCarrer];
                }
                
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择省市区"];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}


- (void)emptyTime
{
    _beginTime = 0;
    _endTime = 0;
    //    _backCount = 0;
}


@end
