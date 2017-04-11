//
//  TicketExplainCell.h
//  fxdProduct
//
//  Created by zy on 16/2/16.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketExplainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
-(void)setValues:(NSString *)formDate :(NSString*)toDate;
@end
