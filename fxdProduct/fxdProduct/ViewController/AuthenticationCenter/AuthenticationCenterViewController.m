//
//  AuthenticationCenterViewController.m
//  fxdProduct
//
//  Created by sxp on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "AuthenticationCenterViewController.h"
#import "PserInfoViewController.h"
#import "ProfessionViewController.h"
#import "UserContactsViewController.h"
#import "CertificationViewController.h"
#import "EditCardsController.h"
#import "SesameCreditViewController.h"
#import "UserDataModel.h"
#import "UserDataViewModel.h"
#import "HighRandingModel.h"
#import "GetCustomerBaseViewModel.h"
#import "Custom_BaseInfo.h"
#import "DataWriteAndRead.h"
#import "GetCareerInfoViewModel.h"
#import "CustomerCareerBaseClass.h"
#import "CertificationViewController.h"

@interface AuthenticationCenterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ProfessionDataDelegate>

{

    NSArray *_imageArr;
    NSArray *_titleArr;
    NSArray * _promtpTitleArr;
    BOOL isPhoneAuthType;
    
    //各种认证状态
    NSString *_nextStep;
    NSString *_resultCode;
    NSString *_rulesId;
    NSString *_isMobileAuth;
    NSString *_isZmxyAuth;
    NSString *_phoneAuthChannel;
    NSString *_creditCardStatus;
    NSString *_socialSecurityStatus;
    NSString *_isInfoEditable;  //0-前3项不可修改  1-可修改
    HighRandingModel * _creditCardHighRandM;
    HighRandingModel * _socialSecurityHighRandM;
    
    
    
}

@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSString *verifyStatus;

@end

@implementation AuthenticationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"认证中心";

//    self.view.backgroundColor = [UIColor grayColor];
    _imageArr = @[@"icon_wri_ide_1",@"icon_wri_per_1",@"icon_wri_rece_1",@"icon_wri_face_1",@"icon_wri_mob_1",@"icon_wri_sesa_1",@"icon_wri_credit_1",@"icon_wri_social_1",@""];
    _titleArr = @[@"身份信息",@"个人信息",@"收款信息",@"人脸识别",@"手机认证",@"芝麻信用",@"信用卡认证",@"社保认证",@""];
    
    _promtpTitleArr = @[@"请完善您的身份信息",@"请完善您的个人信息",@"请完善您的收款信息",@"请完成人脸识别认证",@"请完善您的收款信息",@"请完善您的手机认证",@"请完善您的芝麻信用认证"];
    [self configureView];
    [self headingRefresh];

}
-(void)configureView{
    // 设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // UICollectionViewFlowLayout流水布局的内部成员属性有以下：
    /**
     @property (nonatomic) CGFloat minimumLineSpacing;
     @property (nonatomic) CGFloat minimumInteritemSpacing;
     @property (nonatomic) CGSize itemSize;
     @property (nonatomic) CGSize estimatedItemSize NS_AVAILABLE_IOS(8_0); // defaults to CGSizeZero - setting a non-zero size enables cells that self-size via -preferredLayoutAttributesFittingAttributes:
     @property (nonatomic) UICollectionViewScrollDirection scrollDirection; // default is UICollectionViewScrollDirectionVertical
     @property (nonatomic) CGSize headerReferenceSize;
     @property (nonatomic) CGSize footerReferenceSize;
     @property (nonatomic) UIEdgeInsets sectionInset;
     */
    //    // 定义大小
    CGFloat height = 110;
    if (UI_IS_IPHONE5) {
        height = 100;
    }
    layout.itemSize = CGSizeMake(_k_w/3, height);
    //    // 设置最小行间距
    layout.minimumLineSpacing = 0;
    //    // 设置垂直间距
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 设置滚动方向（默认垂直滚动）
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(0, 39);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[AuthenticationCenterCell class] forCellWithReuseIdentifier:@"AuthenticationCenterCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    UIButton *bottomBtn = [[UIButton alloc]init];
    [bottomBtn setTitle:@"资料重新测评" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bottomBtn.backgroundColor = UI_MAIN_COLOR;
    [bottomBtn addTarget:self action:@selector(bottomClick) forControlEvents:UIControlEventTouchUpInside];
    [Tool setCorner:bottomBtn borderColor:UI_MAIN_COLOR];
    [self.view addSubview:bottomBtn];
    __weak typeof(self) wekSelf = self;
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wekSelf.view.mas_bottom).offset(-69);
        make.left.equalTo(wekSelf.view.mas_left).offset(20);
        make.right.equalTo(wekSelf.view.mas_right).offset(-20);
        make.height.equalTo(@44);
    }];
}

