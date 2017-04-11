//
//  TicketExplainCell.m
//  fxdProduct
//
//  Created by zy on 16/2/16.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "TicketExplainCell.h"

@implementation TicketExplainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Tool setCornerWithoutRadius:self.lblContent borderColor:rgba(214, 214, 214, 1)];
    
}
-(void)setValues:(NSString *)formDate :(NSString *)toDate
{
    NSString *str = @"\n  使用说明\n  1.本券只可抵扣利息使用,不可提现,不可转让;\n  2.本券从还款第一期即可使用; \n  3.可分期使用,如当期本金100元,当期利息21元,还款总额仅100元,21元利息已抵扣,抵扣利息直至100元优惠劵抵扣完毕;\n  4.如当前有逾期则本券不可使用;\n  5.本券不可与其他红包叠加使用;\n  6.本券最终解释权归发薪贷所有。\n";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:15];
    paragraphStyle.firstLineHeadIndent = 10;
    [paragraphStyle setHeadIndent:18];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:23 weight:5] range:NSMakeRange(3, 4)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(7, str.length-7)];
    self.lblContent.attributedText = attributedString;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
