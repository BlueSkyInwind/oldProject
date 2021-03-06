//
//  AuthenticationCenterViewController.m
//  fxdProduct
//
//  Created by sxp on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "AuthenticationCenterVCModules.h"
#import "UserIdentityInformationVCModules.h"
#import "UserProfessionalInformationVCModules.h"
#import "UserMobileAuthenticationVCModules.h"
#import "EditCardsController.h"
#import "SesameCreditCertificationVCModules.h"
#import "UserDataModel.h"
#import "UserDataViewModel.h"
#import "HighRandingModel.h"
#import "GetCustomerBaseViewModel.h"
#import "Custom_BaseInfo.h"
#import "DataWriteAndRead.h"
#import "GetCareerInfoViewModel.h"
#import "CustomerCareerBaseClass.h"
#import "UserMobileAuthenticationVCModules.h"
#import "UserCardResult.h"
#import "CardInfo.h"
#import "CheckViewModel.h"
#import "SupportBankList.h"

@interface AuthenticationCenterVCModules ()<UICollectionViewDelegate,UICollectionViewDataSource,ProfessionDataDelegate,MoxieSDKDelegate>
{

    NSArray *_imageArr;
    NSArray *_editImageArr;
    NSArray *_completeImageArr;
    NSArray *_inAuthenticationImageArr;
    NSArray *_titleArr;
    NSArray * _promtpTitleArr;
    BOOL isPhoneAuthType;
    
    NSMutableArray * _supportBankListArr;
    
    //各种认证状态
    NSString *_nextStep;
    NSString *_resultCode;
    NSString *_rulesId;
    NSString *_isMobileAuth;
    NSString *_isZmxyAuth;
    NSString *_phoneAuthChannel;
    NSString *_creditCardStatus;
    NSString *_socialSecurityStatus;
    HighRandingModel * _creditCardHighRandM;
    HighRandingModel * _socialSecurityHighRandM;
    
    UserDataModel * userDataModel;
    UICollectionViewFlowLayout *layout;
    
}
@property (nonatomic,strong)NSString *isEvaluation;
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSString *verifyStatus;
@property (nonatomic,strong)UIButton *evaluationBtn;

@end

@implementation AuthenticationCenterVCModules