-(void)bottomClick{

    NSLog(@"资料重新测评");
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (section == 0) {
        return 6;
    }
    return 3;
//    return _imageArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    AuthenticationCenterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AuthenticationCenterCell" forIndexPath:indexPath];

    if (indexPath.section == 0) {
        cell.image.image = [UIImage imageNamed:_imageArr[indexPath.row]];
        cell.nameLabel.text = _titleArr[indexPath.row];
    }else{
    
        if (indexPath.row == 0) {
            cell.image.image = [UIImage imageNamed:_imageArr[_imageArr.count-3]];
            cell.nameLabel.text = _titleArr[_titleArr.count-3];
        }else if(indexPath.row == 1){
        
            cell.image.image = [UIImage imageNamed:_imageArr[_imageArr.count-2]];
            cell.nameLabel.text = _titleArr[_titleArr.count-2];
        }
    }
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    AuthenticationCenterHeaderView * headView =   [[AuthenticationCenterHeaderView alloc]init];
    if (indexPath.section == 0) {
        headView.titleLabel.text = @"基础认证";
        headView.descLabel.text = @"基础认证请按顺序填写";
    }else{
    
        headView.titleLabel.text = @"高级认证";
        headView.descLabel.text = @"有助于提额和加快审核";
    }
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    headerView.backgroundColor = rgb(242, 242, 242);
    [headerView addSubview:headView];
    return headerView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.section) {
        case 0:
            if (_nextStep.integerValue > 0) {
                
                
            }
            if (_nextStep.integerValue == -2) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前状态无法修改资料"];
                return;
            }
            switch (indexPath.row) {
                case 0:{
                    [self getUserInfo:^(Custom_BaseInfo *custom_baseInfo) {
                        PserInfoViewController *perInfoVC = [[PserInfoViewController alloc] init];
                        perInfoVC.custom_baseInfo = custom_baseInfo;
                        [self.navigationController pushViewController:perInfoVC animated:true];
                    }];
                }
                    break;
                case 1:{
                    [self getCustomerCarrer_jhtml:^(CustomerCareerBaseClass *careerInfo) {
                        ProfessionViewController *professVC = [[ProfessionViewController alloc] init];
                        professVC.delegate = self;
                        professVC.careerInfo = careerInfo;
                        [self.navigationController pushViewController:professVC animated:true];
                    }];
                }
                    break;
                case 2:{
                    //此处需要一个返回默认卡的接口
                    [self getCustomerCarrer_jhtml:^(CustomerCareerBaseClass *careerInfo) {
                        
                        EditCardsController *editCard=[[EditCardsController alloc]initWithNibName:@"EditCardsController" bundle:nil];
                        editCard.typeFlag = @"0";
                        [self.navigationController pushViewController:editCard animated:YES];
                        
                    }];
                }
                    break;
                case 3:{
                    __weak typeof (self) weakSelf = self;
                    [self getUserInfo:^(Custom_BaseInfo *custom_baseInfo) {
                        FaceIdentiViewController * faceIdentiCreditVC = [[FaceIdentiViewController alloc]init];
                        faceIdentiCreditVC.verifyStatus = [NSString stringWithFormat:@"%.0lf",custom_baseInfo.result.verifyStatus];
                        [weakSelf.navigationController pushViewController:faceIdentiCreditVC animated:true];
                        faceIdentiCreditVC.identifyResultStatus = ^(NSString * status) {
                            weakSelf.verifyStatus = status;
                            [weakSelf.collectionView reloadData];
                        };
                    }];
                }
                    break;
                case 4:{
                    if (![self mobilePhoneOperatorChannels]) {
                        return;
                    }
                    CertificationViewController * certificationVC = [[CertificationViewController alloc]init];
                    certificationVC.phoneAuthChannel = _phoneAuthChannel;
                    certificationVC.isMobileAuth = _isMobileAuth;
                    certificationVC.whetherPhoneAuth = isPhoneAuthType;
                    [self.navigationController pushViewController:certificationVC animated:true];
                }
                    break;
                case 5:
                {
                    if (_isZmxyAuth.integerValue == 2) {
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
                        return;
                    }
                    if(_isZmxyAuth.integerValue == 1){
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您正在认证中，请勿重复认证!"];
                        return;
                    }
                    SesameCreditViewController *controller = [[SesameCreditViewController alloc]initWithNibName:@"SesameCreditViewController" bundle:nil];
                    [self.navigationController pushViewController:controller animated:YES];
                }
                    break;
                default:
                    break;
            }
            break;
        case 1:
            if (_nextStep.integerValue > 0) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请先完成基础资料认证"];
                return;
            }
            switch (indexPath.row) {
                case 0:{
                    if ([_creditCardStatus isEqualToString:@"1"]) {
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
                        return;
                    }
                    if ([_creditCardStatus isEqualToString:@"2"]) {
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"认证中，请稍后！"];
                        return;
                    }
                    [self mailImportClick];
                }
                    break;
                case 1:
                {
                    if ([_socialSecurityStatus isEqualToString:@"1"]) {
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
                        return;
                    }
                    if ([_socialSecurityStatus isEqualToString:@"2"]) {
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"认证中，请稍后！"];
                        return;
                    }
                    [self securityImportClick];
                }
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    
}
-(void)headingRefresh{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshInfoStep)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    self.collectionView.mj_header = header;
}

