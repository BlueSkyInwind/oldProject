//
//  ExpressViewController.h
//  fxdProduct
//
//  Created by dd on 16/8/3.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface ExpressViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, copy) NSString *productId;

@end
