//
//  PayDisplayCell.h
//  fxdProduct
//
//  Created by admin on 2017/7/19.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PayDisplayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dispalyLabel;

-(void)setDispalyLabeltext:(NSString *)text;

@end