-(BOOL)mobilePhoneOperatorChannels{
    __block BOOL result = true;
    if ([_resultCode isEqualToString:@"1"]) {
        isPhoneAuthType = false;
    }else{
        [self liveDiscernAndmibileAuthJudge:^(BOOL isPass) {
            result = isPass;
        }];
    }
    return result;
}

-(void)liveDiscernAndmibileAuthJudge:(void(^)(BOOL isPass))result{
    
    if ([_verifyStatus isEqualToString:@"2"] || [_verifyStatus isEqualToString:@"3"]) {
        isPhoneAuthType = true;
        result(true);
    }else if ([_verifyStatus isEqualToString:@"1"]){
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"请先进行人脸识别"];
        result(false);
    }else{
        //模拟的运营商认证
        isPhoneAuthType = false;
        result(true);
    }

}

#pragma 魔蝎导入
//邮箱导入
- (void)mailImportClick{
    
    [[MXVerifyManager shareInstance]configMoxieSDKWithViewcontroller:self mxResult:^(NSDictionary * result) {
//        NSString *taskType = result[@"taskType"];
        NSString *taskId = result[@"taskId"];
        [self TheCreditCardInfoupload:taskId];
    }];
    
    [[MXVerifyManager shareInstance] creditCard];
    
}
//社保导入
-(void)securityImportClick{
    
    [[MXVerifyManager shareInstance]configMoxieSDKWithViewcontroller:self mxResult:^(NSDictionary * result) {
//        NSString *taskType = result[@"taskType"];
        NSString *taskId = result[@"taskId"];
        [self TheCreditCardInfoupload:taskId];
    }];
    
    [[MXVerifyManager shareInstance] socialSecurity];
}

