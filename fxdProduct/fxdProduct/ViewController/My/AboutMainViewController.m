//
//  AboutMainViewController.m
//  fxdProduct
//
//  Created by zy on 15/12/11.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "AboutMainViewController.h"
#import "MyAboutOursViewController.h"
#import "FXDWebViewController.h"

@interface AboutMainViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *contentAry;
}
@end

@implementation AboutMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"关于我们";
    [self addBackItem];
//    contentAry=[[NSArray alloc]initWithObjects:@"发薪贷简介",@"发展历程",@"媒体报道",@"微信:急速发薪/faxindai",@"微博:http://weibo.com/5697425557",@"官网:http://www.faxindai.com", nil];
    contentAry=[[NSArray alloc]initWithObjects:@"发薪贷简介",@"发展历程", nil];

    self.tableView.delegate=self;
    self.tableView.dataSource=self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contentAry.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"aboutUs"];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aboutUs"];
    }
    cell.textLabel.text=contentAry[indexPath.row];
    cell.textLabel.textColor=RGBColor(89, 87, 87, 1);
    cell.textLabel.font=[UIFont systemFontOfSize:16];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if(indexPath.row==0)
    {
//        MyAboutOursViewController *Myabout=[[MyAboutOursViewController alloc]init];
        FXDWebViewController *webView = [[FXDWebViewController alloc] init];
        webView.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_aboutus_url];
        [self.navigationController pushViewController:webView animated:YES];
    }else if (indexPath.row == 1) {
        FXDWebViewController *webView = [[FXDWebViewController alloc] init];
        webView.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_depHistory_url];
        [self.navigationController pushViewController:webView animated:YES];
    }
//    else if (indexPath.row == 2) {
//        FXDWebViewController *webView = [[FXDWebViewController alloc] init];
//        webView.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_mediaReport_url];
//        [self.navigationController pushViewController:webView animated:YES];
//    }
//    else if (indexPath.row==3)
//    {
//        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//        pasteboard.string =[cell.textLabel.text substringFromIndex:3];
//        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"复制微信公众号成功，请在微信中搜索关注"];
//    }else if(indexPath.row==4)
//    {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[cell.textLabel.text substringFromIndex:3]]];
//    }else
//    {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.faxindai.com"]];
//    }
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
