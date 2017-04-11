//
//  LoanProcessCell.h
//  fxdProduct
//
//  Created by dd on 2017/2/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoanProcessResult;

@interface LoanProcessCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *topLine;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@property (weak, nonatomic) IBOutlet UILabel *statusTitle;

@property (weak, nonatomic) IBOutlet UILabel *detailProcess;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (nonatomic, strong) LoanProcessResult *loanProcess;

@end
