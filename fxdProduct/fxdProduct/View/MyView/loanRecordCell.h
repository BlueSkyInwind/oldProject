//
//  loanRecordCell.h
//  fxdProduct
//
//  Created by zy on 16/1/21.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetMoneyHistoryBaseClass.h"
#import "RepayRecord.h"
@interface loanRecordCell : UITableViewCell
-(void)setCellValue:(RepayRecord*)result;
@end
