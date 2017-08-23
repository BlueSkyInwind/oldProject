//
//  AuthenticationCenterViewController.m
//  fxdProduct
//
//  Created by sxp on 2017/8/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "AuthenticationCenterViewController.h"

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

    self.view.backgroundColor = [UIColor grayColor];
    _imageArr = @[@"",@"",@"",@"",@"",@"",@"",@""];
    _titleArr = @[@"身份信息",@"个人信息",@"收款信息",@"人脸识别",@"手机认证",@"芝麻信用",@"信用卡认证",@"社保认证"];
    
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
    layout.itemSize = CGSizeMake((_k_w-4)/3, 100);
//    // 设置最小行间距
    layout.minimumLineSpacing = 1;
    // 设置垂直间距
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 1, 1);
    // 设置滚动方向（默认垂直滚动）
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(0, 30);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:collectionView];
    [collectionView registerClass:[AuthenticationCenterCell class] forCellWithReuseIdentifier:@"AuthenticationCenterCell"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (section == 0) {
        return 6;
    }
    return 2;
//    return _imageArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    AuthenticationCenterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AuthenticationCenterCell" forIndexPath:indexPath];
   
    if (indexPath.section == 0) {
        cell.image.image = [UIImage imageNamed:_imageArr[indexPath.row]];
        cell.nameLabel.text = _titleArr[indexPath.row];
    }else{
    
        if (indexPath.row == 0) {
            cell.image.image = [UIImage imageNamed:_imageArr[_imageArr.count-2]];
            cell.nameLabel.text = _titleArr[_titleArr.count-2];
        }else{
        
            cell.image.image = [UIImage imageNamed:_imageArr[_imageArr.count-1]];
            cell.nameLabel.text = _titleArr[_titleArr.count-1];
        }
    }
    
    
    return cell;
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor redColor];
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    headView.backgroundColor = [UIColor redColor];
    [headerView addSubview:headView];
    return headerView;
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
