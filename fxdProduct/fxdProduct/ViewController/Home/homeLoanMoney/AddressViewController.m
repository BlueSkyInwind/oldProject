//
//  AddressViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/9.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "AddressViewController.h"
#import "InfoFiveCell.h"
#import "AddCell.h"
#import "TextViewCell.h"
#import "BtnCell.h"
#import "TelSeperateCell.h"
#import "AddDetailViewController.h"
#import "HomeInfoViewController.h"
#import "ColledgeView.h"
#import "DetaillabeCell.h"
#import "TextDetailLabelCell.h"
#import "SchoolViewController.h"


@interface AddressViewController ()<UITableViewDataSource,UITableViewDelegate,AddDeetailDelegate,UITextFieldDelegate,UITextViewDelegate,ColledgeViewDelegate,SchoolSelectDelegate>
{
    NSArray *_scetionArray;
    NSString *_row0School;
    NSString *_row1Xueli;
    NSString *_companyAdd;
    NSString *_telPhone;
    NSString *_telquhao;
    NSString *_telnum;
    NSString *_textViewText;
    
    UIButton *btn;
    UIImage *imagea;
    NSMutableArray *cityArray;
    ColledgeView *_collView;
    NSArray *_education;
    NSString *_educationCode;
    NSString *_company;
}

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"填写资料";
    _textViewText = @"单位详细地址";
    self.view.backgroundColor = RGBColor(241, 241, 241, 1);
    /*
     专科 30
     本科 20
     硕士研究生  12
     博士 11
     */
    _education = @[@"30",@"20",@"12",@"11",@"9"];
    
    
    [self addBackItem];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    cityArray = [NSMutableArray arrayWithObjects:@"省",@"市",@"区",nil];
    imagea = [UIImage imageNamed:@"flow02Preserv02"];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btn setEnabled:NO];
    self.tableView.backgroundColor = RGBColor(241, 241, 241, 1);
    //    self.tableView.backgroundColor = [UIColor cyanColor];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    _scetionArray = @[@"请您填写教育信息",@"请您填写工作信息"];
    _row1Xueli =@"";
    _row0School = @"";
    _company = @"";
}

#pragma mark-> UITableViewDataSource,UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *addIden = @"DetaillabeCell";
        DetaillabeCell *cell = [tableView dequeueReusableCellWithIdentifier:addIden];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DetaillabeCell" owner:self options:nil] lastObject];
        }
        
        cell.detailLabel.text = _scetionArray[0];
        cell.backgroundColor = rgb(241, 241, 241);
        return cell;
    }
    