-(void)setIsEvaluation:(NSString *)isEvaluation{
    _isEvaluation = isEvaluation;
    if ([isEvaluation isEqualToString:@"0"]) {
        _evaluationBtn.backgroundColor = kUIColorFromRGB(0x9e9e9f);
        _evaluationBtn.enabled = false;
    }else{
        _evaluationBtn.backgroundColor = UI_MAIN_COLOR;
        _evaluationBtn.enabled = true;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"认证中心";
    _imageArr = @[@"icon_wri_ide_1",@"icon_wri_per_1",@"icon_wri_face_1",@"icon_wri_mob_1",@"icon_wri_sesa_1",@"icon_wri_rece_1",@"icon_wri_credit_1",@"icon_wri_social_1",@""];
    _editImageArr = @[@"icon_wri_ide_2",@"icon_wri_per_2",@"icon_wri_face_2",@"icon_wri_mob_2",@"icon_wri_sesa_2",@"icon_wri_rece_2",@"icon_wri_credit_2",@"icon_wri_social_2",@""];
    _completeImageArr = @[@"icon_wri_ide_3",@"icon_wri_per_3",@"icon_wri_face_3",@"icon_wri_mob_3",@"icon_wri_sesa_3",@"icon_wri_rece_3",@"icon_wri_credit_3",@"icon_wri_social_3",@""];
    _inAuthenticationImageArr = @[@"icon_wri_mob_4",@"icon_wri_sesa_4",@"icon_wri_credit_4",@"icon_wri_social_4"];

    _titleArr = @[@"身份信息",@"个人信息",@"人脸识别",@"手机认证",@"芝麻信用",@"收款信息",@"信用卡认证",@"社保认证",@""];
    
    _promtpTitleArr = @[@"请完善您的身份信息",@"请完善您的个人信息",@"请完成人脸识别认证",@"请完善您的收款信息",@"请完善您的手机认证",@"请完善您的收款信息",@"请完善您的芝麻信用认证",];
    _isEvaluation = @"0";
    
    [self configureView];
    [self headingRefresh];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView.mj_header beginRefreshing];
    [self configMoxieSDK];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.collectionView.mj_header endRefreshing];
}
-(void)configureView{
    // 设置流水布局
    layout = [[UICollectionViewFlowLayout alloc]init];
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
    CGFloat width = _k_w/3;
    if (UI_IS_IPHONE5) {
        height = 100;
        width = (_k_w-2)/3;
    }
    
    layout.itemSize = CGSizeMake(width, height);
    //    // 设置最小行间距
    layout.minimumLineSpacing = 0;
    //    // 设置垂直间距
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 设置滚动方向（默认垂直滚动）
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(0, 39);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h) collectionViewLayout:layout];
    if (@available(iOS 11.0, *)) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, BarHeightNew, _k_w, _k_h) collectionViewLayout:layout];
        _collectionView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = rgb(242, 242, 242);
    _collectionView.scrollEnabled = true;
    if (UI_IS_IPHONE4) {
        _collectionView.scrollEnabled = true;
    }

    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[AuthenticationCenterCell class] forCellWithReuseIdentifier:@"AuthenticationCenterCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ReusablefooterView"];

    _evaluationBtn = [[UIButton alloc]init];
    [_evaluationBtn setTitle:@"额度重新审核" forState:UIControlStateNormal];
    [_evaluationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _evaluationBtn.backgroundColor = UI_MAIN_COLOR;
    [_evaluationBtn addTarget:self action:@selector(bottomClick) forControlEvents:UIControlEventTouchUpInside];
    [FXD_Tool setCorner:_evaluationBtn borderColor:[UIColor clearColor]];
    [self.view addSubview:_evaluationBtn];
    __weak typeof(self) wekSelf = self;
    [_evaluationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wekSelf.view.mas_bottom).offset(-69);
        make.left.equalTo(wekSelf.view.mas_left).offset(20);
        make.right.equalTo(wekSelf.view.mas_right).offset(-20);
        make.height.equalTo(@44);
    }];
    
    if (UI_IS_IPHONEX) {
        [_evaluationBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(wekSelf.view.mas_bottom).offset(-93);
        }];
    }
}

