//
//  RepayListCell.m
//  fxdProduct
//
//  Created by dd on 16/8/31.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "RepayListCell.h"
#import "RepayListInfo.h"
#import "P2PBillDetail.h"

@implementation RepayListCell
//{
//    BOOL _identifierSelect;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tapSecory = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    self.identifierView.userInteractionEnabled=YES;
    [self.identifierView addGestureRecognizer:tapSecory];
    if (!_orderStateView.hidden) {
        UITapGestureRecognizer *tapClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailClick)];
        self.orderStateView.userInteractionEnabled=YES;
        [self.orderStateView addGestureRecognizer:tapClick];
    }
    
}

- (void)setIdentifierSelect:(BOOL)identifierSelect
{
    _identifierSelect = identifierSelect;
    if (identifierSelect) {
        [_numberOfIdentifier setHidden:YES];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"repay_selt@2x" ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        _identifierView.layer.contents = (id)image.CGImage;
    } else {
        [_numberOfIdentifier setHidden:NO];
        if (_displayStyle == RepayCellDetail) {
            if (![_situation.status_ isEqualToString:@"1"]) {
                NSString *path = [[NSBundle mainBundle] pathForResource:@"repay_un@2x" ofType:@"png"];
                UIImage *image = [UIImage imageWithContentsOfFile:path];
                _identifierView.layer.contents = (id)image.CGImage;
            }else {
                UIImage *image = [[UIImage alloc] init];
                _identifierView.layer.contents = (id)image.CGImage;
            }
        }else{
            NSString *path = [[NSBundle mainBundle] pathForResource:@"repay_un@2x" ofType:@"png"];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            _identifierView.layer.contents = (id)image.CGImage;
        }
    }
}


/**
 *  @author dd
 *
 *  查询用户账单信息
 *  status: 1->已还   2->逾期   3->未来期   4->当期
 */
- (void)setSituation:(Situations *)situation
{
    _situation = situation;
    if (_displayStyle == RepayCellNormal) {
        _numberOfIdentifier.text = [NSString stringWithFormat:@"%ld",[_situation.no_ integerValue]];
        _moneyLabel.text = [NSString stringWithFormat:@"%.2f元",[_situation.debt_total_ floatValue]];
        if ([_situation.status_ isEqualToString:@"2"]) {
            _overTime.text = [NSString stringWithFormat:@"逾期%ld天",labs([_situation.days_ integerValue])];
            _moneyLabel.textColor = [UIColor redColor];
            _overTime.textColor = [UIColor redColor];
        }else {
            _overTime.text = [NSString stringWithFormat:@"剩余%ld天",[_situation.days_ integerValue]];
            if ([_situation.status_ isEqualToString:@"4"]) {
                _moneyLabel.textColor = rgb(253, 111, 0);
            }else {
                _moneyLabel.textColor = UI_MAIN_COLOR;
                _overTime.textColor = rgb(137, 137, 137);
            }
        }
    }else {
        
        _moneyLabel.text = [NSString stringWithFormat:@"%.2f元",[_situation.debt_total_ floatValue]];
        if ([_situation.status_ isEqualToString:@"2"]) {
            _detailStateLabel.text = [NSString stringWithFormat:@"%@ 逾期",_situation.end_time_];
            _detailStateLabel.textColor = [UIColor redColor];
            _moneyLabel.textColor = [UIColor redColor];
        }else if ([_situation.status_ isEqualToString:@"1"]) {
            _detailStateLabel.text = [NSString stringWithFormat:@"%@ 已还",_situation.end_time_];
            _detailStateLabel.textColor = [UIColor grayColor];
            _moneyLabel.textColor = [UIColor grayColor];
        }else if ([situation.status_ isEqualToString:@"4"]) {
            _detailStateLabel.text = [NSString stringWithFormat:@"%@ 待还",_situation.end_time_];
            _detailStateLabel.textColor = [UIColor grayColor];
            _moneyLabel.textColor = rgb(253, 111, 0);
        }else {
            _detailStateLabel.text = [NSString stringWithFormat:@"%@ 待还",_situation.end_time_];
            _detailStateLabel.textColor = [UIColor grayColor];
            _moneyLabel.textColor = UI_MAIN_COLOR;
        }
    }
}


