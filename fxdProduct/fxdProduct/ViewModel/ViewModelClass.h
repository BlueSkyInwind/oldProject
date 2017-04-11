//
//  PublicViewModel.h
//  fxdProduct
//
//  Created by dd on 15/12/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModelClass : NSObject

@property (nonatomic,strong) ReturnValueBlock returnBlock;
@property (nonatomic,strong) FaileBlock faileBlock;

- (void) setBlockWithReturnBlock:(ReturnValueBlock) returnBlock
                                WithFaileBlock: (FaileBlock) faileBlock;

@end
