//
//  LoanProcessCell.m
//  fxdProduct
//
//  Created by dd on 2017/2/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "LoanProcessCell.h"
#import "LoanProcessModel.h"

@implementation LoanProcessCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setLoanProcess:(LoanProcessResult *)loanProcess
{
    self.statusTitle.text = loanProcess.apply_status_;
    self.detailProcess.text = loanProcess.content_;
    self.time.text = loanProcess.audit_time_;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