#pragma mark - 网络请求
//获取进度条的进度
- (void)refreshInfoStep
{
    UserDataViewModel * userDataVM = [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * resultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([resultM.flag isEqualToString:@"0000"]) {
            UserDataModel * userDataM = [[UserDataModel alloc]initWithDictionary:(NSDictionary *)resultM.result error:nil];
            _nextStep = userDataM.nextStep;
            _resultCode = userDataM.resultcode;
            _rulesId = userDataM.rulesid;
            _isMobileAuth = userDataM.isMobileAuth;
            _isZmxyAuth = userDataM.isZmxyAuth;// 1 未认证    2 认证通过   3 认证未通过
            _phoneAuthChannel = userDataM.TRUCKS_;  // 手机认证通道 JXL 表示聚信立，TC 表示天创认证
            if (_nextStep.integerValue == 4) {
                _isInfoEditable = userDataM.isInfoEditable;
            }
//            [self setProcess];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:resultM.msg];
        }
        [self.collectionView.mj_header endRefreshing];
    } WithFaileBlock:^{
        [self.collectionView.mj_header endRefreshing];
    }];
    [userDataVM obtainCustomerAuthInfoProgress:nil];
}
-(void)TheCreditCardInfoupload:(NSString *)taskid {
    
    UserDataViewModel * userDataVM = [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if (baseResultM.errCode.integerValue == 0) {
            //高级认证状态查询
            [self obtainHighRanking];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM TheCreditCardInfoUpload:taskid];
}
-(void)TheSocialSecurityupload:(NSString *)taskid {
    
    UserDataViewModel * userDataVM = [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if (baseResultM.errCode.integerValue == 0) {
            //高级认证状态查询
            [self obtainHighRanking];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM socialSecurityInfoUpload:taskid];
}
-(void)obtainHighRanking{
    
    UserDataViewModel * userDataVM = [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            NSArray * array = (NSArray *)baseResultM.data;
            for (NSDictionary * dic  in array) {
                HighRandingModel * highRandM  = [[HighRandingModel alloc]initWithDictionary:dic error:nil];
                if ([highRandM.type isEqualToString:@"社保"]) {
                    _socialSecurityHighRandM = highRandM;
                    _socialSecurityStatus = highRandM.resultid;
                }
                if ([highRandM.type isEqualToString:@"邮箱信用卡"]) {
                    _creditCardHighRandM = highRandM;
                    _creditCardStatus = highRandM.resultid;
                }
            }
            [self.collectionView reloadData];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM obtainhighRankingStatus];
}
- (void)getUserInfo:(void(^)(Custom_BaseInfo *custom_baseInfo))finish
{
    GetCustomerBaseViewModel *customerInfo = [[GetCustomerBaseViewModel alloc] init];
    [customerInfo setBlockWithReturnBlock:^(id returnValue) {
        Custom_BaseInfo *custom_model = returnValue;
        [Utility sharedUtility].userInfo.userMobilePhone = custom_model.ext.mobilePhone;
        if ([custom_model.flag isEqualToString:@"0000"]) {
            id data = [DataWriteAndRead readDataWithkey:UserInfomation];
            if (data) {
                [DataWriteAndRead writeDataWithkey:UserInfomation value:nil];
                if (![custom_model.result.idCode isEqualToString:@""] && custom_model.result.idCode != nil) {
                    [DataWriteAndRead writeDataWithkey:UserInfomation value:custom_model];
                    [Utility sharedUtility].userInfo.userIDNumber = custom_model.result.idCode;
                    [Utility sharedUtility].userInfo.userMobilePhone = custom_model.ext.mobilePhone;
                    [Utility sharedUtility].userInfo.realName = custom_model.result.customerName;
                    if ([[Utility sharedUtility].userInfo.account_id isEqualToString:@""] || [Utility sharedUtility].userInfo.account_id == nil) {
                        [Utility sharedUtility].userInfo.account_id = custom_model.result.createBy;
                    }
                }
            } else {
                if (![custom_model.result.idCode isEqualToString:@""] && custom_model.result.idCode != nil) {
                    [DataWriteAndRead writeDataWithkey:UserInfomation value:custom_model];
                    [Utility sharedUtility].userInfo.userIDNumber = custom_model.result.idCode;
                    [Utility sharedUtility].userInfo.userMobilePhone = custom_model.ext.mobilePhone;
                    [Utility sharedUtility].userInfo.realName = custom_model.result.customerName;
                    if ([[Utility sharedUtility].userInfo.account_id isEqualToString:@""] || [Utility sharedUtility].userInfo.account_id == nil) {
                        [Utility sharedUtility].userInfo.account_id = custom_model.result.createBy;
                    }
                } else {
                    [DataWriteAndRead writeDataWithkey:UserInfomation value:nil];
                }
            }
            finish(custom_model);
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:custom_model.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [customerInfo fatchCustomBaseInfo:nil];
}
-(void)getCustomerCarrer_jhtml:(void(^)(CustomerCareerBaseClass *careerInfo))finish
{
    GetCareerInfoViewModel *getCareerInfoViewModel = [[GetCareerInfoViewModel alloc] init];
    [getCareerInfoViewModel setBlockWithReturnBlock:^(id returnValue) {
        CustomerCareerBaseClass *carrerInfoModel = returnValue;
        if ([carrerInfoModel.flag isEqualToString:@"0000"]) {
            finish(carrerInfoModel);
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:carrerInfoModel.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [getCareerInfoViewModel fatchCareerInfo:nil];
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