-(void)bottomClick{
    [self UserDataCertificationinterface];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    AuthenticationCenterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AuthenticationCenterCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.image.image = [UIImage imageNamed:_imageArr[indexPath.row]];
        cell.nameLabel.text = _titleArr[indexPath.row];
        if (!userDataModel) {
            return cell;
        }
        switch (indexPath.row) {
            case 0:{
                if ([userDataModel.identity isEqualToString:@"0"]) {
                    cell.image.image = [UIImage imageNamed:_imageArr[indexPath.row]];
                    break;
                }
                //是否可编辑控制前三个cell
                if ([userDataModel.identityEdit isEqualToString:@"1"]) {
                    cell.image.image = [UIImage imageNamed:_editImageArr[indexPath.row]];
                    break;
                }
                cell.image.image = [UIImage imageNamed:_completeImageArr[indexPath.row]];
            }
                break;
            case 1:{
                if ([userDataModel.person isEqualToString:@"0"]) {
                    cell.image.image = [UIImage imageNamed:_imageArr[indexPath.row]];
                    break;
                }
                //是否可编辑控制前三个cell
                if ([userDataModel.personEdit isEqualToString:@"1"]) {
                    cell.image.image = [UIImage imageNamed:_editImageArr[indexPath.row]];
                    break;
                }
                cell.image.image = [UIImage imageNamed:_completeImageArr[indexPath.row]];
            }
                break;
            case 2:{
                if (![userDataModel.faceIdentity isEqualToString:@"2"] && ![userDataModel.faceIdentity isEqualToString:@"3"]) {
                    cell.image.image = [UIImage imageNamed:_imageArr[indexPath.row]];
                    break;
                }
                cell.image.image = [UIImage imageNamed:_completeImageArr[indexPath.row]];
            }
                break;
            case 3:{
                if (![userDataModel.telephone isEqualToString:@"2"]) {
                    cell.image.image = [UIImage imageNamed:_imageArr[indexPath.row]];
                    break;
                }
                cell.image.image = [UIImage imageNamed:_completeImageArr[indexPath.row]];
            }
                break;
            case 4:{
                if ([userDataModel.zmIdentity isEqualToString:@"3"]) {
                    cell.image.image = [UIImage imageNamed:_imageArr[indexPath.row]];
                    break;
                }
                if ([userDataModel.zmIdentity isEqualToString:@"1"]) {
                    cell.image.image = [UIImage imageNamed:_inAuthenticationImageArr[indexPath.row - 4]];
                    break;
                }
                cell.image.image = [UIImage imageNamed:_completeImageArr[indexPath.row]];
            }
                break;
            case 5:{
                if ([userDataModel.gathering isEqualToString:@"0"]) {
                    cell.image.image = [UIImage imageNamed:_imageArr[indexPath.row]];
                    break;
                }
                cell.image.image = [UIImage imageNamed:_completeImageArr[indexPath.row]];
            }
                break;
            default:
                break;
        }
    }else{
        if (indexPath.row == 0) {
            cell.image.image = [UIImage imageNamed:_imageArr[_imageArr.count-3]];
            cell.nameLabel.text = _titleArr[_titleArr.count-3];
            if ([_creditCardStatus isEqualToString:@"1"]) {
                cell.image.image = [UIImage imageNamed:_completeImageArr[_completeImageArr.count-3]];
            }else if ([_creditCardStatus isEqualToString:@"2"]){
                cell.image.image = [UIImage imageNamed:_inAuthenticationImageArr[_inAuthenticationImageArr.count-2]];
            }
        }else if(indexPath.row == 1){
            cell.image.image = [UIImage imageNamed:_imageArr[_imageArr.count-2]];
            cell.nameLabel.text = _titleArr[_titleArr.count-2];
            if ([_socialSecurityStatus isEqualToString:@"1"]) {
                cell.image.image = [UIImage imageNamed:_completeImageArr[_completeImageArr.count-2]];
            }else if ([_socialSecurityStatus isEqualToString:@"2"]){
                cell.image.image = [UIImage imageNamed:_inAuthenticationImageArr[_inAuthenticationImageArr.count-1]];
            }
        }else if(indexPath.row == 2){
            cell.image.image = [UIImage imageNamed:@""];
            cell.nameLabel.text = @"";
        }
    }
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
        headerView.backgroundColor = rgb(242, 242, 242);
        if (headerView.subviews.count > 0) {
           [headerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
        AuthenticationCenterHeaderView * headView =   [[AuthenticationCenterHeaderView alloc]init];
        if (indexPath.section == 0) {
            headView.titleLabel.text = @"基础认证";
            headView.descLabel.text = @"基础认证请按顺序填写";
        }else{
            headView.titleLabel.text = @"高级认证";
            headView.descLabel.text = @"有助于提额和加快审核";
        }
        [headerView addSubview:headView];
        return headerView;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if (![self cellStatusIsSelect:indexPath.row]) {
                return;
            }
            switch (indexPath.row) {
                case 0:{
                    [self getUserInfo:^(Custom_BaseInfo *custom_baseInfo) {
                        UserIdentityInformationVCModules *perInfoVC = [[UserIdentityInformationVCModules alloc] init];
                        perInfoVC.custom_baseInfo = custom_baseInfo;
                        [self.navigationController pushViewController:perInfoVC animated:true];
                    }];
                }
                    break;
                case 1:{
                    [self getCustomerCarrer_jhtml:^(CustomerCareerBaseClass *careerInfo) {
                        UserProfessionalInformationVCModules *professVC = [[UserProfessionalInformationVCModules alloc] init];
                        professVC.delegate = self;
                        professVC.careerInfo = careerInfo;
                        [self.navigationController pushViewController:professVC animated:true];
                    }];
                }
                    break;
                case 2:{
                    if ([userDataModel.faceIdentity isEqualToString:@"2"]  || [userDataModel.faceIdentity isEqualToString:@"3"]) {
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
                        return;
                    }
                    __weak typeof (self) weakSelf = self;
                    [self getUserInfo:^(Custom_BaseInfo *custom_baseInfo) {
                        UserFaceIdentiVCModules * faceIdentiCreditVC = [[UserFaceIdentiVCModules alloc]init];
                        faceIdentiCreditVC.verifyStatus = [NSString stringWithFormat:@"%.0lf",custom_baseInfo.result.verifyStatus];
                        [weakSelf.navigationController pushViewController:faceIdentiCreditVC animated:true];
                        faceIdentiCreditVC.identifyResultStatus = ^(NSString * status) {
                            weakSelf.verifyStatus = status;
                            [weakSelf.collectionView reloadData];
                        };
                    }];
                }
                    break;
                case 3:{
                    if ([userDataModel.telephone isEqualToString:@"2"]) {
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
                        return;
                    }
                    UserMobileAuthenticationVCModules * certificationVC = [[UserMobileAuthenticationVCModules alloc]init];
                    certificationVC.phoneAuthChannel = @"TC";
                    certificationVC.isMobileAuth = userDataModel.telephone;
                    [self.navigationController pushViewController:certificationVC animated:true];
                }
                    break;
                case 4:{
                    if ([userDataModel.zmIdentity isEqualToString:@"2"]) {
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
                        return;
                    }
                    if([userDataModel.zmIdentity isEqualToString:@"1"]){
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您正在认证中，请勿重复认证!"];
                        return;
                    }
                    SesameCreditCertificationVCModules *controller = [[SesameCreditCertificationVCModules alloc]initWithNibName:@"SesameCreditCertificationVCModules" bundle:nil];
                    [self.navigationController pushViewController:controller animated:YES];
                }
                    break;
                case 5:
                {
                    //此处需要一个返回默认卡的接口
                    [self getGatheringInformation_jhtml:^(CardInfo *cardInfo) {
                        EditCardsController *editCard=[[EditCardsController alloc]initWithNibName:@"EditCardsController" bundle:nil];
                        editCard.typeFlag = @"0";
                        editCard.cardName = cardInfo.bankName;
                        editCard.cardNum = cardInfo.cardNo;
                        editCard.reservedTel = cardInfo.bankPhone;
                        editCard.cardCode = cardInfo.bankNameCode;
                        editCard.popOrdiss  = true;
                        [self.navigationController pushViewController:editCard animated:YES];
                    }];
                }
                    break;
                default:
                    break;
            }
            break;
        case 1:
            if (![userDataModel.zmIdentity isEqualToString:@"2"]) {
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
-(BOOL)cellStatusIsSelect:(NSInteger)row{
    
    if ([userDataModel.identity isEqualToString:@"0"] && row > 0) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请您先完善身份信息！"];
        return false;
    }
    if ([userDataModel.person isEqualToString:@"0"] && row > 1) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请您先完善个人信息！"];
        return false;
    }
    switch (row) {
        case 0:{
            if ([userDataModel.identityEdit isEqualToString:@"0"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前状态无法修改资料"];
                return false;
            }
        }
            break;
        case 1:{
            if ([userDataModel.personEdit isEqualToString:@"0"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前状态无法修改资料"];
                return false;
            }
        }
            break;
        case 2:
        {
            if ([userDataModel.faceIdentity isEqualToString:@"2"] || [userDataModel.faceIdentity isEqualToString:@"3"])  {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"已认证"];
                return false;
            }
        }
            break;
        case 3:{
            if ([userDataModel.telephone isEqualToString:@"2"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"已认证"];
                return false;
            }
        }
            break;
        case 4:{
            if ([userDataModel.zmIdentity isEqualToString:@"2"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"已认证"];
                return false;
            }
        }
            break;
        case 5:{
            if ([userDataModel.gathering isEqualToString:@"1"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前状态无法修改资料"];
                return false;
            }
        }
            break;
        default:
            break;
    }
    return true;
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
/*
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
 */
#pragma mark - 魔蝎信用卡以及社保集成
//邮箱导入
- (void)mailImportClick{
    @try {
        [MoxieSDK shared].taskType = @"email";
        [[MoxieSDK shared] startFunction];
    } @catch (NSException *exception) {
        DLog(@"%@", exception);
        return;
    } @finally {
    }
}
//社保导入
-(void)securityImportClick{
    @try {
        [MoxieSDK shared].taskType = @"security";
        [[MoxieSDK shared] startFunction];
    } @catch (NSException *exception) {
        DLog(@"%@", exception);
        return;
    } @finally {
    }
}
-(void)configMoxieSDK{
    /***必须配置的基本参数*/
    [MoxieSDK shared].delegate = self;
    [MoxieSDK shared].userId = [FXD_Utility sharedUtility].userInfo.juid;
    [MoxieSDK shared].apiKey = theMoxieApiKey;
    [MoxieSDK shared].fromController = self;
    [MoxieSDK shared].useNavigationPush = NO;
    [self editSDKInfo];
};

#pragma MoxieSDK Result Delegate
-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary{
    int code = [resultDictionary[@"code"] intValue];
    NSString *taskType = resultDictionary[@"taskType"];
    NSString *taskId = resultDictionary[@"taskId"];
    NSString *message = resultDictionary[@"message"];
    NSString *account = resultDictionary[@"account"];
    BOOL loginDone = [resultDictionary[@"loginDone"] boolValue];
    NSLog(@"get import result---code:%d,taskType:%@,taskId:%@,message:%@,account:%@,loginDone:%d",code,taskType,taskId,message,account,loginDone);
    //【登录中】假如code是2且loginDone为false，表示正在登录中
    if(code == 2 && loginDone == false){
        NSLog(@"任务正在登录中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集中】假如code是2且loginDone为true，已经登录成功，正在采集中
    else if(code == 2 && loginDone == true){
        NSLog(@"任务已经登录成功，正在采集中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
        [self obtainHighRankingClassifyStatus:taskType TaskId:taskId];
    }
    //【采集成功】假如code是1则采集成功（不代表回调成功）
    else if(code == 1){
        NSLog(@"任务采集成功，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
        [self obtainHighRankingClassifyStatus:taskType TaskId:taskId];
    }
    //【未登录】假如code是-1则用户未登录
    else if(code == -1){
        NSLog(@"用户未登录");
    }
    //【任务失败】该任务按失败处理，可能的code为0，-2，-3，-4
    //0 其他失败原因
    //-2平台方不可用（如中国移动维护等）
    //-3魔蝎数据服务异常
    //-4用户输入出错（密码、验证码等输错后退出）
    else{
        NSLog(@"任务失败");
    }
}
-(void)editSDKInfo{
    [MoxieSDK shared].navigationController.navigationBar.translucent = YES;
    [MoxieSDK shared].backImageName = @"return_white";
//    [MoxieSDK shared].navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    [MoxieSDK shared].navigationController.navigationBar.tintColor = UI_MAIN_COLOR;
    [[MoxieSDK shared].navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    [MoxieSDK shared].navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName, nil];
}
-(void)obtainHighRankingClassifyStatus:(NSString *)type TaskId:(NSString *)taskId{
    if (!taskId || !type) {
        return;
    }
    if ([type isEqualToString:@"email"]) {
        //        _creditCardStatus = @"1";
        [self TheCreditCardInfoupload:taskId];
    }
    if ([type isEqualToString:@"security"]) {
        //        _socialSecurityStatus = @"1";
        [self TheSocialSecurityupload:taskId];
    }
}
#pragma mark - 网络请求
//获取进度条的进度
- (void)refreshInfoStep
{
    if (![FXD_Utility sharedUtility].loginFlage) {
        return;
    }
    [self obtainHighRanking];
    UserDataViewModel * userDataVM1 = [[UserDataViewModel alloc]init];
    [userDataVM1 setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * resultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([resultM.errCode isEqualToString:@"0"]) {
            UserDataModel * userDataM = [[UserDataModel alloc]initWithDictionary:(NSDictionary *)resultM.data error:nil];
            self.isEvaluation = userDataM.test;
            userDataModel = userDataM;
            [self.collectionView reloadData];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:resultM.friendErrMsg];
        }
        [self.collectionView.mj_header endRefreshing];
    } WithFaileBlock:^{
        [self.collectionView.mj_header endRefreshing];
    }];
    [userDataVM1 obtainBasicInformationStatusOfAuthenticationCenter];
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
                if ([highRandM.tasktypeid isEqualToString:@"1"]) {
                    _socialSecurityHighRandM = highRandM;
                    _socialSecurityStatus = highRandM.resultid;
                }
                if ([highRandM.tasktypeid isEqualToString:@"2"]) {
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
        [FXD_Utility sharedUtility].userInfo.userMobilePhone = custom_model.ext.mobilePhone;
        if ([custom_model.flag isEqualToString:@"0000"]) {
            id data = [DataWriteAndRead readDataWithkey:UserInfomation];
            if (data) {
                [DataWriteAndRead writeDataWithkey:UserInfomation value:nil];
                if (![custom_model.result.idCode isEqualToString:@""] && custom_model.result.idCode != nil) {
                    [DataWriteAndRead writeDataWithkey:UserInfomation value:custom_model];
                    [FXD_Utility sharedUtility].userInfo.userIDNumber = custom_model.result.idCode;
                    [FXD_Utility sharedUtility].userInfo.userMobilePhone = custom_model.ext.mobilePhone;
                    [FXD_Utility sharedUtility].userInfo.realName = custom_model.result.customerName;
                    if ([[FXD_Utility sharedUtility].userInfo.account_id isEqualToString:@""] || [FXD_Utility sharedUtility].userInfo.account_id == nil) {
                        [FXD_Utility sharedUtility].userInfo.account_id = custom_model.result.createBy;
                    }
                }
            } else {
                if (![custom_model.result.idCode isEqualToString:@""] && custom_model.result.idCode != nil) {
                    [DataWriteAndRead writeDataWithkey:UserInfomation value:custom_model];
                    [FXD_Utility sharedUtility].userInfo.userIDNumber = custom_model.result.idCode;
                    [FXD_Utility sharedUtility].userInfo.userMobilePhone = custom_model.ext.mobilePhone;
                    [FXD_Utility sharedUtility].userInfo.realName = custom_model.result.customerName;
                    if ([[FXD_Utility sharedUtility].userInfo.account_id isEqualToString:@""] || [FXD_Utility sharedUtility].userInfo.account_id == nil) {
                        [FXD_Utility sharedUtility].userInfo.account_id = custom_model.result.createBy;
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

-(void)getGatheringInformation_jhtml:(void(^)(CardInfo *cardInfo))finish{
    
    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResult = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResult.flag isEqualToString:@"0000"]) {
            NSArray * array  = (NSArray *)baseResult.result;
            _supportBankListArr = [NSMutableArray array];
            for (int i = 0; i < array.count; i++) {
                SupportBankList * bankList = [[SupportBankList alloc]initWithDictionary:array[i] error:nil];
                [_supportBankListArr addObject:bankList];
            }
            [self fatchCardInfo:_supportBankListArr success:^(CardInfo *cardInfo) {
                finish(cardInfo);
            }];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResult.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [checkBankViewModel getSupportBankListInfo:@"2"];
}
- (void)fatchCardInfo:(NSMutableArray *)supportBankListArr success:(void(^)(CardInfo *cardInfo))finish
{
    BankInfoViewModel * bankInfoVM = [[BankInfoViewModel alloc]init];
    [bankInfoVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            CardInfo *resultCardInfo = [[CardInfo alloc] init];
            NSArray * array = (NSArray *)baseResultM.data;
            if (array.count <= 0){
                finish(resultCardInfo);
                return;
            }
            for (int  i = 0; i < array.count; i++) {
                NSDictionary *dic = array[i];
                CardInfo * cardInfo = [[CardInfo alloc]initWithDictionary:dic error:nil];
                if ([cardInfo.cardType isEqualToString:@"2"]) {
                    for (SupportBankList *banlist in _supportBankListArr) {
                        if ([cardInfo.cardShortName isEqualToString: banlist.bank_short_name_]) {
                            resultCardInfo = cardInfo;
                            resultCardInfo.bankNameCode = banlist.bank_code_;
                        }
                    }
                    break;
                }
            }
            finish(resultCardInfo);
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultM.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [bankInfoVM obtainUserBankCardList];
}

- (NSString *)formatTailNumber:(NSString *)str
{
    return [str substringWithRange:NSMakeRange(str.length - 4, 4)];
}
/**
 用户认证接口
 */
-(void)UserDataCertificationinterface{
    UserDataViewModel * userDataVM =  [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            UserDataEvaluationVCModules * checkVC = [[UserDataEvaluationVCModules  alloc]init];
            [self.navigationController pushViewController:checkVC animated:true];
            //首次测评发放红包提示
            NSString * str = baseResultM.data[@"redIssuedSucce"];
            if (str != nil && ![str isEqualToString:@""]) {
                [[MBPAlertView sharedMBPTextView]showTextOnly:[UIApplication sharedApplication].keyWindow message:str];
            }
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM UserDataCertification];
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
