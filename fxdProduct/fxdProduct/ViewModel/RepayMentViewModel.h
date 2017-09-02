//
//  RepayMentViewModel.h
//  fxdProduct
//
//  Created by dd on 15/12/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "ViewModelClass.h"

@interface RepayMentViewModel : ViewModelClass

- (void)fatchQueryWeekShouldAlsoAmount:(NSDictionary *)paramDic;

- (void)getCurrentRenewalWithStagingId:(NSString *)stagingId;

- (void)getBankCardList;
@end