//    if (indexPath.row == 1) {
//        static NSString *addIden = @"TextDetailLabelCell";
//        TextDetailLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:addIden];
//        if (!cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"TextDetailLabelCell" owner:self options:nil] lastObject];
//        }
//        
//        cell.texttLabel.text = @"学校";
//        cell.detaillLabel.text=_row0School;
//        cell.detaillLabel.textAlignment = NSTextAlignmentRight;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        return cell;
//    }
    if (indexPath.row == 1) {
        static NSString *addIden = @"TextDetailLabelCella";
        TextDetailLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:addIden];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TextDetailLabelCell" owner:self options:nil] lastObject];
        }
        
        cell.texttLabel.text = @"学历";
        cell.detaillLabel.text=_row1Xueli;
        cell.detaillLabel.textAlignment = NSTextAlignmentRight;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    if (indexPath.row == 2) {
        static NSString *addIden = @"DetaillabeCell1";
        DetaillabeCell *cell = [tableView dequeueReusableCellWithIdentifier:addIden];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DetaillabeCell" owner:self options:nil] lastObject];
        }
        
        cell.detailTextLabel.text = _scetionArray[1];
        cell.backgroundColor = rgb(241, 241, 241);
        return cell;
    }
    if (indexPath.row == 3) {
        static NSString *aCellId = @"eInfoCommonCell";
        InfoFiveCell *loanNumCell = [tableView dequeueReusableCellWithIdentifier:aCellId];
        if (!loanNumCell) {
            loanNumCell = [[[NSBundle mainBundle] loadNibNamed:@"InfoFiveCell" owner:self options:nil] lastObject];
        }
        loanNumCell.titleLabel.text=@"单位名称";
        loanNumCell.infoTextField.placeholder=@"请输入本人单位名称";
        loanNumCell.infoTextField.text=_company;
        loanNumCell.infoTextField.tag = 110;
        loanNumCell.photoBtn.hidden=YES;
        loanNumCell.lowLabel.hidden=NO;
        
        return loanNumCell;
    }
    if (indexPath.row == 4) {
        static NSString *aCellId = @"TelSeperateCell";
        TelSeperateCell *Cell = [tableView dequeueReusableCellWithIdentifier:aCellId];
        if (!Cell) {
            Cell = [[[NSBundle mainBundle] loadNibNamed:@"TelSeperateCell" owner:self options:nil] lastObject];
        }
        Cell.forgTelTextFiled.text = _telquhao;
        Cell.forgTelTextFiled.tag =200;
        Cell.forgTelTextFiled.textColor = RGBColor(0, 144, 255, 1);
        Cell.forgTelTextFiled.delegate = self;
        Cell.backTelTextField.text = _telnum;
        Cell.backTelTextField.tag =201;
        Cell.backTelTextField.textColor = RGBColor(0, 144, 255, 1);
        Cell.backTelTextField.delegate = self;
        
        return Cell;
    }
    if(indexPath.row == 5)
    {
        static NSString *addIden = @"AddCell";
        AddCell *cell = [tableView dequeueReusableCellWithIdentifier:addIden];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddCell" owner:self options:nil] lastObject];
        }
        
        cell.labelCity.text = [NSString stringWithFormat:@"%@,%@,%@",cityArray[0],cityArray[1],cityArray[2]];
        if ([cell.labelCity.text isEqualToString:@"省,市,区"]) {
            cell.labelCity.textColor=RGBColor(214.0, 214.0, 214.0, 1);
        }else{
            cell.labelCity.textColor = RGBColor(0, 144, 255, 1);
        }
        return cell;
    }

    if (indexPath.row == 6) {
        static NSString *addIden = @"TextViewCell";
        TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addIden];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TextViewCell" owner:self options:nil] lastObject];
        }
        //            cell.textField.tag= 300;
        //            [cell.textField addTarget:self action:@selector(textFieldChangeBtn) forControlEvents:UIControlEventAllEditingEvents];
        cell.textView.text =_textViewText;
        cell.textView.font = [UIFont systemFontOfSize:17];
        if ([_textViewText isEqualToString:@"单位详细地址"]) {
            cell.textView.textColor=RGBColor(214.0, 214.0, 214.0, 1);
        }else{
            cell.textView.textColor=RGBColor(0, 144, 255, 1);
        }
        cell.textView.delegate = self;
        return cell;
    }
    if (indexPath.row == 7) {
        static NSString *addIden = @"BtnCell";
        BtnCell *cell = [tableView dequeueReusableCellWithIdentifier:addIden];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BtnCell" owner:self options:nil] lastObject];
        }
        cell.backgroundColor = [UIColor clearColor];
        [cell.btn addTarget:self action:@selector(btnClickRowf3) forControlEvents:UIControlEventTouchUpInside];
        [cell setSeparatorInset:UIEdgeInsetsZero];
        cell.backgroundColor = rgb(241, 241, 241);
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
        return cell;
    }
        return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 6) {
        return 120;
    }
    if (indexPath.row == 7) {
        return 130;
    }
    
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }
    return 0.1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        
        _collView =[[[NSBundle mainBundle] loadNibNamed:@"ColledgeView" owner:self options:nil] objectAtIndex:0];
        _collView.frame = CGRectMake(0, 0, _k_w, _k_h);
        _collView.delegate = self;
        [_collView show];
    }
    
//    if (indexPath.row == 1) {
//        SchoolViewController *schoolView = [SchoolViewController new];
//        schoolView.delegate = self;
//        [self.navigationController pushViewController:schoolView animated:YES];
//    }
    
    if (indexPath.row == 5) {
        
        AddDetailViewController *addVC= [AddDetailViewController new];
        addVC.delegate = self;
        [self.navigationController pushViewController:addVC animated:YES];
    }
}

- (void)setSelectSchool:(NSString *)school
{
    _row0School = school;
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView reloadData];
//    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark->action

