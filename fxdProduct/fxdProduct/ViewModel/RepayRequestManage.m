//
//  RepayRequestManage.m
//  fxdProduct
//
//  Created by dd on 2017/2/12.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "RepayRequestManage.h"
#import "HomeViewModel.h"
#import "LoanPeriodListVCModule.h"
#import "UserStateModel.h"
#import "RepayMentViewModel.h"
#import "LoanPaymentDetailVCModule.h"
#import "RepayListInfo.h"
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
    

    if ([self.platform_type isEqualToString:@"0"]||[self.platform_type isEqualToString:@"3"]) {
        
        if ([self.product_id isEqualToString:RapidLoan] || [self.product_id isEqualToString:DeriveRapidLoan]) {
            [self post_getLastDate];
            return;
        }
        
        LoanPeriodListVCModule *repayMent=[[LoanPeriodListVCModule alloc]initWithNibName:[[LoanPeriodListVCModule class] description] bundle:nil];
        repayMent.product_id = self.product_id;
        repayMent.applicationId = self.applicationId;
        repayMent.platform_type = self.platform_type;
        [_targetVC.navigationController pushViewController:repayMent animated:YES];
    }
    
    if ([self.platform_type isEqualToString:@"2"]) {
        LoanPeriodListVCModule *repayMent=[[LoanPeriodListVCModule alloc]initWithNibName:[[LoanPeriodListVCModule class] description] bundle:nil];
        repayMent.product_id = self.product_id;
        repayMent.applicationId = self.applicationId;
        repayMent.platform_type = self.platform_type;
        [_targetVC.navigationController pushViewController:repayMent animated:YES];
    }
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
        BaseResultModel *baseRM =returnValue;
        if ([baseRM.errCode isEqualToString:@"0"]) {
            RepayListInfo * _repayListModel = [[RepayListInfo alloc]initWithDictionary:(NSDictionary *)baseRM.data error:nil];
            [self fatchCardInfo:_repayListModel];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:_targetVC.view message:baseRM.friendErrMsg];
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
            
            LoanPaymentDetailVCModule *repayMent=[[LoanPaymentDetailVCModule alloc]initWithNibName:[[LoanPaymentDetailVCModule class] description] bundle:nil];
            repayMent.repayType = RepayTypeClean;
            repayMent.supportBankListArr = supportBankListArr;
            CGFloat finalRepayAmount = 0.0f;
            for (Situations *situation in repayListInfo.situations_) {
                finalRepayAmount += [situation.debt_total_ floatValue];
            }
            repayMent.isPopRoot = _isPopRoot;
            repayMent.repayAmount = finalRepayAmount;
//            repayMent.product_id = RapidLoan;
//            if ([self.product_id isEqualToString:DeriveRapidLoan]) {
//                repayMent.product_id = DeriveRapidLoan;
//            }
            repayMent.repayListInfo = repayListInfo;
            repayMent.situations = repayListInfo.situations_;
            [_targetVC.navigationController pushViewController:repayMent animated:YES];
            
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:_targetVC.view message:baseResult.msg];
        }
    } WithFaileBlock:^{
        
    }];
    
    [checkBankViewModel getSupportBankListInfo:@"2"];

}


@end