- (void)setBill:(BillList *)bill
{
    _bill = bill;
    if (_displayStyle == RepayCellNormal) {
        _numberOfIdentifier.text = [NSString stringWithFormat:@"%d",_bill.cur_stage_no_];
        _moneyLabel.text = [NSString stringWithFormat:@"%.2f元",_bill.amount_total_];
        if (_bill.status_ == 2) {
            _overTime.text = [NSString stringWithFormat:@"逾期%d天",abs(_bill.days)];
            _moneyLabel.textColor = [UIColor redColor];
            _overTime.textColor = [UIColor redColor];
        }else {
            _overTime.text = [NSString stringWithFormat:@"剩余%d天",_bill.days];
            if (_bill.status_ == 4) {
                _moneyLabel.textColor = rgb(253, 111, 0);
            }else {
                _moneyLabel.textColor = UI_MAIN_COLOR;
                _overTime.textColor = rgb(137, 137, 137);
            }
        }
    }else {
        
        _moneyLabel.text = [NSString stringWithFormat:@"%.2f元",_bill.amount_total_];
        if (_bill.status_ == 2) {
            _detailStateLabel.text = [NSString stringWithFormat:@"%@ 逾期",[FXD_Tool dateToFormatString:_bill.bill_date_]];
            _detailStateLabel.textColor = [UIColor redColor];
            _moneyLabel.textColor = [UIColor redColor];
        }else if (_bill.status_ == 1) {
            _detailStateLabel.text = [NSString stringWithFormat:@"%@ 已还",[FXD_Tool dateToFormatString:_bill.bill_date_]];
            _detailStateLabel.textColor = [UIColor grayColor];
            _moneyLabel.textColor = [UIColor grayColor];
        }else if (_bill.status_ == 4) {
            _detailStateLabel.text = [NSString stringWithFormat:@"%@ 待还",[FXD_Tool dateToFormatString:_bill.bill_date_]];
            _detailStateLabel.textColor = [UIColor grayColor];
            _moneyLabel.textColor = rgb(253, 111, 0);
        }else {
            _detailStateLabel.text = [NSString stringWithFormat:@"%@ 待还",[FXD_Tool dateToFormatString:_bill.bill_date_]];
            _detailStateLabel.textColor = [UIColor grayColor];
            _moneyLabel.textColor = UI_MAIN_COLOR;
        }
    }
}



- (void)click
{
    if (_displayStyle == RepayCellNormal) {
        _identifierSelect = !_identifierSelect;
        BOOL seletState = _identifierSelect;
        if (_row >= _clickMinIndex && _row <= _clickMaxIndex) {
            [self.delegate clickCell:self.row selectState:seletState];
        }
    } else {
        if (_situation != nil) {
            if ([_situation.status_ isEqualToString:@"2"] || [_situation.status_ isEqualToString:@"4"]) {
                if (_row != _clickMinIndex) {
                    _identifierSelect = !_identifierSelect;
                    BOOL seletState = _identifierSelect;
                    [self.delegate clickCell:self.row selectState:seletState];
                }
            }
        }
        if (_bill != nil) {
            if (_bill.status_ == 2 || _bill.status_ == 4) {
                if (_row != _clickMinIndex) {
                    _identifierSelect = !_identifierSelect;
                    BOOL seletState = _identifierSelect;
                    [self.delegate clickCell:self.row selectState:seletState];
                }
            }
        }
    }
}

- (void)detailClick
{
    if (self.detailClickBlock != nil) {
        self.detailClickBlock(self.row);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