-(void)btnClickRowf3
{
    if ([_row1Xueli isEqualToString:@""]){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择学历"];
    }else if ([_company isEqualToString:@""]){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写单位名称"];
    }else if ([_telquhao length] <= 2 || [_telquhao length]>=5){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的区号"];
    }else if ([_telnum length]<= 4 || [_telnum length]>=9)
    {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的座机号"];
    }else if ([cityArray[0] isEqualToString:@"省"]){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择单位地址"];
    }else if ([_textViewText isEqualToString:@"单位详细地址"]){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写单位详细地址"];
    }else{
        [self setParaDic];
        HomeInfoViewController *hom=[HomeInfoViewController new];
        [self.navigationController pushViewController:hom animated:YES];
    }
}

//判断学校与其他
-(void)isOthersAndSchool{
    
}

- (void)setParaDic
{
    if([_row1Xueli isEqualToString:@"其他"]){
        _row0School = @"";
    }
    NSDictionary *dic = @{
                          @"degree":_educationCode,
                          @"unitAddress":[NSString stringWithFormat:@"%@%@%@%@",cityArray[0],cityArray[1],cityArray[2],_textViewText],
                          @"unitTelephone":[NSString stringWithFormat:@"%@%@",_telquhao,_telnum],
                          @"company":_company};
    DLog(@"%@,%@,%@,%@",_row0School,_educationCode,_telnum,_company);
//    @"schoolName":_row0School,
    [[Utility sharedUtility].getMoneyParam addEntriesFromDictionary:dic];
}


#pragma ->AddDeetailDelegate

-(void)setMultible:(NSString *)string1 andshi:(NSString *)string2 andQu:(NSString *)string3
{
    cityArray = [NSMutableArray arrayWithObjects:string1,string2,string3, nil];
//    NSIndexPath *indexpath_1=[NSIndexPath indexPathForRow:4 inSection:0];
//    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath_1] withRowAnimation:UITableViewRowAnimationNone];
     [self.tableView reloadData];
}

#pragma ->UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 200) {
        //        _loanTele=textField.text;
        _telquhao=[NSString stringWithFormat:@"%@%@",textField.text,string];
        if ([_telquhao length] > 4) {
            return NO;
        }
    }
    if (textField.tag == 201) {
        //        _loanTele=textField.text;
        _telnum=[NSString stringWithFormat:@"%@%@",textField.text,string];
        if ([_telnum length] > 8) {
            return NO;
        }
    }
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField.tag == 200 ) {
        _telquhao = textField.text;
    }
    if (textField.tag == 201) {
        _telnum = textField.text;
    }
    if (textField.tag == 110) {
        _company =textField.text;
    }
    return YES;
}

#pragma ->action

-(void)textFieldChangeBtn
{
    UITextField *filed= (UITextField *)[self.view viewWithTag:300];
    [filed setHidden:YES];
}

#pragma ->UITextViewDelegate
//通过判断表层TextView的内容来实现底层TextView的显示于隐藏
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    textView.editable = YES;
    if(![textView.text isEqualToString:@""])
    {
        _textViewText = textView.text;
        textView.textColor=RGBColor(0, 144, 255, 1);
    }
    if ([textView.text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    UITextField *filed= (UITextField *)[self.view viewWithTag:300];
    [filed setHidden:YES];
    if([textView.text isEqualToString:@"单位详细地址"])
    {
        textView.text=@"";
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@""])
    {
        textView.text=@"单位详细地址";
        textView.textColor=RGBColor(214.0, 214.0, 214.0, 1);
        UITextField *filed= (UITextField *)[self.view viewWithTag:300];
        [filed setHidden:NO];
    }else{
        _textViewText = textView.text;
//        NSIndexPath *indexpath_1=[NSIndexPath indexPathForRow:5 inSection:0];
//        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath_1] withRowAnimation:UITableViewRowAnimationNone];
        textView.editable = NO;
//         [self.tableView reloadData];
    }
}

#pragma ->ColledgeViewDelegate
-(void)ColledgeDelegateNString:(NSString *)CollString andIndex:(NSIndexPath *)indexPath
{
    
    if ([CollString isEqualToString:@"其他"]) {
        _row0School = @"";
    }
    _row1Xueli = CollString;
//    NSIndexPath *indexpath_1=[NSIndexPath indexPathForRow:2 inSection:0];
//    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath_1] withRowAnimation:UITableViewRowAnimationNone];
     [self.tableView reloadData];
    _educationCode = [_education objectAtIndex:indexPath.row];
}

//隐藏tabbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

@end
