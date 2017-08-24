//
//  AuthenticationCenterViewController.m
//  fxdProduct
//
//  Created by sxp on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "AuthenticationCenterViewController.h"
#import "SeniorCertificationView.h"
@interface AuthenticationCenterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

{

    NSArray *_imageArr;
    NSArray *_titleArr;
    
}


@end

@implementation AuthenticationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"认证中心";

//    self.view.backgroundColor = [UIColor grayColor];
    _imageArr = @[@"icon_wri_ide_1",@"icon_wri_per_1",@"icon_wri_rece_1",@"icon_wri_face_1",@"icon_wri_mob_1",@"icon_wri_sesa_1",@"icon_wri_credit_1",@"icon_wri_social_1",@""];
    _titleArr = @[@"身份信息",@"个人信息",@"收款信息",@"人脸识别",@"手机认证",@"芝麻信用",@"信用卡认证",@"社保认证",@""];
    
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
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    [collectionView registerClass:[AuthenticationCenterCell class] forCellWithReuseIdentifier:@"AuthenticationCenterCell"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
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
            switch (indexPath.row) {
                case 0:
                    NSLog(@"身份信息");
                    break;
                case 1:
                    NSLog(@"个人信息");
                    break;
                case 2:
                    NSLog(@"收款信息");
                    break;
                case 3:
                    NSLog(@"人脸识别");
                    break;
                case 4:
                    NSLog(@"手机认证");
                    break;
                case 5:
                    NSLog(@"芝麻信用");
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    NSLog(@"信用卡认证");
                    break;
                case 1:
                    NSLog(@"社保认证");
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
