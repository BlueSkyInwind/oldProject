//
//  RepayRequestManage.m
//  fxdProduct
//
//  Created by dd on 2017/2/12.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "RepayRequestManage.h"
#import "HomeViewModel.h"
#import "RepayListViewController.h"
#import "UserStateModel.h"
#import "RepayMentViewModel.h"
#import "RepayDetailViewController.h"
#import "RepayListInfo.h"
#import "BankModel.h"
#import "CheckViewModel.h"
#import "SupportBankList.h"

@implementation RepayRequestManage
{
    UserStateModel *_model;
}

- (void)repayRequest
{
    [self checkState];
}

//查询状态
-(void)checkState{
    
    HomeViewModel *homeViewModel = [[HomeViewModel alloc] init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        if([returnValue[@"flag"] isEqualToString:@"0000"])
        {
            _model=[UserStateModel yy_modelWithJSON:returnValue[@"result"]];
            if (_model.platform_type != nil) {
                if ([_model.platform_type isEqualToString:@"0"]) {
                    if ([_model.product_id isEqualToString:RapidLoan]) {
                        [self post_getLastDate];
                    }else {
                        RepayListViewController *repayMent=[[RepayListViewController alloc]initWithNibName:[[RepayListViewController class] description] bundle:nil];
                        repayMent.userStateParse = _model;
                        [_targetVC.navigationController pushViewController:repayMent animated:YES];
                    }
                }
                if ([_model.platform_type isEqualToString:@"2"]) { 
                    RepayListViewController *repayMent=[[RepayListViewController alloc]initWithNibName:[[RepayListViewController class] description] bundle:nil];
                    repayMent.userStateParse = _model;
                    [_targetVC.navigationController pushViewController:repayMent animated:YES];
                }
            } else {
                RepayListViewController *repayMent=[[RepayListViewController alloc]initWithNibName:[[RepayListViewController class] description] bundle:nil];
                repayMent.userStateParse = _model;
                [_targetVC.navigationController pushViewController:repayMent animated:YES];
            }
        }
        else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:_targetVC.view message:returnValue[@"msg"]];
        }
    } WithFaileBlock:^{
        
    }];
    [homeViewModel fetchUserState:nil];
}

/**
 *  @author dd
 *
 *  查询用户账单信息
 *  status: 1->已还   2->逾期   3->未来期   4->当期
 */
- (void)post_getLastDate
{
    RepayMentViewModel *repayMentViewModel = [[RepayMentViewModel alloc] init];
    [repayMentViewModel setBlockWithReturnBlock:^(id returnValue) {
        RepayListInfo *_repayListModel = [RepayListInfo yy_modelWithJSON:returnValue];
        if ([_repayListModel.flag isEqualToString:@"0000"]) {
            if (_model.applyStatus.integerValue == 7 || _model.applyStatus.integerValue == 8) {
                [self fatchCardInfo:_repayListModel];
            } else {
                RepayDetailViewController *repayMent=[[RepayDetailViewController alloc]initWithNibName:[[RepayDetailViewController class] description] bundle:nil];
                repayMent.product_id = _model.product_id;
                repayMent.isP2pView = _isP2pView;
//                _model.product_id;
                [_targetVC.navigationController pushViewController:repayMent animated:YES];
            }
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:_targetVC.view message:_repayListModel.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [repayMentViewModel fatchQueryWeekShouldAlsoAmount:nil];
}

- (void)fatchCardInfo:(RepayListInfo *)repayListInfo
{

    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResult = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResult.flag isEqualToString:@"0000"]) {
            NSArray * array  = (NSArray *)baseResult.result;
            NSMutableArray * supportBankListArr = [NSMutableArray array];
            for (int i = 0; i < array.count; i++) {
                SupportBankList * bankList = [[SupportBankList alloc]initWithDictionary:array[i] error:nil];
                [supportBankListArr addObject:bankList];
            }
            
            RepayDetailViewController *repayMent=[[RepayDetailViewController alloc]initWithNibName:[[RepayDetailViewController class] description] bundle:nil];
            repayMent.repayType = RepayTypeClean;
            repayMent.supportBankListArr = supportBankListArr;
            CGFloat finalRepayAmount = 0.0f;
            for (Situations *situation in repayListInfo.result.situations) {
                finalRepayAmount += situation.debt_total;
            }
            repayMent.isP2pView = _isP2pView;
            repayMent.repayAmount = finalRepayAmount;
            repayMent.product_id = RapidLoan;
            //            repayMent.cellSelectArr = _cellSelectArr;
            //            repayMent.save_amount = _save_amount;
            repayMent.repayListInfo = repayListInfo;
            repayMent.situations = repayListInfo.result.situations.copy;
            repayMent.model = _model;
            [_targetVC.navigationController pushViewController:repayMent animated:YES];
            
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:_targetVC.view message:baseResult.msg];
        }
    } WithFaileBlock:^{
        
    }];
    
    [checkBankViewModel getSupportBankListInfo:@"2"];

}


@end
