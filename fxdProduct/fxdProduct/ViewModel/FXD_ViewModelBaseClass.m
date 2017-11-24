//
//  PublicViewModel.m
//  fxdProduct
//
//  Created by dd on 15/12/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@implementation FXD_ViewModelBaseClass


- (void) setBlockWithReturnBlock:(ReturnValueBlock)returnBlock WithFaileBlock:(FaileBlock)faileBlock
{
    _returnBlock = returnBlock;
    _faileBlock = faileBlock;
}

@end
